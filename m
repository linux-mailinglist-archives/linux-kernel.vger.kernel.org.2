Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A878F30CE2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhBBVpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhBBVpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:45:41 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F6C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 13:45:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q2so9887545edi.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 13:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqE3NBkcYof351zw0GZ4Pohphx1oYlmm/8WK6ccPjhk=;
        b=vyQwafCdNmvMb9BCPCrecMVqY9gMT8SYwMzFObX0IzV/enZAULSGo3VH4dZseE+H2U
         cqA29xvLCqyRLXD1l+jYUtJEcNJFtUp35vYZTyfxFDsziSZidOJug4qqzHFwveaOQCq4
         CgOrT/a5qLhXsbKhhM80rxuFoMfNBucUHz7X2Rth/+gHQO9F+gCFg5xVLAiO2kFr6n73
         I/sEUYMDTmZ2LZ3B3pl2dRXi0vj4tGjyx6FQNOfhDQm5uIT5MB8bzErLBc9BHJxAa+Q5
         svfyf310gyAVuehwKZH/Jsbl4EGvF5cI1aAaC7KcSiFqtguU9oVlPPWRTJ8o78IaaIuA
         NmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqE3NBkcYof351zw0GZ4Pohphx1oYlmm/8WK6ccPjhk=;
        b=L3ZlwaGQRzAonfx5fzefwLUpseDPdCSMeDZUBofCpw5nyY/RFLzH4rcUyGDEZ9KMrd
         8hlpw4PoGXqjOW7CQbCxE9BRnYxN58xQZ0hM2SZd5s7bMj5zbkGVM8E9kRVkJn0vsRdO
         bQauTPnq7YigNojo+Td38/8fO/MiaqzAY49+VSS/ODASDrYLI1neIPJHlhwnQgEm6k70
         cJNu9l+q52x4hD2aLI98ViSaOejXewXb1wlfvZ9Lc9tHKh3Gw6Vy8CqZB0YSd/Dab2RW
         pgDC/lNG2zB/tYtbYaiMH1SJC/Zh/2Gjk8VXwRh9zM4in7GQ8fPFk+i0b9hXfo5E9v17
         7ZCQ==
X-Gm-Message-State: AOAM530/hWuDymsgjEYbr47jP21WGpGaUs4Xgy8+lwMMU3IFdMuhQeas
        oHOOI1nyCuNlqDFTha53CG/mAxzU02faAtKfKxwUJ8PODnwO
X-Google-Smtp-Source: ABdhPJxOBFi9brI4qqJZ7PRXNM/LhhjWpc226wQCu4D34YiD5U69GMmAkx+jxIY8Wqs4OTiU0jr3QJ8wbA28O58BJDw=
X-Received: by 2002:aa7:c78e:: with SMTP id n14mr103716eds.31.1612302298389;
 Tue, 02 Feb 2021 13:44:58 -0800 (PST)
MIME-Version: 1.0
References: <20210202212930.18845-2-danielwa@cisco.com>
In-Reply-To: <20210202212930.18845-2-danielwa@cisco.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Feb 2021 16:44:47 -0500
Message-ID: <CAHC9VhTo_aTTsS5W-+AJe+RrNG4yL3_TbfOKZhZfpjg0QkkZUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] audit: show (grand)parents information of an audit context
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Eric Paris <eparis@redhat.com>, Phil Zhang <xuanyzha@cisco.com>,
        xe-linux-external@cisco.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 4:29 PM Daniel Walker <danielwa@cisco.com> wrote:
> From: Phil Zhang <xuanyzha@cisco.com>
>
> To ease the root cause analysis of SELinux AVCs, this new feature
> traverses task structs to iteratively find all parent processes
> starting with the denied process and ending at the kernel. Meanwhile,
> it prints out the command lines and subject contexts of those parents.
>
> This provides developers a clear view of how processes were spawned
> and where transitions happened, without the need to reproduce the
> issue and manually audit interesting events.
>
> Example on bash over ssh:
>     $ runcon -u system_u -r system_r -t polaris_hm_t ls
>     ...
>     type=PARENT msg=audit(1610548241.033:255): subj=root:unconfined_r:unconfined_t:s0-s0:c0.c1023  cmdline="-bash"
>     type=PARENT msg=audit(1610548241.033:255): subj=system_u:system_r:sshd_t:s0-s0:c0.c1023        cmdline="sshd: root@pts/0"
>     type=PARENT msg=audit(1610548241.033:255): subj=system_u:system_r:sshd_t:s0-s0:c0.c1023        cmdline="/tmp/sw/rp/0/0/rp_security/mount/usr/sbin/sshd
>     type=PARENT msg=audit(1610548241.033:255): subj=system_u:system_r:init_t:s0                    cmdline="/init"
>     type=PARENT msg=audit(1610548241.033:255): subj=system_u:system_r:kernel_t:s0
>     ...
>
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Phil Zhang <xuanyzha@cisco.com>
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  include/uapi/linux/audit.h |  5 ++-
>  init/Kconfig               |  7 +++++
>  kernel/audit.c             |  3 +-
>  kernel/auditsc.c           | 64 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 2 deletions(-)

This is just for development/testing of SELinux policy, right?  It
seems like this is better done in userspace to me through a
combination of policy analysis and just understanding of how your
system is put together.

If you really need this information in the audit log for some
production use, it seems like you could audit the various
fork()/exec() syscalls to get an understanding of the various process
(sub)trees on the system.  It would require a bit of work to sift
through the audit log and reconstruct the events that led to a process
being started, and generating the AVC you are interested in debugging,
but folks who live The Audit Life supposedly do this sort of thing a
lot (this sort of thing being tracing a process/session).

-- 
paul moore
www.paul-moore.com
