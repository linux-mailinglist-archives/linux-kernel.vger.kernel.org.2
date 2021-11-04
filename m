Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC97444EAE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhKDGTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhKDGS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:18:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AC5C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:16:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id p8so3224066pgh.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbXeBeFVIbJL0zVsHbJWS69VKZbvaHQJ1NJ1nNYzH5o=;
        b=K7cY9L7BZ4EijItlsj5l8Wfek38LgcdaLzP68W4+UDaN1Vaq9b+auzJGcap4hOKuEi
         Js3kd/FczL7O0+x+VP+H1BKlQc5P25GB9Cm+TRR3qoXANn0M63eH8hoHHN1Bk35d4yCS
         Jq2SG6NdnKxEOLf/T40PgdXmJBUdVIAHNujH4WG3YnEY1wZlCe4gEG6vE/vupuJys4//
         N2ZMleW6W9Pr1hSHjKjg6V4Ru0SZm6QHdSUmXc/a5g3Dgcn72sSYSjlBIc3D+ae3JSl6
         EDPRhGjvmSta6afufqTZ+XiySZH/1Hej9yV7JTRuxAehTraN8QNncxD/Uct08DWO/Ohh
         LXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbXeBeFVIbJL0zVsHbJWS69VKZbvaHQJ1NJ1nNYzH5o=;
        b=aWDQXe9ZJa/f8TowAArQpPYF2EpnFVKRMlj9CEwefQMWrWAWZv3VYrORNEe0WbiD45
         8s/6rLA1ByZhe0KqzMa7l7WoVsDjPsbDhCgREeWYxpq6/I9hec94zSN3uDgkKQkdzSha
         62yCv9dvgWvGSpSDKKqxlLRHD7iX4xyP/BL6lSp43yMpUpdTXQmlk0+Y2BD5ajbzq7d3
         iqBEtnsX6RNSoashYcOE8Sotm7A9Ol/AiTIw/3NwsAdRT9a//QMF7v/ktJLMLgwds+JD
         wRrpvBv8PoJ7491gnqxldur3dewoDNAuXSmBEpZQ0Tn/945ABVj7ajdHc0Kp0tMr0nSW
         QM/w==
X-Gm-Message-State: AOAM530xM1E9H20iUdaHGo4mnKpyxP1+INMGImrsr0ADr0bYEbMEBxQK
        hLNQeV+qDf+kKWcDYOUSBuk=
X-Google-Smtp-Source: ABdhPJzhSB0snaFT7es3crYVFnnajooOY3O+Pcbo0ctPmgnoA16RmNZ+1vxXkIEoNPwFaNclz8/ceQ==
X-Received: by 2002:a62:30c7:0:b0:44c:1ec3:bc31 with SMTP id w190-20020a6230c7000000b0044c1ec3bc31mr50673921pfw.21.1636006581002;
        Wed, 03 Nov 2021 23:16:21 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id k4sm3235258pjl.20.2021.11.03.23.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 23:16:20 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     jdike@addtoit.com
Cc:     davidcomponentone@gmail.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes.berg@intel.com,
        yang.guang5@zte.com.cn, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] um: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 14:16:08 +0800
Message-Id: <20211104061609.1496503-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/um/os-Linux/sigio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9e71794839e8..1eb15f3cfdc8 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -50,7 +50,7 @@ static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
-	struct pollfds *fds, tmp;
+	struct pollfds *fds;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
@@ -77,9 +77,7 @@ static int write_sigio_thread(void *unused)
 					       "write_sigio_thread : "
 					       "read on socket failed, "
 					       "err = %d\n", errno);
-				tmp = current_poll;
-				current_poll = next_poll;
-				next_poll = tmp;
+				swap(current_poll, next_poll);
 				respond_fd = sigio_private[1];
 			}
 			else {
-- 
2.30.2

