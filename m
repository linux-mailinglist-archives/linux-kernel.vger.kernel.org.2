Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B2B32BA80
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357764AbhCCLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:24:21 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28055 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbhCCC0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 21:26:37 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210303022541epoutp01e3c12121adcd671631f981fd23a2a160~os-di0xjl2944429444epoutp01g
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:25:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210303022541epoutp01e3c12121adcd671631f981fd23a2a160~os-di0xjl2944429444epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614738341;
        bh=WFo02n4iB9wax/xdPqJhFWU/UDoKMo20zeRVoCJV5bc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qVXqu/MudW/bDVSKRUnS7k/Ns8wKJoWo+nd9I/WVTJzFuKXf6Cx1tVuVW0Bp7T2oe
         8rA9iLGY8o+8CMo8uqQovbqH6+xs0vw9LNprdeGcRS93UlanxMpaJDzcUFbzCZ5AQj
         8j+AqEWmVI5vHRyizlzJHrHv3iFv/rJddT9O+Baw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210303022540epcas2p3c118942f347dc9684a7da127da3899b6~os-dCSTxP1464014640epcas2p3Y;
        Wed,  3 Mar 2021 02:25:40 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.188]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DqyXM4q7jz4x9Py; Wed,  3 Mar
        2021 02:25:39 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.03.10621.2A3FE306; Wed,  3 Mar 2021 11:25:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b~os-aKt_op2609226092epcas2p1y;
        Wed,  3 Mar 2021 02:25:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210303022537epsmtrp2771194dd94b1b5e07c2981840718d41a~os-aKGawX0055600556epsmtrp2P;
        Wed,  3 Mar 2021 02:25:37 +0000 (GMT)
