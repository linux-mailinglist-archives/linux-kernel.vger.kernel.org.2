Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39903EDA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhHPQAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbhHPQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:00:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D2EC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso2640950wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czsniBPSjwcUGxCWkGVlyBHAWB3MYgK1t+X524MoiAo=;
        b=CyEwiTS3Wc372QOZJfXNzQ0gxL3/bOanRaXo2+E8n5YD81UYgV/SQFdcp5zaER7QPz
         V7IaWdTD9I1pI+S1e51uTtlSJAGmrBv7vNhtoygHm7GPVJ67X38ZiWQK561+O2SogxkY
         41Zg+sB41fO1j8wYK7ADKxJL0yk0jHDZGM/ZjP+Na/gBj25Cprypu7bxSZkOdK8ULICb
         j6UPA+oVptcuNsDhHeB3CpQlUkw96v8B6AoMHEGFKC2LqI91Lb+8dnzUUGnYq7W2QeQ5
         CKn9wh64CPaS8lqd3ows3g180FnKF1GkPptfxQQkOuQbuiJgrT6EN682rEMRR/AgZmi+
         to9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czsniBPSjwcUGxCWkGVlyBHAWB3MYgK1t+X524MoiAo=;
        b=F9v4kM+73FTJ6k92ODRCFkaggoG4kZnYzdFTPtW0Q6WlDhnhXOCSD9IFwHeFCNX4cM
         RiBi0yGduBSTMujDtY9TssPgE9YrRQ8DRyAVL1FK7Ol/NMwV3xgxjH5iv8vvvQi6ft8D
         9YQ+KClpdg9W3gmZmSHrx7ERd6ytqjA0M5EZUXlvhRcittxP5wH8VsBNP6uk6qxo+l3d
         REE/lLBMqlRZTiu/vYJWbevN9BVGtfRsJvlJdIVAqL1aQP5ODmWZzDUWdvaFhPJ1MSi7
         YLZig6P6uYu/6RzbBZ/UA1EntWTbJs/D94c5iySwz0QXwI1j1OjjnoWmZRTA86yz8uX1
         pdBw==
X-Gm-Message-State: AOAM533qZV8CqKLvjUD+7Pqp/BdIqDTRM2pb5GIZo+a6W8K9OD481KGk
        PURl5I8fl+14XD3mtwPInBU=
X-Google-Smtp-Source: ABdhPJxNRCNPqPehTurkv/wvbUChYRSMHJ2m8ie29BNkluhdmR2cCFm3GnzwESmH9Gf/kpLbRR+rgQ==
X-Received: by 2002:a1c:a90d:: with SMTP id s13mr16074639wme.132.1629129567256;
        Mon, 16 Aug 2021 08:59:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id a77sm11589597wmd.31.2021.08.16.08.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 08:59:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/23] staging: r8188eu: simplify multiplication in core/rtw_ioctl_set.c
Date:   Mon, 16 Aug 2021 17:58:02 +0200
Message-Id: <20210816155818.24005-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816155818.24005-1-straube.linux@gmail.com>
References: <20210816155818.24005-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify multiplication in core/rtw_ioctl_set.c. to improve readability
and clear a checkpatch issue.

CHECK: spaces preferred around that '/' (ctx:VxV)

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index edcac238076a..bb6bc6508255 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -825,7 +825,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 			i++;
 		}
 
-		max_rate = max_rate*10/2;
+		max_rate *= 5;
 	}
 
 	return max_rate;
-- 
2.32.0

