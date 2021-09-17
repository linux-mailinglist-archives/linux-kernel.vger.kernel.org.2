Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AD940F767
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243961AbhIQMX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243710AbhIQMXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:23:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B8DD611C8;
        Fri, 17 Sep 2021 12:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631881348;
        bh=cpgmyBFI6GAlRzryA585L1WdlWTMOwIRy1Zsb+LlcJQ=;
        h=From:To:Cc:Subject:Date:From;
        b=uF9HGSzP0ij/EqnDpfpj2Ph5cPa3WB8SOx+9ZJSr9YY8X7qeeQ91GK3kwxHpkMQFO
         VkxsDF2joaCqCxGBmpMmqL03GXLt0q70RvEasQRfxYcVWlIKkkaY4m2zKSmwNl6ltv
         iZhEWKjIb8OllzycYqnRoMB/ZgEKxvxjNADkxW740+wvWD33k5j0pnrJEI/OKDyHmS
         S7hjXbWuLqWG5f0bL8krDIAb5vWrt4l3LQnbF23DjUYNvAbquWU9I/JPphfuUoUak5
         6DbgPfEf6z+ApFlbNRDlw/NwYJSawl5duDquzYhaDcFw7k0Rtk9JYAGby4XFpzM0UR
         pp3MGjGrHH8xA==
From:   SeongJae Park <sj@kernel.org>
To:     corbet@lwn.net
Cc:     SeongJae Park <sj@kernel.org>, roger.pau@citrix.com,
        jgross@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Update SeongJae's email address
Date:   Fri, 17 Sep 2021 12:22:22 +0000
Message-Id: <20210917122222.3109-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates SeongJae's email addresses in documents to his
preferred one.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-xen-blkback   | 4 ++--
 Documentation/ABI/testing/sysfs-driver-xen-blkfront  | 2 +-
 Documentation/translations/ko_KR/memory-barriers.txt | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
index ac2947b98950..a74dfe52dd76 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
@@ -29,7 +29,7 @@ Description:
 What:           /sys/module/xen_blkback/parameters/buffer_squeeze_duration_ms
 Date:           December 2019
 KernelVersion:  5.6
-Contact:        SeongJae Park <sjpark@amazon.de>
+Contact:        SeongJae Park <sj@kernel.org>
 Description:
                 When memory pressure is reported to blkback this option
                 controls the duration in milliseconds that blkback will not
@@ -39,7 +39,7 @@ Description:
 What:           /sys/module/xen_blkback/parameters/feature_persistent
 Date:           September 2020
 KernelVersion:  5.10
-Contact:        SeongJae Park <sjpark@amazon.de>
+Contact:        SeongJae Park <sj@kernel.org>
 Description:
                 Whether to enable the persistent grants feature or not.  Note
                 that this option only takes effect on newly created backends.
diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
index 28008905615f..61fd173fabfe 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
@@ -12,7 +12,7 @@ Description:
 What:           /sys/module/xen_blkfront/parameters/feature_persistent
 Date:           September 2020
 KernelVersion:  5.10
-Contact:        SeongJae Park <sjpark@amazon.de>
+Contact:        SeongJae Park <sj@kernel.org>
 Description:
                 Whether to enable the persistent grants feature or not.  Note
                 that this option only takes effect on newly created frontends.
diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 64d932f5dc77..75aa5531cc7d 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1,6 +1,6 @@
 NOTE:
 This is a version of Documentation/memory-barriers.txt translated into Korean.
-This document is maintained by SeongJae Park <sj38.park@gmail.com>.
+This document is maintained by SeongJae Park <sj@kernel.org>.
 If you find any difference between this document and the original file or
 a problem with the translation, please contact the maintainer of this file.
 
@@ -10,13 +10,13 @@ a fork.  So if you have any comments or updates for this file please
 update the original English file first.  The English version is
 definitive, and readers should look there if they have any doubt.
 
-===================================
+=================================
 이 문서는
 Documentation/memory-barriers.txt
 의 한글 번역입니다.
 
-역자： 박성재 <sj38.park@gmail.com>
-===================================
+역자： 박성재 <sj@kernel.org>
+=================================
 
 
 			 =========================
-- 
2.17.1

