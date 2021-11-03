Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2594444B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhKCPiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhKCPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:38:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD6AC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:35:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n23so2683657pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U+B8Hf1PfsKsr2YH8Xlnh9nNd0DF8feROp75CoCDRiA=;
        b=FukFJQLwi8HTKk0+fixspqNA2BgQXBjfOgW8NENe6o38DP7dfo0RaIZgQNOPbaL6+p
         /0dem6RQ/p5GvzfR42F5v0TLvItvnPuGstUNc6eXBfoowjj0hdyP0IOA4Qf14J+MLB28
         A13954FyI3LP/a05AZkst9fRVLXRGK+CrYKwSo8COIhIkKhF0pjy7kL0SuyFDP0leP2G
         eU+rlumzwyMgjigZSzsCaWj5uEaUbZjfU5RlnvC08eQy+WY366uA1sSM8vlOw1My7veS
         RZbF1/6V973ZON6MPYq/6EMpOSq8o7Ndl6Qt4Yc+mUsjIAJ1pdk8vfUgSOk0e51dBsC6
         9Fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U+B8Hf1PfsKsr2YH8Xlnh9nNd0DF8feROp75CoCDRiA=;
        b=5tVf+uLkjKvB461EyDjLkuzW7k9l0Ig3i96aZT4BrH4ziPFPcC8QdUPRQHFXPUQU7/
         su3hbMXRPbQ6UYtSZfhtD2cwGga9Z+wCUSZVV5tZ/vJQJwGf6CwLR/EDpTZ8bP1PUbnN
         YH5b3XxbLxNb4CfmxGMTU7mdtTesEg3D0kniq0h/IrKvESgZ4dx1zy1bc3FCPmNOb4yr
         g2DmEEvwvklvuAvg4JGnmjsOy+p22Z1FX/fcmH02zzR/g+tsy35Bj/bBtvb+H2tw1Zs5
         U+YloOEPbxFT0/SnZCGVoqs16w4EB8jG08AdkfGHXpcuVXxfxLzWLadi804tlYQIMpvN
         5jBg==
X-Gm-Message-State: AOAM533H4qiCThABGCt2b5IyHTf414BLG7N0jqrccQq0RKmiYlnHHayl
        ES3w9peKNKFwiVjn+fMT5Xa4h6KBBd4=
X-Google-Smtp-Source: ABdhPJyBxDVtiZ2twRWo36io7cuy4zlus0U0RUX3qcrBJAznP+R8QvHG+dHeOJZrivrwmgjX4RvudQ==
X-Received: by 2002:a62:7dc7:0:b0:47e:50ae:b9eb with SMTP id y190-20020a627dc7000000b0047e50aeb9ebmr43735240pfc.77.1635953737566;
        Wed, 03 Nov 2021 08:35:37 -0700 (PDT)
Received: from pc ([223.197.3.99])
        by smtp.gmail.com with ESMTPSA id 1sm2547453pfl.133.2021.11.03.08.35.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Nov 2021 08:35:37 -0700 (PDT)
Date:   Wed, 3 Nov 2021 23:35:29 +0800
From:   Zhaoyu Liu <zackary.liu.pro@gmail.com>
To:     gregkh@linuxfoundation.org, masahiroy@kernel.org,
        ripxorip@gmail.com, zackary.liu.pro@gmail.com, mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/tags: merge "TAGS" and "tags" in case
Message-ID: <20211103153522.GA23842@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merge "TAGS" and "tags" for the code more concise

Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
---
 scripts/tags.sh | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 16d475b3e203..a9181dd0fee2 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -315,15 +315,11 @@ case "$1" in
 		dogtags
 		;;
 
-	"tags")
-		rm -f tags
-		xtags ctags
-		remove_structs=y
-		;;
-
-	"TAGS")
-		rm -f TAGS
-		xtags etags
+	"TAGS" | "tags")
+		rm -f $1
+		xtags $([ $1 = "tags" ]	\
+			&& echo ctags		\
+			|| echo etags)
 		remove_structs=y
 		;;
 esac
-- 
2.17.1

