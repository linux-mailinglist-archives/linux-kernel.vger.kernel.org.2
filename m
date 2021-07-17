Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277F03CC685
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 23:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhGQVyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 17:54:11 -0400
Received: from mx.ucr.edu ([169.235.156.38]:23548 "EHLO mx-lax3-3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231528AbhGQVyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 17:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626558673; x=1658094673;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:cc;
  bh=1yilOERNyPcoY3A26m/nt1Y2t9Ypa4x9Ubo3GY7XWj8=;
  b=d0et77i9rItA6Lt47431yzqS3mBeZZLyZn69cDoB4jO286P0ChZ47zcb
   SlWRlT2ckPa+ojPbpUsorw3CqkzvlLPRY1iFktfey32mE7ayN3hIzFQF3
   VcKZb7rnBdfSPSZ+N1K93SCZCWgpHQykHkUJT/bPlrwOGljYvwfyn+A+5
   Na3oSnyLKSbpuaonJLlIJ+lzsxjBwi+BBzNvRdOaxEcBBbPXmLHWPwApN
   IB4eFDSK4/cbBoP+tiJ7qiGQX/N+TLnmRXBObLpb2Pi4aJYDR89Oklf/x
   PAqmf8JYVBPU5bXq8ddNMSulPwXe9FZcQ5yCbeSDLU6j2FQdMP+/Bu4Ky
   g==;
IronPort-SDR: ZqKMpSr86yFTejtlWDQjraasEPFFYDqyuBIgnLFs27gaxtxwsXLoo9tIrUdyhfUzTmxG1Bh3mf
 Gx7Hlwg7vyKs8+yuBMHpXGocCzoVk+ZG/ujSl41DXCjKmAGc9LSl50wy9605gDsqxnqQ9IKY+2
 WptarHzL/ihDtLTmJiMqJU1jHX6KQ0frL6Vwt5UoP+OPqyTlyyDmC4PJv3nu+9qDkweLCBayRK
 GpQECy354o86gg6iuZwD4oTd9j/1rI/DYZ8G2GLa0P9+s1cE0/VYX3SNNbIw/Y+0h8ycDTBKsZ
 kx73AQIALFyppiNNGLuth+gM
X-IPAS-Result: =?us-ascii?q?A2GyAgBOUPNghsfXVdFaHgEBCxIMQIFOC4N4VhaESJFgi?=
 =?us-ascii?q?mKBGoZ8iGaBfAIJAQEBD0EEAQGEVwIjglsCJTQJDgIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQYBAQEBAQEFBAEBAhABAQEBgQoLWQtjgU+BeQYEPYI4KYNlCQEBAQMSE?=
 =?us-ascii?q?QRSEAsLDQICJgICIhIBBQEcGSI5ghYBgwebDIEEPYsyfzOBAYd8AQkNgWMSf?=
 =?us-ascii?q?iqHCoZiJ4IpgUuBBYEzNz6HWxSCUASDF3sTW4JIVgEBAZAvG4MGiz2BJptjA?=
 =?us-ascii?q?QYCgwockj+LeiuVPZEhuysQI4E4ghUzGiV/BmcKgUFNAQIBAgEMAgECAQIBA?=
 =?us-ascii?q?gECCAEBAo41jlYkLzgCBgsBAQMJjDsB?=
IronPort-PHdr: A9a23:6UnWXRfg9pB6zbH7zTSGT6rPlGM+R97LVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWRG9+GoKIcw6qO6ua8AD1Guc7A+Fk5M7V0HycfjssXmwFySOWkMmbcaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 AuqoQnLqMUbgYRuJ6UtxhDUpndEZ/layXlnKF6Omxvw/Nu88IJm/y9Np/8v6slMXLngca8lV
 7JYFjMmM2405M3vqxbOSBaE62UfXGsLjBdGGhDJ4x7mUJj/tCv6rfd91zKBPcLqV7A0WC+t4
 LltRRT1lSoILT858GXQisxtkKJWpQ+qqhJjz4LIZoyeKeFzdb3Bc9wEWWVBX95RVy1fDYO6c
 4sPFPcKMeJBo4Xgu1cCsR6yCA+pBOPu0T9InX723as10+88Dw/IxRErH9wPsHvKqNX6KboZX
 eS7waXUyDnOae5d1zXg54jSah0urv+MUrBwf8TfykchCh/Kg06MqYD5JT6ZyvgBv3SZ4udmS
 Omhi3QnqwZ0ojW3xMgsi4jIhoIIylDD6C52w4Y1Kse5SEVmZtOlEJpRtyGAOIt3Xs8uX29lt
 T0nyrIao563ZjYFx4k6xxPGbfGMboeH7A75WumLPTd4mGxqeKi5hxuq7EWt1+LyW8qw3VtKs
 iZLnNbCu3IQ2hHN68WKV/Vw80Su1DiA2Q7e9v1JLEM2mKffN5Mt3qA9m4YSvEnAAiL7nEP7h
 7KVeEU84uWk9fjrb7H8qpKfN4J4kB/yPrkul8ClHOg1NgwDUm6G8uqmzrLj51f2QLBSg/0zl
 anWrY7VKNwApq68Hw9VyoEj6wujDzu+0NQXg30HLFVddRKClYfpOlXOLOngDfewnligiTlry
 +3CM7DlGJnNIX/DkLDufbZ59UFQ0hY8zdda555MC7EBJuz8WlPpudDGEhM0Nxa4zuXnBdlny
 I8SRGKCDrWEPK7WtVKE/ucvLPONZI8Rtjb9Mf8l5/v2gH45mF4dfbOm3ZoLZHykEPlrOFiZb
 mb2gtsbD2gFoxc+QPTwiFKeST5Te2qyX6Uk6zE/CYKmC5rDR4+0jLyCwii7BJtWaX5CCl2XD
 3foeJuLW+0WZCKRPMBhiDoEWqalS4M70hGurgD6mPJJNO3RrxwZp5L+05BH5+TS3UUj5zx9D
 pzFiEmQRHsyk28VEWxllJtjqFBwnw/QmZNzhOZVQJkMv5t0
IronPort-HdrOrdr: A9a23:3ixkoKsGoEltC8M9FMUsx72U7skDc9V00zEX/kB9WHVpmwKj5q
 aTdZUgpGbJYVkqKRQdcLy7Scu9qDbnhP1ICOoqXItKPjOW3FdARbsKheDfKn/bexEWndQtsp
 uIsJISNDQzNzJHZArBjDVQ2uxOruW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="57826492"
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jul 2021 14:51:12 -0700
Received: by mail-pg1-f199.google.com with SMTP id j17-20020a63cf110000b0290226eb0c27acso10496691pgg.23
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 14:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=24ruHgKdRqiISpvE23HRNMHuYpAUJ+UGSln1cmXL8UU=;
        b=ICxByutlTrW/UigrjK+vEp4v5qHRabPCFyitpykaCnMyJ4oQIntdD42xYtNbcifx5v
         C24d/Mrd2tMvIBARa92hsmo/lABP33rq879N8uYp90fIkMC/ZHHXLhOTDf0R13QgG0SZ
         dyy8nX5KnTqCUfkH/9y0vxqb8xXDR9MaclCu5LGmBGUrL4zhUIT9LbNd7jct5WC99PRQ
         KrLFv7i4Nx/WSy4uUX6V8gHZeQz1T/lbvzGXJVYycHUpBVi0ZTF7T/xA6iBtRFKGcW0V
         hj1lJLPVmFRwOPitt6ifqkJR0NpexGHuQ7g9woRz9DqE4tDhBdMc1Jnoj8PjI9XpiM8U
         8PzQ==
X-Gm-Message-State: AOAM5309Ijv7lVFfHGDXLg44lKlUH+7EdRfRbuvQrFrgMX8PZNxzODV9
        0xZn95lJ19Mru4lxKlzvOp7F5O3nyv5fncfj8jmd3noHxuJGDB9n8uxVK6/Fs/kbNSdW9RAGw5T
        J8bLgN5irCjqXrzcVPnidUxnXw4QfmlYE0B+bIT5J0w==
X-Google-Smtp-Source: ABdhPJxjcYD5ySdMjptKWIwJXI/6cV1wOnHcpRa5G9B3khFeGN6yFjiDKV3UGhAWzEhCKKRSzcn6m7KZM7CQ5wy1sG0=
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr17145131pff.49.1626558669968;
        Sat, 17 Jul 2021 14:51:09 -0700 (PDT)
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id
 w125-20020a62dd830000b02902e8e511c32fmt11615347pff.49.1626558669672; Sat, 17
 Jul 2021 14:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210624031719.11157-1-yzhai003@ucr.edu> <20210625053858.3862-1-yzhai003@ucr.edu>
In-Reply-To: <20210625053858.3862-1-yzhai003@ucr.edu>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Sat, 17 Jul 2021 14:50:59 -0700
Message-ID: <CABvMjLRQdTzfPX8YRtAwsPbh=FjbzxRu7Hhun1gk0i1kka94nA@mail.gmail.com>
Subject: Re: [PATCH v3] media: atomisp: fix the uninitialized use and rename "retvalue"
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All:
Does the new patch work?


On Thu, Jun 24, 2021 at 10:37 PM Yizhuo <yzhai003@ucr.edu> wrote:
>
> Inside function mt9m114_detect(), variable "retvalue" could
> be uninitialized if mt9m114_read_reg() returns error, however, it
> is used in the later if statement, which is potentially unsafe.
>
> The local variable "retvalue" is renamed to "model" to avoid
> confusion.
>
> Fixes: ad85094 (media / atomisp: fix the uninitialized use of model ID)
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> index f5de81132177..77293579a134 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
> @@ -1533,16 +1533,19 @@ static struct v4l2_ctrl_config mt9m114_controls[] = {
>  static int mt9m114_detect(struct mt9m114_device *dev, struct i2c_client *client)
>  {
>         struct i2c_adapter *adapter = client->adapter;
> -       u32 retvalue;
> +       u32 model;
> +       int ret;
>
>         if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
>                 dev_err(&client->dev, "%s: i2c error", __func__);
>                 return -ENODEV;
>         }
> -       mt9m114_read_reg(client, MISENSOR_16BIT, (u32)MT9M114_PID, &retvalue);
> -       dev->real_model_id = retvalue;
> +       ret = mt9m114_read_reg(client, MISENSOR_16BIT, MT9M114_PID, &model);
> +       if (ret)
> +               return ret;
> +       dev->real_model_id = model;
>
> -       if (retvalue != MT9M114_MOD_ID) {
> +       if (model != MT9M114_MOD_ID) {
>                 dev_err(&client->dev, "%s: failed: client->addr = %x\n",
>                         __func__, client->addr);
>                 return -ENODEV;
> --
> 2.17.1
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
