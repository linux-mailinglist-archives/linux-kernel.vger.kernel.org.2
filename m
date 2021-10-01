Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88141F3A5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355349AbhJARyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:54:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20220 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353901AbhJARyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:54:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191H6bJZ016182;
        Fri, 1 Oct 2021 17:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MyWftJrsmTMfly1OMkvuLEIsUppsWujUQTt12O7qRsU=;
 b=RY0ETUv+5w6Z2dgd/EOKX8GAalYH8CVdHeGBpXEEp8Ic0dyPVMlETer58xGFqx9A7kc0
 BnIqKf8khHfw8/rdFDtq1p7wHlx5Tf2FNxhDN3stjXiTNWZRliSKH3Qd+uALfFZs4wI9
 eBeNYlw/rSMsrm5HG6UcvluucTlx4TP+CnjewE8x72mP1GDP98AOXc22zzNTscyi0pML
 5WI0oZzClEaEV/KKmPOdwkfk0p5TRsp9MmB/+rPODjZ0I2HC0t/4hv23v5GB3jdvJ7AJ
 IlLW+2VSDZai4Rjb+VWiwDQaDBliqw964OMy3TBdtCkArlIjzeOyBO26GMx8CitHw+TY gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdds88wse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191HkMnd108954;
        Fri, 1 Oct 2021 17:52:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3020.oracle.com with ESMTP id 3bc3chup8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 17:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZoyValffEDdxg6gNSMR1n7a4FTCgkpFgzfnMejr8vXz78tWJAJXMtrQ+fnmJ8JJRiyo0ahPh3M+VLC4jQ5oqK+dUNbD0csT0MIe66mLmV4VH8KKwbl7lFudNCtC0CjfF8SN6SAo9ZDGpRFV6x4xm2XnTtqUjtRub32TsIB+44OLO1A0dDhPcPx0MxgELy3cU3pr5Sr18rXabCC+Je38Imi+ItyruiwenTI4ZeTf1ppZ7YDlv+Qrb+dwI67qlWPozCk6oMAlwp3lEENJrGyqEDeDmDwXabek8wYhrKOLPUG25/ZXY0B6uCwSwjGGGZHnpT6wDyKuT5cCQ9HBD9GeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyWftJrsmTMfly1OMkvuLEIsUppsWujUQTt12O7qRsU=;
 b=d3mmRcAoShcGZ1tMscfMGsRYkjCfM8G5JbLilwVyLqoojI+uEoYTFOQEb1hIyEPr1jwHh1q9xuDo3bOM8Za5VnHgkwgXHLp5++yFZLLzASh60mdu9t0s7XFzftLSumP6QF3duxuvKVAqHL6B5n3Q9q87Y0yEKPLYgAQOcDbAn0HqblbSYQpI8XJuG7uMde9dcmPGT15G/zt33MqXKg3+0KJp9Z/70DA4D427dFKwO81NWU/ILD4MGRS6X0wSdz3zAdPNER0HR1T/DmpmbPYTf6tFMS6Cv3gLPoglHeY/p9iI0ODVMWsq372l7PbCVkS/zPr+YXyxzcna4Jj3Mr2sjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyWftJrsmTMfly1OMkvuLEIsUppsWujUQTt12O7qRsU=;
 b=xFiV39npSbSO9M9PH/0rR1exbds5JWwzwz3//Bw2DJbwhHFQIZGgEzJ3fhQ512UoN1exSS8ptfG8iEoceHQEw+/EV0oUsSZaMWm8zVLIpOa1xTOlYCbjJ4WLtj+YlFWUY1iyJQ2HP46aEED1TNcTIO+0CiXZuMEi2EBEgleiGIg=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 17:52:30 +0000
Received: from CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73]) by CH2PR10MB4200.namprd10.prod.outlook.com
 ([fe80::9516:b37d:b134:1e73%9]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 17:52:30 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 0/5] hugetlb: add demote/split page functionality
