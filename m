Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055374384A5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJWSHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJWSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 14:07:36 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F7FC061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 11:05:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq11so2364731lfb.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vppgzpnDmxHajRXRNTQTVMaBkZ0Oav0mmSG1SIlu/rs=;
        b=LFFV1xXfOncBfDf93gnnvtg6QVMmja8w5m6zOXkecuS5Ip7OPwzvJTI5sjWvnYa1KI
         uWo+EZjhQrF8Vi4uNlr0/pmGBgom0RTV/2DuYSQ7uch2wpbuVEJw8hsQrwx50DVN4hPB
         woUcCRS1FM7UAO97fc8aL46NmE7uR0sFzBONLVbALlZeLnwWjHBVIotahmfZsbIu9sST
         C9kUn5hKl8yIHaklHF4SOYcNLsHTU0nijDkB4kC3tegiQCTTYCG0pYO1xH3l+6TOfqZx
         oZnTaZi8Drjnk52mUDjZvUYUzetOp5eGv8pKHQ0e5+ogaHdgwLAC/4xnYTNmfJbuqUs1
         hRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vppgzpnDmxHajRXRNTQTVMaBkZ0Oav0mmSG1SIlu/rs=;
        b=T8XjVNSrgN19M+1RZnbEGZvDxWiFvrtKu+wxmk5VqsWB/DXNU+Upvqf39G7stZe1MA
         NcoAS1q3H3FgDG4Ml1RMo+2PLQH4BpmanJzrgfsxPBeeZkTUtOnRX5o6LE52B//OsCyC
         8JAGijOeeM2fk0EJ2RDT7mltJxp5m1jfOCSuOXUG0zzxOffefiKKBvEPPuNI1VbyJBbf
         FMPmkfny1Uo44I3GGy8QmSxyAGALrjnpHnwzaxTPmUv6ICBySaJGdMueCDlO0SfLFPzj
         DWJfuqPOuG7YmQeE4OAwayS4V4wyKjVVPXGtIi0HLveApWpVz1NtNzRmEV4pllndOLbU
         Cfng==
X-Gm-Message-State: AOAM533k8Y/fm3JtZ6xYgvryCTclYiCi/0SVY+OV/uu3bTAJgSYdDdKj
        nMu9b6lW6MCw5dHWJM6lMbc=
X-Google-Smtp-Source: ABdhPJybZgmpDtZxF+2+LrxJvNK0AmEQVqJ8XbV94GdxyWJtgX8Lva1JRmmXhaCeGR3fU7hWf1fvCw==
X-Received: by 2002:a05:6512:3f87:: with SMTP id x7mr6832999lfa.5.1635012314785;
        Sat, 23 Oct 2021 11:05:14 -0700 (PDT)
Received: from localhost.localdomain ([46.230.137.73])
        by smtp.googlemail.com with ESMTPSA id m7sm1100095lfo.181.2021.10.23.11.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 11:05:14 -0700 (PDT)
From:   Jim Christian Haukvik <jchaukvik@gmail.com>
To:     johan@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jim Christian Haukvik <jchaukvik@gmail.com>
Subject: [PATCH] kernel/params.c: Refactor dash2underscore
Date:   Sat, 23 Oct 2021 20:04:51 +0200
Message-Id: <20211023180451.59033-1-jchaukvik@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors the dash2underscore function
to use the ternary operator.

Signed-off-by: Jim Christian Haukvik <jchaukvik@gmail.com>
---
 kernel/params.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index 8299bd764e42..865a76fec79a 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -76,9 +76,7 @@ static void maybe_kfree_parameter(void *param)
 
 static char dash2underscore(char c)
 {
-	if (c == '-')
-		return '_';
-	return c;
+	return (c == '-') ? '_' : c;
 }
 
 bool parameqn(const char *a, const char *b, size_t n)
-- 
2.33.1

