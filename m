Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DB7306B45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhA1Cwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhA1Cwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:52:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E529BC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:51:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a14so4895942edu.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpQaqfgxd7HJasSj0lTbCtNGSUTspubqoBTb1LMXVRM=;
        b=NnGpVeSqtPgrJgZIm930ZFHJoqoTXILyr0S82daUWTGBNJaaiM327+reTyu7uBvBmj
         Z8xjmu2Fy/SAUf2zI2rW4yt1AB9R4gmZQ5vKMqg+7Z7kiDhxsMEEh13MGIfSTgocfCiK
         FJ2llM/eYKEK++Bc7K7k9DiJov12Fptz89vTPOf86EaBD33OGm/CgsNjkypRCo8vYY+C
         c6zzT6VfEiJSk/dcd6pW8/XqNS4zZiYtLT9mL8FkH6wkoF9AxWEPLaU6GmXzW+4dggWh
         t+Fmk6/m3Yi6bI0WwKHQesQbEsviHMjbPDplLIuiSikTp6UtQ/3XYWNiNsOo1JTHBhjW
         GX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpQaqfgxd7HJasSj0lTbCtNGSUTspubqoBTb1LMXVRM=;
        b=tTCDLoZ9zD7muuOPRS+p3FaJtpVU773yn1O0GH8Z2pQD7D+NJ4ttgsA/dbWvi8U55V
         rjnAOGy3kbwyweb6iFnKA1eig3XCto3POEQaQkC/ThSJGSD3R6imhETJC6c9o0CSj0ov
         23zrQsVibCqp5GMwUqomnTpmfhg7YEkXhmoexmekcojs7OJBLsEBkopBGHHO95oI5OF5
         EuxHxstIRGmtOT5/M6HdOns8o24K2UvPy5LTXvEqFfQRAvxP/lN9Iv3GCi/kdpuuD+g5
         i/imzFWP29hmiielkdUJJgGddkm9ZwwnYUw7XdyctHZ9SHy7LAtRvigb/Fep8Sfbk4xM
         azSw==
X-Gm-Message-State: AOAM5333HUzD8IEK9gp52PXPNb7G2gm2z/MXqKhTzyaVV1hzKR6jBN1j
        uSJ21WJEEXFVy4e4V5Bue0+P3+jDdHojiYzIjmBXEteclVWIxnI=
X-Google-Smtp-Source: ABdhPJyNf5vAnk4XFxWjzPoVjPvkYX+ygHKOJ+fk+XCk8eH+ZWou3fZkEEhhHv/CtO2hTnpY5zc82GD11WjV3xXgQMg=
X-Received: by 2002:a05:6402:1bcd:: with SMTP id ch13mr11572381edb.31.1611802318522;
 Wed, 27 Jan 2021 18:51:58 -0800 (PST)
