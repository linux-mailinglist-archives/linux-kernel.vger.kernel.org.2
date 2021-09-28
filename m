Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424C841AF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbhI1Mux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:50:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240711AbhI1Muw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:50:52 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SAJ4Eq019457;
        Tue, 28 Sep 2021 08:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Y0lsPQ3de1hi0HT1iJbp1UbGiO/7GnkeYOUpwVeKUTE=;
 b=h5KAHzZNdK3KLlgER0onYrZGrzUUun2gsSU3KXV7xR9XoIayMvcXZUj12fu37/ZYARbZ
 XeefROo0pkwZEemrkKxlQrhy1lzNICFty02Yx1/hE1RTP3uRfHQ2gBVlAqF4rPov7ezU
 NaCVoOTc64PMCPQ4FwlsQnry7MEQf/oSRDuDzb+wHGNjDCk98WEIqcsXoDY/gO2jyTwd
 PPIkV1AePuA/SsnSlwE1P5I5eB/DTwlCQx7uQxiAgGbgtaMtEbZJworeScIdsit7+9BG
 hVcmP8Z7sIrj3gJIiWkvNSMnGW4D2RpnvX0kQPmKDqdUQqeBvW+jRMnWL4Hn+v9DX4at mg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bc16mb5jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 08:48:53 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18SChFcT030260;
        Tue, 28 Sep 2021 12:48:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3b9u1je28x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 12:48:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18SCmmRK56361414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 12:48:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45CD84C058;
        Tue, 28 Sep 2021 12:48:48 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 776474C059;
        Tue, 28 Sep 2021 12:48:42 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.50.245])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Sep 2021 12:48:42 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        peterz@infradead.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com
Cc:     maddy@linux.ibm.com, santosh@fossix.org,
        aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, tglx@linutronix.de,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com
Subject: [PATCH v5 4/4] docs: ABI: sysfs-bus-nvdimm: Document sysfs event format entries for nvdimm pmu
Date:   Tue, 28 Sep 2021 18:18:34 +0530
Message-Id: <20210928124834.146803-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6vqiGTjGIiT5nhz1KivSxMLR6mekFC9r
X-Proofpoint-GUID: 6vqiGTjGIiT5nhz1KivSxMLR6mekFC9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Details are added for the event, cpumask and format attributes
in the ABI documentation.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index bff84a16812a..64004d5e4840 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -6,3 +6,38 @@ Description:
 
 The libnvdimm sub-system implements a common sysfs interface for
 platform nvdimm resources. See Documentation/driver-api/nvdimm/.
+
+What:           /sys/bus/event_source/devices/nmemX/format
+Date:           September 2021
+KernelVersion:  5.16
+Contact:        Kajol Jain <kjain@linux.ibm.com>
+Description:	(RO) Attribute group to describe the magic bits
+		that go into perf_event_attr.config for a particular pmu.
+		(See ABI/testing/sysfs-bus-event_source-devices-format).
+
+		Each attribute under this group defines a bit range of the
+		perf_event_attr.config. Supported attribute is listed
+		below::
+		  event  = "config:0-4"  - event ID
+
+		For example::
+			ctl_res_cnt = "event=0x1"
+
+What:           /sys/bus/event_source/devices/nmemX/events
+Date:           September 2021
+KernelVersion:  5.16
+Contact:        Kajol Jain <kjain@linux.ibm.com>
+Description:	(RO) Attribute group to describe performance monitoring events
+                for the nvdimm memory device. Each attribute in this group
+                describes a single performance monitoring event supported by
+                this nvdimm pmu.  The name of the file is the name of the event.
+                (See ABI/testing/sysfs-bus-event_source-devices-events). A
+                listing of the events supported by a given nvdimm provider type
+                can be found in Documentation/driver-api/nvdimm/$provider.
+
+What:          /sys/bus/event_source/devices/nmemX/cpumask
+Date:          September 2021
+KernelVersion:  5.16
+Contact:        Kajol Jain <kjain@linux.ibm.com>
+Description:	(RO) This sysfs file exposes the cpumask which is designated to
+		to retrieve nvdimm pmu event counter data.
-- 
2.26.2

