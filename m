Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C214B3F7B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbhHYRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242237AbhHYRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:18:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C607DC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:17:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso4803807wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/f463DvLr/calLiNDLjjt5FVZTkgEt9zc8bsS269TX4=;
        b=RxRikHdqw6b+lKNARRx5dCX2F0IAkiWmxrlJeJZAKxRWT8yPks8zcoHz0bioTrDxFc
         BZhXiLKQNxU60sHlNvEZq6/1UcojlvGaPPMXkCzlHhbc8RoxIrXw/bEHmGleQ4JufsXB
         647rvgHOiBUxbdjfv/zqvUjB4s3bl+9DseREk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/f463DvLr/calLiNDLjjt5FVZTkgEt9zc8bsS269TX4=;
        b=dLoF/I5WVUVANPjylhufC0TDc8mE00sldQAW9sTaXpODY1aG2lCptfkMNZa09W7JfB
         5j2mzCqREOF9IK3LmOPlWbAIJZYQ8wQf5faScWi9F1oGopSOqzdvNE1ZMnjSg4+kcbCI
         QD471MlpILb4WaaJ1qBFjYv0H+Z4OJDHe1FAHGaZsFAbdGmb7c6duJx3hhA0FT7lKERZ
         ofGLakgpnQhM1Fmn1iUGJKhfUlChoAoRgovx2PpoB3ESkg0+SDNvUTOdE/SnqCTurOAb
         6dhMqld1B6CcDKf/JNwI6ta0LE5AHKeWfUiduyRyvBn/3Xm3tNHiWWZAt3dAEYTJ46k2
         Bl+A==
X-Gm-Message-State: AOAM530/XdPq+D+8NzvyGaAIPj+BWXrIZBZ9HXwy0BAL++vZZriMCh1v
        mLieUSN/oJhYmOq98odotlhzZqRClTmBZGcGCDSlxw==
X-Google-Smtp-Source: ABdhPJzI9RrfjwzTOtGiWMbqXx7vP1XByzV71h+90EGK5unVPWdIf36Ze521g0NSBr859KeELBJYfaTZ7AgEsaN9gcg=
X-Received: by 2002:a1c:3182:: with SMTP id x124mr3157462wmx.35.1629911878352;
 Wed, 25 Aug 2021 10:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-12-cristian.marussi@arm.com> <7a2f972d-fdd0-d0f7-cac2-1989980ed872@gmail.com>
In-Reply-To: <7a2f972d-fdd0-d0f7-cac2-1989980ed872@gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 25 Aug 2021 13:17:47 -0400
Message-ID: <CA+-6iNw-_VXcntU_UE8kTiPb8Sq28KkZG1__N7rE4ezo=VqQVQ@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] [RFC] firmware: arm_scmi: Add
 sync_cmds_atomic_replies transport flag
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        etienne.carriere@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000089cbfe05ca656e6a"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000089cbfe05ca656e6a
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 25, 2021 at 12:38 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> > A flag is added to let the transport signal the core that its handling of
> > synchronous command messages implies that, after .send_message has returned
> > successfully, the requested command can be assumed to be fully and
> > completely executed on SCMI platform side so that any possible response
> > value is already immediately available to be retrieved by a .fetch_reponse:
> > in other words the polling phase can be skipped in such a case and the
> > response values accessed straight away.
> >
> > Note that all of the above applies only when polling mode of operation was
> > selected by the core: if instead a completion IRQ was found to be available
> > the normal response processing path based on completions will still be
> > followed.
>
> This might actually have to be settable on a per-message basis ideally
> since we may be transporting short lived SCMI messages for which the
> completion can be done at SMC time, and long lived SCMI messages (e.g.:
> involving a voltage change) for which we would prefer a completion
> interrupt. Jim, what do you think?
Even if the SCMI main driver could be configured this way in an
elegant manner, I'm not sure that there is a clean way of specifying
this  attribute on a per-message basis.  Certainly we could do this
with our own protocols, but  many of our "long lived" messages are the
Perf protocol's set_level command.  At any rate, let me give it some
thought.

Regards,
Jim
> --
> Florian

--00000000000089cbfe05ca656e6a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LeylbuEJGL9I80yqq8e6Z+Q6ulLxa6SopzpoysJe/vEVHgp9jPNppZzwKngVd2iDBRqpKlCngIAM
DXgVGyEojXnuEbRs3NlB7wq1kJGlYysrnDug55ncJM8CAwEAAaOCAdswggHXMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJQYDVR0R
BB4wHIEaamFtZXMucXVpbmxhbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYD
VR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFCeTeUYv84Mo3T1V+OyDdxib
DDLvMA0GCSqGSIb3DQEBCwUAA4IBAQCCqR1PBVtHPvQHuG8bjMFQ94ZB7jmFEGhgfAsFJMaSMLov
qyt8DKr8suCYF4dKGzqalbxo5QU9mmZXdLifqceHdt/Satxb+iGJjBhZg4E0cDds24ofYq+Lbww2
YlIKC2HHxIN+JX2mFpavSXkshR5GT29B9EIJ8hgSjbs61XXeAcrmVIDfYbXQEmGbsnwqxdq+DJpQ
S2kM2wvSlgSWDb6pL7myuKR5lCkQhj7piGSgrVLJRDRrMPw1L4MvnV9DjUFMlGCB40Hm6xqn/jm0
8FCLlWhxve5mj+hgUOPETiKbjhCxJhhAPDdCvDRkZtJlQ8oxUVvXHugG8jm1YqB5AWx7MYICbTCC
AmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UE
AxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMI+Aj9XRk/wFexb9/
MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCVN64LJAWxmqAoWlQP++xnRdGH3owy
xZ+EcKeAs5EStjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA4
MjUxNzE3NThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQME
AgEwDQYJKoZIhvcNAQEBBQAEggEAkLp65/WK3ztv1oEP8DJ/oedLBy6Bw2rkFkjGs7hf3aPgBGlE
L49Jb4/kgdWMsavmdG/Se1QtZl6kwb4JJ5US3iyD4+rY+P1Aq7xez66d0A4/c8wnGQlQG1JCidUo
VLXtwenR3JGLfvdUu9qRFOrJiL0IUHYwMQltCZibe7uh18vY8suQFttfRLGhLajfq8VsM6ss4koV
n7Q1QiRY8kF7KCfQhzJIYRjDbjzi2Q4t6L6Rv1Du0DGxC3faoIUONcvk/gDuOUTb6jjb3PszyBfC
Sixsyw0b0Ea/YIHY9r8t6ufJ9ztkvOEEkplxCiF8MR2u3p/OaTCNhZxZ5qZt8y1bIQ==
--00000000000089cbfe05ca656e6a--
