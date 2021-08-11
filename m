Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1DC3E89EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhHKFyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbhHKFye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:54:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEF2C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:54:10 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id be20so2966869oib.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pJHsBNbdM68NHFN+WVrohaQ6exWh5T1KZJKnJiutO8=;
        b=W9/XbrFfYPJ4Jxf786AYrmVbrWlRz0FrCcCVuAE3dQ5RG4GIGu9oS1fHL5RhdSfsMF
         iAtIyQS6kAx6zhtquNL84Jy2h1z9X8cpkcEd2Z29hT+pYsUMFFo23ysc/UrY7nBQteg8
         /h3WvTVdFNfkhm1petSoeNK6YrDv6ZncoFdF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pJHsBNbdM68NHFN+WVrohaQ6exWh5T1KZJKnJiutO8=;
        b=RHr9Y9EZHpemy5jPlIaoLSi2xcEviTUjHd4nMT3sZ4GcgymiEmnbBnL1eR3AzC9rHa
         yR+oYlKeLA3x656YhErQMCrFoaTOo+EwKu19ueg4DG6oJc57ajZZU6EmymS8SfS0dvJd
         rh/pNFeBxtYmsNFoDqTN57qJxGaFl23IJoqr9/CiKQUdT588jeQcxYIWqIIm+Gu+Vjh8
         PsH5JnIfE9lw5GJ629g7LJAYaAPhfJ1J3dbj1mcGy6CsMXF8DYFFjBakirOPiooKYj8/
         eYVpc2IGQuDVFh/QtaXTPHxIIETL3SeyuFdarEgSfHHabDohOlEs7bLO0lX7Hen8Tpui
         Pmhg==
X-Gm-Message-State: AOAM533WKmXjHV4SChE9pK0IVUCm4G0SfaQqkhwO6II2QkXTQbOEqidH
        kWUBdEOiSzGqqCOFlvXyVLtqSk1Y4wBYup1ZuymjUA==
X-Google-Smtp-Source: ABdhPJwx5Q+Nm8kvAeMrVYHpDgyCF7VaemxDxc3+zrRPzGcbNqrpQmgVnN87Hq+gwIH4gJyKB7HVkk0b+0YpbIlwlyY=
X-Received: by 2002:aca:ddc3:: with SMTP id u186mr6635702oig.90.1628661249141;
 Tue, 10 Aug 2021 22:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210811154005.7fbbb9e2@canb.auug.org.au>
In-Reply-To: <20210811154005.7fbbb9e2@canb.auug.org.au>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Wed, 11 Aug 2021 11:23:57 +0530
Message-ID: <CAK=zhgqELQM1Sro5dredSxS1w+qbfnOhMznH_CAdHiYr6FB6_g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003d5b5705c9423f89"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003d5b5705c9423f89
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 11, 2021 at 11:10 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the scsi-mkp tree got conflicts in:
>
>   drivers/scsi/mpt3sas/mpt3sas_base.c
>   drivers/scsi/mpt3sas/mpt3sas_base.h
>
> between commit:
>
>   fae21608c31c ("scsi: mpt3sas: Transition IOC to Ready state during shutdown")
>
> from Linus' tree and commit:
>
>   432bc7caef4e ("scsi: mpt3sas: Add io_uring iopoll support")
>
> from the scsi-mkp tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks Stephen,  Below changes are looking good.

