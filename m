Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242D54329D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhJRWky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:40:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48122C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:38:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y30so4281409edi.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJDfmyop/V4rvl65JIYoaDp6WS/FqduuNkWdpWg5ihg=;
        b=PgO0iBVzgV2hk1s+hEvbt/eSwhu0I08HyB7L60bLVrL3Pdf4qansEmG8o1q17wMICs
         aixjwdnWs4xyV8ymGwX0DrJUhv7b2ZXhoRlFbCYPw2/a/xobdtgqCJvgXUAYbvGPjpTq
         qmd0tidfmy55WhN3S8kNCYXEYNEaDbEmMnPjKD3bqfjCaoBld9BLyo61LTk0aXhqgm9m
         d0yoFRXWa3tjnGXx0jQFqSnH8Aeca7FCsjWYRM9SDm+xtvh07tvHDH4p8GaYuyjunljt
         ldEC9rTS8gUg0MfpezZzAbsN18e86VQeNezSQWLpXXjpu7BKwKTwxotVunq8s4/avW0P
         rSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJDfmyop/V4rvl65JIYoaDp6WS/FqduuNkWdpWg5ihg=;
        b=IyI1/Oy1yMPkiwhjag8e6scgiVKKqfmVZvpJBVm6xL2ZdnhEZIopSqMZKvtRV4Kl51
         ewP9mYHJ7md8Dil+Mo+/7ZAfFqutPNHY4Td1gBEjIO+RAw88x1LCYyTwrFaDzre9H3gC
         wIRgX99GMG97Mh6UjPb5z1V8y1ojEj3udp+WzIWuKfo+DYZh0vCRljCXEYG+L8+QplN3
         3+RiDG/rfn8lnFBnioFazYHt5NvENYmnPG0iHV5gWzAZspnuvbt1mZCAhuL5DI3UN64+
         5mMSkh4nVn4xrxD49ytNVhlxcv5/SKE17lqtV9783R6fMh5hKfeMKyqq6VGWbv1INrxj
         YFsA==
X-Gm-Message-State: AOAM533PxWcNwrTN4pM+Na21mkYS/v02iyKc6NOkHZzkD6omxBfANQyQ
        7CeQlwFK17Oc6Hnk21uoAManC947mQInmUZLovsE
X-Google-Smtp-Source: ABdhPJyufqACuVs9xSaXi0aNgHv5cNi7aWflgOkVwEWLvhrcqzczYH7N9io59h8+yZtJn9qjV+m8URssrzj8ClQxp4Q=
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr47802673edd.256.1634596717804;
 Mon, 18 Oct 2021 15:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211016072351.237745-1-cuigaosheng1@huawei.com> <20211016072351.237745-3-cuigaosheng1@huawei.com>
In-Reply-To: <20211016072351.237745-3-cuigaosheng1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 18 Oct 2021 18:38:26 -0400
Message-ID: <CAHC9VhSyFrEV5c9Z+aMU+WL3zi88A7ZJft-ic6cUH0mpXEzkxQ@mail.gmail.com>
Subject: Re: [PATCH -next,v3 2/2] audit: return early if the rule has a lower priority
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     Eric Paris <eparis@redhat.com>, rgb@redhat.com,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 3:21 AM Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>
> It is not necessary for audit_filter_rules() functions to check
> audit fileds of the rule with a lower priority, and if we did,
> there might be some unintended effects, such as the ctx->ppid
> may be changed unexpectedly, so return early if the rule has
> a lower priority.
>
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  kernel/auditsc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Merged to audit/next, thanks!

-- 
paul moore
www.paul-moore.com