Date:   Fri,  1 Oct 2021 10:52:05 -0700
Message-Id: <20211001175210.45968-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0060.namprd22.prod.outlook.com
 (2603:10b6:300:12a::22) To CH2PR10MB4200.namprd10.prod.outlook.com
 (2603:10b6:610:a5::9)
MIME-Version: 1.0
Received: from monkey.oracle.com (50.38.35.18) by MWHPR22CA0060.namprd22.prod.outlook.com (2603:10b6:300:12a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 17:52:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba42ec89-2296-4b6f-e361-08d985043d43
X-MS-TrafficTypeDiagnostic: CH0PR10MB5177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5177FCE92B885C72782538DAE2AB9@CH0PR10MB5177.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoHunIh2/oqCU7BCZ4kP5W72LfYqOCE6kPc0LagWSwYgnF/1RfB7wFWeCp9Z+eT/ziPZIN/36/8Ud1yRXYIs+b+6IR/k22n9Oe0iVxHK0lUlHYf0rzmx2LtSyEEq3E9cJoUnKVLmiu5deLOI3x2aDMXhlbxS4BAoSkeYu7UA9vNdureCIYGroQpapEsTdo7yBxYgNMRG72x4JKYAqBknOEK10Pr1J98XAVVM34AxUrf+Ey2mlCXQvdXkt+HYb6stClZnuJBVJcGjtCw+6E27CRn2ozs5tHg3au/SczorWgrEi8lTHPJ4C+u3GOiwRYZFpH2+yFf/odHD3+dn7Ba7zNjyO/gaGSLrU+c0uBwa+YPs/m2JrnDR961JilYGRGNhdPeAZz+TiVOWmYiGvupKPL7O1jd6lYYYd6zeHkKzOe24Z/s8kxW51hFsOamoK814AvVe9hIaQBerEC3kKHNUVkh+hTB07KheTAXEsP6qRFOl141iDm6fHCkIEaa6OiAHssL+BLnWVO7VV3O7JApzUsb6NGi6+LXvRxbmMX1veZM3BwO1QcNCZjbOlQZa573ssvG9bSJ0ETyWcnevGXpkfBao66meIpR1bNTpODS4ODm4jFJ7WV2nhgy7Chgm9UbTnV5nV0ml2F6eCT6Mz+vLIwdmt8flSOib1YCVH+yqYeMzvoJ3b5DP6AOkpmJp05mKgJ2LfSSc5VA0Latl3Y0Yjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4200.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(2906002)(52116002)(107886003)(83380400001)(1076003)(7696005)(5660300002)(316002)(8676002)(38350700002)(4326008)(86362001)(26005)(66556008)(66476007)(54906003)(6486002)(36756003)(66946007)(186003)(44832011)(8936002)(38100700002)(6666004)(956004)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MP6lWdbthR2XOTixf/PCQrJKrm4tFOwoA57OyTwZOzBmxuTUqFKS/vCZSE2r?=
 =?us-ascii?Q?8Co5SJ0x054HOMew5t37fyTSTaJUPr3Jcuk9EAXGbXTn8fyjOLlhjBWDA+pb?=
 =?us-ascii?Q?EiNDAWdF5HsmqCbXo9GTNwqf+zONgylNvxqMCwHbXbsgMPPHfeTJdK85qyLx?=
 =?us-ascii?Q?fzPbhW/CudM3iHarNSl3caglr5knOQVzXCeEwiXOeUrUPmVLK1zRXUDPmrC7?=
 =?us-ascii?Q?oIJXMoFvvHO2aVjxkwhUd6Yq/+U+hNm3gNk0JJI0M/VZls/MaD3QXUtDpAj/?=
 =?us-ascii?Q?eCrt+mf83x3BQ/nYa9YbF7g8TWYNsBT6m8LsMudWr2Lly1eLjxDPQMltRwwG?=
 =?us-ascii?Q?ckw0X9R1tYvR10059e12/GTKRlFDa2u/6korVj44FmQ6qa0cbfv4lZ+Ua5UX?=
 =?us-ascii?Q?31J17Vl61Nd5FlVDY8j5N4qQzvzratmBKjA3k4HU93IDqugmttkVMPUpxu+D?=
 =?us-ascii?Q?+tSh03UYo0fwNeR3PruaMr/1PwKPsMFEecfd8L7vgCupJRM9g5CYKs4JDaig?=
 =?us-ascii?Q?OOlOZpuoDui63cZW+qdfU7dYlf9YE2nZyypHkg2Y9TURQUkmj/euys46NnH1?=
 =?us-ascii?Q?cO8+yPZhvCiDO7hqwpmEp+hq0if2lq/J/Cwhn5I75iEu0hJEeDDyaX6LhlkN?=
 =?us-ascii?Q?yfc08SdN/U34vz9+bHWrBWeSyOiN+FGxcb2z/PhKTfEN0piBLvubKfAHF0kg?=
 =?us-ascii?Q?cxD8lHHnNU5AoBQaD9TESFBjHEmbgWX7rcQVmeA+G8O2vKVeUhLKii+CynZ3?=
 =?us-ascii?Q?jv59C4thYJJefHnCdxX13DZwCoNyCHunbb7dC6abCLkCWQ9UbfuN5lvwBaPx?=
 =?us-ascii?Q?V09O/mi8OCBFP6a6cdrQO6kGXfqPVZ2O0ilk/j1uvSS4XJpcAGZCxbc8531J?=
 =?us-ascii?Q?pmXRG42HaX2AJNhG4cfvIKmmFPU/zKcTXwL7LOQxsWmHkXDZ8Pbg+A3hXPXT?=
 =?us-ascii?Q?mO1qRZoaRa4FLUpjL+C+9IlxF4XY5EqcJ2TXhSoFulcoioRTNb9b2U6fHrZb?=
 =?us-ascii?Q?9LiHNoyC1iTGEvsfajuKuW3QlmCXSHpItd0/pkm+lFGpksQKblIGv2ToWpFW?=
 =?us-ascii?Q?DEfHxkU5+wQRl0YawTuaHfAhUQ3mPXT8clvG779Df0s1b1/ziPWEWSPLXC3p?=
 =?us-ascii?Q?BwcH40l6KQzd+Zx0lZ9NA576eFU/u4JInX4qZKmPd/JEnhLOnN2NzG03lF5n?=
 =?us-ascii?Q?yf/MdstRc37NTevEX+mHbi0g5xplKaEykyh19ps8DfR6vz8JzYlOcfACqONp?=
 =?us-ascii?Q?fLtImvqDB1axb9iYFjsT3rvZfAOMzMnaMixR578wl1XJA1abVjQPFBRUocay?=
 =?us-ascii?Q?uEG4/jSbHI33cuv0XGmslBWA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba42ec89-2296-4b6f-e361-08d985043d43
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4200.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 17:52:30.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f18dQBTgg76ZSyPVj+MFiSPfzehXcvXHl834JDqU0hLNklxX5F9NC2kYkY8khOmzL3PbSwui32AEp5pHdiUL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10124 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010127
X-Proofpoint-GUID: NvzdzmAI8tisrBuMQvKOjrnju5QYTWvg
X-Proofpoint-ORIG-GUID: NvzdzmAI8tisrBuMQvKOjrnju5QYTWvg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The concurrent use of multiple hugetlb page sizes on a single system
is becoming more common.  One of the reasons is better TLB support for
gigantic page sizes on x86 hardware.  In addition, hugetlb pages are
being used to back VMs in hosting environments.

When using hugetlb pages to back VMs, it is often desirable to
preallocate hugetlb pools.  This avoids the delay and uncertainty of
allocating hugetlb pages at VM startup.  In addition, preallocating
huge pages minimizes the issue of memory fragmentation that increases
the longer the system is up and running.

In such environments, a combination of larger and smaller hugetlb pages
are preallocated in anticipation of backing VMs of various sizes.  Over
time, the preallocated pool of smaller hugetlb pages may become
depleted while larger hugetlb pages still remain.  In such situations,
it is desirable to convert larger hugetlb pages to smaller hugetlb pages.

Converting larger to smaller hugetlb pages can be accomplished today by
first freeing the larger page to the buddy allocator and then allocating
the smaller pages.  For example, to convert 50 GB pages on x86:
gb_pages=`cat .../hugepages-1048576kB/nr_hugepages`
m2_pages=`cat .../hugepages-2048kB/nr_hugepages`
echo $(($gb_pages - 50)) > .../hugepages-1048576kB/nr_hugepages
echo $(($m2_pages + 25600)) > .../hugepages-2048kB/nr_hugepages

On an idle system this operation is fairly reliable and results are as
expected.  The number of 2MB pages is increased as expected and the time
of the operation is a second or two.

However, when there is activity on the system the following issues
arise:
1) This process can take quite some time, especially if allocation of
   the smaller pages is not immediate and requires migration/compaction.
