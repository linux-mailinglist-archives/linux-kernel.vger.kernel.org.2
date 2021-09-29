Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68441C57A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344156AbhI2NYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344148AbhI2NYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:24:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07A6C061760;
        Wed, 29 Sep 2021 06:22:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b20so10812602lfv.3;
        Wed, 29 Sep 2021 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OGgy6PY9R3yl/0r3hvANVaQGDrHRDnCpCti/cTSOZWk=;
        b=bZZ/ymz9a6EE+ghHDYneld/zn5AOqI7cwiEBNW5tD/hJn0XwMOOfakhSake6pab53D
         65bsBQnQ7+Ynz6s9g8JKEDs/6BKGs4wZBo0Nx2TbDsxqQY98JWez/ZL/PceJOQVLqk3M
         55hzYHJG4D94hmqEhL2rpqAGvYYC9+ZRYT+zAx0yoyq5b6bp7/DtcRdL++GhnpBclsB6
         9QnvJ35jB0ShORRCfpDtIy6utEI0tvF35+/xKhlS523ylQbjy2JknfhV3zmaY/L+vpEO
         g++JhBPOxadhDDz4wQq18KGCX/ozByIIWhyhQ4DjgMzADHuOv+GVJId56pqLrdLMFi9o
         rwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OGgy6PY9R3yl/0r3hvANVaQGDrHRDnCpCti/cTSOZWk=;
        b=ZeRP6hdGvj2pUjTTzX6SUcMMb87q9UpnC4MmOtlR0cbkqbBLRwi/M7wByJXIHQY6b4
         hFV+wXiga4mcnQs+oZuM3HOsMwWsYtdPSamg+3uLTNhfPo36wv5LyzQgWHHzuhoY0VTA
         EHzcVuIrYFbKiGBL2zw/q1i82d1MSwhiomaFcduwwMWPj2mbtnCh845eh5fSegY0kdQR
         3fnmtMV7I9jFRI7oncjl7fFyh2vM0pSnRopEzGIoNu19lzPnTJ1ukd5yUdii8KXyS/HE
         Vq657zlKYKoSuYgbJeMNLXN4bTyXjijmIvBiEgdCCJsjcaQMDmCcOTLVq3/OTF6DT2KE
         jWzw==
X-Gm-Message-State: AOAM532hjuo935YG04uXkyKFyPG7XOtGjqFoTfxrr1UtKok9SVcDaK1m
        OKVRFr9zd5NucIXIytGxgY+qcDHRMqE4Ng==
X-Google-Smtp-Source: ABdhPJz5PwOMN3Err04apFYPqLdEP6g0+0yGRnCveILE/3Sk6HV4EikhelqSLZFfp1+bLJCglNhcjA==
X-Received: by 2002:a19:711d:: with SMTP id m29mr1012930lfc.132.1632921740148;
        Wed, 29 Sep 2021 06:22:20 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id z10sm283695ljc.117.2021.09.29.06.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 06:22:19 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Junlin Yang <yangjunlin@yulong.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/2] usb: cdc-wdm: Constify static struct wwan_port_ops
Date:   Wed, 29 Sep 2021 15:21:43 +0200
Message-Id: <20210929132143.36822-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929132143.36822-1-rikard.falkeborn@gmail.com>
References: <20210929132143.36822-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of wdm_wwan_port_ops is to pass its address to
wwan_create_port() which takes a pointer to const wwan_port_ops as
argument. Make it const to allow the compiler to put it in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 03b25aaaa1dd..e5834f1228f9 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -911,7 +911,7 @@ static int wdm_wwan_port_tx(struct wwan_port *port, struct sk_buff *skb)
 	return rv;
 }
 
-static struct wwan_port_ops wdm_wwan_port_ops = {
+static const struct wwan_port_ops wdm_wwan_port_ops = {
 	.start = wdm_wwan_port_start,
 	.stop = wdm_wwan_port_stop,
 	.tx = wdm_wwan_port_tx,
-- 
2.33.0