MIME-Version: 1.0
References: <202101242104019221924@zte.com.cn>
In-Reply-To: <202101242104019221924@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Jan 2021 21:51:47 -0500
Message-ID: <CAHC9VhQR2+Zz8pzaCp4YJ-r8Tk-RBOuUhXNU=VJaWOw3sbeN+w@mail.gmail.com>
Subject: Re: [RFC,v3,1/1] audit: speed up syscall rule filtering
To:     yang.yang29@zte.com.cn
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 8:04 AM <yang.yang29@zte.com.cn> wrote:
>
> From 85b3eccf7f12b091b78cc5ba8abfaf759cf0334e Mon Sep 17 00:00:00 2001
> From: Yang Yang <yang.yang29@zte.com.cn>
> Date: Sun, 24 Jan 2021 20:40:50 +0800
> Subject: [PATCH] audit: speed up syscall rule filtering
> audit_filter_syscall() traverses struct list_head audit_filter_list to find
> out whether current syscall match one rule. This takes o(n), which is not
> necessary, specially for user who add a very few syscall rules. On the other
> hand, user may not much care about rule add/delete speed. So do o(n)
> calculates when rule changes, and ease the burden of audit_filter_syscall().
>
> Define audit_rule_syscall_mask[NR_syscalls], every element stands for
> one syscall.audit_rule_syscall_mask[n] == 0 indicates no rule cares about
> syscall n, so we can avoid unnecessary calling audit_filter_syscall().
> audit_rule_syscall_mask[n] > 0 indicates at least one rule cares about
> syscall n, then calls audit_filter_syscall(). Update
> audit_rule_syscall_mask[n] when syscall rule changes.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  include/linux/audit.h |  3 +++
>  kernel/auditfilter.c  |  4 ++++
>  kernel/auditsc.c      | 36 ++++++++++++++++++++++++++++++++----
>  3 files changed, 39 insertions(+), 4 deletions(-)

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ce8c9e2..1b8ff4e 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1627,8 +1653,9 @@ void __audit_free(struct task_struct *tsk)
>                 context->return_valid = AUDITSC_INVALID;
>                 context->return_code = 0;
>
> -               audit_filter_syscall(tsk, context,
> -                                    &audit_filter_list[AUDIT_FILTER_EXIT]);
> +               if (unlikely(audit_rule_syscall_mask[context->major]))
> +                       audit_filter_syscall(tsk, context,
> +                                            &audit_filter_list[AUDIT_FILTER_EXIT]);
>                 audit_filter_inodes(tsk, context);
>                 if (context->current_state == AUDIT_RECORD_CONTEXT)
>                         audit_log_exit();
> @@ -1735,8 +1762,9 @@ void __audit_syscall_exit(int success, long return_code)
>                 else
>                         context->return_code  = return_code;
>
> -               audit_filter_syscall(current, context,
> -                                    &audit_filter_list[AUDIT_FILTER_EXIT]);
> +               if (unlikely(audit_rule_syscall_mask[context->major]))
> +                       audit_filter_syscall(current, context,
> +                                            &audit_filter_list[AUDIT_FILTER_EXIT]);
>                 audit_filter_inodes(current, context);
>                 if (context->current_state == AUDIT_RECORD_CONTEXT)
>                         audit_log_exit();

Looking at this revision I believe I may not have been as clear as I
should have been with my last suggestion.  Let me try to do better
here.

Thus far I'm not very happy with the audit_rule_syscall_mask[]
additions; it looks both wasteful and inelegant to me at the moment.
I would much rather see if we can improve the existing code by fixing
inefficiencies in how we handle the rule filtering.  This is why my
previous comments suggested looking at the audit_filter_syscall() and
audit_filter_inodes() calls in __audit_free() and
__audit_syscall_exit(), the latter of course being more important due
to its frequency.

In both cases an audit_filter_inode() AUDIT_RECORD_CONTEXT decision
takes precedence over any audit_filter_syscall() decision due to the
code being structured as so:

  audit_filter_syscall(...);
  audit_filter_inodes(...);
  if (state == AUDIT_RECORD_CONTEXT)
    audit_log_exit();

... my suggestion is to investigate what performance benefits might be
had by leveraging this precedence, for example:

  audit_filter_inodes(...);
  if (state != AUDIT_RECORD_CONTEXT)
    audit_filter_syscall(...);
  if (state == AUDIT_RECORD_CONTEXT)
    audit_log_exit();

... of course I would expect the performance to be roughly the same
when there is no matching rule, but I think there would be a
performance when in those cases where a watched inode triggers an
audit rule.

Beyond that, there is probably work we could do to combine some
aspects of audit_filter_syscall() and audit_filter_inodes() to
eliminate some redundancy, e.g. reduce the number of audit_in_mask()
calls.  Actually looking a bit closer there are a number of
improvements that could likely be made, some might have some
performance impacts.

Let me know if you are going to pursue the suggestion above about
reordering the audit_filter_*() functions as I'll hold off on the
other changes.

-- 
paul moore
www.paul-moore.com
