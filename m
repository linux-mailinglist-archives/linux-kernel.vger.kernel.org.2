Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F1B3AD9DB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhFSLjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhFSLjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:39:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DEEC061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:37:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624102654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ums+h3Qr4LeMZdW3sa2+1i2S4XpLBjN7KS0U3VAjUCc=;
        b=TDFuKC2NjnHaaPfa3ipTmLHktR1lXcAl4IiUrBoa+5fZ3fuN3QoM0h3hYSu/jbWaichDUS
        X+2/o8O5enb091NmBaEtTiFgVHfvN++EVfBElBYYNf+0rlpsr10UCMlgE3M1QA5uoYhDJ2
        wfz2lYmyURjV5aOh2gop5OcVO/u+9K871feHYeXidbNld3dPNFjWvb36xzh5Y/5pxINP5T
        1BKsVeVkecYJfzEMjpRT8nJtdaHmZSzs0vLl3asOL//4JXvUjtxQ71z+UwyCDkBstAl2T3
        MHSEzG3OMGAluJgEWg2QVI5+rz0RbkfqS3qqkAJpoHclH5hcj/mloqYfwBx/fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624102654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ums+h3Qr4LeMZdW3sa2+1i2S4XpLBjN7KS0U3VAjUCc=;
        b=QljFLa8+AHJO0aSz3EEe7DT8kh3JVsUemjJQxevrjWPntcFXkCAuCAxBCOcrE1QU8xsM1H
        AvkwvB3KDJm9R9Cg==
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: Re: [PATCH 20/39] irqdomain: Protect the linear revmap with RCU
In-Reply-To: <20210520163751.27325-21-maz@kernel.org>
References: <20210520163751.27325-1-maz@kernel.org> <20210520163751.27325-21-maz@kernel.org>
Date:   Sat, 19 Jun 2021 13:37:33 +0200
Message-ID: <87zgvmccg2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20 2021 at 17:37, Marc Zyngier wrote:
>  static void irq_domain_clear_mapping(struct irq_domain *domain,
> @@ -902,12 +901,12 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
>  		return 0;
>  	}
>  
> +	rcu_read_lock();
>  	/* Check if the hwirq is in the linear revmap. */
>  	if (hwirq < domain->revmap_size)
> -		return domain->revmap[hwirq]->irq;
> -
> -	rcu_read_lock();
> -	data = radix_tree_lookup(&domain->revmap_tree, hwirq);
> +		data = rcu_dereference(domain->revmap[hwirq]);
> +	else
> +		data = radix_tree_lookup(&domain->revmap_tree, hwirq);
>  	rcu_read_unlock();
>  	return data ? data->irq : 0;

This is wrong and was wrong before. This wants to be:

     irq = data ? data->irq : 0;
     rcu_read_unlock();
     return irq;

Thanks,

        tglx
