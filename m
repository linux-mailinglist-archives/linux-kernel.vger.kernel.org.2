Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D873E892F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 06:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhHKEUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 00:20:01 -0400
Received: from mx-lax3-1.ucr.edu ([169.235.156.35]:6972 "EHLO
        mx-lax3-1.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhHKET5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 00:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1628655575; x=1660191575;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:cc;
  bh=8+2MFUiKTr6YMmCUjLtaAbosp3nC3TfZco3vRdKPf+I=;
  b=dg0GcqOE5ZjIMy45+OXlgMn83b8CWUSBMRm6cLNX66fWYKhYuPbfQ0YN
   29r9vLsr5KZ6wZ8xYHiVIN/NIpwpo0Ck/uA+DdYAH5aPiaq4IZQJlzbzx
   ebO8wE2zwdF6yEd+K2nP86SoW6MHWVfJoSYq7B35AeGjgpM+e6YN647Uu
   pgomnNU+ByyEUTst6AEelFEFMH6Ac2l/Zc4VKQ3w+xl8eIyJUGch/oy3w
   gsymhs6sUQQduk/LfGXDVw/gnsPTJAXYoCtziUUW3cUnKxNgsk3L8FJaf
   pYVcRz+Zp0VLxb/5guHfDHdUZL/TwWgwbNyZYg+x/xbC39hlwnblBjci+
   A==;
IronPort-SDR: URTmqXauW8LtgQw3OLK8jdP5QHA+wAPveQSJQ6CwxF4JtVHlodg73idhhwrDcwyZBxYtB0tnye
 7RiQ9REStlKANdkY2Z372pcqo0sUtXIw0zjpFWv+K4zmi2aZ9oGkYlH1MA/vRBv/pjBxUNt7E8
 4wl52zRIGPp+EnHunAZlkvZIPCiQ0/CRJF1QSvQupTnBIW3bXtmCL9sst5AJbKOKka8RjTAQ1O
 M+G6QxRbv0y2EL3s29WJmCbXUXiZoUW9QfJeLNXgPVKOuIqUBQbEio9EIBulgM83kM/5LPJG5n
 Hr416HLWG9ym6bucwes+5Ur0
X-IPAS-Result: =?us-ascii?q?A2F+AgCfThNhhkfYVdFagQmBWYN4VhaESJFuimWBGoZ8i?=
 =?us-ascii?q?GiBfAIJAQEBD0EEAQGEWAIjgkECJTQJDgECBAEBAQEDAgMBAQEBAQEDAQEGA?=
 =?us-ascii?q?QEBAQEBBQQBAQIQAQEBAYEgC1kLY4FPgXkGBD2CNSmDZQgBAQEBAxIRBFIQC?=
 =?us-ascii?q?wsKAwICJgICIhIBBQEcGSI5ghYBgwedH4EEPYo4en8ygQGIFgEJDU6BFRJ+K?=
 =?us-ascii?q?ocLhmQngimBS4EFgTM3PodbFIJQBINcexNbgU6BUAEBAZA6G4MGiUmCCYEmm?=
 =?us-ascii?q?3EBBgKDDhySSowBK4NlkWCRKpgtoxYQI4E9ghUzGiV/BmcKgUFNAQIBAgEMA?=
 =?us-ascii?q?gECAQIBAgECCAEBAo41jlYkLzgCBgsBAQMJiHgB?=
IronPort-PHdr: A9a23:U2DlRxWa3eejId7dr2xNDhmnHznV8Kz2VTF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB92du6oP1LSempujcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffRlEiCC+bL9uI
 xm7rwTcvdQKjIV/Lao81gHHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2Q
 rJeDDQ9LmA6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD+/9
 KpgVgPmhzkbOD446GHXi9J/jKRHoBK6uhdzx5fYbJyJOPZie6/Qe9YaRWtaXsZKVixBBIy8Z
 JYRAeQYIO1YoYj9qEUKrRSjGAKgAO3ixiNNinLwwKY00fkuERve0QMvEdIBsnTaotv2OqkPT
 e+417XIwSnZYv9KxTvx9IrFfxY8qv+MR7Jwds/RxFEtGAPEj1SQqZHlPzSI3esOs2iU9etgX
 v+ohm8nqgBxoiKgxsYwhoXViI8Y0U3E+jljwIovO9K3VVN7bMeiHZBNuC6UK5F4Tdk+Q2F0p
 ik60LsGtIamcSUXx5oqxBrSZvybf4aG7RzuVvucLCl5iX94dr+yhBm//0euxODgSsS501RHo
 y5Zn9XQqH0Ayx3e58ubR/Z5+EqqxDWB1xjL5+1aPUw5kbDXJp0hz7IqiJYfrEXOEjX0lUnri
 qKda18q9fKy6+v9Z7XrvpqcN4hphQ7gKqkugcm/AfggMggJQmib5fyw1L398k39R7VHlvg2n
 bPYsJDePMgbvqy5DxJM3oYt6RuzEi2q0NsfnXkAI1JFfAyIg5L1NFHJJfD0Ffa/g1Kynzd33
 /3KIKHtD5HXInXAkLrtZ6hx51NdxQYpz91T+opYCrQbL/LyXk/xusbYDhg8MwGsw+fmCdV92
 ZkfWW6THqOUPrjfsUKU6eI1OeWDepIauCvlJ/g/+/HulWM5mUMafaSx2ZsXaXa4HulpIkmAY
 nrjnM0BEWEUsQo6V+HqllKCXiBJZ3qoXKIz+Cs7CIS4AofHXIyth6aB3CjoVrNMYWUTO1GeE
 WrvP7eEUvZEPDOAIsZgymRffaWqUcks2Qz451yy8KZuMueBon5QjpnkztUgorKL/Sw=
IronPort-HdrOrdr: A9a23:5tqW/avFhgOGEoosZfaEj6yd7skDc9V00zEX/kB9WHVpmwKj5q
 aTdZUgpGbJYVkqKRQdcLy7Scu9qDbnhP1ICOoqXItKPjOW3FdARbsKheDfKn/bexEWndQtsp
 uIsJISNDQzNzJHZArBjDVQ2uxOruW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="59626268"
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2021 21:19:33 -0700
Received: by mail-pj1-f71.google.com with SMTP id 61-20020a17090a09c3b029017897f47801so4131472pjo.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 21:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=xTux7jQgzWsX3hb3coGUGgC9dvVrQ9GiczNsYL/eB4o=;
        b=g4BgjbqqfA672FDRFtWtcXwpeK6X62iEvs//Xs/QVCG+NgHCK74hH+fltF9IZK6Xfs
         L8lYZ0PaSkkAUXLl71LzlQuiRpjDjOIfPIB2NkIM083huxYbJl9Em+mpQwxoBdEnvUmj
         /coi8mOpDP7XdAO1rQp9dZ6Vze/YXs80YPInF+UcuZBc4Rnrz8qB71xRYJY5HCMbviM3
         wThuHOwXnIkOPMp89S1KYsPvKcehv3j1QdmMY00hvM7rMIf3s/L2oTOVskhtOTkPZ+Tr
         4Bym+xCebpeOuC1YpFq6up3RWKk7cmKqLanKTmB8Inlhwux3/o3zzuBSAbJqCDboe0kG
         7yOA==
X-Gm-Message-State: AOAM533EdKkGs91aO9A5iyt/zAdc323BuFKgjKAd0/YhTdBrXtAfx60x
        9LpqUmIGOvFSzLJW2Bo1nfUwKBTpwP3nJ2pgjBiOTa4R+9juw2Eb4XS1TQhUGL+2p72OPWP0J3r
        Jk4taz4x97dnMpqOHPNWE/otkLPTgjpq9UMiQi/ANiA==
X-Google-Smtp-Source: ABdhPJzh/Psz3RJ+3YGdgVJIUqxlsN0c1embWJYGfGCxt2RU5trEXOPBDMNQ4gyq7U8SD2SNSUjqWg0sx/TJdO4jmmU=
X-Received: by 2002:a63:f242:: with SMTP id d2mr151330pgk.384.1628655571899;
        Tue, 10 Aug 2021 21:19:31 -0700 (PDT)
X-Received: by 2002:a63:f242:: with SMTP id d2mt121407pgk.384.1628655571687;
 Tue, 10 Aug 2021 21:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210723003607.64179-1-yzhai003@ucr.edu> <20210811035405.17382-1-yzhai003@ucr.edu>
In-Reply-To: <20210811035405.17382-1-yzhai003@ucr.edu>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Tue, 10 Aug 2021 21:19:20 -0700
Message-ID: <CABvMjLRj-ofVoNpOvT+DPOdW-=L52KbsRYeaKv=MTYfSJPZNBA@mail.gmail.com>
Subject: Re: [PATCH v4] media: atomisp: fix the uninitialized use and rename "retvalue"
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
For your information, I update my signed-off zone using my full name
"Yizhuo Zhai"

On Tue, Aug 10, 2021 at 8:54 PM Yizhuo Zhai <yzhai003@ucr.edu> wrote:
>
> From: Yizhuo <yzhai003@ucr.edu>
>
> Inside function mt9m114_detect(), variable "retvalue" could
> be uninitialized if mt9m114_read_reg() returns error, however, it
> is used in the later if statement, which is potentially unsafe.
>
> The local variable "retvalue" is renamed to "model" to avoid
> confusion.
>
> Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
> Signed-off-by: Yizhuo Zhai<yzhai003@ucr.edu>
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
