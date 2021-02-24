Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C773F323A45
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhBXKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhBXKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:13:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5667C061574;
        Wed, 24 Feb 2021 02:12:36 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z7so907041plk.7;
        Wed, 24 Feb 2021 02:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvISrt6vYqvUm9PHBD/p/wweiIQ+cNzFh5pQ6zkWASM=;
        b=sD8bWvD1vcfd3uRV/4Fo8JnspSgsE2jadK1HkywrLcdhUhMXMWjq4/6atvUaSi3D7w
         6dW+N44WH5F7Og/Te0BcRwoFFGSoUL9jH4PDzy6I262gIjIPTEJalpji6U5Hsit3vsHn
         fqIDUDjg138qyAujmWD+Y88DLXTEpMDNzc7pjLvibvHqOq5aQs5LrCHdzbEQZT8Bha4Y
         PW3htTRzEaqh4/lyS6fJiR8Vd/+e+rIjJY9JBhWdnH7ZYzOrhqiSdTz2eg96ucwVahwF
         Zbvms0WFZY4PoeYuGRkRHuqCIxGLI9b5klqYl4prZrfTNWIdK3wPSGOEmuJg9SKqFmX4
         nN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvISrt6vYqvUm9PHBD/p/wweiIQ+cNzFh5pQ6zkWASM=;
        b=JZ/nyHtmhbEsLxAY99dPOWWvSbuPNa3XMuAYv8PMDubTWqZF1tf3KQeBX4KEkQqLbR
         j+jsKTnxqPVfflAw8AJMfL4LKGOXCyutmkgsBg/B6NxWi7wSLa8umsltM1743vogPuY/
         WVF8o6T9mgDcRUjwW5mjVMgCw1vWoq97RGoibBzJwVKFLPvnZOSpU5m0NYz9j+ZkQZwl
         vehTVrEvW/mFIYhz5sc7LYy2XrT75Z2HPH0GHYsLVJYhMPbV7idadvAgXx50jpWwrCPW
         MchVXDnPmNVjJqDlAME92hUO8IYQclaPtETsLGOgrj9aLFEg4jAjeJAbGGWMj9xKKYO0
         Nx6A==
X-Gm-Message-State: AOAM531yOTEq2UwbY6gX7Jm/xqfjSO4lNFYDUhk+TB63LP3CwEl6Sfux
        Y1SLv2eYyV3fQmbLJJxRKE2JkPSKCnV7wg3ZrrE=
X-Google-Smtp-Source: ABdhPJxKDFMwtTGODQK28m5lHAr4T/V7FvHh0JKisx6pW5W3afq3SiVj0xMdvgRslblb6Fj8nQXwONCnaEPtAZItn4k=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr1493951pjx.181.1614161556497;
 Wed, 24 Feb 2021 02:12:36 -0800 (PST)
MIME-Version: 1.0
References: <1614154581-33967-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1614154581-33967-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Feb 2021 12:12:20 +0200
Message-ID: <CAHp75VcDeoSvu6RjJ7JrycrxS2umL5Cx-B_8NrLLcgZR6VVrZw@mail.gmail.com>
Subject: Re: [PATCH] x86: platform: iosf_mbi: Replace DEFINE_SIMPLE_ATTRIBUTE
 with DEFINE_DEBUGFS_ATTRIBUTE
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 10:16 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./arch/x86/platform/intel/iosf_mbi.c:482:0-23: WARNING: iosf_mcr_fops
> should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/x86/platform/intel/iosf_mbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
> index 526f70f..ba70597 100644
> --- a/arch/x86/platform/intel/iosf_mbi.c
> +++ b/arch/x86/platform/intel/iosf_mbi.c
> @@ -479,7 +479,7 @@ static int mcr_set(void *data, u64 val)
>
>         return err;
>  }
> -DEFINE_SIMPLE_ATTRIBUTE(iosf_mcr_fops, mcr_get, mcr_set , "%llx\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(iosf_mcr_fops, mcr_get, mcr_set, "%llx\n");
>
>  static struct dentry *iosf_dbg;
>
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
