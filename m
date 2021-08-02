Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7B3DDD72
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhHBQTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhHBQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:19:03 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6890BC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 09:18:53 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id d3so9115986qvq.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqSi2DWJQSHFbeSWRi1dH74yVKtdTqQrPRmLEYWYlbs=;
        b=h/XQdhlILCw/+Q5AVlBwggYYgCsNnJTRn3Z6tqiQg/srd2PFd/5P0LfwY976zgfamt
         Eld7Ds6h/30s7hTfGfyHfhPfU76xhHXb13bScDcPC+XiV1tBNZQaWaRdeX3qiYaWMxQ3
         FmpoEwvQv4H3xkX/sbCP3CVkpVKZdsuP95PtxR4hCh3PuAYTg0bOi1oHP/T3s4qJ1iQh
         y0Hb7Q3hrOymsnDY2hgUm2CmUEOPshqEl/unsvM2yQeaGaYGFn8uNnBe607LszrJoyK0
         LKYHiKhZkHNYeuWo4OJR4+0R3gErVUk1M6pp2VyyE60cmsod8V/CYSdZC7/N8mZJDgjF
         9Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqSi2DWJQSHFbeSWRi1dH74yVKtdTqQrPRmLEYWYlbs=;
        b=VtP2oEXiXtKkhB52OK7TRGkdm1CRCFOWebEJDAEx3/qJb/jcwS+Wtn/gqwVDsZDOn1
         HE3KQo9yeptmhSp4Gemkgo77YdxFqQ9sPFiua3Skhu0Umx7W7Px7Dd10CDv41jY3Qy1T
         WQYrC+7H5y2G5HAbOoUNIPLEasBgMtJbvE9gTCWuM9v0qwRdWNYKXP9Esmrl8Cqsooi1
         PetT7XakE/uzv8YFEAXKsNvJKnx3hg8lhAJ7MaVFXVzracf648gYeSXh0/vAPIrT29fr
         dGx15Mgk2ahO1vr8TdBZcQFoxebc3F21viICB8MV+ADD4X24tdxRxZ3MxZjVl9GMF8wz
         xotw==
X-Gm-Message-State: AOAM531hDtq1B2IU14myY3NogRDZpjjLZJgVVF7AZ0zYZ52k3JHbj39Q
        0UfXEV/IscyJkElIEQ9d//RPiwd9kzYV0q+tL1s=
X-Google-Smtp-Source: ABdhPJwjeKX8dVL7c74Sv+rQlQ8wjBu7odGyPJrq3rHoCjO43yM5Gdqt+HyaXoJwAC2tNgSMrlEBo5d0qlYc/sl1Y10=
X-Received: by 2002:a05:6214:1bcf:: with SMTP id m15mr8334112qvc.62.1627921132550;
 Mon, 02 Aug 2021 09:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210731214211.657280-1-jim.cromie@gmail.com> <20210731214211.657280-3-jim.cromie@gmail.com>
In-Reply-To: <20210731214211.657280-3-jim.cromie@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 2 Aug 2021 17:18:41 +0100
Message-ID: <CACvgo50DDp3p=-2mzY8jvzuLo_4_1L+b8=x6ZRERtcVJUHcomQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] moduleparam: add data member to struct kernel_param
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>, Jessica Yu <jeyu@kernel.org>,
        Johan Hovold <johan@kernel.org>, Joe Perches <joe@perches.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On Sat, 31 Jul 2021 at 22:42, Jim Cromie <jim.cromie@gmail.com> wrote:

> Use of this new data member will be rare, it might be worth redoing
> this as a separate/sub-type to keep the base case.
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  include/linux/moduleparam.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index eed280fae433..e9495b1e794d 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -78,6 +78,7 @@ struct kernel_param {
>                 const struct kparam_string *str;
>                 const struct kparam_array *arr;
>         };
> +       void *data;

Might as well make this "const void *" since it is a compile-time constant?

-Emil
