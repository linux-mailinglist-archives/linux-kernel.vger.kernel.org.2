Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E10A4195C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhI0OCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234715AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A16BB61260;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=tXZCTQeyF8jXhZbgmmQUTNpLQ9Rtm77QaTTOLqxCn1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7GQxvIgsQZj6Gy7MVjPw3TU3NGkbd9LIFvtw8oBPmNAI4qGez3Xn0yqATvl7Cqo3
         kgyOtS81yxtHiyNMKuQ6Gvtp4ZaDWRpNB1nghDAyUi5ZfsrMNLT16gkwtok72eze+G
         nFcEbA4iJL9u/UgnSDBCsyBmm0FyVLtblcGKXeFuVK/ntJNOVVwthBVlKZ2R5GEMN0
         4pHY5Yl/uKulZxZUJnYAnKS083Lc4j1m3wq3EMZHGDx9q2ZzJNtwlKeZsBqjmKrH2Q
         TLYLXzDNPc1qbEBM+vjkbei+54LCidV3stbBeyBaC2gjUol4usEJw6wMYJQw8Yq+QI
         jvp5bIyoN06bQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000AuU-UT; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] ABI: obsolete/sysfs-bus-iio: add some missing blank lines
Date:   Mon, 27 Sep 2021 15:59:48 +0200
Message-Id: <602c52c3fb957b9d7d6b72292dc86d295b50c881.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid those warnings:
	Documentation/ABI/obsolete/sysfs-bus-iio:171: WARNING: Unexpected indentation.
	Documentation/ABI/obsolete/sysfs-bus-iio:12: WARNING: Unexpected indentation.
	Documentation/ABI/obsolete/sysfs-bus-iio:2: WARNING: Unexpected indentation.
	Documentation/ABI/obsolete/sysfs-bus-iio:149: WARNING: Unexpected indentation.

Fixes: caf0fb3bb38a ("iio: Documentation: move incompatible ABI to obsolete")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/obsolete/sysfs-bus-iio | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/obsolete/sysfs-bus-iio b/Documentation/ABI/obsolete/sysfs-bus-iio
index c9531bb64816..b64394b0b374 100644
--- a/Documentation/ABI/obsolete/sysfs-bus-iio
+++ b/Documentation/ABI/obsolete/sysfs-bus-iio
@@ -6,6 +6,7 @@ Description:
 
 		Since Kernel 5.11, multiple buffers are supported.
 		so, it is better to use, instead:
+
 			/sys/bus/iio/devices/iio:deviceX/bufferY/length
 
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/enable
@@ -17,6 +18,7 @@ Description:
 
 		Since Kernel 5.11, multiple buffers are supported.
 		so, it is better to use, instead:
+
 			/sys/bus/iio/devices/iio:deviceX/bufferY/enable
 
 What:		/sys/bus/iio/devices/iio:deviceX/scan_elements
@@ -165,6 +167,7 @@ Description:
 
 		Since Kernel 5.11, multiple buffers are supported.
 		so, it is better to use, instead:
+
 			/sys/bus/iio/devices/iio:deviceX/bufferY/watermark
 
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/data_available
@@ -179,4 +182,5 @@ Description:
 
 		Since Kernel 5.11, multiple buffers are supported.
 		so, it is better to use, instead:
+
 			/sys/bus/iio/devices/iio:deviceX/bufferY/data_available
-- 
2.31.1

