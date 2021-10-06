Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC939424135
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbhJFPXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbhJFPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:23:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6E1C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 08:21:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f4so6094487edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=P0tGE7p+AV7X8vAEgZS8QLZhRwDjoxzZkIbnWYUcb+8=;
        b=Q1VNpyrz7YgVOjlS1ERSx+BHl1g1JH8SHRb1cbUFTQQMgiP6Vb25CDn1MzdqvF2ujs
         a1nYtU1RPBrj0Sj2osWRA0aZ26H2kUsixiSmdfGIDJvR2RBzanHUhT/+pWUmWRa5lCJ+
         SLkccr41YtByBWtd762q6lywmOxom/ajQb/jGFsZuG361IlUm7yWBqXkO3pzzubI/Stl
         GJQ2gUT+34NatL8sP3gJ4Xe/FIfN7WdpbHacP1AGb+Z2HsInbN7qszjceePCWlbAUKmH
         0GRYjWEgTbKUTgycdkwKVQWMToPnvEoCJnHPonDSj2y2S0guJY7FmlCvO8XLCZpO0GBH
         vWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P0tGE7p+AV7X8vAEgZS8QLZhRwDjoxzZkIbnWYUcb+8=;
        b=JTTen2W3ruwWpg32e6vWm8BshE4HqzrsbBh9BoVgloJIngcSP20JzINCecvj2ym605
         3c6ezNIjnBBDF99YdtuzP9dlhlaRP5ewTMJrgnYjwWrKTNt6ZX1AKGM3BziOpE0rFmCT
         4IYc02y5lY4LKpfUgSQ3kBw/Zwvxr3eZD644r0Q+FLLwODDJZcMn79y0PbpWgXb/lgy1
         WGYRJdnkVQ5Mf/P+/Jy+wrI4kuM8TQc2lsza7M/H3xgkCx89wPHlU6nQg9NxAesJ4Spp
         aR2A0DTlVn/CYkub2UiXh8kYcvdmjpqOD8lXaFUesIZ1OKfjcJY1AM//Ji4d8RjnfMnM
         Q6wg==
X-Gm-Message-State: AOAM532XdaY9c9U1fU423Z1THnWoAzFVB0qeiN7VoyeKObwi9B2Rz494
        art3CSbVR2chnMAwjE+b/HE=
X-Google-Smtp-Source: ABdhPJxC+b3Q3j5vWHfm+9wcv+OaxmWfI2GGp20dqgF4eLY47sPJmgOLaJoMA6fjK1bs/gJcLPp1og==
X-Received: by 2002:a17:906:1146:: with SMTP id i6mr33232322eja.12.1633533685876;
        Wed, 06 Oct 2021 08:21:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z4sm1500764ejw.46.2021.10.06.08.21.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Oct 2021 08:21:25 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     kuba@kernel.org, gregkh@linuxfoundation.org, neilb@suse.com,
        mojha@codeaurora.org, jkosina@suse.cz
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] hashtable: remove a redundant check in hash_for_each_xxx()
Date:   Wed,  6 Oct 2021 15:21:00 +0000
Message-Id: <20211006152100.17795-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The three hash_for_each_xxx() helper iterate the hash table with help
of hlist_for_each_entry_xxx(), which breaks the loop only when obj is
NULL.

This means the check during each iteration is redundant. This patch
removes it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/hashtable.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..a15719ed303f 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -124,8 +124,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @member: the name of the hlist_node within the struct
  */
 #define hash_for_each(name, bkt, obj, member)				\
-	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
-			(bkt)++)\
+	for ((bkt) = 0, obj = NULL; (bkt) < HASH_SIZE(name); (bkt)++)	\
 		hlist_for_each_entry(obj, &name[bkt], member)
 
 /**
@@ -136,8 +135,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @member: the name of the hlist_node within the struct
  */
 #define hash_for_each_rcu(name, bkt, obj, member)			\
-	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
-			(bkt)++)\
+	for ((bkt) = 0, obj = NULL; (bkt) < HASH_SIZE(name); (bkt)++)	\
 		hlist_for_each_entry_rcu(obj, &name[bkt], member)
 
 /**
@@ -150,8 +148,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @member: the name of the hlist_node within the struct
  */
 #define hash_for_each_safe(name, bkt, tmp, obj, member)			\
-	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
-			(bkt)++)\
+	for ((bkt) = 0, obj = NULL; (bkt) < HASH_SIZE(name); (bkt)++)	\
 		hlist_for_each_entry_safe(obj, tmp, &name[bkt], member)
 
 /**
-- 
2.23.0

