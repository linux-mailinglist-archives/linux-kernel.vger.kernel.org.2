Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04A3777B4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 19:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhEIRPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhEIRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 13:15:38 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA1C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 10:14:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c21so11647774pgg.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=dT5OkAYCALyixcxFHYYKTuu0iIYm2fnzdCuDeHhhfJw=;
        b=Feg+YLNPEoJySXrfgZ14g85XpumBmBR8d0SXdMNJhUWLpSR7rXzYd+BXYJ1dvxTsQp
         6V2nVvCDszeaA5iMGn7HJji93qJyUsKs6WaNzGAnK5rDVEOI3mTdLBJApVYS5R2nu7OU
         iLKX3FKtXADm5vG2i2/9hFQoemCoEv0/d2bItN2Ru/tFbZTdtbX0N9ve/a9iAi2SY6R7
         dvF4wNvi1xaqofYAbMd10KeVSpeQfI5qUOD627vXNXR+pL/2A0dxkYlcHjr7Uckq2FEG
         AAchoiZjygbIidCUYvrePODMwVACaHgDqQARlsdxGvqF455/HSO4XmSU9ICLrXLfHttS
         HKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dT5OkAYCALyixcxFHYYKTuu0iIYm2fnzdCuDeHhhfJw=;
        b=VDSY5SS6AT18rDdyWx52VLnUtStY0xjd76YS2ZjkVExM8WtvRxTxcjOLAfxnc2qmpz
         8ghLYkugp30TeaWOCrP9slecDtnWwdlQ/GD9KRsyJzwDRMbzTdQa2IfekK+meshCaAn9
         JHVQS0O4v1K75F42BDqZPtMvxq6xkBCeSD61bwb9wUtnXt+bH3kwSWD+4kMc8Xb87sl2
         89AyWB2BpxHoF7SsgTZC5rhW/OnBh17MFHV0dO6xPHiWUj2zucPTnCxM1hNivitLO98r
         TT4FFyQEiT3ME5Li5mke4/piNu5T+Ys5xHtm2HaQMRqdaHiWqXar4Ymue+yN7qB/8ivq
         FSyg==
X-Gm-Message-State: AOAM5338ER8g2UaAksx41zdTGQRbC9QL4F0tfpVHZqr1CWI5jWebqBc+
        TM+4KBgfuIq6phf9T8NNmAo=
X-Google-Smtp-Source: ABdhPJykw3FWTgTEI5/kBjsLomeWUheNQoTyz/VcsBdPm8L50AFxfj0DHw2M0RtpsDXFBqUKZa3UQQ==
X-Received: by 2002:a05:6a00:895:b029:27f:96bb:915e with SMTP id q21-20020a056a000895b029027f96bb915emr21437655pfj.77.1620580474655;
        Sun, 09 May 2021 10:14:34 -0700 (PDT)
Received: from user ([2001:4490:4409:3b7b:b3a2:efed:aeca:89f9])
        by smtp.gmail.com with ESMTPSA id a20sm9214970pfn.23.2021.05.09.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 10:14:34 -0700 (PDT)
Date:   Sun, 9 May 2021 22:44:27 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, atulgopinathan@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8192e: Remove duplicate declartion
Message-ID: <20210509171427.GA9937@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dupilcate declartion of function rtllib_stop_send_beaconsi()
notify_wx_assoc_event() in rtl8192e/rtllib.h file.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4cabaf21c1ca..c6f8b772335c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1979,8 +1979,6 @@ void rtllib_softmac_new_net(struct rtllib_device *ieee,
 void SendDisassociation(struct rtllib_device *ieee, bool deauth, u16 asRsn);
 void rtllib_softmac_xmit(struct rtllib_txb *txb, struct rtllib_device *ieee);

-void rtllib_stop_send_beacons(struct rtllib_device *ieee);
-void notify_wx_assoc_event(struct rtllib_device *ieee);
 void rtllib_start_ibss(struct rtllib_device *ieee);
 void rtllib_softmac_init(struct rtllib_device *ieee);
 void rtllib_softmac_free(struct rtllib_device *ieee);
--
2.25.1

