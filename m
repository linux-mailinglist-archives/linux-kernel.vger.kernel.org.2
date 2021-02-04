Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C6330FC03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 19:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbhBDSxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 13:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbhBDSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:52:45 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D755C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 10:52:04 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id es14so2230949qvb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8ZgAvEajl8OUNniz+1itXG7C5l6k2fF6JkJiBsO4nok=;
        b=nhMmLKArS2xb9cFp5MMKn5zJt2CZdTGK2ypgPa6MYMSt8duhxNfT5BFkLKjDiJAMXe
         wj6pNooIJSgf1MhhpBgtcavRJwxmF+xeTFBWe/YiQA5+B10FF4Yqv7dbpsZHSzdPzYYr
         vUgA3osoftu5awaOEuKhB3pAPpuRtJINsCondAWAr9QcdNXoV9azZWYVjdCMKl50r5AG
         zhIV9TjRDdVlHyrCbid0aZxIw2GmkSOfQGNWDFarSx2gq9dD/R4gUz5J1X6XVJ+IvvWz
         y6M3dda45nlYqZ05dheJD89SuSr/3wFCsVTJM3TaA7ZQNg/56Hyfc/1dVPGFufSQrsPw
         HCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8ZgAvEajl8OUNniz+1itXG7C5l6k2fF6JkJiBsO4nok=;
        b=H2L0cjC18xczOwTIZKqk1qcD1290t6COpy4XCLD5H7ozFpgcPwzpq2CE7dsCkAMOOv
         OD5Ye1rgAss9GCaEgUDNg/pjRnI2hI9YM0L+CKcq1T6Hn/W+uyAlza2VvuW8xqMYWeyg
         mH3fT4Pj88JXzHJwd4MDCZm7pIl1oYVO0Ulq8mQdEUAnmODPj527yYbM3Ga2Cw5+do/B
         2R9RF+P18veDgAriH/S/IbZPckx0Tkal+F0uVViec5k7FNnL0PWcZuUSu/C6H2hEWBN8
         8/14s9piFLsCcSe5mqrc6J86AH0wsSd76K7bpcMMa8p1zgYxCEgwchFstTi5ifbp7L7T
         CsGQ==
X-Gm-Message-State: AOAM531hE+w2q/RXx7IGiXDTCOQP5C+unS4LfNuVRU3dICIDO2x1DYp5
        /hPGd8mYg6qHW1572wSkG58=
X-Google-Smtp-Source: ABdhPJyJvT/YDmhSIb/x8r7uRaFvl000p8edHD/mRjYqlce+22wUNtkbzecqkR/f+Bcr9lN5Wu7enA==
X-Received: by 2002:a0c:fe0b:: with SMTP id x11mr656852qvr.18.1612464723755;
        Thu, 04 Feb 2021 10:52:03 -0800 (PST)
Received: from ?IPv6:2601:5c0:c200:27c6:cd86:137:1075:f377? ([2601:5c0:c200:27c6:cd86:137:1075:f377])
        by smtp.gmail.com with ESMTPSA id 186sm6052286qkh.30.2021.02.04.10.52.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 10:52:03 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v6 02/10] Revert "drm/qxl: do not run release if qxl
 failed to init"
From:   Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <d217112e-e49d-bd1f-0c39-3eac2dd721fd@suse.de>
Date:   Thu, 4 Feb 2021 13:52:02 -0500
Cc:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <60B8023C-78C9-441D-AA21-A13C4445F666@gmail.com>
References: <20210204145712.1531203-1-kraxel@redhat.com>
 <20210204145712.1531203-3-kraxel@redhat.com>
 <d217112e-e49d-bd1f-0c39-3eac2dd721fd@suse.de>
To:     Thomas Zimmermann <tzimmermann@suse.de>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

The original problem was qxl_device_init() can fail,
when it fails there is no need to call=20
	qxl_modeset_fini(qdev);
	qxl_device_fini(qdev);
But those two functions are otherwise called in the qxl_drm_release() -

I have posted an updated patch.
The new patch use the following logic

+	if (!qdev->ddev.mode_config.funcs)
+	  return;
	qxl_modeset_fini(qdev);
	qxl_device_fini(qdev);

Thanks,
- Tong


> On Feb 4, 2021, at 1:34 PM, Thomas Zimmermann <tzimmermann@suse.de> =
wrote:
>=20
> Hi
>=20
> Am 04.02.21 um 15:57 schrieb Gerd Hoffmann:
>> This reverts commit b91907a6241193465ca92e357adf16822242296d.
>=20
> This should be in the correct format, as given by 'dim cite'.
>=20
> dim cite b91907a6241193465ca92e357adf16822242296d
> b91907a62411 ("drm/qxl: do not run release if qxl failed to init")
>=20
>> Patch is broken, it effectively makes qxl_drm_release() a nop
>> because on normal driver shutdown qxl_drm_release() is called
>> *after* drm_dev_unregister().
>> Cc: Tong Zhang <ztong0001@gmail.com>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  drivers/gpu/drm/qxl/qxl_drv.c | 2 --
>>  1 file changed, 2 deletions(-)
>> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c =
b/drivers/gpu/drm/qxl/qxl_drv.c
>> index 34c8b25b5780..fb5f6a5e81d7 100644
>> --- a/drivers/gpu/drm/qxl/qxl_drv.c
>> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
>> @@ -144,8 +144,6 @@ static void qxl_drm_release(struct drm_device =
*dev)
>>  	 * reodering qxl_modeset_fini() + qxl_device_fini() calls is
>>  	 * non-trivial though.
>>  	 */
>> -	if (!dev->registered)
>> -		return;
>=20
> I'm not sure what the original problem was, but I'm sure that this =
isn't the fix for it. If there's a problem with shutdown, the operations =
rather have to be reordered correctly.
>=20
> With the citation style address:
>=20
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
>>  	qxl_modeset_fini(qdev);
>>  	qxl_device_fini(qdev);
>>  }
>=20
> --=20
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>=20

