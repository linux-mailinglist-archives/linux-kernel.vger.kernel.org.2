Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2380405B98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhIIQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbhIIQ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:58:05 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA61BC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 09:56:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m4so4020796ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVjhQf4Wc5qDwKc6Wxkb4xPFLHy4YamVgNh/i3e/aqg=;
        b=sV1HzMzIqQ847QSIIUoHp201jmkdi8+7JMKKQdM8EinRPUqW6MxoJPuy/M2sRh2YX8
         xGwcv5MvtoepmTeQz63R00ZU3mkodxx8Vtuf7cefIh7JiddrNc0Yd+HLcMnE0u5OAfR/
         fweeDgDPOYX5WlQZwmnM8z7OYcNcHK5+OUWA6PU/YOo3Ef1EPu2B782teb163N0EMh5v
         mjd6zGLdXtWdZIVYySo5svms0Bzb+9s5hNCnj2sj2n75/Y3AjSmdyyKIMNTBPT1kXSVH
         /V0DIbMAyvMrgOFxygJGca5bv4qaGEU//VC0F8i/MejvgsFhmMA+lFU74x5dSN7tsYCr
         da0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVjhQf4Wc5qDwKc6Wxkb4xPFLHy4YamVgNh/i3e/aqg=;
        b=vLhmivwnprr0ab349aSu7IyoOsx3Wr0M6viVr5Rq2FRQtUS2IaaRO6cqDxeiI6hTIl
         NHuoIqd5VOU7s8kheFcTE454ZDpckjS5WGW+c+sy8pMYTQbXw1H6B9/Uh7oPDZc+Af2Q
         d50NSYIW2DrhELKXDVAiBUSmA9XrpX9Z4H6Vmp6qG3LAR+ZnafA3/utignhIQULBcMtG
         v2mfTIv3hrB+VCQSFP8LcnaIs/qIe+OnF5Bcy9WDx6cgdBVFbWfcOvyu4q8JaCN/vac3
         CdAohhHdfSHYuiXLfL0UjBA8oFIZzVdiyWOTicbAiCYIq3v11UE6Kb22ppBl/V2yyNKn
         bdkQ==
X-Gm-Message-State: AOAM530R58I9hEwWptjAXFWqdIt5Y3lk2RubdGVMHfKuWFwFW4IejXUj
        D+dLYYy4aWpR/CsbItGvRyeZoeuUPQ14xmkBQvzkMQ==
X-Google-Smtp-Source: ABdhPJyBVMMchSS0qFtishSD9a5wrolWJ8ciw91FaTTuYLkugS9n2LgQcH50i9XKqfmx+Hyck1TZPoAOaz3VPVWAemY=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr677223lji.508.1631206613776;
 Thu, 09 Sep 2021 09:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
In-Reply-To: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 9 Sep 2021 09:56:17 -0700
Message-ID: <CAHVum0cGkzLg_5fZNFNTG=RRqGYW-8YG2V3gst1TevjtQ4YdBA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] misc_cgroup: introduce misc.events and misc_events.local
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mkoutny@suse.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 10:24 PM brookxu <brookxu.cn@gmail.com> wrote:
>
> From: Chunguang Xu <brookxu@tencent.com>
>
> Introduce misc.events and misc.events.local to make it easier for
> us to understand the pressure of resources. The main idea comes
> from mem_cgroup.
>
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>  include/linux/misc_cgroup.h |  9 +++++++
>  kernel/cgroup/misc.c        | 50 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 58 insertions(+), 1 deletion(-)

Thanks for the changes. Please also update the documentation at
Documentation/admin-guide/cgroup-v2.rst for the new changes in the
misc cgroup.
