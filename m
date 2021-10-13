Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74E42CC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhJMVO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJMVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:14:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE49FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:12:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z20so15655733edc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1LgKY9ubJwkEIHDGsg63hyGpmKH47suPVaXuM2S3ec=;
        b=VKqbb/4vPpf51Tc4j5Z45Sf3Zz1o4H/vNa/IrPfr3ggAxr8mLwee/dGVhmaGV+2fpz
         SJ+Lk130pXh5HB7kD1XYc5a98MeiqQ5AuLG/PJlHTXV8Jl4qUCWFEspQa2pAhB0qwtxF
         BpKUFjZeDvSXMhwxODPSe51qoCqkr9ihle/jnoQ86Ajh9syi4H/hG9G9HenDxYGeQrrw
         CamZKxSNdAl+LtOpgdzYgrWtsiaGQIcqy7MgdKNCtFNjtFai93n0ixERXGSlIJdESus4
         aw2OTx7yNu8VBK5ULb0RokU1bgVcUg5fQswkAnnhQNYeCVx3inrd02efClpRlWX6Q36I
         1BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1LgKY9ubJwkEIHDGsg63hyGpmKH47suPVaXuM2S3ec=;
        b=Q1R2V1rGaFKZgsfM0hCzIiHOODYNhNsX5jNlUH0JkcOOMS7N3urzHDCXoeGBv1l3/J
         FL+mZ08sAIx2Amimg/jaLDbMRN6CxPXX+TFKA2ZLB1E1CZ9ZTZGWE58GVTeE50ywS7Np
         DRG4KNGrgCao4YRt61FKgRXRNs2akRDBH22fYPfA3uTG4OTdA/E1EwI41x4P4ZHPonA2
         wKVcm8oREHILmFp26BkCjf791yVZdpHFcgXGJ9JMKgchAP5zGO13PJLCMjLX3bCRLnHK
         juLEZ1x4HlI1DVH+Wv5hJWNM7JlSKXtAF1TvS4TK4Qlg63fLIf+Wqv5G0fqz+NhOUjdf
         3adA==
X-Gm-Message-State: AOAM532oOUIH388Y/i8LzbULl/VtwP+YQHBopgxU+znAH/YyWL3wGYPE
        ZMGBIBzUF+A9vZLQpyvVohytIfQSMMM4f+gfPUF4
X-Google-Smtp-Source: ABdhPJyAiWQXGQhIqSy4BRdxxSMzu4wtimoLcUmCiwhwOPD13Peavb3ClTRn5qpYIdmr7XV6U9ZqUK9coskHkfzuO+o=
X-Received: by 2002:a17:906:d975:: with SMTP id rp21mr1923350ejb.104.1634159569393;
 Wed, 13 Oct 2021 14:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211013091208.36209-1-cuigaosheng1@huawei.com> <20211013091208.36209-2-cuigaosheng1@huawei.com>
In-Reply-To: <20211013091208.36209-2-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Oct 2021 17:12:38 -0400
Message-ID: <CAHC9VhQR4OZWRrQODEjBxhjpH3yPRqPFE4X6RkVFEmv1e9Z8iw@mail.gmail.com>
Subject: Re: [PATCH -next,v2 1/2] audit: fix possible null-pointer dereference
 in audit_filter_rules
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, xiujianfeng@huawei.com,
        wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:10 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> Fix this possible null-pointer dereference in audit_filter_rules.

Thanks for fixing this, just a couple of small comments:

I think you can drop the description text below here, the code snippet
is just a duplicate of the code and the error message is pretty
obvious.

> If ctx is null, a null-pointer dereference will occur:
>     case AUDIT_SADDR_FAM:
>         if (ctx->sockaddr)
>                 ...
>         break;
>
> audit_filter_rules() error: we previously assumed 'ctx' could be null
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

I would also add a Fixes tag, for example:

Fixes: bf361231c295 ("audit: add saddr_fam filter field")

> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4ba3b8573ff4..42d4a4320526 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -647,7 +647,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>                         result = audit_comparator(audit_loginuid_set(tsk), f->op, f->val);
>                         break;
>                 case AUDIT_SADDR_FAM:
> -                       if (ctx->sockaddr)
> +                       if (ctx && ctx->sockaddr)
>                                 result = audit_comparator(ctx->sockaddr->ss_family,
>                                                           f->op, f->val);
>                         break;
> --
> 2.30.0

-- 
paul moore
www.paul-moore.com
