Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778FC35F994
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347160AbhDNRNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:13:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:3013 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345473AbhDNRNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:13:08 -0400
IronPort-SDR: rVSufdc29H2i1nVLggKWvbaw/1qYlSHVIo6ZDd/uV+Nc2zmJxFnbTcOeVHcJhhSB2Q0wm5WKYM
 btNIBKYoi6Hw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="181811930"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="181811930"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:12:46 -0700
IronPort-SDR: m0pMUeCiSNJiP3uI9MFOjORxwthq8g1scpsCCDSzopp76+FOLPsXy1SiRLIlVpMA1ec0JoYeef
 r0CIPLkJRruA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="382427969"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2021 10:12:44 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/7] intel_th: Constify attribute_group structs
Date:   Wed, 14 Apr 2021 20:12:48 +0300
Message-Id: <20210414171251.14672-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rikard Falkeborn <rikard.falkeborn@gmail.com>

The only usage of them is to pass their address to sysfs_create_group()
and sysfs_remove_group(), both which have pointers to const
attribute_group structs as input. Make them const to allow the compiler
to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/intel_th.h | 2 +-
 drivers/hwtracing/intel_th/msu.c      | 2 +-
 drivers/hwtracing/intel_th/pti.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/intel_th.h b/drivers/hwtracing/intel_th/intel_th.h
index 05fa2dab37d1..89c67e0e1d34 100644
--- a/drivers/hwtracing/intel_th/intel_th.h
+++ b/drivers/hwtracing/intel_th/intel_th.h
@@ -178,7 +178,7 @@ struct intel_th_driver {
 	/* file_operations for those who want a device node */
 	const struct file_operations *fops;
 	/* optional attributes */
-	struct attribute_group	*attr_group;
+	const struct attribute_group *attr_group;
 
 	/* source ops */
 	int			(*set_output)(struct intel_th_device *thdev,
diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 7d95242db900..2edc4666633d 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -2095,7 +2095,7 @@ static struct attribute *msc_output_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group msc_output_group = {
+static const struct attribute_group msc_output_group = {
 	.attrs	= msc_output_attrs,
 };
 
diff --git a/drivers/hwtracing/intel_th/pti.c b/drivers/hwtracing/intel_th/pti.c
index 0da6b787f553..09132ab8bc23 100644
--- a/drivers/hwtracing/intel_th/pti.c
+++ b/drivers/hwtracing/intel_th/pti.c
@@ -142,7 +142,7 @@ static struct attribute *pti_output_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group pti_output_group = {
+static const struct attribute_group pti_output_group = {
 	.attrs	= pti_output_attrs,
 };
 
@@ -295,7 +295,7 @@ static struct attribute *lpp_output_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group lpp_output_group = {
+static const struct attribute_group lpp_output_group = {
 	.attrs	= lpp_output_attrs,
 };
 
-- 
2.30.2

