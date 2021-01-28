Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2909D30784B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhA1Ojb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 09:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhA1Oix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 09:38:53 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AE1C061756
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:38:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 31so3422532plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 06:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T5UYTaCWBB2+LL3/tlIpAWg8VNUjtbCiU5GIunU3FQA=;
        b=lemjJsVNz4QAZ71wmvSd0jyU2J+KV3q5/B81uKegT1yGLXYN8f4OL+FliTvFamYXd8
         bI0dymcugaSilUiCDNWyEPL8BgEgXLRNKWfvqt3ztrrWmJPhc7X9kiqLRw10kisDrikn
         iGurBG42JLZFDuFF0BOs9Un8AQAXcp3u5e9MLB6xiiLWQ3UxTH+uEgTq+FtRtk9Nzl8w
         1d5VZ35CapxRz5vEdYcYp1++YbqMuL10b9aDdjyrGM+URjZexNgVKYilXCfp3GMjD9Zd
         gsCQTlxsJ/+iqNqIsO2AyU1FpqhG8VVqhaFvI3mW72qCaI/+V65sx2xja9JHxFO4tSI2
         i+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T5UYTaCWBB2+LL3/tlIpAWg8VNUjtbCiU5GIunU3FQA=;
        b=ECEJeuM0spUvBTUR/Fj2tJjmai2gXf+RGrE6LJ/te7Ik1h+y/EA7bn9fYoHcz0j4Kn
         aPaUtDMcHP6qoXZe5TwxZDRDItRPfnpRUE2CFRtLsEQuQBDzOXZ/esVd424TogGkvoQd
         RpGydFnQFRO/EYII7R7aFhUS+xS1qPoxuRurntskz2Yb6tkfpCjXnhj8EFU2ss9kR+4I
         GqVwTkaFWFqqrYwgsoxF09iTcz3ImthqrcmG4OD3Lk1VzwFDXQfgB/wouatacVfPsLxJ
         Ue0hGqKaNBmJRitltR2VeL50lV9QRD/KHePNSn4PSkHcqTvDiCTZx5TSQvu7NmGKVliS
         qz7g==
X-Gm-Message-State: AOAM533saRkESu0PljQuaGDJKqpI73V7FvKj76ziXY7EOs3SecahV+ov
        LmFfA2xkIP0KR4fcstTo1QU=
X-Google-Smtp-Source: ABdhPJykgH4q/QELQvYtHb6mhN9lqck+TapgGDJ4p0HAktUkCukRaxf4o4j0g2xa47nLvcnTqcPdkw==
X-Received: by 2002:a17:90a:db4c:: with SMTP id u12mr11196677pjx.14.1611844692826;
        Thu, 28 Jan 2021 06:38:12 -0800 (PST)
Received: from localhost.localdomain ([2405:201:9004:686d:e9f6:a78b:e60e:9585])
        by smtp.gmail.com with ESMTPSA id w14sm5358621pjl.38.2021.01.28.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 06:38:12 -0800 (PST)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH v2 3/3] docs: add documentation for checkpatch
Date:   Thu, 28 Jan 2021 20:08:02 +0530
Message-Id: <20210128143802.15888-4-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128143802.15888-1-dwaipayanray1@gmail.com>
References: <20210128143802.15888-1-dwaipayanray1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link the checkpatch documentation to the dev-tools index
for sphinx.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 Documentation/dev-tools/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 1b1cf4f5c9d9..43d28998118b 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -14,6 +14,7 @@ whole; patches welcome!
 .. toctree::
    :maxdepth: 2
 
+   checkpatch
    coccinelle
    sparse
    kcov
-- 
2.30.0

