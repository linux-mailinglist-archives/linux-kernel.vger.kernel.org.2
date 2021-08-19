Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770DE3F14F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhHSINn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:13:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8883 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhHSINm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:13:42 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gqy8Y2ktlz8sdd;
        Thu, 19 Aug 2021 16:09:01 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 16:13:04 +0800
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 16:13:04 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Mark Brown <broonie@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <wanghaibin.wang@huawei.com>
Subject: [Question] Make the DT cpu-map parser be aware of socket nodes
Date:   Thu, 19 Aug 2021 16:13:03 +0800
Message-ID: <20210819081303.188008-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that there is some discrepancy between the kernel documentation
(Documentation/devicetree/bindings/cpu/cpu-topology.txt) and the actual
implementation of DT topology parser for ARM64 (function parse_dt_topology()
in drivers/base/arch_topology.c).

The Doc implies that we can define a cpu-map for the ARM64 multi-socket
system like:
(1) cpu-map
	socket0
		cluster0
			core0
			core1
		cluster1
			core0
			core1
	socket1
		cluster0
			core0
			core1
		cluster1
			core0
			core1

or a cpu-map for 32-bit system like:
(2) cpu-map
        cluster0
                cluster0
                        core0
                        core1
                cluster1
                        core0
                        core1
        cluster1
                cluster0
                        core0
                        core1
                cluster1
                        core0
                        core1

But current parser only assumes that there are nested clusters within
cpu-map and is unaware of socket, the parser also ignore any information
about the nesting of clusters and present the scheduler with a flat list
of them. So based on current parser, we will get "4 packages, 2 cores per
package, 1 threads per core" from (2), but can not generate a valid
topology from (1).

There are two questions that I'm not sure.

1) Why are we using leaf cluster nodes as packages ? To be more consistent with
the concept of package (or sockets), maybe we should use the top-level cluster
nodes as packages, or just make one single socket ?

2) Now it's documented that a cpu-map with socket nodes can be defined for ARM64,
then do we have any plan to make the parser be aware of sockets too ?
Like, we will make each socket nodes as a package instead of the leaf clusters
if there are socket nodes found in the DT. So we will get "2 packages, 4 cores
per package, 1 thread per core" from cpu-map (1).

In virtualization, I hope to describe the user-defined (from QEMU) topology
information (e.g. sockets=2,cores=8,threads=2) through DT, so that the guest
kernel can get the topology. But I'm not sure whether to build the DT in format
"cpu-map/socket%d/core%d/thread%d" or "cpu-map/cluster%d/core%d/thread%d".
Honestly, I think the first one is consistent with the Doc.


Looking forward to some reply, thanks!

Yanan
.
