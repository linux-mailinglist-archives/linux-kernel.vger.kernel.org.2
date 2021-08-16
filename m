Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681F83ED0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhHPJFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 05:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhHPJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 05:05:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C4EC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:05:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q6so10982923wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norberthealth-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mMaesSXI/1ebDXpZxtJ9KM9Ruw6o7aKYtfvKIOk0/pg=;
        b=XbxJRgeIK1EnHAxTA0KXtizH38cpXbRQZwPqr/qe4xGSzahCbKRoW1ev6TTS91EaGN
         32Bx7vxDQaFuwDG2sPHP/Te5Iy36Kju8obuCiOrrogPQ42JqhWf5tA0xumk9K4KvPnof
         hOjBP7iHJ+hYdvhVJvjebfKRpisLGSehXzxvK8uLcBW5kTvFFDl56gVSh91TU31Derro
         xA1kjRLhro84EKFTj7DcFDFlQgE5DB7XK0sh0cHym+XnFQYVRrClMyE7zY2bfKOPDZeY
         fRkzIIfJOXpkIwn5GekPua5kQIsuA1kqE80fBhmMb4UgONBDhsj90x8eeVyWHtkOmHwJ
         h6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mMaesSXI/1ebDXpZxtJ9KM9Ruw6o7aKYtfvKIOk0/pg=;
        b=EXbCrXsx7EnmlB2zp4Taj+dZVgWOiotfYpE0bqG0dVdamyft/eAegqjmVWBkYSvpwb
         8+yG08hgJCmcr9S0kKUmywxj8tSYxLtXA+Sb+c/VQU4TP9UcJJiCvH5fecNUp4gA5wzw
         pmXeanwqkRmx3H5ntSalwdgafD5ezjq6oM8d5+fi6EOH+y7JRIQaXPSUoUz8uVjAj/K/
         V1SBjMC6Gp92LOt6Yjc7tzE1mREv9dYXNFfuPDcoz0fDXvr0ef32GQARpGcxB3HGZibG
         3uDO9esaT5BCcZoap1+i2IkZNKtHD2ARh6Uj8ba1C8wd3IqBZKFeD7Y26cknZI54NHlt
         BSWg==
X-Gm-Message-State: AOAM531FANcd9+TtS23X9UG546eJXhF/PkZSPdraqBc6d6j6bwpBskmW
        0yE5B7iAb5KzUmHrPEsXxy1fAQ==
X-Google-Smtp-Source: ABdhPJwbZOXGLGuWCEeUa31iyyVOThWJ8ZKO/RjWuqmTI89nAoGHQrLzkB9L8b5Ws/U6urBbrXbXQw==
X-Received: by 2002:a5d:658e:: with SMTP id q14mr17226897wru.142.1629104699511;
        Mon, 16 Aug 2021 02:04:59 -0700 (PDT)
Received: from localhost.localdomain (81.227.26.93.rev.sfr.net. [93.26.227.81])
        by smtp.gmail.com with ESMTPSA id l12sm9381761wms.24.2021.08.16.02.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:04:59 -0700 (PDT)
From:   Roger Knecht <roger@norberthealth.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Roger Knecht <roger@norberthealth.com>
Subject: [PATCH] Trivial comment fix for the CRC ITU-T polynom
Date:   Mon, 16 Aug 2021 11:04:31 +0200
Message-Id: <20210816090431.6540-1-roger@norberthealth.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the CRC ITU-T V.41 spec the polynom is x^16 + x^12 + x^5 + 1.
Source: https://www.itu.int/rec/T-REC-V.41-198811-I/en

Signed-off-by: Roger Knecht <roger@norberthealth.com>
---
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

