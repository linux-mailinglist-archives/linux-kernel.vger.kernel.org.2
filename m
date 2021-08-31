Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC33FC7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhHaNMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhHaNMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:12:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ECEC061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:11:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i6so27688177wrv.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norberthealth-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tGsBv1pAuKTHv07Wj00TrdwJkxbHrYcPF1O+phMPjvQ=;
        b=ISRMIHCJo448TK3sYnTZC8NZneL8WWKQmmbfRil/r88gcP2FvGMwDJcHzNGU7h6pWp
         Uj1DedVk/iy/C0+x69z8cYGRGpFRcHLxzrwqcpSdA8QwB5V8FgUxLvfba+MZwB4iMmBI
         2AQz58GRAZKv5TeQ+UH+mxQnmXmlozsdWp/A/b7wLp8Eh5FVLfRphF1vf+eabskTzfBH
         FB2qBNC2qeMp6cwV8A21qCVZmkbAmBcYhBevk1KHB6RWAom/EWLrW+AaIVIVJQi7gPNr
         ElMBPZJiIOcqPvDmuuCyHy+y8Pp+pFZNzE4rbLvNr0zKYrmvtzcXTGHv4qwN/wn8TrVf
         nC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tGsBv1pAuKTHv07Wj00TrdwJkxbHrYcPF1O+phMPjvQ=;
        b=dtjLzyiC4WNPpGKmmX4wApG7/99k31Filb18YOWhudHwKQajuhTGs7OvG8KBDPvHvn
         KLUwvpDaaYWIvPJOD7VR2B+/GkuBE1pkT7npQ4Gngx7qnr/wXRyuT3A+H3V3Mp4O3Qf3
         Ra2aW+gvgomAH5xHBJdtQo32RnaVI8t2FCrUENu49Ulle5YR/n8NnwPG891+icGDa2fM
         o3ExAghNq0DmncdkPedLhPQnrtha8fwDI0h5IxxaKzhUO+ojHuksTGgVWW4SZrPFVpJ1
         ooCzfbQKHagrMWR79xx/ofYWhy9o8MPrDPinenMmtq5kJh15KT1wa57ahbMrz2G/uGce
         QO6A==
X-Gm-Message-State: AOAM530RmTuU33SEbKQFEQ3ZdurEZhrrZdrcG4ICOwx9c1duqHy6L41v
        Ets3qXa8x4HtCeKwPnVBTlJr8w==
X-Google-Smtp-Source: ABdhPJzXoivC1fHD6K9VYjFIPCkIgh3F+PvZ4MUGwzNrTLi0V4Up8N81Xnbry7iYFxDBEQalfJ5rbA==
X-Received: by 2002:a05:6000:23a:: with SMTP id l26mr30839399wrz.369.1630415494498;
        Tue, 31 Aug 2021 06:11:34 -0700 (PDT)
Received: from localhost.localdomain (81.227.26.93.rev.sfr.net. [93.26.227.81])
        by smtp.gmail.com with ESMTPSA id k4sm18459745wrm.74.2021.08.31.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 06:11:34 -0700 (PDT)
From:   Roger Knecht <roger@norberthealth.com>
To:     Jiri Kosina <jkosina@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jiri Kosina <trivial@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roger Knecht <roger@norberthealth.com>
Subject: [PATCH RESEND v3] Trivial comment fix for the CRC ITU-T polynom
Date:   Tue, 31 Aug 2021 15:07:02 +0200
Message-Id: <20210831130702.31526-1-roger@norberthealth.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a small typo in the CRC ITU-T polynom documentation.

The code comment says that the polynom is x^16 + x^12 + x^15 + 1, but the
correct polynom is x^16 + x^12 + x^5 + 1.

Quote from page 2 in the ITU-T V.41 specification:
  "2 Encoding and checking process

  The service bits and information bits, taken in conjunction, correspond
  to the coefficients of a message polynomial having terms from x^(n-1)
  (n = total number of bits in a block or sequence) down to x^16. This
  polynomial is divided, modulo 2, by the generating polynomial
  x^16 + x^12 + x^5 + 1. [...]"

Source: https://www.itu.int/rec/T-REC-V.41-198811-I/en

The hex polynom 0x1021 and CRC code implementation are correct.

Signed-off-by: Roger Knecht <roger@norberthealth.com>
---
Changes for the resend:
  - Moved "changes and thanks" out of the commit message.

Thanks,
Roger

 include/linux/crc-itu-t.h | 2 +-
 lib/crc-itu-t.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/crc-itu-t.h b/include/linux/crc-itu-t.h
index a4367051e192..2f991a427ade 100644
--- a/include/linux/crc-itu-t.h
+++ b/include/linux/crc-itu-t.h
@@ -4,7 +4,7 @@
  *
  * Implements the standard CRC ITU-T V.41:
  *   Width 16
- *   Poly  0x1021 (x^16 + x^12 + x^15 + 1)
+ *   Poly  0x1021 (x^16 + x^12 + x^5 + 1)
  *   Init  0
  */
 
diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
index 1974b355c148..56e6e0d63d1e 100644
--- a/lib/crc-itu-t.c
+++ b/lib/crc-itu-t.c
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <linux/crc-itu-t.h>
 
-/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^15 + 1) */
+/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^5 + 1) */
 const u16 crc_itu_t_table[256] = {
 	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
 	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
-- 
2.17.1

