Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2223D81F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhG0Vlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbhG0Vli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:41:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97064C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:41:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m13so24252718lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s93ky4F/jioIoNmdtZvpaIjb8/udfZPafTlFZjDMqHQ=;
        b=R8iLQFVMijNvae4GMHQsDyKNJF1x6r0W7+1jWZhTLpPYX7jpQldHzHrpSGKdSGe8OB
         2dUeA4EQCX8Qhh8ndamI5LuUzwNaMLGiIjV/goZKSMkcQeDY81ehXZ907DPyaA0k6eyk
         6JSfkAPSRjslQzjF22lcu5/hizvGfzsfq/oP3Hl5uzqq6QpEGU03LVJIFm0ek2RbdTBS
         QHPA2SP83GMPrVFBySAAhlD43A1Qaxjb6vifSAvDl9b1vwStGPYCvohj3pP/l3Bx1MpG
         RkuHnFM0MrGqkZWeNzKMpd8+6OK2JCZPEBFaJe5l7sjk5VRrvv/O5G5IePluX4xby4R+
         xbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s93ky4F/jioIoNmdtZvpaIjb8/udfZPafTlFZjDMqHQ=;
        b=TG9eQ6rneXy1RgCgBl9yVHVW9oNSzqTNvMshNzilOR4qql8oTLyxkvGikIXpTnAAhE
         z4ZuNL/IIw6dru91HMF+svBXpSmgY9sS5f7rcGiZ1V36mldh3n2zrSQATT4MFGsRuQEV
         jI7knCQIdipnR1tTqecMNMq9LSjpqzHkje3uZjSwNDYG0xUw/GUEjZXCMTzqufeJQSJp
         ubPnp3/CJk7dahH9s5ogHonJd9kfqyxR54I2RD4e+uB4XZuJcx480HAl7Cak6+aLqvao
         lmtn9uHvuyBK7vqUrYwMtiLDQpdwcUi+YmvSpnW6aslCn9p/yK2r5hXgsmOdik+VxMWS
         c+Ew==
X-Gm-Message-State: AOAM531F/l47I/o6TdnWiGuUirsz3O94XkH5SPGxE9ancKFw2UK7aJFC
        6/uhyO6eOtmFcBQU99mlaaod2/Ftmxv2GGK2AAQ5aA==
X-Google-Smtp-Source: ABdhPJxr8Yyt8L0du5zCgYW2LNbT/Y9UwNtbKzX2hkrtXXoTu7RlfDx5JR0o5i2oAGspuWvPpzMgLwQgDU2+wEK13Rc=
X-Received: by 2002:ac2:4d86:: with SMTP id g6mr17764047lfe.549.1627422094752;
 Tue, 27 Jul 2021 14:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com> <b009f4c7-f0ab-c0ec-8e83-918f47d677da@virtuozzo.com>
In-Reply-To: <b009f4c7-f0ab-c0ec-8e83-918f47d677da@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 14:41:23 -0700
Message-ID: <CALvZod6xT-Hh3Jndh4uY_YXstjk18Lq_kLxo1huBPnb8A84Wew@mail.gmail.com>
Subject: Re: [PATCH v7 03/10] memcg: enable accounting for file lock caches
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:33 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> User can create file locks for each open file and force kernel
> to allocate small but long-living objects per each open file.
>
> It makes sense to account for these objects to limit the host's memory
> consumption from inside the memcg-limited container.
>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
