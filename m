Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC903FEABB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 10:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244636AbhIBIin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 04:38:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46114 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244285AbhIBIim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 04:38:42 -0400
Received: from zn.tnic (p200300ec2f0ed1001ca2b7d5ff141705.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:1ca2:b7d5:ff14:1705])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BC631EC01A9;
        Thu,  2 Sep 2021 10:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630571858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PJx6p3VEqSoFIMakNm40UMucY9SA7AJ42uykU9Je9Es=;
        b=COmfr/82OCPYaLn2WRo00+55usCGcervGIgz/9Kieu55qNjyycCe/rJHb2uvaajRibT7tP
        uwv947MT0jfgzaxY4R73O4WzUZyE6UZzNISBp61AWpWWeaFQhT4S8hB+kvguEdvObD9Blv
        3eAhT22v6tKIUFLxMmmaWfBDrzdyMxY=
Date:   Thu, 2 Sep 2021 10:38:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     jiasheng <jiasheng@iscas.ac.cn>
Cc:     x86@kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] x86/microcode/amd: Add __list_del_entry_valid() in
 front of __list_del() in free_cache()
Message-ID: <YTCNdmeyq55UBPXK@zn.tnic>
References: <1630547122-3731091-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1630547122-3731091-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Sep 02, 2021 at 01:45:22AM +0000, jiasheng wrote:
> We have found that in the complied files __list_del()
> appear more than 100 times, and under at least 90% circumstances
> that __list_del_entry_valid() and __list_del() appear in pairs.
> For example, they appear together in the __list_del_entry()
> of the header file, 'include/linux/list.h'.
> But we have found that in the free_cache(), there is only
> __list_del() instead of the pair.
> Therefore, we consider that the __list_del_entry_valid()
> might be forgotten.

if this is how you're going to "analyze" whether something is amiss
in the code - by looking at how some other code does something, i.e.,
patterns - and not involve grey matter and actually *think* what you're
doing before doing it and what those functions do, your patches will
simply get ingored.

> Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>

When you sign off on a patch, please give your full name.

> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 3d4a483..1987ee1 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -626,6 +626,8 @@ static void free_cache(void)
>  	struct ucode_patch *p, *tmp;
>  
>  	list_for_each_entry_safe(p, tmp, &microcode_cache, plist) {
> +		if (!__list_del_entry_valid(p->plist))
> +			continue;
>  		__list_del(p->plist.prev, p->plist.next);
>  		kfree(p->data);
>  		kfree(p);
> -- 

Also, always CC lkml when submitting patches. CCed now.

Ok, it looks like you're a newbie to this - I'd suggest you read all of
this here:

https://www.kernel.org/doc/html/latest/process/index.html

to get acquainted with how this work is usually done and then try to fix
real bugs first.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
