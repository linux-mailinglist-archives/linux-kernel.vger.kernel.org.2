Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FC32C174
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838654AbhCCTBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbhCCShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:37:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2F6C061760
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 10:36:57 -0800 (PST)
Received: from zn.tnic (p200300ec2f086d00c42804c7137f86b4.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6d00:c428:4c7:137f:86b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5A2F1EC0300;
        Wed,  3 Mar 2021 19:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614796616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cTpX8tdaG4cEB5Oo/0I4OUwn2PmXYx9DU6+xKcSA6gw=;
        b=SG1KtJDmEDAttFzmoaaEfy2W4Jv5zYqLk8bYy95MOFBFmfwBUI25HC/GKs9dZ0s52c/Oxj
        36VzJf7x+FUTvD26vGqhNCki3kUOkKGqEyQKKYNNhpnSc2SV9442l7m4n8AKMNjnjzpKIj
        zNWHTI4fCSCtvpCyLiyYvnVdrFLn4f8=
Date:   Wed, 3 Mar 2021 19:36:50 +0100
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
Message-ID: <20210303183650.GG22305@zn.tnic>
References: <20210303064357.17056-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210303064357.17056-1-jslaby@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 07:43:57AM +0100, Jiri Slaby wrote:
> Commit 8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO
> functions") added a printf of len which is size_t. Compilers now
> complain on 32b:
> In file included from arch/x86/entry/vdso/vdso2c.c:162:
> arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
> arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'}
> 

I know it is obvious but how do you trigger this?

A 32-bit allmodconfig with both debian's gcc-10 and leap15's gcc-7 don't
trigger that warning. Which might answer your question why I haven't
caught it yet. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
