Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4BD35513A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245210AbhDFKvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbhDFKvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:51:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82B7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 03:51:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o6so4192337wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9jWO01eQCvaSALTaYkYaRpgTZuO0r7x7rAnN4myhxg=;
        b=B3Ep+wExrgNMtKa8EakKLL7kSl/7DSbnkWpxxMYEK/oxjgbZMOvAqWvKpIsing3zxu
         s/npRS1/OSQ7QHLFmo9WBHjnBYyR/bDsGAhqJl7QNr/Sud+rYToJarxr5T8+Hc4ryr/0
         9AZsOP/HlHrK2zB4vfvN7ZYFmAWuYqdBNrlh6aXuefzF/G1/qxOorPfPT0Oq2TDETgKZ
         D5iWK4t92EXRlKNVBANM6GuCqsNBiHgKYIjxXaWt72JFg7Zn/OMDc8608cOa2JzREgMb
         k8+6Aa09jjGL/mcik6of57bEFbKnArDko3tnTriMdAtAsHG9HFcSqdrOh7j2md/tvXQe
         GoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a9jWO01eQCvaSALTaYkYaRpgTZuO0r7x7rAnN4myhxg=;
        b=ItoQbPdbOsSObcIsiPsShEVA/Jdy/jIKQT+xm1g+g0h6muoo2haqyIAEt2qQrDshXA
         yr3zD9pGZAcHDBafr5uFpYkcN1WwyoFcEwxoh0xFDx829GDvuskYd7M3Qsn7YI7q2D1n
         4OL0JD5mfNgcOYEippG5MojSLMwg+xcOpzE1u1uHpK4nsg/zjeX2FpMCMa+UPMiQHAKf
         sJBE3txrwmeGigb2b9MQJQWz85MEycTG3NaRauRHbTGmHTev8IiiF5+J8zuXV793isOW
         EsC7Ie+o6H1vpOXHh5mrQhvr5I4j5synuc3tk3ETwjwjGtVagtZXxdyNHOy+bq9XuoWx
         sEEQ==
X-Gm-Message-State: AOAM532AMJ6u+mPJeWPbL99wQ5qcBDwe8O29yc+Nr37csc+CjZ8IOmes
        7tKaD+zx4+p5R/4LJ7o+av57rnXirjRg6Q==
X-Google-Smtp-Source: ABdhPJxQOjyaK8Qd7dD5gHn2A2Ngxdpd7HfM815L2u2CG0SAVMPtVYJI53J97KTVwnSCHf9CetMUcQ==
X-Received: by 2002:a1c:4686:: with SMTP id t128mr3467097wma.156.1617706286497;
        Tue, 06 Apr 2021 03:51:26 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:9a5b:98e6:2174:bf29])
        by smtp.gmail.com with ESMTPSA id c18sm5044229wrp.33.2021.04.06.03.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:51:26 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com,
        driverdev-devel@linuxdriverproject.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] drivers: staging: rtl8712: align arguments with open parenthesis
Date:   Tue,  6 Apr 2021 11:51:24 +0100
Message-Id: <20210406105124.78498-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up checks of "Alignment should match open parenthesis"
in file mlme_osdep.h

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8712/mlme_osdep.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/mlme_osdep.h b/drivers/staging/rtl8712/mlme_osdep.h
index 9eaf94f072ff..a02c782588dd 100644
--- a/drivers/staging/rtl8712/mlme_osdep.h
+++ b/drivers/staging/rtl8712/mlme_osdep.h
@@ -22,8 +22,8 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter);
 void r8712_os_indicate_connect(struct _adapter *adapter);
 void r8712_report_sec_ie(struct _adapter *adapter, u8 authmode, u8 *sec_ie);
 int r8712_recv_indicatepkts_in_order(struct _adapter *adapter,
-				struct recv_reorder_ctrl *precvreorder_ctrl,
-				int bforced);
+				     struct recv_reorder_ctrl *precvreorder_ctrl,
+				     int bforced);
 void r8712_indicate_wx_assoc_event(struct _adapter *padapter);
 void r8712_indicate_wx_disassoc_event(struct _adapter *padapter);
 
-- 
2.25.1