X-AuditID: b6c32a45-34dff7000001297d-42-603ef3a221d9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.65.13470.1A3FE306; Wed,  3 Mar 2021 11:25:37 +0900 (KST)
Received: from rack03.dsn.sec.samsung.com (unknown [12.36.155.109]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210303022537epsmtip1c21b4f3e83b02b645dc1f324b429b77c~os-Z96z801460114601epsmtip1k;
        Wed,  3 Mar 2021 02:25:37 +0000 (GMT)
From:   taehyun cho <taehyun.cho@samsung.com>
To:     balbi@kernel.org
Cc:     taehyun.cho@samsung.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
Date:   Wed,  3 Mar 2021 11:26:28 +0900
Message-Id: <20210303022628.6540-1-taehyun.cho@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmhe6iz3YJBmemi1sca3vCbtG8eD2b
        xeVdc9gsFi1rZbaYdFDUgdVj06pONo/9c9ewe/RtWcXo8XmTXABLVI5NRmpiSmqRQmpecn5K
        Zl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBaJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BoWGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsbivcsYC2ZwVvxaFNbA
        uIe9i5GTQ0LAROLb3dfMXYxcHEICOxgl5h2awgrhfGKU+Hn0KiOE841R4lrnKbiWH7d2QbXs
        ZZTYPLMHquUHo8SPk4uZQarYBLQl9jffZAWxRQREJNqez2ACKWIW6GSUuPL4MRNIQljARuL9
        52WMIDaLgKrEsrNXwOK8AtYS289cYoNYJy+xqOE3VFxQ4uTMJywgNjNQvHnrbLAzJAS2sUv8
        6PjGCtHgIvG69TNUs7DEq+NboO6Wkvj8bi8bREM7o8SvE2tYIZwpjBIf1p1ihKgylpj1rB3I
        5gBaoSmxfpc+iCkhoCxx5BbUYj6JjsN/2SHCvBIdbUIQjaoS7RfvQ62Vlri0+SaU7SHRt3wV
        2AlCArES36edYpvAKD8LyTuzkLwzC2HvAkbmVYxiqQXFuempxUYFhsjRuokRnPi0XHcwTn77
        Qe8QIxMH4yFGCQ5mJRFe8Ze2CUK8KYmVValF+fFFpTmpxYcYTYEBPJFZSjQ5H5h680riDU2N
        zMwMLE0tTM2MLJTEeYsNHsQLCaQnlqRmp6YWpBbB9DFxcEo1MAm2/e1LlrGYVyEsvV6tWWRJ
        u5he/P6HnXGdwnynl34TdVsVtD375MMLGpc8Hh7InHl1sZmXj1NTzNKzhTfv3I9PCH6w7dUZ
        g1PVHw4UnFUVnfS963zxpUf17+7OLbNbJxnO3yTgMP/mjHrmnXtlOGZ8OZL4RuHoE7XXB3da
        vGxiS617KHA+7RtDhzvTYlvRA225nO2XM6dwh069cIp1ZfeRc6zXFwaLR6nMCT35f9vLCbx2
        Xsunn5twZ9l3ZuP5RSuT69blcYjf1zrnzcSp8/GEace10uJ7d17PUHT8X5I0pyPK4LGG17Pf
        N2b+V2v3X+V6/M0MxwW9P2Uy083Obff8zcrntr+g4rnaglmBnwWUWIozEg21mIuKEwGSKNbO
        BQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPLMWRmVeSWpSXmKPExsWy7bCSnO7Cz3YJBl8OGFgca3vCbtG8eD2b
        xeVdc9gsFi1rZbaYdFDUgdVj06pONo/9c9ewe/RtWcXo8XmTXABLFJdNSmpOZllqkb5dAlfG
        4r3LGAtmcFb8WhTWwLiHvYuRk0NCwETix61dzF2MXBxCArsZJbatXsUIkZCWOPV4ATOELSxx
        v+UIK0TRN0aJW+dugnWzCWhL7G++yQpiiwiISLQ9n8EEUsQs0M0o0ff0KBNIQljARuL952Vg
        U1kEVCWWnb0CFucVsJbYfuYSG8QGeYlFDb+h4oISJ2c+YQGxmYHizVtnM09g5JuFJDULSWoB
        I9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgMNTS3MG4fdUHvUOMTByMhxglOJiV
        RHjFX9omCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cA0
        n+vcmlvWMxO2z+c2TD70jL0pNKPi4x/GJI9POqtmWvdvOucXX6qrvfGiooCswSON+VLKgZbT
        OKRCS+ZPyLjRdki87sFLPUl77ft3WFx35Csczz58+MqDx2qhCeWXxLglLH9lm+xtz4zOMo57
        uXDdv2NylT93CHzbdWpNvcvU2/2/1J8ZLg1WjnlwtvJWW/LdnoLG3ol2NpVSGg2KLuwnMnLq
        XnK8kPKZkH1v7fuetMs72ixuPf+yhHU31xmO66b+Hb/k9S6lNLTd+Om5LWGXIsPtUvk5mnER
        re9UQ3/tSNzu2ur3ZNsjL2ZjnoautS+Odv8X/q275E2qVwpnaG38rqAzv1hcjjTv1Z3xXVyJ
        pTgj0VCLuag4EQBQmClBsgIAAA==
X-CMS-MailID: 20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ARCH_EXYNOS' is not suitable for DWC3_EXYNOS config.
'USB_DWC3_EXYNOS' is glue layer which can be used with
Synopsys DWC3 controller on Exynos SoCs. USB_DWC3_EXYNOS'
can be used from Exynos5 to Exynos9.

Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
---
 drivers/usb/dwc3/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 2133acf8ee69..2a339b3b82c2 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -67,11 +67,12 @@ config USB_DWC3_OMAP
 
 config USB_DWC3_EXYNOS
 	tristate "Samsung Exynos Platform"
-	depends on (ARCH_EXYNOS || COMPILE_TEST) && OF
-	default USB_DWC3
+	depends on (USB_DWC3 || COMPILE_TEST) && OF
 	help
-	  Recent Exynos5 SoCs ship with one DesignWare Core USB3 IP inside,
-	  say 'Y' or 'M' if you have one such device.
+	  'USB_DWC3_EXYNOS' is glue layer which can be used with
+	  Synopsys DWC3 controller on Exynos SoCs. USB_DWC3_EXYNOS'
+	  can be used from Exynos5 to Exynos9. say 'Y' or 'M'
+	  if you have one such devices.
 
 config USB_DWC3_PCI
 	tristate "PCIe-based Platforms"
-- 
2.26.0