2) There is no guarantee that the total size of smaller pages allocated
   will match the size of the larger page which was freed.  This is
   because the area freed by the larger page could quickly be
   fragmented.
In a test environment with a load that continually fills the page cache
with clean pages, results such as the following can be observed:

Unexpected number of 2MB pages allocated: Expected 25600, have 19944
real    0m42.092s
user    0m0.008s
sys     0m41.467s

To address these issues, introduce the concept of hugetlb page demotion.
Demotion provides a means of 'in place' splitting of a hugetlb page to
pages of a smaller size.  This avoids freeing pages to buddy and then
trying to allocate from buddy.

Page demotion is controlled via sysfs files that reside in the per-hugetlb
page size and per node directories.
- demote_size   Target page size for demotion, a smaller huge page size.
		File can be written to chose a smaller huge page size if
		multiple are available.
- demote        Writable number of hugetlb pages to be demoted

To demote 50 GB huge pages, one would:
cat .../hugepages-1048576kB/free_hugepages   /* optional, verify free pages */
cat .../hugepages-1048576kB/demote_size      /* optional, verify target size */
echo 50 > .../hugepages-1048576kB/demote

Only hugetlb pages which are free at the time of the request can be demoted.
Demotion does not add to the complexity of surplus pages and honors reserved
huge pages.  Therefore, when a value is written to the sysfs demote file,
that value is only the maximum number of pages which will be demoted.  It
is possible fewer will actually be demoted.  The recently introduced
per-hstate mutex is used to synchronize demote operations with other
operations that modify hugetlb pools.

