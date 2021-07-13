Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A453C68AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 04:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhGMCwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 22:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhGMCwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 22:52:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6123C0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 19:50:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id he13so38576566ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 19:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWczaO7ySSiQEoLTm+vGNbJHvEdGB0XrhK/1xIN+Aus=;
        b=Sz93spVMlMgoWe2sZ2r3Sz2PEcFIEQvOOwY8u2FVFgbqj+Y8QFubzljug1xWvPL6SV
         FbCnv7Ba9zGqQldDysh7s/04AEVO/S5LyTSsKT+d0M4l5Zd74JvQ+rDyd2eZ6N/HVjV6
         kfASR4E7QkQKyLlbkUjggu/OLBXIPWzLcZ1ztsRe9fP7yBaZQ54UzhTWIafVKbQ2E7/7
         1znI5RilIoH8kYRdBgU+gi1nbzDuTyrbc5XfgzNCJKNz8DJ278In0riaMpI0ql9zSRKL
         qD1Q3IthOfpu0/u9Jo/kzokAqI+gFhnx4PhKpKhJIhHw5vVoU4297mmWdFYL6Q1ftPLw
         3t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWczaO7ySSiQEoLTm+vGNbJHvEdGB0XrhK/1xIN+Aus=;
        b=sT9jOyPtqiIsPE9RaPQbiPULzabSfYDxtBGXpuG+JdUOCFtTgieKak0eWGQuHm/Gxg
         BPWAbF8iNOZuh++gYPfTc4vWA2otZmYclUPYKsw4tGzN5H9JUFBnsmVqTa6Rh2JVSQ73
         cnz7XRK6dhJa2APp1jFct1qtvodoIBxzLemvnq+YAfaM9NOsGkUDITUff7rZWP7zVX/I
         EZVr5GAlExH/nCcc8rxokYAEBGADJZ+4BoPHjB2a18SEvVt38vM+Npef/GyAXoOBoiKq
         UoGqHLIXXa/YjPy6ISDK8FeNkCkJweqX/G4mMSk9yjFYvSUiN/4WMSx0sax6ssDdnzky
         nwKA==
X-Gm-Message-State: AOAM530kKBwIqzzsUOqus8QArpZFvadtpaSlAI7hFqjep9vTrUsKcXgk
        dTh6o/P941gJkfqCz3lOJqChBMWY/IiShRaNv0uz
X-Google-Smtp-Source: ABdhPJzNR4zA6YxGCbdMJynlOAwTlByTwODW2K6iOZJn460bfey1kOM4PrBmXJSlzObxOQ0BeDzOO+Rd6aH6CJgHoQI=
X-Received: by 2002:a17:906:6d0a:: with SMTP id m10mr2841662ejr.106.1626144599162;
 Mon, 12 Jul 2021 19:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210712234801.GA29226@raspberrypi>
In-Reply-To: <20210712234801.GA29226@raspberrypi>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Jul 2021 22:49:48 -0400
Message-ID: <CAHC9VhTO=EubNyYJ5eOfpWPW2HGuVP-WFTm42mfiwtfWapt3tQ@mail.gmail.com>
Subject: Re: [PATCH] lsm_audit,selinux: add exception handling for possible
 NULL audit buffers
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 7:48 PM Austin Kim <austindh.kim@gmail.com> wrote:
> From: Austin Kim <austin.kim@lge.com>
>
> It is possible for audit_log_start() to return NULL on error.
> So add exception handling for possible NULL audit buffers where
> return value can be handled from callers.

Hi.

The patch looks fine to me, but I think the description doesn't tell
the full story and I'm worried that people might misunderstand why
this patch is worthwhile.  I would suggest you revise the commit
description to explain that in these cases it is safe to return early
when audit_log_start() returns NULL because the only non-cleanup
processing left in these functions is to generate an audit record.
Returning early in these cases is a performance optimization and not a
correctness issue; the audit_log_*() functions can support being
passed a NULL audit_buffer argument.

> Signed-off-by: Austin Kim <austin.kim@lge.com>
> ---
>  security/selinux/hooks.c       | 4 ++++
>  security/selinux/ss/services.c | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b0032c42333e..9e84e6635f2f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3325,6 +3325,8 @@ static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
>                         }
>                         ab = audit_log_start(audit_context(),
>                                              GFP_ATOMIC, AUDIT_SELINUX_ERR);
> +                       if (!ab)
> +                               return rc;
>                         audit_log_format(ab, "op=setxattr invalid_context=");
>                         audit_log_n_untrustedstring(ab, value, audit_size);
>                         audit_log_end(ab);
> @@ -6552,6 +6554,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>                                 ab = audit_log_start(audit_context(),
>                                                      GFP_ATOMIC,
>                                                      AUDIT_SELINUX_ERR);
> +                               if (!ab)
> +                                       return error;
>                                 audit_log_format(ab, "op=fscreate invalid_context=");
>                                 audit_log_n_untrustedstring(ab, value, audit_size);
>                                 audit_log_end(ab);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index d84c77f370dc..e5f1b2757a83 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1673,6 +1673,8 @@ static int compute_sid_handle_invalid_context(
>         if (context_struct_to_string(policydb, newcontext, &n, &nlen))
>                 goto out;
>         ab = audit_log_start(audit_context(), GFP_ATOMIC, AUDIT_SELINUX_ERR);
> +       if (!ab)
> +               goto out;
>         audit_log_format(ab,
>                          "op=security_compute_sid invalid_context=");
>         /* no need to record the NUL with untrusted strings */
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
