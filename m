Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E793FE292
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbhIASzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244827AbhIASzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:55:15 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FF1C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 11:54:17 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a10so508529qka.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yACBHeKeTEMDk9G3lLdGdDWvtaeZqYr0jQBUvqwglB4=;
        b=Idwyh/ZOPXWdXddScG9pysT9Y1D20q4/aaYdSHfPuGvxdq8UBrqgS0gGKzb2RyhlFG
         1ixEQaGyJhPCSvAIC9kVBRrsdpYew405vHVNIMYDMr2eCGTJT5aNsIennOISX/1fSbLB
         vw0hxgb9xxUjp5BnURN8EsrzaTSVLcoqF18z4bqyAsWyeb4EZJdmVa1YIGjA5BKRW83M
         c+R0ypRvgnYpol8jKW5URb6aIZ8R57CHUt66XSfw2GJe6RwKawG6pI8KBuT8dzCDAY1T
         ++89cqPwwX4CefMn1INBz7ULDzTtB40xZ344utxHy1zRKa9QDMKQxLlZ87RofmhBTNE5
         f3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yACBHeKeTEMDk9G3lLdGdDWvtaeZqYr0jQBUvqwglB4=;
        b=d1wsJVDhpTEq/mik40CQPJNTUyIduBYzblY44mufdi4jAQDyvgy1dZ4b0Ksb3BldsZ
         nM6GUH/KOmpBbjGBHOttZfXq5Fw3tangxi/+XIAvIYbxpywikDRmAchCGJ6eKC92sHkp
         7U9YZwuKSBFKu0bab+gHemF/qOs5pWM07zE1samJ9d66Vq4xQRrLqfEQPG7QMnfXgt9A
         tz3xGL9SL9Ev+Uq4Shixq5Sd7VR2x7fbxsUjlKCPfIvoIjpV3/fj0eTuWpr/DspRHNf4
         fS6nnN/htKmX/OZPC+gXvcqzKh9qEnr6T5VdEMtEqxf9b2P2qdC4EU/2Hj6F2BrnSYgn
         YpAg==
X-Gm-Message-State: AOAM530tpd8MKcNPs0oyhF2Aid+ytNwzsiEKYXV+Ys0haH83vTBKHdUQ
        bh2Mv3EC0ntUS3HlAFApPK2bzY7oSdV8VTZATRmRy5FcgwaV
X-Google-Smtp-Source: ABdhPJwxUAWGvA4IBMn5mMg38sMi31Mre6YzUnRruh8cQT7hDfLAJ8Qn5kmdWmS5DDnWKzNCtLE9LtF6dBqjhJRtPZ8=
X-Received: by 2002:a05:620a:1379:: with SMTP id d25mr1128331qkl.238.1630522456666;
 Wed, 01 Sep 2021 11:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210830193355.11338-1-asha.16@itfac.mrt.ac.lk> <20210831084735.GL12231@kadam>
In-Reply-To: <20210831084735.GL12231@kadam>
From:   "F.A. SULAIMAN" <asha.16@itfac.mrt.ac.lk>
Date:   Thu, 2 Sep 2021 00:24:05 +0530
Message-ID: <CAHnw0NAMaByr5m5Ai2APBc6Az_Lbb=TyCWmSdotVWKBJLPfVqg@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: fix memory leak error
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 2:18 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Aug 31, 2021 at 01:03:55AM +0530, F.A.Sulaiman wrote:
> > Smatch reported memory leak bug in rtl8723b_FirmwareDownload function.
> > The problem is pFirmware memory is not released in release_fw1.
> > Instead of redirecting to release_fw1 we can turn it into exit
> > and free the memory.
> >
> > Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
> > ---
> >  drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > index de8caa6cd418..b59c2aa3a9d8 100644
> > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
> > @@ -436,7 +436,7 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
> >       if (pFirmware->fw_length > FW_8723B_SIZE) {
> >               rtStatus = _FAIL;
> >               DBG_871X_LEVEL(_drv_emerg_, "Firmware size:%u exceed %u\n", pFirmware->fw_length, FW_8723B_SIZE);
> > -             goto release_fw1;
> > +             goto exit;
> >       }
>
> The current tree doesn't have DBG_871X_LEVEL() so you must be working
> against something old.  You need to work against linux-next or staging
> next.
>
> Your patch fixes a bug, but it would be better to just re-write the
> error handling for this function.  There is another bug that a bunch
> of error paths don't call release_firmware(fw).  Use the "Free the Last
> Thing" method.
>
>         pFirmware = kzalloc(sizeof(struct rt_firmware), GFP_KERNEL);
>         if (!pFirmware)
>                 return _FAIL;
>
> The last thing we allocated is "pFirmware" so free that if we have an
> error.
>
>         pBTFirmware = kzalloc(sizeof(struct rt_firmware), GFP_KERNEL);
>         if (!pBTFirmware) {
>                 rtStatus = _FAIL;
>                 goto free_firmware;
>         }
>
> Now the last thing is pBTFirmware.
>
>         rtStatus = request_firmware(&fw, fwfilepath, device);
>         if (rtStatus) {
>                 rtStatus = _FAIL;
>                 goto free_bt_firmware;
>         }
>
> Now the last thing is "fw".  But this is a bit tricky because we're
> going to release it as soon as possible and not wait until the end of
> the function.  There isn't a reason for this...  We can change that or
> keep it as-is.  If we keep it as is, then the we'll just call
> release_firmware(fw); before the goto free_bt_firmware;  The current
> code leaks fw on a bunch of error paths.
>
>         pFirmware->fw_buffer_sz = kmemdup(fw->data, fw->size, GFP_KERNEL);
>         if (!pFirmware->fw_buffer_sz) {
>                 rtStatus = _FAIL;
>                 release_firmware(fw);
>                 goto free_bt_firmware;
>         }
>
> Or:
>
>         pFirmware->fw_buffer_sz = kmemdup(fw->data, fw->size, GFP_KERNEL);
>         if (!pFirmware->fw_buffer_sz) {
>                 rtStatus = _FAIL;
>                 goto release_fw;
>         }
>
> Now the last thing is pFirmware->fw_buffer_sz.  Etc.
>
> Then at the end it's just:
>
> free_fw_buffer:
>         kfree(pFirmware->fw_buffer_sz);
> release_fw:
>         release_firmware(fw);
> free_bt_firmware:
>         kfree(pBTFirmware);
> free_firmware:
>         kfree(pFirmware);
>
>         return rtStatus;
> }
>

Thank you! I'll do the changes and send you a v2 patch.

Best Regards,
Asha Sulaiman.
