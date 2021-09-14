Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0F340B0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhINOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233859AbhINOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCD8161214;
        Tue, 14 Sep 2021 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631629970;
        bh=QxShY/2OTnQ/+HyxlNpT1IybG10frFPYzxvwcYyvbdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=egzPNksXi0Mv+Xf8oJpm7PYGs9oqRk/H9jC/+GWAa5z0C4zJfbbMuxpj4eoZuvokB
         X6UCYLmTfVa/j+XfbJ+6XQrq2RDdRvy88UuvEHRNuzpYU6lHH4+OmeiB86JnqrSd1Q
         zz+QVn1M9qH3vsN3bdK/78wu9v4VIMsDhGpS8qaNnysC9ChUA56OaXnvvOpq6fkLXK
         5HizPV+0ETPH0Y6pVyFd7ttL2bldEgu6EoEuKCeq6ZYOI+YTLoqc9AyKiBQzu72FLi
         qtwzSQx0jSQhEE7JuOaFYr2SLD//fnjlu1mmG0MRi+0ou0WAKwSjVRiGq3fV/el1c/
         OWX3KzEeuF0fA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9UN-000Kl2-UC; Tue, 14 Sep 2021 16:32:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/29] ABI: sysfs-class-infiniband: use wildcards on What definitions
Date:   Tue, 14 Sep 2021 16:32:28 +0200
Message-Id: <df195c1204a56a9a83926e6a1a38fb91a7221869.1631629496.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629496.git.mchehab+huawei@kernel.org>
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An "N" upper letter is not a wildcard, nor can easily be identified
by script, specially since the USB sysfs define things like.
bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
to convert it into a Regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../ABI/stable/sysfs-class-infiniband         | 64 +++++++++----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
index 9b1bdfa43354..ebf08c604336 100644
--- a/Documentation/ABI/stable/sysfs-class-infiniband
+++ b/Documentation/ABI/stable/sysfs-class-infiniband
@@ -232,10 +232,10 @@ Description: 	The RoCE type of the associated GID resides at index <gid-index>.
 		or "RoCE v2" for RoCE v2 based GIDs.
 
 
-What:		/sys/class/infiniband_mad/umadN/ibdev
-What:		/sys/class/infiniband_mad/umadN/port
-What:		/sys/class/infiniband_mad/issmN/ibdev
-What:		/sys/class/infiniband_mad/issmN/port
+What:		/sys/class/infiniband_mad/umad<N>/ibdev
+What:		/sys/class/infiniband_mad/umad<N>/port
+What:		/sys/class/infiniband_mad/issm<N>/ibdev
+What:		/sys/class/infiniband_mad/issm<N>/port
 Date:		Apr, 2005
 KernelVersion:	v2.6.12
 Contact:	linux-rdma@vger.kernel.org
@@ -261,8 +261,8 @@ Description:
 		userspace ABI compatibility of umad & issm devices.
 
 
-What:		/sys/class/infiniband_verbs/uverbsN/ibdev
-What:		/sys/class/infiniband_verbs/uverbsN/abi_version
+What:		/sys/class/infiniband_verbs/uverbs<N>/ibdev
+What:		/sys/class/infiniband_verbs/uverbs<N>/abi_version
 Date:		Sept, 2005
 KernelVersion:	v2.6.14
 Contact:	linux-rdma@vger.kernel.org
@@ -471,7 +471,7 @@ Description:
 		=============== ======================================================
 
 
-What:		/sys/class/infiniband/qibX/ports/N/sl2vl/[0-15]
+What:		/sys/class/infiniband/qibX/ports/<N>/sl2vl/[0-15]
 Date:		May, 2010
 KernelVersion:	v2.6.35
 Contact:	linux-rdma@vger.kernel.org
@@ -480,8 +480,8 @@ Description:
 		the Service Level (SL). Listing the SL files returns the Virtual
 		Lane (VL) as programmed by the SL.
 
-What:		/sys/class/infiniband/qibX/ports/N/CCMgtA/cc_settings_bin
-What:		/sys/class/infiniband/qibX/ports/N/CCMgtA/cc_table_bin
+What:		/sys/class/infiniband/qibX/ports/<N>/CCMgtA/cc_settings_bin
+What:		/sys/class/infiniband/qibX/ports/<N>/CCMgtA/cc_table_bin
 Date:		May, 2010
 KernelVersion:	v2.6.35
 Contact:	linux-rdma@vger.kernel.org
