Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AFB3C2516
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 15:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGINo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhGINo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 09:44:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A16FC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 06:42:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625838130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XS55LEXK0mDOV67QDnJIakM5Dk49PHJcSI/qt3Ma4Mk=;
        b=zF96qiupU1s/vwJj7vcE0/YmkhSL/6pTLtqYGalLf+jb0i7hVaPjOUksMAs/e+L2IkYg1z
        CBNwDrIWnaSGIMNfpQREdE2ToJw649p/cGzbNr4kxmAOH3htC3WC+Jv1olvjxd9tMLoVM+
        24a+QPwTevG0ATkMT9ly7eV1ygQO/fz4kbTV7jp0RQsvWoE2wSTSCLX15auPZngSQwrUzc
        FkocCGa8t4vIjgQGN81S466XfrP3pgFmmfNy6e0vG6fVvg6doZOwI3FmejV3tNEmJItAbQ
        ldL3IoQm1YeqEikRe6LDyNkjwXEfiX45syqhnGr8aFDt475BnXIvrSroxW+70A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625838130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XS55LEXK0mDOV67QDnJIakM5Dk49PHJcSI/qt3Ma4Mk=;
        b=8CKIAxO7pwWjQWZPnD3rmnKUSBJRhyBHmHPEGBwutCkeF+RX7nZ/C7UN8OE477affKSOB5
        X4fq36MIwXQgINDQ==
To:     Marc Zyngier <maz@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [GIT PULL] irqchip fixes for 5.14, take #1
In-Reply-To: <20210709094306.1459561-1-maz@kernel.org>
References: <20210709094306.1459561-1-maz@kernel.org>
Date:   Fri, 09 Jul 2021 15:42:10 +0200
Message-ID: <87eec7ob7x.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On Fri, Jul 09 2021 at 10:43, Marc Zyngier wrote:
> One is a simple documentation update. The other is an interesting bug
> affecting MIPS, where we were able to perform irqdomain look-ups
> (which now implies using RCU at all times) without being in the right
> context (straight out of idle, for example). The issue was always
> there, we were just 'lucky' not to use RCU consistently in the
> irqdomain code...
>
> Please pull,

done.

Thanks,

        tglx
