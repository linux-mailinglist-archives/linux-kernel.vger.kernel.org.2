Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4735C672
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbhDLMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbhDLMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:41:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9495C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:40:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g66-20020a1c39450000b0290125d187ba22so6308507wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDtDoRs+7JTKmRSNbYm/eoC5RrOrbwKn07hGic3mdK8=;
        b=rWpSopbfXoidRd+rBu8OzHyrQSkM/8rg+DbhCxV40cfP343hyJOaPcMVGstU61R6HS
         FB2FfC6o7MQv9Scm43yyGbYMY4eDR26hRa7lMtjQLsMj0aVRtGpPFCTMjzSkZPHGqM1C
         ludoR4jQjsaAzQvje06u04ytzHvzkLSKkLIzF523OkzNQV+Rabg4BSNY0koV6kmI7yNj
         9SD/NpA1ohOrGv6jkWGVx/5bXWbyWWLoybs3/aoWgy0fg8yvFSNAWCQGT7Q9AXj8TRdd
         7+IcHxNf0ahsCTBp2Q9vjkz9Vp7+xAVUYZpzrHyZxK08kFePpDl8i6RiyFmnFRdlLme2
         PUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDtDoRs+7JTKmRSNbYm/eoC5RrOrbwKn07hGic3mdK8=;
        b=Qn4qBB0A5xlF5xKT5OOXEfEJ3OHiI5BmjdEJEkF9XxWfVIFxTu8AS3p6BrYapxNGyT
         DN0d0mc6tEMyTYWKuczq3ya7DlK0DyU/6s1SroqO3Ey9W3/EVHBMMJKkkbbxZGLVy+dv
         E5k/CYx0Zps860oDjhhPmZ5RoOOSFHxtjrvAJaxL/B6AHXhWRa/hUOvmbPE48WGCBrzh
         ME4NVWFGUmf8eEEvo0AbSHSUKaZlHCsHk2YeqUOBvAX80S+8WbMiTJwrm64q6vQYHAVr
         CODAHywYlWYhWmfGDynHxyERpROXvduVphj3ExD/mJ1b/8e02qBYmafeTPGCp0eJjQuz
         llUg==
X-Gm-Message-State: AOAM533avV4ZIQUYOxqB8nTH5MBFnzffNNq/z24IsYJrBmzMpA4ZCJcW
        TAVAdINBTepeX0XaXzUunA/PFNMJ/olGnhXuPcM=
X-Google-Smtp-Source: ABdhPJwwzJV0JxFgyJYKPbig9riaMMb4hkRQqbS7qviEMxuCuPwShBYC81dKvxPFisExlNuFbUS1LVEVUA3QZEcTxAM=
X-Received: by 2002:a7b:c003:: with SMTP id c3mr26208794wmb.59.1618231248564;
 Mon, 12 Apr 2021 05:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <1617957240-53633-1-git-send-email-tiantao6@hisilicon.com>
 <CAGngYiVfattJKO7npMHTagxNfzU-B=rP3FoZ89_yzy-c=Zw2RQ@mail.gmail.com> <44f55f42-cb52-f705-c40a-6d5c1844f56b@huawei.com>
In-Reply-To: <44f55f42-cb52-f705-c40a-6d5c1844f56b@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 12 Apr 2021 08:40:36 -0400
Message-ID: <CAGngYiV2dH4nLkFocyL4YkYkL3qu_kyB5ELZbWLeFMjjsFRpwQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: simplify devm_anybuss_host_common_probe
To:     "tiantao (H)" <tiantao6@huawei.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 9:14 PM tiantao (H) <tiantao6@huawei.com> wrote:
>
> What about doing it like this?
>
> -static void host_release(struct device *dev, void *res)
> +static void host_release(void *res)
>   {
> -       struct anybuss_host **dr = res;
> -
> -       anybuss_host_common_remove(*dr);
> +       anybuss_host_common_remove(res);
>   }

That looks like it could work. Can you resend as a "proper" patch,
please? To tell the versions apart, simply specify [PATCH v1] [PATCH
v2] etc in the patch title/subject line. Then below the patch's "---
line", add the version history.
