Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A020641D1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 05:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347989AbhI3Dj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 23:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346796AbhI3DjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 23:39:25 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE52C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 20:37:43 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id s137so2174806vke.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 20:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4b3DOEuint+WBw7an5Qknmrkjl0i1y1HcTIoKU3zalE=;
        b=BNthy7e7lNpu4+NE9vBtOHHjcEgbb9FfvTE2xiomHVM5k2AoSstsZb0Ib/bCmpHFL2
         I7MR8CYJ1bz2mS6+go3Vk3zlHbpEz2YpzUW4xC+aZL+sl50WG8u78lofZsgMmXGZO6wh
         SLuR9F9VRZ68fE7aorklrfFUs40JM6A2qD1kgg8mj6vBGvoiR/kUJ0cnY9Shc0zUkdmu
         ZSWq3OAoyiTyhP074mbKhtSX7Dif1MwN/KE1ylJ708rkMwt1FA6CQhcKE2gVly5xOd3G
         cJOK7OgaI/JneKqOYeXV4utbWJjLCypgybzg8yYzI27DyrECFZKR+YY/IVrB4p1G4/h5
         jiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4b3DOEuint+WBw7an5Qknmrkjl0i1y1HcTIoKU3zalE=;
        b=efFVIj8DlV7Y1B1/fzhlV3DfmUk9bc3dLniD9WLaaaMRIz7ZAb27f/v1BCKTOHvuDA
         tfuIlcVBxT1vi+tawe1O0oU7V16nv/Y8v8cl5OVU3xlcb6WRunJp9amzeoeZu9rFuT6y
         joeyGIv0cpV6ezVOjZFeaCExzyKGgWY+Ub19tcdcWyvDFlbqMbX70lT5knDCrKg38xig
         q/UrLKHQWbnsrUWW8SDgtSQGQtZhawBriZddk2N9GOs4rEAE6OcZrXGIowRmA3eztjhi
         xertewb1Yr565nV6oOkIxtl/tbVg8Hk3+ot5J3O2MRsdQ3vwMXOpZ2U0mJxdO55UdsL2
         cINA==
X-Gm-Message-State: AOAM533W3ub5RXf87PaB/o0zMykvumLi7sXYxYHWSV8oOBObNoHsi6Un
        2tJZrKrF9cEZYgtWBdz8UXzTqsZQ3KoEXPFvbb7F/09H
X-Google-Smtp-Source: ABdhPJziVCgaFcxzo8BazIHTTlgJGuIrwL4ipzqezGpkldOKIC4mrZi+hraS0wbXD15E+6UNWvZS0MEa3h+MYmpMsEU=
X-Received: by 2002:a1f:1f0a:: with SMTP id f10mr1667502vkf.21.1632973062492;
 Wed, 29 Sep 2021 20:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210930014427.14239-1-jim.cromie@gmail.com> <20210930014427.14239-3-jim.cromie@gmail.com>
 <a61f6bc2dc18397de92e4b7cdd9b37e2dff7e114.camel@perches.com>
In-Reply-To: <a61f6bc2dc18397de92e4b7cdd9b37e2dff7e114.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Wed, 29 Sep 2021 21:37:16 -0600
Message-ID: <CAJfuBxxHM+peMGnFQaQVOvhLC8n9GhVtWBOk1zmLwXpVmDSYpA@mail.gmail.com>
Subject: Re: [PATCH 2/4] amdgpu_ucode: reduce number of pr_debug calls
To:     Joe Perches <joe@perches.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 8:08 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2021-09-29 at 19:44 -0600, Jim Cromie wrote:
> > There are blocks of DRM_DEBUG calls, consolidate their args into
> > single calls.  With dynamic-debug in use, each callsite consumes 56
> > bytes of callsite data, and this patch removes about 65 calls, so
> > it saves ~3.5kb.
> >
> > no functional changes.
>
> No functional change, but an output logging content change.
>
> > RFC: this creates multi-line log messages, does that break any syslog
> > conventions ?
>
> It does change the output as each individual DRM_DEBUG is a call to
> __drm_dbg which is effectively:
>
>         printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
>                __builtin_return_address(0), &vaf);
>
>

ok.  that would disqualify the nouveau patch too.
