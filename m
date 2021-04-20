Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3673659E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhDTNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhDTNVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:21:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F428C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:21:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id m16so27953264qtx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 06:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=lcg8d1PC77f/cxBaj4rJNOd2+9alxBLI/ogFkLACJAU=;
        b=Sua0BebkkUy3kCFmagM1DRdUVxn4LsgxsKJK3PeYxGXYmS8P9pEWXx+R3h8WKHzmGm
         QxfGGM0uPtce4sodKA88FwYIxhO1EPveSEcH0tACdGQPNMqTDN/jbj9ATzlxk18z7ajp
         +Jo0AHm19BeaFJVk/Xpj9Gq7vUhbAAYIbVHkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=lcg8d1PC77f/cxBaj4rJNOd2+9alxBLI/ogFkLACJAU=;
        b=O+9nlEjhWap3ROFEeHMoV5tNKZWtZiNQZsmMP8Zt+ds2ldWa2b2sLI4XTcp1dD7KTp
         WTpp7IfKzHlRoXrL/IQT8GTDmwOLUAYDgWv057eH5sfmAXkgosVfFGWqvEzaRQVJK5gi
         poKGWpcQkugzUZ50F8fUmsjYBgSqHWt7M8mT2oaBHxYpwAL0imj+mwlgsIT1ZNKtiKfv
         VntEiY8Itd42JdBGGJYvVT/zrnSDiIz2GEf4ngPs6evXCHmBBJPIWF8D8JYHgWrjGzG8
         KCRJf5HFJEceSIm/p2kp9dTf0wb4Ba1Lt1qXWVlY93DU9XThOOML3C3kcxBiB15/sM5d
         s+yg==
X-Gm-Message-State: AOAM5335W3+hA5rB5CCqASD8jYu9iE1W4pHiUK82MDLt2MjDM5BjX3Jy
        YhZv0gNYML1a1jrDCT4u054aXs+Ue+RiGeAJ7y586Q==
X-Google-Smtp-Source: ABdhPJziFdyqNh0H/mlBVvxfPeftckS6vfx/lG71D+X3PrSsYVC1WYKHOp2ICVgs1JGgJ7EosclLbJU5wmqilFeuzQs=
X-Received: by 2002:ac8:5d88:: with SMTP id d8mr17012278qtx.387.1618924864631;
 Tue, 20 Apr 2021 06:21:04 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <CABTNMG0C7_1xYvgethtdPNTBLAfQEy5xu7q-MG=BbpqF2TwY5A@mail.gmail.com>
In-Reply-To: <CABTNMG0C7_1xYvgethtdPNTBLAfQEy5xu7q-MG=BbpqF2TwY5A@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHysWeFDpgDusIJflHyzZiT0NMu0qqGbA7g
Date:   Tue, 20 Apr 2021 18:51:02 +0530
Message-ID: <edbdf635a1f23dfa5d09c7ff8377bc11@mail.gmail.com>
Subject: RE: Broadcom 9460 raid card takes too long at system resuming
To:     Chris Chiu <chris.chiu@canonical.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Cc:     linux-scsi@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007efaab05c0675193"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007efaab05c0675193
Content-Type: text/plain; charset="UTF-8"

Hi Chris -

Most likely behavior you explained is associated with how much time FW takes
to be activated.
In case of actual init from fresh boot, FW is already started running once
system is powered on, and user may not be aware of it.
By the time OS boot reach driver load from fresh boot, there was enough time
spend in system bring up.This is not true in case of resume (Hibernation.).

Kashyap

