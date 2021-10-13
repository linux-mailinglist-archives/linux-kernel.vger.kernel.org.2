Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA5C42C81B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbhJMRzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbhJMRzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:55:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E86C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:53:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g8so13600532edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLaYS9RXqNt7+hFwlO6gsKYZWSmRQqVaqX+hEJqB9LM=;
        b=xKey7FWoKrUCv8IvtxRentW1ZmNn3JSpGsLpA2udEtATxoIGbSXEjH+SSpjwExDslC
         d+h4PmQCK2gG3F9s49Cfwd/Hyp/+uGQiyhKkvstRVmfUjpCLXom6QKI6qYkOmSSRm1an
         5MPW67g9kXLDgFZ+fw3p5THkh8wGt3zKPpLHASmMfIpUXMEzwzij8u4es9Bh+PITik1a
         94mEzYi/57g6QtmHRg4CQNgkqCLIfUl21ck/+j+Ek7i82MeG0pX2vdRqJilrqmYh5f4j
         UyTT+JRJjjtRNWDFC43CwLfVCddlKhuEOjZRwsgE/1+69lbzCJuGtSMf3AA/SS/cKzF2
         f/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLaYS9RXqNt7+hFwlO6gsKYZWSmRQqVaqX+hEJqB9LM=;
        b=iQ5lu2IOmyyMSPWfV7tWv78sV17awTCEw3XAdlDk0dpYVD0Kz0axd5EYoaeaUTvXbZ
         MToNYQPnw17aazxn2RMVL5V2A0zXRynplOqnDFPSqCriMEkM5g8aBVblIt3YLF/LnVNq
         Q8FLU50YBdPkKPFnRWuZHhs8v9inM9hQ7A6zt5QsnHtr054hERlSS2UsOvfaUwxc79yG
         aR8juOwT1EAx5qXJBIBm9PXuQA3bFjNT1iLJrCoJW2uUkhVsJIR/7585xMruA+O0+ghE
         MGUAkfyaqFCANpO9T2JeF+4sA8CSQW55k2h65hfNliwdWec35ho2Ll5nBdvzWsXUke1U
         C0Zg==
X-Gm-Message-State: AOAM532C14vA379cXjLbrcL/RrZKFD022UsbqRkt/2OZdX8ZXM7z0/Gb
        4TMFqxFVZ6qtNPSuPgT3OQeMjigFn8mE5V8/KuMN
X-Google-Smtp-Source: ABdhPJzxdv34rnUgFkzMsE+FKKRO+1gOHd0i8Ivdq0iHCNJpeRU70lMiFr2rZbn/NVPSyCVuYwZUPN/FflUsOTUSvek=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr1120550edb.209.1634147618378;
 Wed, 13 Oct 2021 10:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211013172847.1196305-1-keescook@chromium.org>
In-Reply-To: <20211013172847.1196305-1-keescook@chromium.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Oct 2021 13:53:27 -0400
Message-ID: <CAHC9VhT0+omwDjqrJ2BtnRfa8SSGAkyUvB6WX95E=ntf9gUbmQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: Avoid warnings about potentially unused hook variables
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 1:31 PM Kees Cook <keescook@chromium.org> wrote:
>
> Building with W=1 shows many unused const variable warnings. These can
> be silenced, as we're well aware of their being potentially unused:
>
> ./include/linux/lsm_hook_defs.h:36:18: error: 'ptrace_access_check_default' defined but not used [-Werror=unused-const-variable=]
>    36 | LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>       |                  ^~~~~~~~~~~~~~~~~~~
> security/security.c:706:32: note: in definition of macro 'LSM_RET_DEFAULT'
>   706 | #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>       |                                ^~~~
> security/security.c:711:9: note: in expansion of macro 'DECLARE_LSM_RET_DEFAULT_int'
>   711 |         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/lsm_hook_defs.h:36:1: note: in expansion of macro 'LSM_HOOK'
>    36 | LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>       | ^~~~~~~~
>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: KP Singh <kpsingh@chromium.org>
> Cc: linux-security-module@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-mm/202110131608.zms53FPR-lkp@intel.com/
> Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks reasonable to me, thanks Kees.  Unless James wants to pick this
up for the security tree, I can pull this into the SElinux tree with
the io_uring change which is causing the testing robot to complain.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/security.c b/security/security.c
> index 9ffa9e9c5c55..462f14354c2c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -706,7 +706,7 @@ static int lsm_superblock_alloc(struct super_block *sb)
>  #define LSM_RET_DEFAULT(NAME) (NAME##_default)
>  #define DECLARE_LSM_RET_DEFAULT_void(DEFAULT, NAME)
>  #define DECLARE_LSM_RET_DEFAULT_int(DEFAULT, NAME) \
> -       static const int LSM_RET_DEFAULT(NAME) = (DEFAULT);
> +       static const int __maybe_unused LSM_RET_DEFAULT(NAME) = (DEFAULT);
>  #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>         DECLARE_LSM_RET_DEFAULT_##RET(DEFAULT, NAME)
>
> --
> 2.30.2

--
paul moore
www.paul-moore.com
