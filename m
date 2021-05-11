Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9BF37AE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhEKSKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhEKSJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:09:21 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB333C061343
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:14 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j11so15252516qtn.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6EnogKluwcsh/pR3Ugtb3jxsHv9fsBdtTnJcs6QGPPM=;
        b=pVyV8UMP2Zs3bVEPeaK/7xHyx5omdnupOpIzbyIBS6Lsg+Qed9iMuBEKWfVIhkog0l
         TKQIqo1dmbwKuXWyquUX53i3fNoGvKZk/ARVO8Kl5PZJyO3eDl6AUw01j/cFKWvUO5P/
         cKbo1tnyubNp6VXR4r2i6aXyjIpg5tefG5rIQP7KGhlXvtQGI5y2Sy6qEwDJxiEFJTwO
         7YZ9bKAPSXWvjy3rgjqQSQAzroHtf10jyJqWKX1IcyVvaDGcfLGgaMtTphCE5KH0zPI9
         Enz7ShPwPsY0ki/+EdXn5xd/VbcQWYdN80t7nGtMrkjzd6GUSI+AGOV3z/HOgMsaqJqc
         PwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6EnogKluwcsh/pR3Ugtb3jxsHv9fsBdtTnJcs6QGPPM=;
        b=pd4CUZtic1bJtpIYjtCtgDnHKbGL2sRoGRhGOP9+xFgLr80VBlnJ9fArIUMd3P2swR
         O8D0si+G6VriZwDosNfRnglJ6gX8PNBL6LtIwe7NteR5Z75MZHsTKSG3riikKpjnwja4
         q4WuoFfi7NJAT3p7EJFrZlnn/gdcvnochLBAUsz8fe772qRTQ55t2CSxBPr6zPVpo5xA
         LhulzClPbDwa7OeaE3NH+hYFReF9lB6RuKhh7QmT4svKRO4BgaRa6I6QQ2pNAgv4pXir
         2upbEGQpKrbjYS4eSHKMtOIM5dzUZND1nSTbyEOtvN2kRshKfDbZRAD21qIe9gMWCGra
         1NsA==
X-Gm-Message-State: AOAM530gHHf00dLtSdjXFlLUGx15q7ez89PThAJNnAGsDpA/DlapZjho
        03aTKuEA3QsmgZEC6rbBoFOHXQ==
X-Google-Smtp-Source: ABdhPJzRLUC7xHdun6LiYTns4U8cKfjV4l3WBR2LIcG6eZSKDlCN3GYWA2ELbZ9EyaHWNeAISgZ/TA==
X-Received: by 2002:ac8:7f53:: with SMTP id g19mr29280882qtk.249.1620756494059;
        Tue, 11 May 2021 11:08:14 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g5sm17104476qtm.2.2021.05.11.11.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:08:13 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org (open list:QUALCOMM CAMERA SUBSYSTEM DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/17] media: camss: csid-170: remove stray comment
Date:   Tue, 11 May 2021 14:07:13 -0400
Message-Id: <20210511180728.23781-7-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210511180728.23781-1-jonathan@marek.ca>
References: <20210511180728.23781-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a leftover from my original patches, it doesn't serve any purpose.
(it was a reminder to figure out how downstream sets a particular field in
the register).

Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/media/platform/qcom/camss/camss-csid-170.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csid-170.c b/drivers/media/platform/qcom/camss/camss-csid-170.c
index 2bc695819919..3958bacd7b97 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-170.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-170.c
@@ -441,7 +441,7 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
 
 	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
 	val |= 1 << CSI2_RX_CFG1_MISR_EN;
-	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1); // csi2_vc_mode_shift_val ?
+	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
 
 	val = 1 << RDI_CTRL_HALT_CMD;
 	writel_relaxed(val, csid->base + CSID_RDI_CTRL(0));
-- 
2.26.1

