Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0108D40B8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhINUEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhINUEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:04:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B0EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:03:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y28so1067908lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z+PxJcPDFHKhLidz43OpQIl4xQ/achkAfQ8Re5y2cOQ=;
        b=fcSz/fDM5ZUPGy3GEMeYii2Mxh/ipolL/v2vDh+qK9ADUjfXlFd3srXHg9A+o8Pmot
         n22YK0z4o/I8BYxXDzQ3BS6AWAC5kHEw+OHh03vX0v2TJL7SqBHx47TacnNtNh92CNRV
         fYIa/5xLSo1HRcb1pxNb1EXaluai7a63A3hPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z+PxJcPDFHKhLidz43OpQIl4xQ/achkAfQ8Re5y2cOQ=;
        b=sy91KpzYSbnFPxmrq/uOeHJMksqCf4AmTOUn9Y7D0RptQ357IBzGjwYMU0whUfGGaJ
         /fcYMIWE8sB0wHNvDa9rzbmzQ2ZiEcQm20XZmb2mF109fATqymlM0lYhvsivpmu7mIAz
         +ndTCJF/5BcGv7xbap02rVqH8SwS0KzI1akze70QDqLgrqDd2SdXDmivTVh8qNoxF57c
         yIdtSXeZK9+lI8ogmXP5JQB8NkreAtoJw770Mr8imce3qyP/CCUlHywmyEAtm74YSkyG
         nUi1uzZSwFJT4U9GhT1UzuzfY+zpRi2sWOXstF2xt2HOVwlCLRyabrTWDEYUDjMyuVoh
         VEdw==
X-Gm-Message-State: AOAM533M+43BVfblxv3BGG8v5Qe9GDEM3bDPHZFnIyNihhIsskPDK0MV
        AfsojpZ6UH2856uGQqImKI208xxXOC+1vsnt5Gs=
X-Google-Smtp-Source: ABdhPJzg3Z/qTxr3PYc/CK0krR/R8jHHUas4PcbdRO7jO7kCu/l7N9rmqbgbduDv/KGGNSAfCwBnUg==
X-Received: by 2002:ac2:558a:: with SMTP id v10mr11209510lfg.338.1631649807155;
        Tue, 14 Sep 2021 13:03:27 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t15sm1404240ljo.102.2021.09.14.13.03.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 13:03:26 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x27so937616lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:03:26 -0700 (PDT)
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr3057776lfu.280.1631649806277;
 Tue, 14 Sep 2021 13:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210907100302.3684453-1-ray.huang@amd.com> <5e365947-4ae1-47a0-7565-7f0cdde0bd84@amd.com>
 <CADnq5_PXOXiob3k5Z+cZz6K2k5iSCdzwNm0ZxKQOuC+PvdJxxg@mail.gmail.com>
In-Reply-To: <CADnq5_PXOXiob3k5Z+cZz6K2k5iSCdzwNm0ZxKQOuC+PvdJxxg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 13:03:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=rz3trQgOJ76pe1poCtmFkat-Y_Dm9_x=fzb27OszJQ@mail.gmail.com>
Message-ID: <CAHk-=wi=rz3trQgOJ76pe1poCtmFkat-Y_Dm9_x=fzb27OszJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: fix the type mismatch error on sparc64
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:48 PM Alex Deucher <alexdeucher@gmail.com> wrote=
:
>
> On Tue, Sep 7, 2021 at 6:25 AM Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> >
> >
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Is one of you going to push this to drm-misc?

I was assuming it was there already.

I guess I'll just apply it directly.

         Linus