@@ -499,11 +499,11 @@ Description:
 				delay.
 		=============== ================================================
 
-What:		/sys/class/infiniband/qibX/ports/N/linkstate/loopback
-What:		/sys/class/infiniband/qibX/ports/N/linkstate/led_override
-What:		/sys/class/infiniband/qibX/ports/N/linkstate/hrtbt_enable
-What:		/sys/class/infiniband/qibX/ports/N/linkstate/status
-What:		/sys/class/infiniband/qibX/ports/N/linkstate/status_str
+What:		/sys/class/infiniband/qibX/ports/<N>/linkstate/loopback
+What:		/sys/class/infiniband/qibX/ports/<N>/linkstate/led_override
+What:		/sys/class/infiniband/qibX/ports/<N>/linkstate/hrtbt_enable
+What:		/sys/class/infiniband/qibX/ports/<N>/linkstate/status
+What:		/sys/class/infiniband/qibX/ports/<N>/linkstate/status_str
 Date:		May, 2010
 KernelVersion:	v2.6.35
 Contact:	linux-rdma@vger.kernel.org
@@ -523,16 +523,16 @@ Description:
 				"Fatal_Hardware_Error".
 		=============== ===============================================
 
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/rc_resends
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/seq_naks
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/rdma_seq
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/rnr_naks
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/other_naks
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/rc_timeouts
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/look_pkts
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/pkt_drops
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/dma_wait
-What:		/sys/class/infiniband/qibX/ports/N/diag_counters/unaligned
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/rc_resends
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/seq_naks
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/rdma_seq
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/rnr_naks
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/other_naks
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/rc_timeouts
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/look_pkts
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/pkt_drops
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/dma_wait
+What:		/sys/class/infiniband/qibX/ports/<N>/diag_counters/unaligned
 Date:		May, 2010
 KernelVersion:	v2.6.35
 Contact:	linux-rdma@vger.kernel.org
@@ -650,9 +650,9 @@ Description:
 		=============== =============================================
 
 
-What:		/sys/class/infiniband/hfi1_X/ports/N/CCMgtA/cc_settings_bin
-What:		/sys/class/infiniband/hfi1_X/ports/N/CCMgtA/cc_table_bin
-What:		/sys/class/infiniband/hfi1_X/ports/N/CCMgtA/cc_prescan
+What:		/sys/class/infiniband/hfi1_X/ports/<N>/CCMgtA/cc_settings_bin
+What:		/sys/class/infiniband/hfi1_X/ports/<N>/CCMgtA/cc_table_bin
+What:		/sys/class/infiniband/hfi1_X/ports/<N>/CCMgtA/cc_prescan
 Date:		May, 2016
 KernelVersion:	v4.6
 Contact:	linux-rdma@vger.kernel.org
@@ -675,9 +675,9 @@ Description:
 				disable.
 		=============== ================================================
 
-What:		/sys/class/infiniband/hfi1_X/ports/N/sc2vl/[0-31]
-What:		/sys/class/infiniband/hfi1_X/ports/N/sl2sc/[0-31]
-What:		/sys/class/infiniband/hfi1_X/ports/N/vl2mtu/[0-15]
+What:		/sys/class/infiniband/hfi1_X/ports/<N>/sc2vl/[0-31]
+What:		/sys/class/infiniband/hfi1_X/ports/<N>/sl2sc/[0-31]
+What:		/sys/class/infiniband/hfi1_X/ports/<N>/vl2mtu/[0-15]
 Date:		May, 2016
 KernelVersion:	v4.6
 Contact:	linux-rdma@vger.kernel.org
@@ -691,8 +691,8 @@ Description:
 		=============== ===================================================
 
 
-What:		/sys/class/infiniband/hfi1_X/sdma_N/cpu_list
-What:		/sys/class/infiniband/hfi1_X/sdma_N/vl
+What:		/sys/class/infiniband/hfi1_X/sdma_<N>/cpu_list
+What:		/sys/class/infiniband/hfi1_X/sdma_<N>/vl
 Date:		Sept, 2016
 KernelVersion:	v4.8
 Contact:	linux-rdma@vger.kernel.org
-- 
2.31.1