Real world use cases
--------------------
The above scenario describes a real world use case where hugetlb pages are
used to back VMs on x86.  Both issues of long allocation times and not
necessarily getting the expected number of smaller huge pages after a free
and allocate cycle have been experienced.  The occurrence of these issues
is dependent on other activity within the host and can not be predicted.

v2 -> v3
  - Require gigantic_page_runtime_supported for demote
  - Simplify code in demote_store and update comment
  - Remove hugetlb specific cma flag, add cma_pages_valid interface
  - Retain error return code in demote_free_huge_page

RESEND -> v2
  - Removed optimizations for vmemmap optimized pages
  - Make demote_size writable
  - Removed demote interfaces for smallest huge page size
  - Updated documentation and commit messages
  - Fixed build break for !CONFIG_ARCH_HAS_GIGANTIC_PAGE

v1 -> RESEND
  - Rebase on next-20210816
  - Fix a few typos in commit messages
RFC -> v1
  - Provides basic support for vmemmap optimized pages
  - Takes speculative page references into account
  - Updated Documentation file
  - Added optimizations for vmemmap optimized pages

Mike Kravetz (5):
  hugetlb: add demote hugetlb page sysfs interfaces
  mm/cma: add cma_pages_valid to determine if pages are in CMA
  hugetlb: be sure to free demoted CMA pages to CMA
  hugetlb: add demote bool to gigantic page routines
  hugetlb: add hugetlb demote page support

 Documentation/admin-guide/mm/hugetlbpage.rst |  30 +-
 include/linux/cma.h                          |   1 +
 include/linux/hugetlb.h                      |   1 +
 mm/cma.c                                     |  21 +-
 mm/hugetlb.c                                 | 307 ++++++++++++++++++-
 5 files changed, 339 insertions(+), 21 deletions(-)

-- 
2.31.1

