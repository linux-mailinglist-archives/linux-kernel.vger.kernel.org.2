Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6270C3F5690
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 05:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhHXDQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 23:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhHXDQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 23:16:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1271AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 20:15:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v10so17846748wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 20:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wuM0gA0s+nDzBm/WicqvsRzRgPoz6c0JvPzwtgzpwzs=;
        b=dhiCTlFpvC0RxZGfroAQApGRaLM1BStb7fHgbT4mNbVa5kccQOdrKTKelWfZujPzq/
         rn72MBN3gpAs2jDUumOUQ2wMri/JonGYFn7tsrN8WANCI1QkyY+fXhZWuEOcLiCCYfCw
         vVszDFW9LU9A5XWIHV3zBlqtKARsLwnKLJrEruvFUOIC0Caxif4Eg4UfSAcFt4p30BlV
         DzjbZlBspzqTMgzcQnvTwINhKEsASGcAKJEmtGt1oGYcK5fimHm613iry/AL5Jev76g8
         yBAvXBpThe7HV7BABv2AYRbU+mEb6cTSeW4Mww14dasK8m5+WNlEV5t86XFgMwAxoohK
         KlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wuM0gA0s+nDzBm/WicqvsRzRgPoz6c0JvPzwtgzpwzs=;
        b=Crm1umHZszXUOg5ZVEcIFMDkDpGHQzExB+1CeEvgBdDYugC5yRsWhFjd3+TxnGDEBw
         ezGWgHPgneOc5XRV1Tt7Ti2R6/wol72r0uAvUvInTu1NXpURpsErqx3ah4aU1pDKpzzu
         Z0lTaYLv2ZTYPIAwZj/9flFya803SqYvLKEgHKxGWOAsX5Wu2Fkj1YZ1NUPJyQd1+Web
         h379w8IR6JaI+CHLZq98k+5wdr+UeA8gnC74L85jhRSA++dppjZFKQ3ISuUxLTrNIVvY
         ej8hoVnFtNlw6cd/su9w+vh4oTWaFQymSaAqwklQV8Rso3ULiB4thp+rBzhTn4Xp7My5
         B67A==
X-Gm-Message-State: AOAM5314UqWKwBwBAOSDoiw5IHI7NdOmlTD6Q4tQLAI5QBOhuyAv3UL4
        yoeWPqBD2D8qG3cby3JcgYs0B4t/eL0=
X-Google-Smtp-Source: ABdhPJxfNhZibxUS07CRUADWjzUZrjTm3QOsCOpGxSPkXArFWOgtRXilPMnaBkFf+i1ps088UkV5wg==
X-Received: by 2002:a5d:6052:: with SMTP id j18mr17167292wrt.348.1629774955396;
        Mon, 23 Aug 2021 20:15:55 -0700 (PDT)
Received: from peggy-InsydeH2O-EFI-BIOS ([154.72.153.223])
        by smtp.gmail.com with ESMTPSA id h12sm938117wmm.29.2021.08.23.20.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 20:15:54 -0700 (PDT)
Date:   Tue, 24 Aug 2021 04:15:51 +0100
From:   Tawah Peggy <tawahpeggy98@gmail.com>
To:     Kroah-Hartman <greg@kroah.com>
Cc:     outreachy-kernel@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] [Outreachy Kernel] Staging: wlan-ng: cfg80211: Fix Lines
 should not end with a '('
Message-ID: <20210824031551.GA80985@peggy-InsydeH2O-EFI-BIOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

CHECK: Lines should not end with a '(' .

Signed-off-by: Tawah Peggy <tawahpeggy98@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 7951bd63816f..8d044e3fc2e8 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -328,8 +328,8 @@ static int prism2_scan(struct wiphy *wiphy,
 		(i < request->n_channels) && i < ARRAY_SIZE(prism2_channels);
 		i++)
 		msg1.channellist.data.data[i] =
-			ieee80211_frequency_to_channel(
-				request->channels[i]->center_freq);
+			ieee80211_frequency_to_channel
+				(request->channels[i]->center_freq);
 	msg1.channellist.data.len = request->n_channels;
 
 	msg1.maxchanneltime.data = 250;
-- 
2.25.1

