Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D5D40D57A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhIPJDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhIPJBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A190E6127A;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782802;
        bh=2onBDmcX5Z2qOBLRcvgnkoXuBMNPKSL8Szs8OXOsw7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SECGetP9a1vvU/DzwjmWRHkSoGdF2KXJx2DKQK3VjDYwOKvMpGE2BA7zAtcLC9Lyy
         8atOeDuuKHaItgPLB6NER+AQidVMx9g8+BwuAK1iv3kzm3IDJsOYarVR3mawEehzfy
         d64OqJMxnzzlVqprEQ5h1k19pI6FB2VIbiKsH9/sscs60p9WzWyT9+YdAN/Ys/v6Zo
         Em2m3h9t0kVg29XiAekHy12MaOv52J4ZHSnRcVKF2lI0fPICsFDHrV4YpU7yTYHhsu
         sxwM7eF6TYDQRlQvGPvueH9M8HsdWTiQMsZMFu9pf8+h7xLJcWQW4P4zZpOqTKrRiA
         Jwxb62PBUpMlA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFQ-001qkO-Rz; Thu, 16 Sep 2021 11:00:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 13/30] ABI: sysfs-class-infiniband: use wildcards on What definitions
Date:   Thu, 16 Sep 2021 10:59:40 +0200
Message-Id: <3cb5cad69f457ed92b38d719ff7f6f0fc9364285.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
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

Acked-by: Jason Gunthorpe <jgg@nvidia.com>
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

