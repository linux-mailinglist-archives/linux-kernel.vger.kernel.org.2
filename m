Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1BB43E8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 21:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhJ1TDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 15:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1TDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:03:48 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEC8C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:01:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 107-20020a9d0a74000000b00553bfb53348so10059290otg.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bacE2xZ0Zkvu7YspICyGT/dvu11LrFL7AAwoJOGCChE=;
        b=jVE62tLkaBUMvhwU5cmhU+FboG50MTyqfyHGgs+k5LQin7JN2s7Fkt2ZW+g094MCZC
         GAS9g5P4coNSSqJWH02fLlKGAk4Y229e7dUcoGw+XdvhqOpl7drH9Rc6uira/epLu/iN
         E2hli4hjC5Lr5Od3R0rr8Qces+XmjvYVlpW/O2GGDWFq3gezGPX3uKuWbncp5cjSrVam
         SYLzsu9rlieR8ubXKdqyKJaqjhv82Yy8EAmcZ3If2ZlhjD2OC730cta4rkqXIao0FUsE
         EqTYHWPSTSDw0n7dA/bBxW+u1L12WC42XWFaIMyjQCeyu8WSebf+yKG3wQ5poexQV7Wu
         r6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bacE2xZ0Zkvu7YspICyGT/dvu11LrFL7AAwoJOGCChE=;
        b=YgWRzupBl8msdKMNkbpO4JPUEC5KDP1BtdwRdlGkpXooeqhew83JQ6AmqfFEwnRcCy
         GegUCaXgawveAyOWSSktjBSkkbiqW/OCutBSWE1KpNPxqF+PIzPmh50k3lQg/4ZTOt3a
         P52F6EebFqHw6KozlL9+0exD2JW8wSCEG5kxNMsVBpnU6rHcfRnl6GsiVG3dzZ8tHYLI
         5kTLSk2u0+YvVc7S11JiW5dPnxhiLrSw1kJJxYdRMBqKgLB2SBzOW8Ld3ls6kEQgsOjJ
         Yvv6f/pwBE7xrAHZdJ8rLAR5PyyGxpPc7tQpLYZULYAU8UDCeJPs0kvqZ8sPFOBwZpSh
         PkLw==
X-Gm-Message-State: AOAM5303VkXjyL/tsL0tgK06Vo+ztlDd4nplHikkdWXMs0jNx0dZcNCH
        8rvnGpCh6XBv8zbpqpFsyh3958Qu1tE=
X-Google-Smtp-Source: ABdhPJyQGMjXGcueoTqhehdF+R2bnjN+AwPrQTrCrnUm6dfu5URGw/b/1NUGRujjjYRKN/WA37ovTg==
X-Received: by 2002:a05:6830:2708:: with SMTP id j8mr4961476otu.240.1635447680164;
        Thu, 28 Oct 2021 12:01:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7sm1296938otn.11.2021.10.28.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:01:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 12:01:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip: Provide stronger type checking for
 IRQCHIP_MATCH/IRQCHIP_DECLARE
Message-ID: <20211028190118.GA739110@roeck-us.net>
References: <20211020104527.3066268-1-maz@kernel.org>
 <20211028172849.GA701812@roeck-us.net>
 <f1d9a7681e7bc83790782ef3e4197a82@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d9a7681e7bc83790782ef3e4197a82@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 07:43:16PM +0100, Marc Zyngier wrote:
> On 2021-10-28 18:28, Guenter Roeck wrote:
> > On Wed, Oct 20, 2021 at 11:45:27AM +0100, Marc Zyngier wrote:
> > > Both IRQCHIP_DECLARE() and IRQCHIP_MATCH() use an underlying
> > > of_device_id()
> > > structure to encode the matching property and the init callback.
> > > However, this callback is stored in as a void * pointer, which
> > > obviously
> > > defeat any attempt at stronger type checking.
> > > 
> > > Work around this by providing a new macro that builds on top of the
> > > __typecheck() primitive, and that can be used to warn when there is
> > > a discrepency between the drivers and core code.
> > > 
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > 
> > This patch results in:
> > 
> > In file included from include/linux/irq.h:589,
> >                  from include/linux/of_irq.h:7,
> >                  from include/linux/irqchip.h:17,
> >                  from arch/h8300/include/asm/irq.h:5,
> >                  from arch/h8300/kernel/traps.c:27:
> > include/linux/irqdesc.h:113:33: error: 'NR_IRQS' undeclared here (not
> > in a function)
> >   113 | extern struct irq_desc irq_desc[NR_IRQS];
> > 
> > and many similar errors when trying to build h8300 images.
> 
> Sigh... Please give this [1] a go.
> 
>         M.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/misc-5.16&id=0646880e517c06f0e0746665ca1e0e6dd36c406e

Yes, that does the trick.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
