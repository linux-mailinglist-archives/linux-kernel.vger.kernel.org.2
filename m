Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D912390CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhEYXdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:33:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34374 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhEYXdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:33:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PNOguC084767;
        Tue, 25 May 2021 23:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=9YhdL/k2pa6x8WHpZUlXfQ+hZShDsdX9onfMwZ34WFw=;
 b=axBQZJfib9AcHx4ZnHa9RuaSJvjEoUMfCymM0Tcn8/e0UBjiJDtuDZYTf6JVFl2UH0ye
 7naAot3vpsBxj6NKxy5bJUPkOyX9+94fg8WTrDicn2wzMzwntPuO0r0ReHYt1QUo/ph7
 o3jlhfr3gUcrEe7i5XMwY1MtvEs+AUhIij2onsLWHPGoDEEeOAnjhfYh/qNqbZZukRrw
 9yj/yuJ0XsioCjNNTYJf8A5XYr9BA4KCq3uPQLUIBCreIWNX6LWpI9XFjcHZPhUzxR9v
 q1pLdSwihDBUg4alK51izlpTSxbmLBum7rtwIsPW9hWPKGDZrYK4lF1YHVbLncohbakC ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 38pqfcfhrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 23:31:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PNQ58l086196;
        Tue, 25 May 2021 23:31:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 38pr0c7d22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 23:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVFyu9DRXK85NijGg41BAimwWG+9s0ek5vRyJbCSc40iWtuc/3Hrlte1Q1UaBy0R/9uBUVkQdZRLdibu8mHZpA5ZYJWi8OMQqHWpj3N04UWFiOWfUqFsZDQpl0VN0MlWIYxGOXN/d+rMUn2OeweaPely4PYZNfoQfLrF8wzaMOav/3/7Y2vxb7Vs6lBJR1dNLVU56NhyBueOMZeXksKILLwCZqNRqWJUMNxg68Gf6dH0sWYz8QEAya0TYUx1sMH8eNffN5CN3z/bXeO9s06qNPDlzphae1IXO2QdyMC3fYljtt72+Hy2NNLrmWiJ5kzHV3P3bakUzKM3VbJNGlDp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YhdL/k2pa6x8WHpZUlXfQ+hZShDsdX9onfMwZ34WFw=;
 b=SE65pN5E9wgabHkJILt+HtLKfaA+w/cuY7D3O8NiDw6Ya+XtUROU+/Z2BzcQVDbE0FWdUN/KEA4ncMZX/4xIYzUUGz/tDq2AYksp8FRofOiudEPbVzHy+g/sqEdYdHxwDVUDL0O5SVAWJRSEV9x/oXHn/UaM/7PNzvHqcbfFAGS54pHgQ0z8VoUlP1ssm6NdkroKuKCRQrq9PC1zHcz95N2bxTyzMPjCYxR7HnqO5d4yJ79NRKDvw6Gn4bCjostwg2WrM58+oBROs1dFsfZDbuNYFq7xFvN5w/zzR+8+oJkNagcGyfd7Igm7cFqujAQIAx76WUO+uEBlkvxZiXhVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YhdL/k2pa6x8WHpZUlXfQ+hZShDsdX9onfMwZ34WFw=;
 b=aXenvG34OrW/hiAZI1eX6KKWPTYVrsV7xYSgn+RPeWNWiqa7UlV4MMMVW46BnO585b+NN5JTlWksV1PfYpzKK7FdwGWKc57q3RgO3TQpstuzvqeZCTzqD4G6JVkgrJDd2RcaxrvOEdCsrH8/SbFcmhHoMzDpWtdFCsq46dFsMpo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2664.namprd10.prod.outlook.com (2603:10b6:a02:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 25 May
 2021 23:31:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 23:31:44 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Mina Almasry <almasrymina@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/2] Track reserve map changes to restore on error
