Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764E731FECF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhBSS37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:29:59 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:8782 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhBSS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:29:54 -0500
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11JINR7V028016;
        Fri, 19 Feb 2021 18:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=+yteBGQhTSmN52lelYK5WiyBCGtEKupWRyLUK8gtESs=;
 b=H4uJLbRzspu5e4MT0IAODBRcbDg1uAIDfGyUpzZvDiMzmagy8bprB0rVSoUz9gcfHWMr
 PtXVJfSvjaoNbmsH2i0flxJTgX+2vQNAAJpuawAY8Ldu0a9x1TtZrIy3wjxEZhLHvLjD
 qhf2ioGD8rJgdw4zDBwCWYW5vK+YRWZdy52FWFrRJdh5D9yxwF4Gk40PSmvDf0FGYMG0
 WvTaJjkovzmh9LWpPYfqDoAe2NeYFgQxOsf/zi7eWKb2DtDVRfWfo2rJuEXiHNv8CSin
 ZLQ33uJKgh2Fu6neBMN7VO4NqsLUGP77LzL9xmCpVOfbidQDzD0diZn3s7GwWRsDmKbD 2g== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 36s65q9k05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 18:28:54 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 455014F;
        Fri, 19 Feb 2021 18:28:53 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id DEE164B;
        Fri, 19 Feb 2021 18:28:52 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 605001)
        id 5DEA730001CF0; Fri, 19 Feb 2021 12:28:52 -0600 (CST)
From:   Justin Ernst <justin.ernst@hpe.com>
To:     Borislav Petkov <bp@suse.de>, Hans de Goede <hdegoede@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Tom Rix <trix@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Travis <mike.travis@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: Fix indentation warning in Documentation/ABI/testing/sysfs-firmware-sgi_uv
Date:   Fri, 19 Feb 2021 12:28:52 -0600
Message-Id: <20210219182852.385297-1-justin.ernst@hpe.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102190144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit c9624cb7db1c ("x86/platform/uv: Update sysfs documentation")

misplaced the first line of a codeblock section, causing the reported
warning message:
Documentation/ABI/testing/sysfs-firmware-sgi_uv:2: WARNING: Unexpected indentation.

Move the misplaced line below the required blank line to remove the
warning message.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: c9624cb7db1c ("x86/platform/uv: Update sysfs documentation")
Acked-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
---
 Documentation/ABI/testing/sysfs-firmware-sgi_uv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index 637c668cbe45..12ed843e1d3e 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -39,8 +39,8 @@ Description:
 
 		The uv_type entry contains the hub revision number.
 		This value can be used to identify the UV system version::
-			"0.*" = Hubless UV ('*' is subtype)
 
+			"0.*" = Hubless UV ('*' is subtype)
 			"3.0" = UV2
 			"5.0" = UV3
 			"7.0" = UV4
-- 
2.26.2

