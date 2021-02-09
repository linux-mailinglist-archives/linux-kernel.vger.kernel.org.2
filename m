Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8033231512E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhBIODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhBIOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:02:51 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B4C06178A;
        Tue,  9 Feb 2021 06:02:10 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id w20so12983295qta.0;
        Tue, 09 Feb 2021 06:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NITe3BJqzCY1ySV0FFf0h+BCloEa4Ar/izGPp65zl4U=;
        b=R4OMrGVG2Lkzfh/SFAyEo5413EfjviAKw6mXdr1Ldf0ggNkspVPKdz7DxFhPTGNWqM
         8g4q5mEc/hmclGeN2GXmyAFN7XV6lxrvKCkJ2cvJECfbX+uCQy7hqdCavJpBgDAfPOEw
         RSlx1Jxlv4tWub9mBSqifVTV1k4pXkTt2XpQbx5TFMBzbQxg0xFV7hgZffeC75wJdRc7
         Miu0mrTSj+PzoqO/6sjBcdMTQGvX1Y72U3bfcbelZbJxaWgR+P7ZtuwEWdqLa6Kegec4
         CnWdh8RpCRM9FA2i93SJK6D0Duu3xBw3lrb2ZihCSojABmZU372H90ejerlF/JBB+xcD
         Vb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NITe3BJqzCY1ySV0FFf0h+BCloEa4Ar/izGPp65zl4U=;
        b=GgGTj5wRwKVSo2XA4wb1c5yNIskmvPdyNktaCrFvVqNJC8wfTBpWpTDjYke/c4c8GP
         lr44NKG6HkbRMmfKZwRKqHE0VKi+uCk1xF3mQfdXPVRkV2GNDLVwnkBJ8RuoeqE/UW5m
         aV0HtZMq45ho4A83EvXDBZ/dPHX/AtvHyBMqnnuNPywY4K5HEGyIlc0PccUa6/bP3XI+
         0kyvXt5DlHq2dzc+hBKIu4XLUyTkqDRV0DWM4NpVjhYSiBKDOl+cJg/e4hOlv8pr6tmU
         dAeLXeoRFwCDfwEt1qy4bo2dnN8jG6GfDcO5n8JUW8O5tMik3swt0p3yKTVruT4SGBKN
         18wg==
X-Gm-Message-State: AOAM531xRCOEPe/GJeV0dwGWpejEDVzEd185/VpeodEN0n+t69e0Pnd2
        twa6bLInOqtw4AEyK/jm8HT0/qsBLsGE+Umu
X-Google-Smtp-Source: ABdhPJwUdq+7qyM1Ktz7HfILFxzm/x3Lpy8UEc3ELERfBHuOYKn3Gmaq/LDjAEJiqFdia4G6YI0ghQ==
X-Received: by 2002:ac8:745a:: with SMTP id h26mr9101456qtr.278.1612879329448;
        Tue, 09 Feb 2021 06:02:09 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.186])
        by smtp.gmail.com with ESMTPSA id x49sm18147839qth.95.2021.02.09.06.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:02:08 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: maintainer: Fix the spelling mistaeks to mistakes in the file pull-requests.rst
Date:   Tue,  9 Feb 2021 19:31:55 +0530
Message-Id: <20210209140155.3890715-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/mistaeks/mistakes/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/maintainer/pull-requests.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/maintainer/pull-requests.rst b/Documentation/maintainer/pull-requests.rst
index 1a2f99b67d25..35759d16a5cc 100644
--- a/Documentation/maintainer/pull-requests.rst
+++ b/Documentation/maintainer/pull-requests.rst
@@ -84,7 +84,7 @@ As said by Linus::
 	time (describing the conflicts and your personal issues for sending
 	it right now), but may not make sense in the context of a merge
 	commit message, so I will try to make it all make sense. I will
-	also fix any speeling mistaeks and bad grammar I notice,
+	also fix any speeling mistakes and bad grammar I notice,
 	particularly for non-native speakers (but also for native ones
 	;^). But I may miss some, or even add some.

--
2.30.0

