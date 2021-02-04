Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5378030FE14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbhBDUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbhBDUVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:21:51 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADA2C06121D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:21:11 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id l23so3361196qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hhif/dUTQoXIIfPryG61RWRP0ankk75APYX7Blt1AJc=;
        b=haoSoMndXJyCLmaDCr53ziw/bvLuMoI9unlpsbh/BUpbXrj1nGZiWpW82ApiDt85YT
         zjc8KccPKk0vuNeP6Sne6tBJPjZ40DMTlhDjsjT196sbSfnRlhlJ6PGnZqxqlkeHuEuf
         VpChiqH+dHfH7AFmWAqD/RPGHmFAEHm8P3sxBh4w64p1yWRPfLwDJt2RmpKPNLZxjLry
         mOAYgjoCtTXc239wCqmALk9/TBwOmTcSDYQE2bqkwj8cRPkirOFrT+CUEkO3IDyz6dal
         fpbywg/NNJGdBVP13aklMdHtqD08rxAjhFHXHGIt3A/B96iEfVQN+UMZwvTTaNFGXcob
         13Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hhif/dUTQoXIIfPryG61RWRP0ankk75APYX7Blt1AJc=;
        b=UYGPEjZzrbQHLROxuQQ/+mvHeCPrmx46hcEp/uCBNB5Ul16vXxowbtAn71IXJs3FE5
         umjQ33OrEPJGebth5JKWY0xjawls59IdZxux0ehXnX+c0G1BB+dbQ6xbsBrAqBdRDMr2
         bzRlYDuF2uQ/AejAGuVDMAUDyahEnMNiZ11zY556keoiK92Py2nFdmZ7UzfzYla6JOP/
         0KErgYbQ7I7c+LcujfJH95OGGycGVoOpRNJnViW0GQMi01HEvOinGSp1BtIDdTCFxIQX
         1n61HRh+qw+GEPDE6Mll4eaPunOQZffVaK//MlHpRKEVsT7gxuUvOifXK1B3tIHmg1WJ
         0eow==
X-Gm-Message-State: AOAM533ZdEayVF7K2NK+XV08a3GGHix/Pok/JocUtK8HyK+mICXUgcys
        /t/HF31ANXDdMeaOvc+RTwvwbO4pEVRIqA==
X-Google-Smtp-Source: ABdhPJzBtWcnl6xe8wj4gW7Fj9w/IksQfuh2DmG51kZHLsHu9r/mNRRmRjkIIJig96HztTbqxgyqBg==
X-Received: by 2002:ac8:5c44:: with SMTP id j4mr1341125qtj.124.1612470070278;
        Thu, 04 Feb 2021 12:21:10 -0800 (PST)
Received: from ?IPv6:2601:5c0:c200:27c6:cd86:137:1075:f377? ([2601:5c0:c200:27c6:cd86:137:1075:f377])
        by smtp.gmail.com with ESMTPSA id l38sm5434750qte.88.2021.02.04.12.21.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 12:21:09 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v6 02/10] Revert "drm/qxl: do not run release if qxl
 failed to init"
From:   Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <3feaeb62-fd50-5cca-26f7-42f6167ef77a@suse.de>
Date:   Thu, 4 Feb 2021 15:21:08 -0500
Cc:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D78EE3A8-C7A8-4694-86E9-2E2278703A62@gmail.com>
References: <20210204145712.1531203-1-kraxel@redhat.com>
 <20210204145712.1531203-3-kraxel@redhat.com>
 <d217112e-e49d-bd1f-0c39-3eac2dd721fd@suse.de>
 <60B8023C-78C9-441D-AA21-A13C4445F666@gmail.com>
 <3feaeb62-fd50-5cca-26f7-42f6167ef77a@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 4, 2021, at 2:06 PM, Thomas Zimmermann <tzimmermann@suse.de> =
wrote:
>=20
> Hi Tong
>=20
>> I have posted an updated patch.
>> The new patch use the following logic
>> +	if (!qdev->ddev.mode_config.funcs)
>> +	  return;
>=20
> This is again just papering over the issue. Better don't call =
qxl_drm_release() in the error path if qxl_device_init() fails.
>=20
> I see two solutions: either roll-back manually, or use our new managed =
DRM interfaces. This is what the other drivers do.
>=20
> Best regards
> Thomas


IMHO - qdev->ddev.mode_config.funcs is set only if the initialization is =
successful,
so using this as an indicator of error case looks ok to me.

The other two options you suggested would require some serious =
significant amount of work to be done,
which I don=E2=80=99t think I currently have such ability to do.

Thanks,
- Tong

