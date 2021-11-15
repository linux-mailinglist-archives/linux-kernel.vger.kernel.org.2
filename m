Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B5F4523BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbhKPB3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbhKOTAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:00:02 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2EC04646D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:55:31 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 13so37272710ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 09:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCaBN9cjIi5aRCpsKKXDJfV+b0H2vF9bTl2czt8xYAM=;
        b=M02FnHMRTh33XQlkGQXpm9/NV7JCegKM7DcVGsHpSVXi7x8I8S4C6ksMPN5Yk3bjzr
         odouE3Gz64O0uegBDOIaXbEqaIBxmHue3AGANbq1UeH8ptLYX3YFoQkspCbK2968+aP3
         Tf0Q4VtFPiXLUhW+8L5lnlM3hvAIMiSb//nLrqL8qZNw8jasEg8gWn/axO/K7ww7Lyw9
         CP74A2KUBAUfPtAk720b4i3FlhFb/HQvYd+8ln1aNxnSRJUuTTKbrv648s9qt79Ch5mU
         NU/LfCgT4XPrZgFpp6Eqj9JXAhEQDgaXHqvk6aW+9qxt2J9SHDauHVoPMVQCyEJMGrn5
         I0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCaBN9cjIi5aRCpsKKXDJfV+b0H2vF9bTl2czt8xYAM=;
        b=XgXtGu5WU4Dcmxx8VqGLsAxfE5YdnyZ7ZNuw4VY4n8Vxp0uV1HYJVVZou1D3iJOLVC
         94vUytg7OGspnOs5vTwVKXAVnPk91vHOo2+1qC2HKYQu200yhbZykWKpzUI1TqUccF7Z
         s81xvyghGzYCId+ua9/A3kOcC/JrPwO885zH9hQwCTljLgJzxtLvi7mxEf+Xr7BPi9fW
         VEkRtVOS25XDVQHTaRWbgQBev8ClHrOieZec2pYBsiOZEEvNPn52xsER0bmPkcI8giZd
         m/+p0kV3cPESref1pZppIq7PWgy9VMpHkt1EPeh+hSXbF+uY+UvWt+QBMpjX2UkvkiBe
         XDpw==
X-Gm-Message-State: AOAM531Xy76nEFEwFaJm/a4UkFVHbFmt8W2SnAMBqKkTolWkcYgjmyoj
        mBnTfKzP0WGnMwwuoTg5M3bIJwV3aTNIROg4YUmwxQ==
X-Google-Smtp-Source: ABdhPJy483yaR8KZ3VIJaiuWvrA4GnWCj8ODvHhuepyoZ3dtU+2OpIZSGeg0jiGqSzm7tgX5Coup7Kf+Gii/CRwacWY=
X-Received: by 2002:a2e:9a8c:: with SMTP id p12mr405228lji.526.1636998929498;
 Mon, 15 Nov 2021 09:55:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636672052.git.mchehab+huawei@kernel.org>
 <81245e1273f2e0e96a520b9d00cd415f65d37b48.1636672052.git.mchehab+huawei@kernel.org>
 <20211115092840.GA26989@kadam>
In-Reply-To: <20211115092840.GA26989@kadam>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Nov 2021 09:55:18 -0800
Message-ID: <CAKwvOd=AFLdyrdGSbREk9ent0iGjG_RmXH+VJXykNZ9WQUT_rw@mail.gmail.com>
Subject: Re: [PATCH 2/3] media: atomisp-gc2235: drop an unused var
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Beatriz Martins de Carvalho 
        <martinsdecarvalhobeatriz@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tom Rix <trix@redhat.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 1:29 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Nov 11, 2021 at 11:08:52PM +0000, Mauro Carvalho Chehab wrote:
> > Fix this clang Werror with W=1:
> >
> > drivers/staging/media/atomisp/i2c/atomisp-gc2235.c:573:6: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
> >         int ret = -1;
> >             ^
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >
>
> Looks good.
>
> There should be warning for "int x = -1;" followed by |= because that's
> a no-op OR assignment.
>
> I'm surprised that clang doesn't print errors about the other
> implementations of power_ctrl().

clang-tidy and scan-build will report dead stores.  You may have seen
patches from reports from Abaci Robot which is running those checks
continuously.

>
> drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
>    448  static int power_ctrl(struct v4l2_subdev *sd, bool flag)
>    449  {
>    450          int ret;
>    451          struct mt9m114_device *dev = to_mt9m114_sensor(sd);
>    452
>    453          if (!dev || !dev->platform_data)
>    454                  return -ENODEV;
>    455
>    456          if (flag) {
>    457                  ret = dev->platform_data->v2p8_ctrl(sd, 1);
>    458                  if (ret == 0) {
>    459                          ret = dev->platform_data->v1p8_ctrl(sd, 1);
>    460                          if (ret)
>    461                                  ret = dev->platform_data->v2p8_ctrl(sd, 0);
>    462                  }
>    463          } else {
>    464                  ret = dev->platform_data->v2p8_ctrl(sd, 0);
>    465                  ret = dev->platform_data->v1p8_ctrl(sd, 0);
>                         ^^^^^^
>
>    466          }
>    467          return ret;
>    468  }
>    469
>    470  static int gpio_ctrl(struct v4l2_subdev *sd, bool flag)
>    471  {
>    472          int ret;
>    473          struct mt9m114_device *dev = to_mt9m114_sensor(sd);
>    474
>    475          if (!dev || !dev->platform_data)
>    476                  return -ENODEV;
>    477
>    478          /*
>    479           * Note: current modules wire only one GPIO signal (RESET#),
>    480           * but the schematic wires up two to the connector.  BIOS
>    481           * versions have been unfortunately inconsistent with which
>    482           * ACPI index RESET# is on, so hit both
>    483           */
>    484
>    485          if (flag) {
>    486                  ret = dev->platform_data->gpio0_ctrl(sd, 0);
>    487                  ret = dev->platform_data->gpio1_ctrl(sd, 0);
>                         ^^^^^^^
>
>    488                  msleep(60);
>    489                  ret |= dev->platform_data->gpio0_ctrl(sd, 1);
>    490                  ret |= dev->platform_data->gpio1_ctrl(sd, 1);
>    491          } else {
>
> regards,
> dan carpenter
>


-- 
Thanks,
~Nick Desaulniers
