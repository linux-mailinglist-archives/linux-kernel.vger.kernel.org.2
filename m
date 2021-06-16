Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573AB3A9C77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhFPNuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFPNt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:49:58 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A72EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 06:47:52 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id dj3so777442qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/opJMd2jNSpNXrVcowvubi0Rvcc9jycfvh3HLJN7cwE=;
        b=OhN7IXPSyZ/7eCN6Rt/VkSBS6OlK/ry0RagF9+kMUrahwieQhcxHEIl1vjnJ6+s0p7
         gW9SIvldOrKyIG2MFgSCS/QdMOooZQfwlhgrKf1DCa3GZZ9wltOxH7s0dI+yfj4rbxEZ
         fGo5oZJxzzSomuKbJIp0PItQxNKlXwU7fWWmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/opJMd2jNSpNXrVcowvubi0Rvcc9jycfvh3HLJN7cwE=;
        b=dpAeJy1LiSqkIhcMWfSvCwlhpRM/i3oOM6CLvITyoOoAyCFFKaW3S7DPXWzXKumpws
         rP9n1Z9yx3KdR2ox54b5Pt3Pa/tn/DGR1EA0TNO7bkZzIITSjtTiItSWKBXtA5Uo3BG7
         aHkEJg2Tm2sAP0And2dbI/PsEhvvl2ab7lqL4pAWX6TBGhi9xethM6fyCoJeBsjBcDYx
         /RK0TRnTmpzOvpIifCMYHvCA4zhO7oBQufDfXDpEDQZ+o5MGo5ZTO1P53FiRVo7BSY5D
         XKDvo8+mcClrQG7skQLlirJ6SjVzRRzZio1H2KsZD5dLQdzJZm7n4s3M+3BJV4lFofIr
         dZKA==
X-Gm-Message-State: AOAM532c8qTP/h+MoiBilIUo7s41kF8qOEde414KHdn0pWm+uD3qeV8C
        /l5fuOTbosJ5wl3CYntaGNxSxWpgpHuy1m94TZMUgOaTHqaJt7NP
X-Google-Smtp-Source: ABdhPJwapHW9Ntv3kssTBFl37AgtQVXnoGei2WePLJtdSqGnT4RNonEoitYACLs9999bSE3Trakzi2M+XP8CmWh8BBw=
X-Received: by 2002:ad4:4d04:: with SMTP id l4mr121182qvl.32.1623851271302;
 Wed, 16 Jun 2021 06:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210604071407.1360742-1-yangyingliang@huawei.com>
In-Reply-To: <20210604071407.1360742-1-yangyingliang@huawei.com>
From:   Kashyap Desai <kashyap.desai@broadcom.com>
Date:   Wed, 16 Jun 2021 19:17:40 +0530
Message-ID: <CAHsXFKEZtYiEA4tC2wEQBb9YOR3X6Be-nCMYrvVruuessZVP0w@mail.gmail.com>
Subject: Re: [PATCH -next v2] scsi: mpi3mr: Make some symbols static
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000367c8f05c4e2560a"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000367c8f05c4e2560a
Content-Type: text/plain; charset="UTF-8"

> Fix the following warnings:
>
>   drivers/scsi/mpi3mr/mpi3mr_os.c:24:5: warning: symbol 'prot_mask' was not declared. Should it be static?
>   drivers/scsi/mpi3mr/mpi3mr_os.c:28:5: warning: symbol 'prot_guard_mask' was not declared. Should it be static?
>   drivers/scsi/mpi3mr/mpi3mr_os.c:31:5: warning: symbol 'logging_level' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>   move extern int prot_mask to mpi3mr.h
> ---
>  drivers/scsi/mpi3mr/mpi3mr.h    | 1 +
>  drivers/scsi/mpi3mr/mpi3mr_fw.c | 1 -
>  drivers/scsi/mpi3mr/mpi3mr_os.c | 4 ++--
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
> index 5d5529167350..6f5dc9e78553 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr.h
> +++ b/drivers/scsi/mpi3mr/mpi3mr.h
> @@ -50,6 +50,7 @@
>  /* Global list and lock for storing multiple adapters managed by the driver */
>  extern spinlock_t mrioc_list_lock;
>  extern struct list_head mrioc_list;
> +extern int prot_mask;
>
>  #define MPI3MR_DRIVER_VERSION  "00.255.45.01"
>  #define MPI3MR_DRIVER_RELDATE  "12-December-2020"
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
> index 8aea1c2ae712..4a007cf54ad7 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
> @@ -9,7 +9,6 @@
>
>  #include "mpi3mr.h"
>  #include <linux/io-64-nonatomic-lo-hi.h>
> -extern int prot_mask;
>
>  #if defined(writeq) && defined(CONFIG_64BIT)
>  static inline void mpi3mr_writeq(__u64 b, volatile void __iomem *addr)
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
> index a54aa009ec5a..eec0b269a4db 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_os.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
> @@ -25,10 +25,10 @@ int prot_mask = -1;
>  module_param(prot_mask, int, 0);
>  MODULE_PARM_DESC(prot_mask, "Host protection capabilities mask, def=0x07");
>
> -int prot_guard_mask = 3;
> +static int prot_guard_mask = 3;
>  module_param(prot_guard_mask, int, 0);
>  MODULE_PARM_DESC(prot_guard_mask, " Host protection guard mask, def=3");
> -int logging_level;
> +static int logging_level;
>  module_param(logging_level, int, 0);
>  MODULE_PARM_DESC(logging_level,
>         " bits for enabling additional logging info (default=0)");

Acked-by: Kashyap Desai <kashyap.desai@broadcom.com>
> --
> 2.25.1
>

--000000000000367c8f05c4e2560a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMEdON+C5N/CKxQaNyh7EGcI6501
gs1Uo2sK1Cuo/JqlMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDYxNjEzNDc1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCvJSqZc221TOEmgOHRAydwkAThnpU6gMCCWWROBxNFAi/K
yiQ+RrVwjSem/NozFix11ZAHY7D4XJi+kpjadYkOpDJ6IjwoWI25SCgygehEyfWiYmiO4022CzwG
IcDuJXs7xXLwFWbGjBODuD2QJFog2MtIfGQf3cWg7SjGC7xvjh5Xl8qx3KW+c+3kQiuaQi+ALygL
3cvnIIDaQwlPVTvnEb9q9d6EP6hVbVBVzHFoz1Dp2sc3/CToLQydUGEDJXfismMCtzZnk9UjUdXy
TemPC4wkvj51r+fM15CzY9XlcwvDh57eZVS8zwTJMmd7AKn1WFIAao1VaDlmCJK/LJE0
--000000000000367c8f05c4e2560a--
