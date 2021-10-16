Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5578F4302BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 15:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240492AbhJPNZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 09:25:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37972 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240431AbhJPNZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 09:25:01 -0400
Received: from zn.tnic (p200300ec2f1ceb007fb855408f3fbdbb.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:eb00:7fb8:5540:8f3f:bdbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31B251EC03C9;
        Sat, 16 Oct 2021 15:22:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634390572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fGrdl/qz1529NFQFPxNJ/LUsbpW0/CbFMjZPDMTEuug=;
        b=Rs3SENr/TxUofol7iOzjtpxwS4RCmX5JG2fzV54gxx9opx5TJytQLx2sl7dPqGbDlGFkqK
        nLO/HyaxLFTr+uRuVL29atSiiHSDCQvVjnm1YaVSozPRZORTR7rlS6SHauOTMMgVt0RkkZ
        sIhpHWkM223fXNEKHJRKGNAH8lmUJOE=
Date:   Sat, 16 Oct 2021 15:22:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     JY Ni <jiayu.ni@linux.alibaba.com>
Cc:     Luming Yu <luming.yu@gmail.com>,
        wujinhua <wujinhua@linux.alibaba.com>, x86 <x86@kernel.org>,
        "zelin.deng" <zelin.deng@linux.alibaba.com>,
        ak <ak@linux.intel.com>, "luming.yu" <luming.yu@intel.com>,
        "fan.du" <fan.du@intel.com>,
        "artie.ding" <artie.ding@linux.alibaba.com>,
        "tony.luck" <tony.luck@intel.com>, tglx <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "pawan.kumar.gupta" <pawan.kumar.gupta@linux.intel.com>,
        "fenghua.yu" <fenghua.yu@intel.com>, hpa <hpa@zytor.com>,
        "ricardo.neri-calderon" <ricardo.neri-calderon@linux.intel.com>,
        peterz <peterz@infradead.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW1BBVENIXSBwZXJm?= =?utf-8?Q?=3A_optimiz?=
 =?utf-8?Q?e?= clear page in Intel specified model with movq instruction
Message-ID: <YWrSKeT+R2S/+udL@zn.tnic>
References: <1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com>
 <YTnWXIB42sCLbM2k@zn.tnic>
 <bf6fe59d-c760-40d4-8201-4170cd90ffc3.wujinhua@linux.alibaba.com>
 <YTnq/3rzmD6ADyZm@zn.tnic>
 <CAJRGBZxHQ3tPrvWWoz9xb0pf=tZ0vrrQYX-Tjr5c=UbxntPtew@mail.gmail.com>
 <1cac1499-6b00-3c18-b64c-a22f269a2706@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cac1499-6b00-3c18-b64c-a22f269a2706@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 08:58:32PM +0800, JY Ni wrote:
> I rebased this patch on linux-next repo and measured the time of building a
> same kernel in original/add-movq-patch version on the same intel CPX server.

...

> delta = (*build_original_time* - *build_movq_time*) / (*build_movq_time*)
> 
> This set of data shows that movq-patch version has better performance than
> original version in most cases.

First of all, please do not top-post but put your answer under the
quoted text like everyone else.

Then, please explain how exactly you ran that measurement so that I can
try to reproduce it here too.

And just to make sure we're talking about the same thing: the patch in
question is this one:

https://lore.kernel.org/r/1631177151-53723-1-git-send-email-wujinhua@linux.alibaba.com

correct?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