> -----Original Message-----
> From: Chris Chiu [mailto:chris.chiu@canonical.com]
> Sent: Monday, April 19, 2021 3:45 PM
> To: kashyap.desai@broadcom.com; sumit.saxena@broadcom.com;
> shivasharan.srikanteshwara@broadcom.com;
> megaraidlinux.pdl@broadcom.com
> Cc: linux-scsi@vger.kernel.org; Linux Kernel
> <linux-kernel@vger.kernel.org>
> Subject: Broadcom 9460 raid card takes too long at system resuming
>
> Hi,
>     We found that the Broadcom 9460 RAID card will take ~40 seconds in
> megasas_resume. It is mainly waiting for the FW to come to ready state,
> please refer to the following kernel log. The FW version is
> "megasas: 07.714.04.00-rc1". It seems that the
> megasas_transition_to_ready() loop costs ~40 seconds in megasas_resume.
> However, the same megasas_transition_to_ready() function only takes a few
> milliseconds to complete in megasas_init_fw(). The .read_fw_status_reg
> maps
> to megasas_read_fw_status_reg_fusion. I tried to add
> pci_enable_device_mem() and pci_set_master before
> megasas_transition_to_ready() in megasas_resume() but it makes no
> difference.
>
> I don't really know what makes the difference between driver probe and
> resume. The lspci information of the raid controller is here
> https://gist.github.com/mschiu77/e74ec084cc925643add845fa4dc31ab6.
> Any suggestions about what I can do to find out the cause? Thanks.
>
> [   62.357688] megaraid_sas 0000:45:00.0: megasas_resume is called
> [   62.357719] megaraid_sas 0000:45:00.0: Waiting for FW to come to ready
> state
> [  104.382571] megaraid_sas 0000:45:00.0: FW now in Ready state [
> 104.382576] megaraid_sas 0000:45:00.0: 63 bit DMA mask and 63 bit
> consistent mask [  104.383350] megaraid_sas 0000:45:00.0:
> requested/available msix 33/33 [  104.383669] megaraid_sas 0000:45:00.0:
> Performance mode :Latency
> [  104.383671] megaraid_sas 0000:45:00.0: FW supports sync cache        :
> Yes
> [  104.383677] megaraid_sas 0000:45:00.0: megasas_disable_intr_fusion is
> called outbound_intr_mask:0x40000009 [  104.550570] megaraid_sas
> 0000:45:00.0: FW provided
> supportMaxExtLDs: 1       max_lds: 64
> [  104.550574] megaraid_sas 0000:45:00.0: controller type       :
> MR(4096MB)
> [  104.550575] megaraid_sas 0000:45:00.0: Online Controller Reset(OCR)
>  : Enabled
> [  104.550577] megaraid_sas 0000:45:00.0: Secure JBOD support   : Yes
> [  104.550579] megaraid_sas 0000:45:00.0: NVMe passthru support : Yes [
> 104.550581] megaraid_sas 0000:45:00.0: FW provided TM
> TaskAbort/Reset timeout        : 6 secs/60 secs
> [  104.550583] megaraid_sas 0000:45:00.0: JBOD sequence map support     :
> Yes
> [  104.550585] megaraid_sas 0000:45:00.0: PCI Lane Margining support    :
> No
> [  104.550999] megaraid_sas 0000:45:00.0: megasas_enable_intr_fusion is
> called outbound_intr_mask:0x40000000
>
> Chris

--0000000000007efaab05c0675193
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
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDfWsS9LGH0ee4Opq38MIgnxKEMk
p113Qw3oNEO8Nj7OMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDQyMDEzMjEwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBHcCfzX5hyepwMFJUUIGTmM5xPfuRBRm9KUWlJ85BqG/eQ
DZv9RkLpDxXLcPuf//c2H5oYiZEzYqLM+ZvvTIyxrtLtIzftFIsd5YX4LzJy3vvUvyPhJXiWLZRo
7ilInZMUSVUT+xCobEfiQNfmcS95jJO20C+YEZqi/9i8gPcExa2ZFUR6aHacUt8CF0996oxlFU4m
sCuKW+tSvDYSPU/XNVIM4S/vV0MMu+oX4fZ8+44WPbUdv73FyChBuhLb1uemsFouTB6DNmg4mdrZ
+wXmVCdaQu4XeI1JAt5bz0Ggvle+bQUn9PMXZNa+RBXN/mv7MUWY7Y4cFkK1enetop1m
--0000000000007efaab05c0675193--
