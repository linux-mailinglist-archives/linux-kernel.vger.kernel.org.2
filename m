Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2C73AE4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhFUIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhFUIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:34:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E95C061283;
        Mon, 21 Jun 2021 01:32:09 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id g142so28315360qke.4;
        Mon, 21 Jun 2021 01:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aKkHlUzJ2DNxuRZQvmBGs5vDxgaoNxO28XI02n6Qax4=;
        b=GzS/xmp2GlkWlVvcdnTyEOXzcyuDbXcrQWZhXKhFHkGxcCCSPpoxU+bJR4a2Vj3jA1
         3o3Qt6GfDjYZ2S7NUrf3eDrc2GOjBp51yl2YM5TCnIPiZkRgqKryo9IyurMW/+lq2i72
         R93JsJlxCaK3jYuIikkJw5mrCbZobHA/WQp3PPiXVmZtPJpWTI45KLrnVTytEP4QoOo/
         csWQ44VcwvucwBYmjJ3eRNzbAp8PiTbXKN1bNml2cqq0Mxq0r/KPKMD5e7LFa/KNJtLK
         +r2NLaH9KtphdSyHuoij+++qoHVAxKObSQZ8zD5uqOF1hizPOv1QHdNayPHXYVWTzZQS
         S7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aKkHlUzJ2DNxuRZQvmBGs5vDxgaoNxO28XI02n6Qax4=;
        b=idKOFIm/xZe9cZmWvNBJQ5a5tMA3vZBQrmWCif+Ib87Ej4P5MWbIeN+9ZuSahyipCW
         z7RTxeh55f6IqPNIIlN0rfH7HadD5pRi400i5jjWFf8aYDRJiBbKZHf68UvVsgKm0oe2
         EQynbp3E8pLSUzQYyy5Rq5Dg25t4GD5XnzpXDoWpFI9RK2+ZtpEezvEw2L+YY1uhl2gj
         5MaAueDj/ixzYrI7h2WfAjdb1Sv/ojDqylJISDXSp3BQDkAKk43CGs4ngJUk+h7JxG2s
         RAjy1GJ5hZdnelliAnynOWvejJTzbwNqhieraULruxtIsyQ50dtYBXqoz7knw+yH4k5p
         ONgQ==
X-Gm-Message-State: AOAM533JnSf//GUE6gTj8bsZq/vRw9xS4oIKocQoDi0KaZF87EsRQYNy
        MJHJSdn4Aewa4QGtWuPV99E=
X-Google-Smtp-Source: ABdhPJzODoXeSjSylACgeOAR+3uvKn3dZ4Ef0l+uROcfZTV7JZC17s5fDMQ1Nk/3dTyCmpUQbUOuYA==
X-Received: by 2002:a05:620a:e02:: with SMTP id y2mr22244039qkm.54.1624264328429;
        Mon, 21 Jun 2021 01:32:08 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id l23sm9852581qtp.28.2021.06.21.01.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 01:32:08 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, jgowans@amazon.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        sj38.park@gmail.com, snu@zelle79.org, vbabka@suse.cz,
        vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v31 13/13] MAINTAINERS: Update for DAMON
Date:   Mon, 21 Jun 2021 08:31:08 +0000
Message-Id: <20210621083108.17589-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621083108.17589-1-sj38.park@gmail.com>
References: <20210621083108.17589-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates MAINTAINERS file for DAMON related files.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Markus Boehme <markubo@amazon.de>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dccbb23109a6..609bc9858748 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5095,6 +5095,18 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DATA ACCESS MONITOR
+M:	SeongJae Park <sjpark@amazon.de>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/damon/*
+F:	Documentation/vm/damon/*
+F:	include/linux/damon.h
+F:	include/trace/events/damon.h
+F:	mm/damon/*
+F:	tools/damon/*
+F:	tools/testing/selftests/damon/*
+
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
-- 
2.17.1

