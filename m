Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E941EEEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhJANyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:54:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46718 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhJANyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:54:45 -0400
Received: from zn.tnic (p200300ec2f0e8e001f2e791e6d4c2984.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8e00:1f2e:791e:6d4c:2984])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B21F11EC0354;
        Fri,  1 Oct 2021 15:53:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633096380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xUv5xjAXztgQHlMEJDvEYisLMtb5UO1HcGM0nw61kNY=;
        b=KuusR7dMsKwj+U+gtx5xh2qM/w6uPTWcxj8vjqSDSbLs0grO12bskEhwT2ZtQ4wL++5Cc4
        mA32hZ3LUg7Zmb3fbbCFAf7DtqNpq42NFBwuk1P9cpv/rLMpbRUyWjFyaCuxhWAA9JiK84
        DqbuCKEK3ulUqF5HMSfeLoSOjpQPaPM=
Date:   Fri, 1 Oct 2021 15:52:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/sev: Fully map the #VC exception stacks
Message-ID: <YVcSuVqmTPiw4YLk@zn.tnic>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic>
 <YVb2AGXAwYx/OI6J@suse.de>
 <YVcF9ENTfLAGaLec@zn.tnic>
 <YVcGdpVuSsieFL8W@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVcGdpVuSsieFL8W@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 03:00:38PM +0200, Joerg Roedel wrote:
> The VC stack is only allocated and mapped when SEV-ES is detected, so
> they can't always be mapped by generic code.

And? I am assuming you do know how to check whether SEV-ES is enabled.

:-)

I also assumed it is implicitly clear that the mapping should not happen
unconditionally but of course behind a check.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