Regards,
Sreekanth
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/scsi/mpt3sas/mpt3sas_base.c
> index cf4a3a2c22ad,e7f6fbb282bd..000000000000
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@@ -8471,7 -8738,8 +8738,8 @@@ mpt3sas_base_hard_reset_handler(struct
>         _base_pre_reset_handler(ioc);
>         mpt3sas_wait_for_commands_to_complete(ioc);
>         mpt3sas_base_mask_interrupts(ioc);
> +       mpt3sas_base_pause_mq_polling(ioc);
>  -      r = _base_make_ioc_ready(ioc, type);
>  +      r = mpt3sas_base_make_ioc_ready(ioc, type);
>         if (r)
>                 goto out;
>         _base_clear_outstanding_commands(ioc);
> diff --cc drivers/scsi/mpt3sas/mpt3sas_base.h
> index 0c6c3df0038d,3cf2e4615ff5..000000000000
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.h
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
> @@@ -1730,10 -1755,9 +1755,13 @@@ do {  ioc_err(ioc, "In func: %s\n", __fu
>         status, mpi_request, sz); } while (0)
>
>   int mpt3sas_wait_for_ioc(struct MPT3SAS_ADAPTER *ioc, int wait_count);
>  +int
>  +mpt3sas_base_make_ioc_ready(struct MPT3SAS_ADAPTER *ioc, enum reset_type type);
>  +void mpt3sas_base_free_irq(struct MPT3SAS_ADAPTER *ioc);
>  +void mpt3sas_base_disable_msix(struct MPT3SAS_ADAPTER *ioc);
> + int mpt3sas_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num);
> + void mpt3sas_base_pause_mq_polling(struct MPT3SAS_ADAPTER *ioc);
> + void mpt3sas_base_resume_mq_polling(struct MPT3SAS_ADAPTER *ioc);
>
>   /* scsih shared API */
>   struct scsi_cmnd *mpt3sas_scsih_scsi_lookup_get(struct MPT3SAS_ADAPTER *ioc,

--0000000000003d5b5705c9423f89
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQdgYJKoZIhvcNAQcCoIIQZzCCEGMCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3NMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVUwggQ9oAMCAQICDHJ6qvXSR4uS891jDjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIxMzAyMTFaFw0yMjA5MTUxMTUxNTZaMIGU
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGDAWBgNVBAMTD1NyZWVrYW50aCBSZWRkeTErMCkGCSqGSIb3
DQEJARYcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAM11a0WXhMRf+z55FvPxVs60RyUZmrtnJOnUab8zTrgbomymXdRB6/75SvK5zuoS
vqbhMdvYrRV5ratysbeHnjsfDV+GJzHuvcv9KuCzInOX8G3rXAa0Ow/iodgTPuiGxulzqKO85XKn
bwqwW9vNSVVW+q/zGg4hpJr4GCywE9qkW7qSYva67acR6vw3nrl2OZpwPjoYDRgUI8QRLxItAgyi
5AGo2E3pe+2yEgkxKvM2fnniZHUiSjbrfKk6nl9RIXPOKUP5HntZFdA5XuNYXWM+HPs3O0AJwBm/
VCZsZtkjVjxeBmTXiXDnxytdsHdGrHGymPfjJYatDu6d1KRVDlMCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUClVHbAvhzGT8
s2/6xOf58NkGMQ8wDQYJKoZIhvcNAQELBQADggEBAENRsP1H3calKC2Sstg/8li8byKiqljCFkfi
IhcJsjPOOR9UZnMFxAoH/s2AlM7mQDR7rZ2MxRuUnIa6Cp5W5w1lUJHktjCUHnQq5nIAZ9GH5SDY
pgzbFsoYX8U2QCmkAC023FF++ZDJuc9aj0R/nhABxmUYErIze2jV/VO8Pj7TnCrBONZ/Qvf8G5CQ
X1hfOcCDBgT7eSvf9YRLaV935mB9/V+KYX8lT4E0lB4wQ0OLV8qUS9UuNoG2lCJ5UQTMrBgeUFFY
eKKhn+R91COmRlKGlaCdTtzKG5atS6dPnGEYUHjcpUvzejmJ5ghBk6P01HqSACsszDOzmBvdiOs+
Ux0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxyeqr1
0keLkvPdYw4wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOL/k8NML0Eqh2R/pctg
ytoGz5VONMTcHiK1F3bBe1fCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIxMDgxMTA1NTQwOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB9E+7CkHyH+5Hx2b6SiCPJsWWqS9IL8DHJpttI
kYl5CJLCXPiI91o7PK7gignB22DY9Qk74Xo+M4Yi6UdjCRb33AfVGJifdNz/rWzOJoSXCk/2AxiV
Rh1Ex07QWvzDA/9XNN1+HOk7tDeU5MAVlLg9nnAi+baifKTlZixv2FIKydeucG2nK2Esju5RoiKs
ekpywGy5JNQXjjZ4B5Qu398b8/xCjheqiHONtt6thDZUKC4evC1UBHnczXn1G/LILe3uJm6Fw6Mv
E9S8dtaVgGY057PYqUPuw3QmFyeyLO0Z6wOdc5EwgmZaxqsJanOTuz4xD+2hAEKeh6nbDpO6lg/u
--0000000000003d5b5705c9423f89--
