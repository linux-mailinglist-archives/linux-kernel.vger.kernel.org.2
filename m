Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8C30AF77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhBASfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhBAScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:32:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB3C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:32:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id g10so17736517wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SoF83zqa4o6wjRaTLITT+SZXWk+cnBlU7tDY3VfJEs=;
        b=S+uBzCKh1GZJdMZRucSjhjms87AHXTsSRlmCuQhNms3pPR13uXfTL8pCbuM2AENBU4
         yAx30YHbk/gmTBg8kITJdPGSVp3AAJQRulom6G/yeVYh0X8flD0BBtAko3ITQVJCyHzc
         uWaR4Obx7k0wM1q79yEs18IncVsryK8n3kIt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SoF83zqa4o6wjRaTLITT+SZXWk+cnBlU7tDY3VfJEs=;
        b=rqd09yV0Uky0UXKGinYs1FFpKEQgz2xUu7PUZwUBNdcQKiR8iwQ/LEldSaepydpZ+7
         X3xis7NUlEOQY+WT3JvTQGy/ucSJbFOSJ2jgLnqLkATbrVrQqQQXuxN+UpQb6q3aQXTG
         Lz6/b94SOFU9wE6LUCmOuJ6oFCSELY7x9bbB0tJPWGCDlzuYxnkm2v+UKP9lQItEK1+9
         5ZUaQR/TTpDkpHq52Rx9vZNBqvfv8KJljCEpbz3Wo/bMy56MMjmNwfri+a+J8Pb54ldC
         xFRIjjlUDB7vxD3rVOailu4NkXOMCLRs04e5nuO0liKwOZgBJGyMxctYdP7R+JFOBDrf
         OGYw==
X-Gm-Message-State: AOAM531BJTfsNt6lf/jGxCUo2Q8CjDdbL8Z2Fpo1ay7BgPgZIJD17rPP
        kZWaidUXS6UDWFEDqZwsYg+AioXeoXII4U3tHE9WUg==
X-Google-Smtp-Source: ABdhPJzW0raaLdsyJa/pVY1yy1ug4OX5v2KHm51ujt9+9FP9lME1RcuXz6GvwUPifz40r6bFM3BFA2dC7Bt7a0bFlJI=
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr19909114wrv.292.1612204320100;
 Mon, 01 Feb 2021 10:32:00 -0800 (PST)
MIME-Version: 1.0
References: <YBfyb+jU5lDUe+5g@mwanda> <cf899c97-2c26-afc4-f0ea-4976a074a05e@broadcom.com>
In-Reply-To: <cf899c97-2c26-afc4-f0ea-4976a074a05e@broadcom.com>
From:   Desmond Yan <desmond.yan@broadcom.com>
Date:   Mon, 1 Feb 2021 10:31:49 -0800
Message-ID: <CAEuuh2-uNkbK6wsJVBUEXMv2TQdhQaRCqtM0GdULWgVHU+JDnQ@mail.gmail.com>
Subject: Re: [PATCH] misc: bcm-vk: unlock on error in bcm_to_h_msg_dequeue()
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d2c3ec05ba4a9186"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d2c3ec05ba4a9186
Content-Type: text/plain; charset="UTF-8"

Yes, in this situation, it is fatal and we would turn off processing
anyway.  But, Dan's change seems more appropriate and proper practice
(thxs for the patch).

Des

On Mon, Feb 1, 2021 at 9:31 AM Scott Branden <scott.branden@broadcom.com> wrote:
>
>
>
> On 2021-02-01 4:22 a.m., Dan Carpenter wrote:
> > Unlock before returning on this error path.
> >
> > Fixes: 111d746bb476 ("misc: bcm-vk: add VK messaging support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/misc/bcm-vk/bcm_vk_msg.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
> > index eec90494777d..fc972e43258a 100644
> > --- a/drivers/misc/bcm-vk/bcm_vk_msg.c
> > +++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
> > @@ -849,7 +849,8 @@ s32 bcm_to_h_msg_dequeue(struct bcm_vk *vk)
> >                                * that is fatal.
> >                                */
> >                               dev_crit(dev, "Kernel mem allocation failure.\n");
> > -                             return -ENOMEM;
> > +                             total = -ENOMEM;
> > +                             goto idx_err;
> >                       }
> >
> This is a pretty fatal case if we fail to allocate memory here.
> Will let Desmond respond if we wanted to keep the mutex locked forever in this
> case or if we do want to return and keep mutex locked if it is fatal and there is
> no real recovery path.
> >                       /* flush rd pointer after a message is dequeued */
>

--000000000000d2c3ec05ba4a9186
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
0nbv//4itGuVqDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgCMsT0WNSM66IvgdT
1XlKWLEVp/VpuFMmWhXCS+AOgbQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjEwMjAxMTgzMjAwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAL2MJ8i+E+/KaYoJbLFjsAEYR+0TOvCn0oop
/F3WX14+50bpvqdeoi+VgP8BkbajRrs/YtUX7RuCJsBlYsDIBuIrMWeVpqimItexR0Ve4nXtrcSG
/uCuHpZz4gxLmNyV/GWxqxQAVSNkq3weSD5yIJEYQtllDHdqUdn/OnatqmSPhBwaHQGpJzUmOcBq
tMurxYlhQVxeBs0pTD01wmTTWPMIgUC04H+UH/sfm9nsvr780chuX+ODAGFRp4Dx9f7ESRSdmLsP
yf8K41gAsWOHNpTvwlRUva1it3FdoyLbWEFP3CuYsEf6ZRi5ttpYT7n/Ll7CnH+kSjrdjpdrcZox
FNY=
--000000000000d2c3ec05ba4a9186--
