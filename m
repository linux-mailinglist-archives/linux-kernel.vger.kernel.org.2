Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1513CB403
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbhGPIT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbhGPITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:19:17 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73436C06175F;
        Fri, 16 Jul 2021 01:16:22 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id f3so4201898qvm.2;
        Fri, 16 Jul 2021 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbSJbIvM1lhLdYl80cU8AkcrpzgH72pjsMMspcUkgh4=;
        b=IBIn4MocQdA0CPzs7cDHhrrLs0Q9nO2THVyfE/GvqFEpDloqN7GmlFTwtxMSNVgsxe
         cuSg5XZU321jSwADS7Pmplzjo0IiQb7I12hWBRw9E+eYpfSeNHqMSVSZaldlShniznr0
         zAU+b5IiOR8jSM6g7SHr0nJ5s9iTSPhqjeYmAttbiIMKZrKfuiw8sDedXBDe0lGJRncC
         zJHR5J5PWKY5CpcwI7z6qcDM/I8YASYcexuJpbYyH1ToZjKm24/pylKupcybMQPcXHFM
         yPgFRL5LvmzIzNGbgy0FD6G0Uf9cQFLJ5J9YEn/gEoiI33MEJr1qd/R+AUQPcY+1mWPM
         oPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qbSJbIvM1lhLdYl80cU8AkcrpzgH72pjsMMspcUkgh4=;
        b=XP941nU5iBNLPRzzLLC0z+M27wgpR42fTxFGdhWY6d0Nngm5i0b9UhrVw1yHD1mbuU
         WHc9eIBk2HHApJV7Kf1VaIlEbV4R+FPRS/BxHvgpqJMacPHRQlZ+/xtsnAj1lq7JxAU3
         Q4InqQkbcL7Y374zH4nbOoZSWsYKi/sXpSzoFmsGGR59r+ntf0yMSchE7/Sllc22pKbv
         h1pMv/nKfKfd0MgrGLWMSGeobkNKhQrf9ofaQLQmxQSA3qEhUyf+eJcf+E5n68nLI9iJ
         u5bXYPYvXQUgoS2/ikScJZK2qAweCJ2GOP0BavWtB0T3jOiIiYLaTOzAxIzBNPOCjHLr
         tOlA==
X-Gm-Message-State: AOAM532c116YQKchN3fh/VUWxWqVI4aE3GLBpvw2zWkmrhMp3054/NZn
        S2Kd+q67kAMyh03i9964Q5k=
X-Google-Smtp-Source: ABdhPJzpnq8z1jyu4kbXU5811aidzjeyH0UJ6NNhMQ3X4EP5mw2cbDqaPZJPRhQyHzp3RsTzgaf1FQ==
X-Received: by 2002:ad4:4e73:: with SMTP id ec19mr8924069qvb.16.1626423381674;
        Fri, 16 Jul 2021 01:16:21 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id c22sm2868464qtd.42.2021.07.16.01.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:16:21 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, joe@perches.com,
        mgorman@suse.de, mheyne@amazon.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        sieberf@amazon.com, sj38.park@gmail.com, snu@zelle79.org,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v34 13/13] MAINTAINERS: Update for DAMON
Date:   Fri, 16 Jul 2021 08:14:49 +0000
Message-Id: <20210716081449.22187-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210716081449.22187-1-sj38.park@gmail.com>
References: <20210716081449.22187-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates MAINTAINERS file for DAMON related files.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Markus Boehme <markubo@amazon.de>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 13ec37ac23c7..1e56c3fe1bd3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5128,6 +5128,17 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DATA ACCESS MONITOR
+M:	SeongJae Park <sjpark@amazon.de>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/damon/
+F:	Documentation/vm/damon/
+F:	include/linux/damon.h
+F:	include/trace/events/damon.h
+F:	mm/damon/
+F:	tools/testing/selftests/damon/
+
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
-- 
2.17.1

