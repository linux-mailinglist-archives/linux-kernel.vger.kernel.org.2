Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF834411DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 02:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhKABm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 21:42:57 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:34676 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhKABm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 21:42:56 -0400
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
        by gw2.atmark-techno.com (Postfix) with ESMTP id 5631C20D0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 10:34:35 +0900 (JST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id A859420D0C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 10:34:33 +0900 (JST)
Received: by mail-pg1-f199.google.com with SMTP id x14-20020a63cc0e000000b002a5bc462947so7594992pgf.20
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 18:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=60F+RMsAw9COGf+/l5AyJtjgtbtNUZqZuiPyUl8gYl8=;
        b=HH9AwX7OVw3KqdfE8yIxSNbUHG03cFlF4Nn4rxVhVbahPSou7wVuftZh/GugyWXhC9
         3WGm12cxPp2QL8G4Ub+crmw3PAMXp9AShfhwcb6ARZpIDv7NPTRa7Yqb9kqiDz80cGDI
         xY3DvW2da33KmxyqEt0/acHSvQ5auYIDwHt5AXdJbQK3BQjWgq05iRFa3r05o/aPdufX
         WhRu0McF2boEe+fnsot9t6xOlwsfS6I3fDQFwSHlVfIIzpRmV7H2M7YggoFNczfqMrHl
         GKG4FpkVRol7jhcDJPRE/lHOrKn7CEbeLwR35Pd2Wi3GE1033Im1sEV/1BoWGM089x8C
         ORdw==
X-Gm-Message-State: AOAM53193/xKDQHYpcFq9ymjWFi5vBxi/YEbk0kdY8tCNaxiJXoQVD1M
        +XmjxdWO2ZZHdfYtEkSX70vJvSMl8n/WwICprwxqy2laF6Ivx1URXaKc/vbfqthR12ltBtQz9wr
        GDt8sUBJCC29gE/N2FKKFKvKtKQ==
X-Received: by 2002:a63:af44:: with SMTP id s4mr19659756pgo.219.1635730472757;
        Sun, 31 Oct 2021 18:34:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyE5voRFvM8wBnDZDL1+6yQOn2/MgNjPMCFqhzxw/t3k39ybQZGDGSD/jk7EGBQnBrdvwLMA==
X-Received: by 2002:a63:af44:: with SMTP id s4mr19659748pgo.219.1635730472578;
        Sun, 31 Oct 2021 18:34:32 -0700 (PDT)
Received: from pc-0115 (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id t4sm13461411pfj.166.2021.10.31.18.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Oct 2021 18:34:32 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1mhMDW-001Mmc-Pl; Mon, 01 Nov 2021 10:34:30 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>, Rob Herring <robh+dt@kernel.org>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 1/2] rtc-rv8803: fix writing back ctrl in flag register
Date:   Mon,  1 Nov 2021 10:33:59 +0900
Message-Id: <20211101013400.325855-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctrl is set from read_regs(..FLAG, 2, ctrl), so ctrl[0] is FLAG
and ctrl[1] is the CTRL register.
Use ctrl[0] to write back to the FLAG register as appropriate.

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---

This probably works in practice because the two registers are pretty close,
but might as well fix it and use the correct register.

 drivers/rtc/rtc-rv8803.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 72adef5a5ebe..0d5ed38bf60c 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -340,8 +340,8 @@ static int rv8803_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		}
 	}
 
-	ctrl[1] &= ~RV8803_FLAG_AF;
-	err = rv8803_write_reg(rv8803->client, RV8803_FLAG, ctrl[1]);
+	ctrl[0] &= ~RV8803_FLAG_AF;
+	err = rv8803_write_reg(rv8803->client, RV8803_FLAG, ctrl[0]);
 	mutex_unlock(&rv8803->flags_lock);
 	if (err)
 		return err;
-- 
2.30.2

