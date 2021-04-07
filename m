Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60546357691
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhDGVSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:18:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51382 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232049AbhDGVS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:18:29 -0400
Received: from zn.tnic (p200300ec2f08fb0020f55c189e926593.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:fb00:20f5:5c18:9e92:6593])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DEDB71EC0345;
        Wed,  7 Apr 2021 23:18:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617830298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lR4HjhpfT7Q4Vo+Wt3lVbKX5Wx7rTwYicT74GM2+xNI=;
        b=GbyN1jVATBLorJv4BVyplZeZdx3/XUSg8LeGrAB5RfCI2sWwIRwYZou8M40d1lL2/VQWpY
        /V/p/bBwRY2bw/6nwMfYuJVCQLszUG6jLFieqeuGTO1exSKHEcuyqSc2Dfu+QEN7Gg+2FM
        vTAysXYGeqakxS/nZOii94xTguM58+8=
Date:   Wed, 7 Apr 2021 23:18:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEoIOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Message-ID: <20210407211816.GP25319@zn.tnic>
References: <20210326000235.370514-1-tony.luck@intel.com>
 <20210326000235.370514-4-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210326000235.370514-4-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:02:34PM -0700, Tony Luck wrote:
> Andy Lutomirski pointed out that sending SIGBUS to tasks that
> hit poison in the kernel copying syscall parameters from user
> address space is not the right semantic.

What does that mean exactly?

From looking at the code, that is this conditional:

        if (t == EX_HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
                m->kflags |= MCE_IN_KERNEL_RECOV;
                m->kflags |= MCE_IN_KERNEL_COPYIN;

so what does the above have to do with syscall params?

If it is about us being in ring 0 and touching user memory and eating
poison in same *user* memory while doing so, then sure, that makes
sense.

> So stop doing that. Add a new kill_me_never() call back that
> simply unmaps and offlines the poison page.

Right, that's the same as handling poisoned user memory.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
