Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E7D39CC5B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 05:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhFFCmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 22:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhFFCmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 22:42:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC8C061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 19:40:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c10so20651669eja.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 19:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4L84HsDMRengwvFhR659voK60eMx8oWTg2lyl+BZ6GE=;
        b=U1sRFJdZfGmi+uonE4HR8vlXGoFVNwiVuAJCmpVtbD36Nxuod80lcLMjSVTqKAuiNx
         V9cTSp8eBVcPqfFvaiOLEbXAknwriuTtHitm8fnubfKye/9oO7KCcakBdty+cRP6WSkp
         Z1lSj4YMfxi6PHyjGP+7z1wVvutZXxIPrPN0Os8Ewt+n+G8kJzQMHfn9pBzP0ddCfly6
         A0V8YkhQxte5oc5ynbAATIoTTVHe0SlV7XDqRvgr1CGZuWFY/O+WpZnLsJGhCYKixldv
         IJqGPABbt3b1QTJnnLVd6mpMIZ314sAqZU5D3MPJ0j889ID0QeqU3bw8lg8lz7DfqDnr
         Qe2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4L84HsDMRengwvFhR659voK60eMx8oWTg2lyl+BZ6GE=;
        b=dlkuIEhYqFyjdAfONDIvuCvyyuzA8oAjYcnLh6j3xqacjp5wmZWJYmg3K5GCd7fTke
         cx686jSwWbEx16GRalPP7KWsFZlnWoXPfQvtckEIm4z6kegLeZ5s3asQolAu8kfaS+Tp
         y09qKqWp5z7L7RVnFzPkx+tbuTzBYX3dPV+YXX71P8/AQBgjXlMSewEc8mXue7/o2g01
         uMaKJfLGpexb1DRxGCl+DJCf09flvJobKmDE72uK+HoHgID5hxJFu31VnbZFi7OfYiTq
         t678ryOuXG99qlsuEJ1J0bVqYETJmEL/kDoKMBjnbER8Jdlo8IV+P7pGAvcUoSLxReAi
         YmFg==
X-Gm-Message-State: AOAM532FLvS+Ce8QNlw/1TBigwsB8dGzR22AOXSdTt4FL8EcFgpGujVg
        MWUxHOaJkKsimmCnQXqtFPMxa7phbb+WuaTcNFUU
X-Google-Smtp-Source: ABdhPJyITF+zXTKJLERj2eWejbByBPtfZx5bFbGZcT3Sqo2IKXinI2tkStI/3LUJRpF332yw05FDeHhES1mCzG7rfHM=
X-Received: by 2002:a17:907:2bd6:: with SMTP id gv22mr11413863ejc.431.1622947216905;
 Sat, 05 Jun 2021 19:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <ba47c2acb7bee9102bb6a85e9ba8b5918fa3610b.camel@yandex.ru>
In-Reply-To: <ba47c2acb7bee9102bb6a85e9ba8b5918fa3610b.camel@yandex.ru>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Jun 2021 22:40:06 -0400
Message-ID: <CAHC9VhTvp3Z26JbXJdq8p4T7w3GZk-1CFWY328o75-AqqUbNTg@mail.gmail.com>
Subject: Re: [PATCH] audit: Rename enum audit_state constants to avoid
 AUDIT_DISABLED redefinition
To:     Sergey Nazarov <s-nazarov@yandex.ru>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 7:21 AM Sergey Nazarov <s-nazarov@yandex.ru> wrote:
>
> AUDIT_DISABLED defined in kernel/audit.h as element of enum audit_state
> and redefined in kernel/audit.c. This produces a warning when kernel builds
> with syscalls audit disabled and brokes kernel build if -Werror used.
> enum audit_state used in syscall audit code only. This patch changes
> enum audit_state constants prefix AUDIT to AUDITSC to avoid AUDIT_DISABLED
> redefinition.
>
> Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> ---
>  kernel/audit.h   |  8 ++++----
>  kernel/auditsc.c | 34 +++++++++++++++++-----------------
>  2 files changed, 21 insertions(+), 21 deletions(-)

Hi Sergey,

Thanks for sending a patch to fix this problem.  One comment below ...

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 1522e10..ee81f20 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -21,16 +21,16 @@
>     a per-task filter.  At syscall entry, the audit_state is augmented by
>     the syscall filter. */
>  enum audit_state {
> -       AUDIT_DISABLED,         /* Do not create per-task audit_context.
> +       AUDITSC_DISABLED,       /* Do not create per-task audit_context.
>                                  * No syscall-specific audit records can
>                                  * be generated. */
> -       AUDIT_BUILD_CONTEXT,    /* Create the per-task audit_context,
> +       AUDITSC_BUILD_CONTEXT,  /* Create the per-task audit_context,
>                                  * and fill it in at syscall
>                                  * entry time.  This makes a full
>                                  * syscall record available if some
>                                  * other part of the kernel decides it
>                                  * should be recorded. */
> -       AUDIT_RECORD_CONTEXT    /* Create the per-task audit_context,
> +       AUDITSC_RECORD_CONTEXT  /* Create the per-task audit_context,
>                                  * always fill it in at syscall entry
>                                  * time, and always write out the audit
>                                  * record at syscall exit time.  */

I believe that just as the AUDIT_ prefix proved to be a bit too
generic, I think that the AUDITSC_ prefix is also not the best choice.
Would you object to using the AUDIT_STATE_ prefix?  As that may get a
bit long, I might suggest dropping the _CONTEXT from the enums too
such that you would end up with the following:

  enum audit_state {
    AUDIT_STATE_DISABLED,
    AUDIT_STATE_BUILD,
    AUDIT_STATE_RECORD,
  };

Thoughts?

-- 
paul moore
www.paul-moore.com
