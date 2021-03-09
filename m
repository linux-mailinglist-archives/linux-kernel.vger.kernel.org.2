Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1368A331B91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhCIATm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:19:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58204 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhCIAT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:19:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1290D9FO094007;
        Tue, 9 Mar 2021 00:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MICUnid9N43fmBJin4Kkdo4WcYEMvjVS4+9tlLcjomw=;
 b=UxfG2w9ldeUre6M+V8gnkXv2kDh3L8hZDBTurqSv89N7cv4IHdAdvDQ91AKswZZhxrFa
 c5e59f0jx4DCwE/nI8As6MXKureBlu+c2/i/VcBqXVAJp1Slugp8OU9KrxUgtUIrlpcG
 CCJWTLaNpApKjsGgTsz1z/CJqj3qL4jXk7uVVV8A6Z8SlVYoUzFjHlFY3EBiRxpzW+Gk
 GssQIB8+0H8whNKTGjXnvBVho3cu5u0GIBolqG2b5xNVGSDuafCMoj1tMZ1ELyZM4mVR
 PyoxOKEHFgtIhTlNCUxG2sSrH6RueEsy5qqbT24c6ravDlKZa7pZ3BadgAGGrfYSDruT Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3742cn5gs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 00:19:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12904wlv053216;
        Tue, 9 Mar 2021 00:19:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3020.oracle.com with ESMTP id 374kgr1w52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Mar 2021 00:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StzkWcAxIAQFP0r62IYC1gP2+FgzU0VvXtlDr8PQjY/dLvGHS1gumgpQz57KKCy7+EMDQMzz/uG1R/ZZNpBlw7F3YTVM7WNdcbFq9KqoPj8GW/me7sv3Ajhs8MkNcc9cDOCawWBE9QRy4CN07KHamJ/0DCZ4Fd8Mx43v/3ilTonTeSIgUzN3SxPn7Jx7RTr1rIexrLG6a8yqIdpQa95gJbZEH6cpvtmgV8ilJnNfO80luKWay9h1uZWQ6u2xEQvUIt1KbfBcA6TupySH6mwmX/8cB0S9BxpnecyTZYTRieJ8Wh0vpTDSKT4S00IgFLxSi+rQFfRmL3435+XS/eEG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MICUnid9N43fmBJin4Kkdo4WcYEMvjVS4+9tlLcjomw=;
 b=d/iMLNCVY+TWsji3T+fVHv2PmZM/2s7bKm92k8um6x7yOhjADbWfPEsYw3catdM3MD9JjsMGZ+cSNPEchinkGhiyQsFxGOiwWeSG1OAEqvZcTRLUfIszxkrwJg3EBBGmDsJMXMaA/156izcfXPCo6YIw9pdZjTRrhbgAf+ezk5w8Az/lE2gDJwjcds5nw3/aOyz5OK/KwiM5UkHfuzLWaq2v4BvE6W5bfCkXPVn22S9Gw072Dj3/rmKKrgAHQE3LuYxhQyje+/J63uwK7sUtQekft7NQ0XZuUHUhYkqe4fRPUGz/HAZbsNSuP3Rw8xvygihp9/YFAsuGCxJOcFVYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MICUnid9N43fmBJin4Kkdo4WcYEMvjVS4+9tlLcjomw=;
 b=Up6IunB7WsPdO2p3NtQIe48O4ybhxXmzIwT0kp0c0l4rRT68SeoUKxiEMe6SXGNCBMy5+5wMeuOsHZgq+npxAeYx75FI7PfUiRwpp6ZRJHN7XHsYDSYOlc63bFGZTND04MOg9pLgrgiEFI6KZ1uHF2lUFf0g+ps3/C87/HrRICI=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3301.namprd10.prod.outlook.com (2603:10b6:a03:14d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Tue, 9 Mar
 2021 00:19:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 00:19:06 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
Date:   Mon,  8 Mar 2021 16:18:52 -0800
Message-Id: <20210309001855.142453-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:101:1f::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by CO1PR15CA0050.namprd15.prod.outlook.com (2603:10b6:101:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 00:19:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 818183d3-2340-4acb-3054-08d8e290f355
X-MS-TrafficTypeDiagnostic: BYAPR10MB3301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3301D7FE229F5024F23E3932E2929@BYAPR10MB3301.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Usx92/pvfVWR2QjXvcJ+IytSjRAUB1Wx95MowZOhyFO6IK5B3jQT7kYhyiL1QKE1sZC0FEruo1B7SjTVrezeYB8puHtO8/cJlWKhaP2j2H1/kECkV+rYNEm8gNnq313X00JIu6TE5cWsaBcQWlAe+AHqIlUJjLoVi2/i3MKsz0qbk4hMwsB+Kc0PT+V9VtoSpVq5fBvInL0/5+ANL+KaR76bwEbSVKrIe+S+N8szVI+1DJXbt1DXfIwi4qfVUmnXnfDNvYHM3R38tF3PNYkGN3cpADbg7wnL+0IRir9+ACA2u3dh+tLS215OQxbTfTRdtxx7Os4xcXilFEtVBCryGTrabCajZJZcOEIRPk9RH8lYOFwXQXKzKOB1OT53J2Z8ukWc4bDP6AUvoXjrrKcabjjzX4CBEs6bh5wTjwP8iX71CHV6zZZ39rkd7dM3QsXqYfKL4oKMT4CQWeTB1mettydAnOOvqcRPrmiFk3n7MOEKGaeI2fyLnhhaxn6nxynWxrEvNuTn4ULQhI6TCU1Nrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(36756003)(186003)(26005)(2906002)(44832011)(2616005)(86362001)(16526019)(956004)(66946007)(5660300002)(6486002)(7696005)(52116002)(316002)(478600001)(8936002)(1076003)(6666004)(107886003)(8676002)(4326008)(66476007)(83380400001)(66556008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ee7+oTQbsWEIPMEvRCU3EF9jcpKXfdJM9v4R+gU/7p5JRnismu6ahzikpz7H?=
 =?us-ascii?Q?DsCB+dJlhuSit/00ZlIqJbUR3sbxPME+RnDM8raTJPxHBSryIZG5eDJRf716?=
 =?us-ascii?Q?Z+9Z64p025+8ZFzTpHzH8dcpSuuRFvoyjtmdB609/r3sv6qa43i9CZabrV/3?=
 =?us-ascii?Q?PE+CK0J2I4Gb2OAXw9Oulb20I+CJzzswHoiRIylPF6J1z8vv9cykY5JE12ln?=
 =?us-ascii?Q?256mMmwk/rRlhxRJwGOqsBNVjK3HmUnCydjjIWQX98RxdHysEIzl8EIkNueO?=
 =?us-ascii?Q?rzOlZ/UHnKDSnrzUCAC2qgdfleLll6LXFjc4lAqhxBc2NFQQdAjuXODh/A0t?=
 =?us-ascii?Q?TVb+lOuV1nq+wp5ZmpRvQoPuB+FAMKZwfQXPaE7RNyeHECjUmMxeWgDeHfSW?=
 =?us-ascii?Q?av/yCh8OXjR1ACYjZ67Wu4KO1EQkO1Mk3AI84qXdGvuG/PEJZiW+cuYilccp?=
 =?us-ascii?Q?qZ3fyWg2kHDuLyA75jYY7CvjqVbpbpezGP31K1f7AKDI+dIXYh5y1PYqYdW9?=
 =?us-ascii?Q?B6W+Uzms96qG0ddViYyFmy1drXoHTxHKfDK7fOvkHLptV5r7wsxpA13VVF/T?=
 =?us-ascii?Q?gZktoIZ8OQWQYN5JFySM+XwIZ6I5m6aPrx2V0ganofY654TLn1OC3RDM1fF1?=
 =?us-ascii?Q?JYLRcFwEsY1Q78CfrA/aKZiBsh1hdGyf+VPkcGbyEUtQVCCdFo5RqV4uWZ7I?=
 =?us-ascii?Q?1IM30IQnRC9iZygkIYJye/6AzHndDCInZTuMadpB1kkjhTOMDYHsKqhTURxt?=
 =?us-ascii?Q?J68Xyk/ZgkhvOJLJg+M7cw8WUbDguEadIAVj/2QhmFpyus9GJLAgr7D1VFZP?=
 =?us-ascii?Q?dbSubaJLjfobnPrV70VpiLEX7vaGaHa7wcDKia1M4oSkP3O8i7ZmPwBhrANg?=
 =?us-ascii?Q?4zvUMdc0Re+aL0uBR9NuKvAN2DgyPcfhdhySoFqLKvFyBm7XFIjikI5AB5QV?=
 =?us-ascii?Q?q5e54Utg8td/o8emiaBJfBgpx+CwFRdQoyFxDnHoV8+uJWysnUCyn+r6tpcn?=
 =?us-ascii?Q?9WM0QgD+Jrmi45J9gma0kj5HiPs9GUoLZCyqJMRwf+7Sach8MDx7ZogFIVLi?=
 =?us-ascii?Q?marjTlay+xwejvdp1kjZZhk0n1DVfnlqTqmktJrocdcu1kZ9+/dmfSlXq6+w?=
 =?us-ascii?Q?aXV0bcfKWEFmq0iZ6a7waboEdvAT5isw1AYepTk+BaT25uNeSMYTSwRtCNJm?=
 =?us-ascii?Q?qIeVj52Kfb69VmN8gy0UvIG0+8iblXlYto/MXAhDsr295z8TdiV8TValx1hu?=
 =?us-ascii?Q?GqurmQMLVNfYhCEvYFVOkBjhOxrIygFPatHhpN/Hlst50q+xy1Ui8/oguyNd?=
 =?us-ascii?Q?/wyvm3jBXOG8EXz9R/AE08DE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818183d3-2340-4acb-3054-08d8e290f355
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 00:19:05.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hiln9ZvmpJHjI1OwUTao1uLqnwdgxl6d97+PP9J7s+G9PYZsQanqvmQscEydpRiFaprpOE9FPpyCLGyUHVECKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3301
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=857
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9917 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The concurrent use of multiple hugetlb page sizes on a single system
is becoming more common.  One of the reasons is better TLB support for
gigantic page sizes on x86 hardware.  In addition, hugetlb pages are
being used to back VMs in hosting environments.

When using hugetlb pages to back VMs in such environments, it is
sometimes desirable to preallocate hugetlb pools.  This avoids the delay
and uncertainty of allocating hugetlb pages at VM startup.  In addition,
preallocating huge pages minimizes the issue of memory fragmentation that
increases the longer the system is up and running.

In such environments, a combination of larger and smaller hugetlb pages
are preallocated in anticipation of backing VMs of various sizes.  Over
time, the preallocated pool of smaller hugetlb pages may become
depleted while larger hugetlb pages still remain.  In such situations,
it may be desirable to convert larger hugetlb pages to smaller hugetlb
pages.

Converting larger to smaller hugetlb pages can be accomplished today by
first freeing the larger page to the buddy allocator and then allocating
the smaller pages.  However, there are two issues with this approach:
1) This process can take quite some time, especially if allocation of
   the smaller pages is not immediate and requires migration/compaction.
2) There is no guarantee that the total size of smaller pages allocated
   will match the size of the larger page which was freed.  This is
   because the area freed by the larger page could quickly be
   fragmented.

To address these issues, introduce the concept of hugetlb page demotion.
Demotion provides a means of 'in place' splitting a hugetlb page to
pages of a smaller size.  For example, on x86 one 1G page can be
demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
- demote_size	Read only target page size for demotion
- demote	Writable number of hugetlb pages to be demoted

Only hugetlb pages which are free at the time of the request can be demoted.
Demotion does not add to the complexity surplus pages.  Demotion also honors
reserved huge pages.  Therefore, when a value is written to the sysfs demote
file that value is only the maximum number of pages which will be demoted.
It is possible fewer will actually be demoted.

If demote_size is PAGESIZE, demote will simply free pages to the buddy
allocator.

Mike Kravetz (3):
  hugetlb: add demote hugetlb page sysfs interfaces
  hugetlb: add HPageCma flag and code to free non-gigantic pages in CMA
  hugetlb: add hugetlb demote page support

 include/linux/hugetlb.h |   8 ++
 mm/hugetlb.c            | 199 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 204 insertions(+), 3 deletions(-)

-- 
2.29.2

