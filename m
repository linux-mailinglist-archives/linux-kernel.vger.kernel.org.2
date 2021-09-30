Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2D41E2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 22:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348142AbhI3Ui3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 16:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhI3Ui2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 16:38:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFBAC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 13:36:45 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so8925818otj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C0b0Hq/LPYCpY2/2mq/Adw+L8zwSj+4o7ctZaqLsgik=;
        b=CsYQryrzj6jYdwNEy/z1ZPKJF5SyBxlYW40KPR9rkWCmSUaS+8ciUtkhQFxh4GFkXS
         hbTsNxnszOQnnNjnghl9wlNFMymtNeQNrELW5yIPUvpo8jTc9pTEybJOqLj5KULiPDJZ
         DHwjbfGlbp3z863DbSWCuXVLZghGLgg5oA5SdkRwckKYx3BuoWKYgE5wc/gbsv8bh2Tk
         4GMx1mNAHXX+kapgoUWOYDCS1wH/ho0lqybOUWvr0PjDnyvXLYOuIDzJam36fkOEnevw
         AVg8fTnkjQpivYfFzb0yHOq16C0JdrJzEXWdgacKdCVmf8wD5VXftGXGBfF8GkDq/vKt
         +ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C0b0Hq/LPYCpY2/2mq/Adw+L8zwSj+4o7ctZaqLsgik=;
        b=TXoT2lkhnu5xeTawMYGr15LMXnEBqJUzGIAkxqb6gtWLmmMrqa8haCnLkFEIllsCMd
         uHctaiXKF3pXkE9e6gmIbXBjXk196wsXtuG1TIzbYlnU82IltjEllbebo4M4rzahz0in
         rV2VES0PZ6P96PTNF94OhWBcYPtc/x59Qh7JB2q5HpUWO8i3vv2xpZsLxb9Z/x+UYSQB
         NjtAHh/lMfUri3Kns3iXz5DOTGgJ1SjGoEk4B+/yUaPLyzXa13qHCSQ4CXjlyzwYuuLj
         BzMU/TpQj2ZvxaZJ3hVgxMM8l0FWdk1fipjd3QD116ADyYNA/QknStswZ2y8Rb7rnYlG
         ZRpg==
X-Gm-Message-State: AOAM531vafq+EAIwrnhPm8ti7UeLx48GF1OwxI15mQHWzw0xn9h7qt9U
        IFDOWQGTzTbD3amtF9b83HiNXLv7d510YeEZue0=
X-Google-Smtp-Source: ABdhPJzgWrrn1lG/uf8m8Y072LrtYojw2gJ8ABZQUrjI5Vhr/KmpovudArA6EvelUiRTfXS6ukIKJ0rtRhbLOgYnUOI=
X-Received: by 2002:a05:6830:1bc6:: with SMTP id v6mr6899764ota.299.1633034205062;
 Thu, 30 Sep 2021 13:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210930203458.441556-1-trix@redhat.com>
In-Reply-To: <20210930203458.441556-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Sep 2021 16:36:33 -0400
Message-ID: <CADnq5_PVz+2XxKfPJxSb3-s+ukPKeGLCSxRwT6X6hduX8_n0Yw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: match the signatures of the real and stub kgd2kfd_probe()
To:     Tom Rix <trix@redhat.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 4:35 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> When CONFIG_HSA_AMD=3Dn this there is this error
> amdgpu_amdkfd.c:75:56: error: incompatible type for
>   argument 2 of =E2=80=98kgd2kfd_probe=E2=80=99
>    75 |  adev->kfd.dev =3D kgd2kfd_probe((struct kgd_dev *)adev, vf);
>
> amdgpu_amdkfd.h:349:17: note: declared here
>   349 | struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>   struct pci_dev *pdev,
>
> The signature of the stub kgd2kfd_probe() does not match the real one.
> So change the stub to match.
>
> Fixes: 920f37e6a3fc ("drm/amdkfd: clean up parameters in kgd2kfd_probe")
> Signed-off-by: Tom Rix <trix@redhat.com>

Anson fixed this up earlier today.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.h
> index 38d883dffc20..69de31754907 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -346,8 +346,7 @@ static inline void kgd2kfd_exit(void)
>  }
>
>  static inline
> -struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, struct pci_dev *pdev,
> -                                       unsigned int asic_type, bool vf)
> +struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd, bool vf)
>  {
>         return NULL;
>  }
> --
> 2.26.3
>
