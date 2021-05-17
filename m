Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB6382932
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbhEQKA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:00:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34623 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbhEQKAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:00:11 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1W-0002Vh-0F
        for linux-kernel@vger.kernel.org; Mon, 17 May 2021 09:58:54 +0000
Received: by mail-ej1-f71.google.com with SMTP id h4-20020a1709067184b02903cbbd4c3d8fso830713ejk.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oRK7fdxqXtvCqQanUPHi5PLCsvN+FRR/HxPoeVMmEY=;
        b=oEifwAImQ7RxOh6xwpAyEm7t4zLmFFE4s8uk3Jew38hZ8hU2b6m4/Yg6FsB4+E/bzX
         qV8ISTzbENClPMxHxEvJJita/mUF/6Dyg9+TGTt6zEJOc3MklUm/Ya2NEU/ZvNaM1lwi
         09In9qiweDMdJyohZRsoThpBivEPk4Izo2GvXCkFA2z5pB+KDGvdvvR8PBtZiAcPSHVP
         WQyxP/yH8YIoHaImlxpWUTXrgsl6CwyfONhcU8qC7PZdvbb6GhkKsjajn9GQuLXA4jPc
         zE9r3lJ8ORbYVfUTVxb8+9tDDQPaZQ31HmdHpzq7QJqmV4QKVbuY20bQie81GSu5ZxgL
         +SaA==
X-Gm-Message-State: AOAM533YO+kKXZ2DAn9SA8BHbPzXeE6W/b6xG22a8TZNUgc7jwT6A3QI
        yiBEdeyL9dB1mnCThDGqoiKbyPOc6kjoi5HxHygphEz6A1/8/0R2PDg9k+gqUaVNX6rkq098C/j
        DEn0yCUFqpfMJQ8NVo0N/gOa3Mq1wxwba3OY4UImDRA==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr61739760ejg.110.1621245533766;
        Mon, 17 May 2021 02:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCJLusPZINe2qdUxpYMFxA8UX6eqbTRbrwv6wXahFNW7BPlHqeGrQshe9NXPBEj1GGA8wlPA==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr61739755ejg.110.1621245533621;
        Mon, 17 May 2021 02:58:53 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q26sm8475329ejc.3.2021.05.17.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:53 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        horms@verge.net.au, ja@ssi.bg, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] netfilter: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:50 +0200
Message-Id: <20210517095850.82083-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find net/netfilter -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 net/netfilter/Kconfig      | 2 +-
 net/netfilter/ipvs/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 56a2531a3402..172d74560632 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -816,7 +816,7 @@ config NETFILTER_XT_TARGET_CLASSIFY
 	  the priority of a packet. Some qdiscs can use this value for
 	  classification, among these are:
 
-  	  atm, cbq, dsmark, pfifo_fast, htb, prio
+	  atm, cbq, dsmark, pfifo_fast, htb, prio
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index d61886874940..271da8447b29 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -318,7 +318,7 @@ config IP_VS_MH_TAB_INDEX
 comment 'IPVS application helper'
 
 config	IP_VS_FTP
-  	tristate "FTP protocol helper"
+	tristate "FTP protocol helper"
 	depends on IP_VS_PROTO_TCP && NF_CONNTRACK && NF_NAT && \
 		NF_CONNTRACK_FTP
 	select IP_VS_NFCT
-- 
2.27.0

