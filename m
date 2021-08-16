Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE23EDD58
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhHPSxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:53:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45742 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhHPSxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:53:17 -0400
Received: from zn.tnic (p200300ec2f08b5001959acf655f190dc.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:b500:1959:acf6:55f1:90dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 788041EC0541;
        Mon, 16 Aug 2021 20:52:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629139960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJIwnKQ9osN83iCsLj2NaLLL1AgWy4Zh2ipZsHW1x4o=;
        b=q5LhCH6WAzsiNPANO7URaJP0E5ZSG0Xl/x01TWnzdwmNdrqhMGxLC4zQrbuKVeYAvvZgvc
        uyeMjls24lCTr8QGYbsQPGfFW3oXNspQksYABhhlnS4yLKCKOfIkilY098LhPtsJkS4pN/
        XTwiVfa7aTOSItIwqjT00QIO6hQaY/k=
Date:   Mon, 16 Aug 2021 20:53:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Message-ID: <YRq0DKXra9zDwYOE@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com>
 <YRV6M1I/GMXwuJqW@zn.tnic>
 <4FD76EDB-A5E6-4F32-8C6C-B47D7456C206@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4FD76EDB-A5E6-4F32-8C6C-B47D7456C206@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 06:33:37PM +0000, Bae, Chang Seok wrote:
> Without DISABLE_XSAVES or something under ifdef CONFIG_X86_XX in
> $arch/x86/include/asm/disable-features.h, I don’t see the difference with this
> macro. Am I missing anything here? Or, boot_cpu_has() is going to be
> deprecated everywhere?

There's:

cpu_has
this_cpu_has
cpu_feature_enabled
boot_cpu_has
static_cpu_has

All code where it doesn't matter which CPU, should use
cpu_feature_enabled() and simplicity will ensue in these here lands.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