Date:   Tue, 25 May 2021 16:31:32 -0700
Message-Id: <20210525233134.246444-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
References: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:300:16::31) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MWHPR13CA0021.namprd13.prod.outlook.com (2603:10b6:300:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Tue, 25 May 2021 23:31:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c878083b-69e4-4de8-3635-08d91fd54192
X-MS-TrafficTypeDiagnostic: BYAPR10MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2664F54189DCE54F3B80B855E2259@BYAPR10MB2664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: toIJMw7uBtKPZH8XSUAP/rHq90wX2Ppvl59MmXuat04ta0uzP890nfVnkkIACX1xeubhf6ZYqBwTEYJa+ja5nXj9mfv8oyFbjqD6BDr7xa4bLtyqyB39iOMUbcHUicOpON2T6hqSXH2yDJJjLcFTavlV0N5zcYvkCmAPiDc0fTIvA3yz1nbg21Xxx+gS4d8UOh9ymarDk3AL1543RnnM2RNmW5hKu0dVnO4v1OVvkVP/Cf1IDaBFG2HIMq7wl1MDA26Aq0VXLrdNZvFFH9jogmELyyLuR9VEIMMy/rZCEboV84LZpEwTfZhRvDyJcG1Tt20pMYYRCxRYdUcLA3Fb/LO9C+qx+kOt+g/nbAcadcItXa5Mdieztg5dISjmeYt4MkK8s1yUiKV/+LDn4FfAla1zKS7wfqn8hNPeQKN983PlXDMGgxC8pNYiq7qZyycJNbRC22a7pY+M2q7RgDADk6hsNooYlZjuoRuZo9t6FDQL/qd7cZer3zW6zOweKoJZWllKlkNJrYUKmN71KDRKgtfr1vbUuHZd6SX1wraQVyN2Aj9Hc3bkJCRGqBix0t1wrTNkzN8ofjdTJzej2nZiM7xj9VRCjxmIyTRVNpwEzyVm7edBGUccVM7z9SACY2M1E9buNj/up1W5JxxywuSozA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(39860400002)(396003)(26005)(8936002)(6486002)(6666004)(956004)(16526019)(5660300002)(107886003)(66946007)(66556008)(1076003)(7696005)(52116002)(186003)(4744005)(44832011)(4326008)(2616005)(66476007)(316002)(478600001)(36756003)(2906002)(86362001)(38350700002)(8676002)(110136005)(54906003)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?W2Q23CSLNBQ7DTSupDSljZ/PytaSUOVZyhH1CZU8ioKqTJTDQnzgroeyYVxR?=
 =?us-ascii?Q?qqrQudrMIbQefvgrynr5IobtVWVqOH4W2+WFiSHl7BDs++nPhZDSDeQ9UIy9?=
 =?us-ascii?Q?edlCBHmPsukfCftTwSYo/rVgEytQYHx+v5rQNgh8m+6xIbmhZVSShok9LkQQ?=
 =?us-ascii?Q?qZnfKpoVinVrS+d2SRtm9vreuVsx+ty2D2cmguKOb7eJCvcI2aCl8Ak0Tu53?=
 =?us-ascii?Q?6bq47/ZJQYODKs3OKa1Jr2jjPE1qqH2M1zHX5X8Uh2MwBPWuRt52PlTlKVjN?=
 =?us-ascii?Q?xnSA+YdfhxQxxV4MxNmBEnGJ4OWuAyNK7eS/Ma7+tsPT8LzfIaVJuNKHDcIx?=
 =?us-ascii?Q?8gHfAYcEOIBhavPMznmiMZBZ98KF93zrrTQ8+c5CVqEULYbLtJCRYLAcds3G?=
 =?us-ascii?Q?GBK+xvdIjatBFJ1ZZ0IUR7iyGv4GRSVPMjdpdhGxCZJyo+dYtgKc5/FyJHM1?=
 =?us-ascii?Q?P5qBUyfo0CuABJCKekT+CY2gody0dbVuJZkKlo6LhLuQr13kKM3xBEvOSZDK?=
 =?us-ascii?Q?W4nIhXiUwGc8qMKSfLazrXvAVgscfw6nvsc4l/akSuDIK07qQ9p0AgYB3JW1?=
 =?us-ascii?Q?3G8hG/TWAH8zJNoOQKo3WGq0uMGllHMcBQHNkLYFul9d3YooMhHb36/gleam?=
 =?us-ascii?Q?UFVn8plT8pzYam8xwEn9SyYJu88XjgDJ9af4a05DGyZeh3gWRGIs9q5JIfza?=
 =?us-ascii?Q?uyeYL7VBqJPZEPpKSRRsOrSCqaQ81bQLu1rC4HkHsaW2/zQi+T4da/zMDN2G?=
 =?us-ascii?Q?ptqvmtwCB4Uddha/XhdaEoywYkSlg9/VU/LZUjKYWf7vvp09v7hM7024HNK0?=
 =?us-ascii?Q?IfTMBq3vDvX1095wtzBDmsn4w4kJA23FVl3sChtHdQ7s41sHydPfgVcUuJhH?=
 =?us-ascii?Q?ma//9xhALV+6zQe3HrHgjxPbuwJUgsLwqvWzpWcpaZjdQLMisAwnaGtA0DR/?=
 =?us-ascii?Q?GNwWqela+3v3FNE6n2dp69ZTT3/RPuI1knbRUwXs6xO9gboiXEi80yiNLK9h?=
 =?us-ascii?Q?mtHP4kyN6Nl+FwiuRTCYamZgJEBwjP8isW+ZLJMPYq/+F64Ol78HiWK1i+31?=
 =?us-ascii?Q?bwDeKsmAfRmq9GbPOjIuBVLU6AnRWA8yyMV73pGuK81g+exQCKAAUXKcMEJL?=
 =?us-ascii?Q?Fsjkaovp484welYVSE8GUFtM2z9+mSk0nk5RLdj0TbSa0CYdToIY3zIFP9rS?=
 =?us-ascii?Q?1Sx0xzyjKy42jQpcZL31VO7w4uG3OtSoy1LICHk75fb+zkrv8ySPgEVJyHpz?=
 =?us-ascii?Q?h1FBN2n3hHSUbnd5AmHHcJRnN8Jmz7p0w6u2HjlVCsfAl7IJA32AXJ80/ceX?=
 =?us-ascii?Q?Ruafz0c1X8Tmlo9Nn+2/EgMl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c878083b-69e4-4de8-3635-08d91fd54192
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 23:31:44.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FghDGk8cPRuD1O2jqb42mC/WBvEhjw+08j2leP88Mni0JKDikN2ewXk2r9e2i+kcyOZiwkkfLZADsKC5aCKJsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2664
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250144
X-Proofpoint-ORIG-GUID: -3LmhE-vADd5TzG6ucuY_H1MLywHMwjp
X-Proofpoint-GUID: -3LmhE-vADd5TzG6ucuY_H1MLywHMwjp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a modification to the reservation tracking for fixup on errors.
It is a more general change, but should work for the hugetlb_mcopy_pte_atomic
case as well.

Perhaps use this as a prerequisite for your fix(es)?  Pretty sure this
will eliminate the need for the call to hugetlb_unreserve_pages.

Mike Kravetz (2):
  hugetlb: rename HPageRestoreReserve flag to HPageRestoreRsvCnt
  hugetlb: add new hugetlb specific flag HPG_restore_rsv_map

 fs/hugetlbfs/inode.c    |   3 +-
 include/linux/hugetlb.h |  17 +++++--
 mm/hugetlb.c            | 108 ++++++++++++++++++++++++++++------------
 mm/userfaultfd.c        |  14 +++---
 4 files changed, 99 insertions(+), 43 deletions(-)

-- 
2.31.1

