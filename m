Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A845535C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 04:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbhKRDZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 22:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhKRDZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 22:25:22 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2102C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 19:22:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m14so4549368pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 19:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version;
        bh=xedMP1ZkqZXA2h8jwzBT2LFvWL5ySMN/Y1y8FYtzcIU=;
        b=Nl41wYBaSKRsBwRePkbDlYmaSIm1ofrircMokZqEZXuh0PLW2T7BjOQbld9LWD6AMw
         YlYJHG7u/FG8b8uvzOv0YKeI/rdlxl4pDTFcy9CPWnq6E4SSSMrb0XEAM1EjXPSyTVrc
         UkvjcCL7Pl2jtwb2m+oGCCRUZm8+xrittprLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=xedMP1ZkqZXA2h8jwzBT2LFvWL5ySMN/Y1y8FYtzcIU=;
        b=bpk+PBGdiQoUkp/tJwfNNp0OAshEUv7J4HlyIB/JFD7fGB1LtRulAV+9GQhBfSmUy1
         E/A6lqMpXh5+5vWerq4psVq7ZAMlGevPVdguQJcjbst+3Vw5ReZhif/DKp3QT1q4B08T
         yF7aZxLdNIwjLRrTHlwB/bqPd9Mn7FZ+U8AimG5kCJ1gSZaDI554HYYXdQzZKuQfOWKv
         x3FxQP8pD8hKed3tKmKkve88bjJ80Z4nGZoFC5YXImNVR1ORi3l2leXvX6/mkFOhLtjb
         28O3Y+xEZNTyKrd5UAik3j7+GspYVLIqtQ4sxA/afVthoXz7taMfhTYLjyMMHy2TbclG
         FdEg==
X-Gm-Message-State: AOAM533s3evIILStODnxwuiIWqPVaPUUtmAvfxcuqffjXvLPBfUctzN+
        ibI53BPyoLKrTAcmhBgrN0hYjiRPA1FZbnfW9ffDPVBt7tgOb/NDcJx2SZVR/ndHFVp9qnx3tlM
        fx45L1MuIHMpb1o9WUTLQHYy7RYO3CIk0QSqou+yWv0BJtt6LMPyHAXvtUek1sU3Xj9E+YZ90iQ
        15bDdKvTKXgwtpp1B3Jw==
X-Google-Smtp-Source: ABdhPJyG8vcHm57su/Lt54mqQMlVn8EkoGKgG4m2E5IO3q/O83iasrtBG9y5eblpIEd3EU1AYZcU7w==
X-Received: by 2002:a65:6a4b:: with SMTP id o11mr9001190pgu.305.1637205741013;
        Wed, 17 Nov 2021 19:22:21 -0800 (PST)
Received: from ldt-sj3-komrakov.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id z10sm1049654pfh.106.2021.11.17.19.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 19:22:20 -0800 (PST)
From:   Alexander Komrakov <alexander.komrakov@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     alexander.komrakov@broadcom.com
Subject: [PATCH 1/1] Calculate the monotonic clock from the timespec clock to generate PPS elapsed real-time event value and stores the result into /sys/class/pps/pps0/assert_elapsed.
Date:   Wed, 17 Nov 2021 19:22:16 -0800
Message-Id: <20211118032217.244985-1-alexander.komrakov@broadcom.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b120da05d107aaec"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b120da05d107aaec
Content-Type: text/plain; charset="US-ASCII"

From: alexkom <alexander.komrakov@broadcom.com>

*** BLURB HERE ***

alexkom (1):
  Calculate the monotonic clock from the timespec clock to generate PPS
    elapsed real-time event value and stores the result into
    /sys/class/pps/pps0/assert_elapsed.

 Documentation/ABI/testing/sysfs-pps | 24 ++++++++++++++++++
 drivers/pps/kapi.c                  | 38 ++++++++++++++++++++++++++---
 drivers/pps/sysfs.c                 | 33 +++++++++++++++++++++++++
 include/linux/pps_kernel.h          |  2 ++
 4 files changed, 94 insertions(+), 3 deletions(-)

-- 
2.25.1


-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--000000000000b120da05d107aaec
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVkwggRBoAMCAQICDHYIL0hy7FtCa0iawzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNDMzNTVaFw0yMjA5MDEwNzU5MzNaMIGV
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDUFsZXggS29tcmFrb3YxLjAsBgkqhkiG9w0B
CQEWH2FsZXhhbmRlci5rb21yYWtvdkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC9plVHzugCEzdkg+8eZF4DLPZ5fqspSSVbjMcgMDJQcAR76/SGGJnSJiHOj/rn
okK4r4HXW8cTMmw/ePqLs+eX7+h2TlrLFdwnPs6ThKSnKe7aNihCrk9rF+WyTTX/VrqyKPYICkp0
/XhRuIlIO0cP979rZRsxD4LKmC6x1msVkkM7JxkWhkktTzQwowAemtij6uzfYeh5BzQd2+LaWp8g
ZX2NhNnwh9gNMFxHdE5c6+G3LG7AHwFOPA6G1TuzZ35urQXh4HWGbGoCJPszKLgccfOBBHYaXyo6
yiBn77ZVlo89La3IlKW/J8Bg1ZiYHcR6RtGGylxCCKgFDdESfV03AgMBAAGjggHgMIIB3DAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCoGA1UdEQQjMCGBH2FsZXhhbmRlci5rb21yYWtvdkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFElfe2CJ
evQgM+vs7qmUiI/AGUBAMA0GCSqGSIb3DQEBCwUAA4IBAQCmTMsF9VHjT0L2ycGjBg8eb/+aTBhL
U6r4e4vaGj/xmDd1cWfvz4brxodjpmuSnjfyWvU/odcNIepLv17Xc91OiZBWGYgr4jNViUqunvaH
DCnJlLbrD88ITE1uo7OCdlN/SS+Sskp2dDvL/Xlyorb+PaS7/AaIwEmuGyJv2uv1wQ+UZzPXXo1B
vOM4N+PxiEKCkmmYhfeSVye92Bta6vjf0b+oDE2JT82+D+9nAfiyJ9P/SRVTTvLlSzcO2fqX6GOc
37xY9F5HGjunD+cc5mqKM/r5PXyM/LEzWjdU1lVUVuvLRerUn+GNFgAPzpksTVYDv2kuseIFwRrF
845kQxaRMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIM
dggvSHLsW0JrSJrDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC4BsvR4ZesMIlq
bOgvaULtje2hJsOUwu9g/lktbrYjcjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMTExMTgwMzIyMjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHSiZ6QVW0nSsG4km4uinkRKcAf8sRbuf
JbnSEa+ASusSnGh14WtFAsRwClZeKnEJXrYDtNLji8OqcpbBuD5tiCKED9sMN/yLnVBMesS8ixl4
TGieekKZEa2yF7j26jMSGweE4PNlN/6bEBdV+mGB8maZlIGQ55ea6q2SqGhPmdxvtlOQHtRyoBH/
xf9M9Z11S4ZYGvaE8JfUZqA8DFvJUpd89Cm04HkvzmezOr+WhSvnK5BZKXQh72b4u2DZYkwHofcL
xkgBxQBoE+LpcIHf6jQOt8YfUlQGu1McvcDmr0TDA7ZDEkDNGS1YLmMTVOWBpMn0rCTIiXtYODLp
f14DIQ==
--000000000000b120da05d107aaec--
