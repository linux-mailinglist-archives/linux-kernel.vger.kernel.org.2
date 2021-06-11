Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F1C3A3D29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhFKHe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFKHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:34:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13ECC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:32:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g24so5205972pji.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPCqp2eGjYWyxk+FWTzcqZLzws1GFwCcPnBYqRgaGjY=;
        b=WI0HmFD9udfNt6puGF2sPP3vr5UJEht56zRSnQcExkBlGzwBAezgwnnWotmwlm6f08
         p6rmo5obbgiylTjTBW+WtQPzAYv0s14AHtjUYE51ouc3GAIRcJYWcT29rrhmJesZJ3g5
         gXohqG1pQ/5LXp5Z8CHNT+x8EGtA/aNTwq24HUEv7iGNr/dlbgu+3TdneVw74uJyH7VW
         WxQzdMRt8Va7YoA7eoCIvns+w1Nrs7CnYkKUFkd0pOSBlGaF19IMb45emSU/1y6XCoHa
         c3Z8ZmdkQWFO4nwYfwNKyJ7RppKFA+9W+hZXgphIthGzj4uhFv19kvOzjTT8X3mwVYMD
         kv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BPCqp2eGjYWyxk+FWTzcqZLzws1GFwCcPnBYqRgaGjY=;
        b=JvCvVN9bFUgX4E5CNKNj6qwxol2Bpb+WIOuqdhSoW5hNbNCqvXSkYm2K1G8q2ZbbLL
         1ZPlYvqVl08XsSIa2umwOYjU2cW5D1OgOHlb6SLg3iINT62MbVf/+/pHp7zW9rYvG2Qb
         TZSFVWGCKB5SYVD4+9Lo9BDf0FJcYCkfZcTFj9IZewfREsRRkiUJxx4maVF/s+3AfNPD
         yDq9CwBzwqrTeP2iWLvyxFc2UwiETiY7iRcayKhocwnbyTXK/0qcm4RUfhiOU4N6GXiU
         zyUFZkr58uZGD3X3FsXmZQCXXThCKWFGk8wKjPDwGKZ8vCaH97aboW3gdJL63l1AJ1oB
         aYcA==
X-Gm-Message-State: AOAM530kfrTjJ2kiOx7vrQKapCqoe5qQAoS8/KWnokAKKhgTcS3GQlg7
        UFfgQjKkCocP9EbuwvXbTXk=
X-Google-Smtp-Source: ABdhPJwhvFF2k1N/OAp9yt8Sw7TqpWkKrs0Z7otIcTPVCOll/eq4RmBn9ZYJ59yPFv6NsL6sex78qA==
X-Received: by 2002:a17:90a:c20b:: with SMTP id e11mr7794271pjt.67.1623396778482;
        Fri, 11 Jun 2021 00:32:58 -0700 (PDT)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:8113:90ef:a3f7:4502])
        by smtp.gmail.com with ESMTPSA id i14sm3988085pjv.15.2021.06.11.00.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 00:32:57 -0700 (PDT)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: [PATCH] sload.f2fs: Reword "IMMUTABLE" in strings/comments
Date:   Fri, 11 Jun 2021 15:31:11 +0800
Message-Id: <20210611073111.947552-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

Since the IMMUTABLE flag for compression is now changed
to F2FS_COMPRESS_RELEASED, some 'IMMUTABLE' words should be changed too:
	1. sload help page
	2. inline comments

Signed-off-by: Robin Hsu <robinhsu@google.com>
---
 fsck/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index c07be1e..c0b871b 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -149,7 +149,8 @@ void sload_usage()
 	MSG(0, "    * -i or -x: use it many times for multiple extensions.\n");
 	MSG(0, "    * -i and -x cannot be used together..\n");
 	MSG(0, "    -m <num> min compressed blocks per cluster\n");
-	MSG(0, "    -r readonly (IMMUTABLE) for compressed files\n");
+	MSG(0, "    -r read only (to release unused blocks) for compressed "
+			"files\n");
 	MSG(0, "    ------------------------------------------------------\n");
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -V print the version number and exit\n");
@@ -650,7 +651,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				}
 				c.compress.min_blocks = val;
 				break;
-			case 'r': /* compress file to set IMMUTABLE */
+			case 'r': /* for setting F2FS_COMOPRESS_RELEASE */
 				c.compress.required = true;
 				c.compress.readonly = true;
 				break;
-- 
2.32.0.272.g935e593368-goog

