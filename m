Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA44391A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhJYIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhJYIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:46:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39CFC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:43:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j9so7840016lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=127n9jitw+qM0/no+A5F8MwZg/H0qRee5cYZhbFBKnk=;
        b=ef5XAjLT9v/0BZJ9udketWfLHu1q6BB3uLTOyqiK/X5lFxsj0Gb4Bvgsfeg643KhWi
         xEw8n0TAvmjizLwdUrTIAKClZn+tFGYtY0Cn9omrCfy+u9OYVDocqNarDJoiwzUbvJN+
         7N0NEHVJ7pBEW1nitpveqcptf9nm66kyr4WRC620pWcjT5yPo/5r/WKpiUmrvOmc477Z
         zUwHvHZY6c6xMiUe/XiDYbxMlthlYsCY3Qd/T+Tx+VwOpW5gu58XazRw7NXKdDyRZjaU
         bLHAR30bkiB7vz84iB9z3qw29rQ+kSgPNHvMGf1mpiMjVLPZgoVGD7ZkjPy9Ta8SuZI6
         He6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=127n9jitw+qM0/no+A5F8MwZg/H0qRee5cYZhbFBKnk=;
        b=EXjdvrFwXGA3lQDiaER7/WhhHnvZMnL3SpWE3oxtUk0x8Ltv4IrajS7646kpA55PY6
         kspRmthSoZr4YIkN0R2MDJcsM4eHnXsk49W0z6LBYRxSjMvitq2hdUMgqJ4aV2D2Lidw
         wbKDMvJrpm5arSi8YWXmZKmfjaJ1ypcbmzDSIOeEMFh7vFWa3YcTVA35VHFHJoa1Z+qJ
         o0DBp62RTpTQpWW2SvVXHrYKXcYHBf1qbQTm/4vHIvMt2hdp0je8tXZTaGKMcMPDyrJB
         vc0vbkG5u49yVxDCnvY7iCBYh2yNmlD21faJwNhrsypv4UaYfWyexM6JWnG+X+i7JMde
         zOhA==
X-Gm-Message-State: AOAM5329AHKSzhxQ0J05eG0ZzYsgRToNctXJwtF9zny1APkNTLCUjaQz
        wSZx9sCHLXhsA+VgIPf+8RVLLtkF6M9VJxiNdVvslw==
X-Google-Smtp-Source: ABdhPJzjE7UWfScThA4eyQy8yhcDoy429xpQEKxElRXoLvDV+DJv7LRSJV1fAUSxnspyYcifdjOURwznJ2PEAVb3Mn8=
X-Received: by 2002:a05:6512:3c8b:: with SMTP id h11mr10140168lfv.80.1635151430262;
 Mon, 25 Oct 2021 01:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211023115209.19115-1-colin.i.king@gmail.com>
In-Reply-To: <20211023115209.19115-1-colin.i.king@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 25 Oct 2021 14:13:36 +0530
Message-ID: <CAFA6WYMJkEPOCUMeF1EL7G1q7akBc-os5GF33Dkh6nok8fANZw@mail.gmail.com>
Subject: Re: [PATCH][next] optee: Fix spelling mistake "reclain" -> "reclaim"
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2021 at 17:22, Colin Ian King
<colin.i.king@googlemail.com> wrote:
>
> There are spelling mistakes in pr_err error messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 6defd1ec982a..45424824e0f9 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -333,7 +333,7 @@ static int optee_ffa_shm_unregister(struct tee_context *ctx,
>
>         rc = ffa_ops->memory_reclaim(global_handle, 0);
>         if (rc)
> -               pr_err("mem_reclain: 0x%llx %d", global_handle, rc);
> +               pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
>
>         return rc;
>  }
> @@ -355,7 +355,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
>         optee_shm_rem_ffa_handle(optee, global_handle);
>         rc = ffa_ops->memory_reclaim(global_handle, 0);
>         if (rc)
> -               pr_err("mem_reclain: 0x%llx %d", global_handle, rc);
> +               pr_err("mem_reclaim: 0x%llx %d", global_handle, rc);
>
>         shm->sec_world_id = 0;
>
> --
> 2.32.0
>
