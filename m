Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403D632D190
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbhCDLFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:05:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58078 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239447AbhCDLF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:05:28 -0500
Received: from zn.tnic (p200300ec2f0f59009dafbf8576ee2b80.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:9daf:bf85:76ee:2b80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 545A41EC04D3;
        Thu,  4 Mar 2021 12:04:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614855887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=llhQBLPeDtzIPrwTkIEGRqLS0ag3wDlnBaWc2eVPdiQ=;
        b=Ui22N6IjM0YbqgZA8jWW341vReC2vr7VvM6nydYQz9ivWmlirg7YRNnmwS6tKLcTafZZuh
        aJV0G2+eMkbgYmqeFzt466jDp4bd/zusm+XVU8UuYf1q4CgkmMUyo5u/KGB3sPRhM2z3d/
        F4S+HR4xqMKi9OmGruQAo8tmIoy/390=
Date:   Thu, 4 Mar 2021 12:04:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86/vdso: Use proper modifier for len's printf in extract
Message-ID: <20210304110441.GD15496@zn.tnic>
References: <20210303064357.17056-1-jslaby@suse.cz>
 <20210303183650.GG22305@zn.tnic>
 <1804463d-bb45-ea75-b4b0-1238c35638a0@suse.cz>
 <20210304104853.GA15496@zn.tnic>
 <f397fa13-5cec-ca09-7c5e-9e99c223bb24@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f397fa13-5cec-ca09-7c5e-9e99c223bb24@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 11:55:18AM +0100, Jiri Slaby wrote:
> On 04. 03. 21, 11:48, Borislav Petkov wrote:
> > On Thu, Mar 04, 2021 at 06:18:25AM +0100, Jiri Slaby wrote:
> > > It's built with gcc 10 from tumbleweed and it's a standard config from
> > > kerncvs:
> > > https://github.com/openSUSE/kernel-source/blob/stable/config/i386/pae
> > 
> > Nope, can't trigger with that one either. :-\
> 
> Beware:
> HOSTCC  arch/x86/entry/vdso/vdso2c
> ^^^^^^
> You would need to _be_ on i586. Or try with -m32:

Yah, that is the explanation. I would've never seen because - although I
do the regular 32-bit builds - I don't do them on a 32-bit platform. But
hey, OBS does. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
