Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D130AF7A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhBASfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhBASdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:33:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBA1C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:32:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v15so17763185wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luGPAvrSMCDhOOW+Z5gmXXQh5R3bWKfdux7Cs/JxoL4=;
        b=SbGJYuDYRiGRLnatGOda+qqpD8NVu6t86woyV1Ci7M8j8dfjUn+D3Dei7OCTc9Z+w0
         It+xKL9fYuualrqAtp45369PoCuNhvZPldjhDri5MdkFcEw/NsGMyDOWNzSURvTU78Go
         b12J0bsMp2LYhgtXqM58LpHhvBRP92CdTLw98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luGPAvrSMCDhOOW+Z5gmXXQh5R3bWKfdux7Cs/JxoL4=;
        b=nXMfXJE9pXjy3I98HnvGmVYiBDdDW7d1gFgJ/lkDh5j6TA2gv87tjkZ5qYrKfKZ8oT
         gfItbVhzDqZiO1sM8H984Bl2Aquxaoyd1rUks7DAoRSI9OeKBGyj4hRHfvXNUKkrd4Kq
         zrVQ59kS4iD7KtQFcEzHT/rroRIJ7XIhBSNX9OaSRN8BywqPMbFMdMKaRuxFCGsk+4c3
         uQVHs7JDf0t1Jq2HU3AAkUCP4lfLIXMoOfumFeNx8YwbDkMFqhMdwvVVMZjw1mOekKf3
         sz+COklGDGOH15Y3tJbIlVi7Dl7OC9qFhnRwhrJy9g0aM5sWzicl+w1NzCHsotJJEyKu
         R2vw==
X-Gm-Message-State: AOAM533mQquhyR57/rSWcva217HJa0s6Y26xz/SB1aE70m8UEXi04bvw
        ERbHZZfdJlK4rNCSMRh+8J9IEgMhSU+6ZElogf0Paw==
X-Google-Smtp-Source: ABdhPJyX273jY7n68N4d5ro/RTJSVYLfjE7A9LCeHrP4/19FLesCEXbrzrtQqZFi1Nqil9ORcjeRpuuXEh3TG6kTBo8=
X-Received: by 2002:a5d:5544:: with SMTP id g4mr19302087wrw.59.1612204350381;
 Mon, 01 Feb 2021 10:32:30 -0800 (PST)
MIME-Version: 1.0
References: <YBfyb+jU5lDUe+5g@mwanda>
In-Reply-To: <YBfyb+jU5lDUe+5g@mwanda>
From:   Desmond Yan <desmond.yan@broadcom.com>
Date:   Mon, 1 Feb 2021 10:32:19 -0800
Message-ID: <CAEuuh2_BH4_7bm7tTZ2VSKNv7eCjj-ZU=zcV3vKbD1H_tJRLcQ@mail.gmail.com>
Subject: Re: [PATCH] misc: bcm-vk: unlock on error in bcm_to_h_msg_dequeue()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a10a8205ba4a934d"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a10a8205ba4a934d
Content-Type: text/plain; charset="UTF-8"

Acked-by: Desmond Yan <desmond.yan@broadcom.com>

On Mon, Feb 1, 2021 at 4:24 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Unlock before returning on this error path.
>
> Fixes: 111d746bb476 ("misc: bcm-vk: add VK messaging support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/bcm-vk/bcm_vk_msg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
> index eec90494777d..fc972e43258a 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_msg.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
> @@ -849,7 +849,8 @@ s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk)
>                                  * that is fatal.
>                                  */
>                                 dev_crit(dev, "Kernel mem allocation failure.\n");
> -                               return -ENOMEM;
> +                               total = -ENOMEM;
> +                               goto idx_err;
>                         }
>
>                         /* flush rd pointer after a message is dequeued */
> --
> 2.29.2
>

--000000000000a10a8205ba4a934d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
C/imrCGPzTVeQHFrCwhpbeRImN6Dxt4RJPXqccMKDYJ6X2SdBHFhCVYewhFlWE6P9lH+lwIDAQAB
o4IBzzCCAcswDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZB
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmcz
b2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNv
bmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0w
OzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMu
Y3JsMCMGA1UdEQQcMBqBGGRlc21vbmQueWFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUjANHprywiIFE
21XAvmsM2JqOdVAwDQYJKoZIhvcNAQELBQADggEBAIiBxkVwdJubzdNzXu4JI18hnJ4a6i/u7Vok
eQCoZ1GqqZsuNpJNXVs/EDoAzj33GWBA9yljpVufyTiot99BghGGhFdMk9asp2iABfVKVbelgkjV
o5qRsPEFKs9CX5YkhefyfeIgmAe4FMMD72DnLpt8Yr0NOaWKrsbE8KYQ8L7T5GZVd1W7ufOAw0JS
kQkyrew0cHrPRSHhE0qx+BLKJF2SQbb1cH/Ra7JhcLfXeJA/eBw1b9Ss/yfnSj3z/TAKOpYsicFX
b+ynK9BBF17HGsWw/7TOms5t0Qk1P6+IBbzUxeh5s4cDAMsDfE1xvUvUVu/2ASpap+hXkoss+Vcc
G2gxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDFJS
0nbv//4itGuVqDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgt0bttFoAZbEReWIE
KbLWCX6DSvO1MhqnWN6S+j+MLR4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjEwMjAxMTgzMjMwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACy9AbWdTQXCiqqRNWd5cYtuFBW8/i0u2eCb
Ekpb8YFDTj7o4vq6DGxaUo3xtIaCis6AKEAk2/Jg+8nRcl7ISb7EKWvsQeJXnNCTVSNQibUpVVUP
SbzbM+F+eS4HSL68d454M1Q5ffZQgfy+BIaLPL1sHxYy0QfTEw24VCvHa4i25LgtLqdRq6SNJJHJ
Q65SxFv2KWC5GuVgP9GrpkwSI+HA2m8cxmkCWjMQWuqiMjgw/UyjbH5FUB8laovkuA8DtaHbGnFJ
QRjslDAuRLSJglJK+g/uDiWzXrpukX9tyUvgSfRO7gKKhtHKhZJxQ6LzAeayoOGC8CK3tNnOI9E+
yAk=
--000000000000a10a8205ba4a934d--
