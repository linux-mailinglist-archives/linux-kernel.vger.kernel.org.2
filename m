Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED133CBD4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 22:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhGPUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbhGPUDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 16:03:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20430C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 13:00:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id oz7so13095703ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdw0IQFcrZt6p5a2Ip3t1Stcax4FglAn7CAcnCq9/SM=;
        b=dh6cUHAnOvTvoIvocM9kSSSzAyojdxBbrfoWEW3dOuT5r8XB6/86iQo+3RCoDsYTPy
         I/Y7BFgrEnEIz5nruIlu7cg7itgBAodiL66lQFqVhS+g+1oZxhgLu6z1PqL2dHCsXMLz
         nixLpfPwT0m5S9alqIl68ZVJAcivcE2mN6yqguSBAU8/9efhLPUEBDm7A4DGWEThu3V+
         ZxdXYMA4IrErXxZXuC+HYLlwmQFWsyyTxkvPHPcg8zI1R30jPg3HF/V+koL7ESQfgsdC
         M2T4xMAn0hhKKt84vCSVOpQqPtumGaW83aQ/mAzv57Ey5irZxD1lpIsMdT+D027uIN1S
         /eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdw0IQFcrZt6p5a2Ip3t1Stcax4FglAn7CAcnCq9/SM=;
        b=GA18RnBUjPAsjaK+X+wT+Mja2TtGALk5NqjOiOK/91feBo/OZQ28Aq7kMP/V+kIAqh
         1eeclNR/yROY2LkVwbQS2PZqVXvFICeoxu7LIEHDa1y1c/OF2PLDA5tCyNWzARfAhavu
         xPIMZmApR/8Q1nuHfJMS6J/i2skY1sADKUdGYVrefU+vL24Acmi2XST532G/1oijioi0
         LJKx8qomZuoCWYn+pQtFwTl2ifOBXldzTedyQRH1YTyJHK6gaE7oq3QgNDKGtStQ2RTl
         pXanjwmC7Q/BIX8aMHcqwn8fRUeTUActAGf/cYE4ImhxR/lJQkccSE7kiZIF/3yKB70E
         sxJg==
X-Gm-Message-State: AOAM530AyoBxBeblrZcB9wMYpRDeE/b5yAgicRmuSgN3jLJ/PMWPKr9V
        AcSu6Zr0di5qGq+x3fwpaz8JlA==
X-Google-Smtp-Source: ABdhPJy4BwHJ6z5T0auOOYDx4/jEfFccIT9YPIMcZinqkT5hbGkCQFtenoLlumCpqJmyBznubvNkag==
X-Received: by 2002:a17:906:6dc5:: with SMTP id j5mr13500151ejt.364.1626465655654;
        Fri, 16 Jul 2021 13:00:55 -0700 (PDT)
Received: from localhost ([2a00:e67:1fd:a:4a4c:28ed:97af:54ad])
        by smtp.gmail.com with ESMTPSA id l16sm1717539eje.67.2021.07.16.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:00:55 -0700 (PDT)
From:   andreas@rammhold.de
To:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Rammhold <andreas@rammhold.de>
Subject: [PATCH] tools: cpupower: fix typo in cpupower-idle-set(1) manpage
Date:   Fri, 16 Jul 2021 22:00:34 +0200
Message-Id: <20210716200034.2158602-1-andreas@rammhold.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Rammhold <andreas@rammhold.de>

The tools name was wrong in the SYNTAX section of the manpage it should
read "idle-set" instead of "idle-info".

Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
---
 tools/power/cpupower/man/cpupower-idle-set.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-idle-set.1 b/tools/power/cpupower/man/cpupower-idle-set.1
index 21916cff7516..8cef3c71e19e 100644
--- a/tools/power/cpupower/man/cpupower-idle-set.1
+++ b/tools/power/cpupower/man/cpupower-idle-set.1
@@ -4,7 +4,7 @@
 cpupower\-idle\-set \- Utility to set cpu idle state specific kernel options
 .SH "SYNTAX"
 .LP
-cpupower [ \-c cpulist ] idle\-info [\fIoptions\fP]
+cpupower [ \-c cpulist ] idle\-set [\fIoptions\fP]
 .SH "DESCRIPTION"
 .LP
 The cpupower idle\-set subcommand allows to set cpu idle, also called cpu
-- 
2.32.0

