Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8983AFAF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFVCR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:17:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9184 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhFVCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:17:27 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M2BLFU029326;
        Tue, 22 Jun 2021 02:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=VzCFuJVi1JWihrkH0U7iXWLRxWpAA8Tov5hTvpOQq40=;
 b=cBWE88gGjMicoakS3zQbUx3JC1NtftC/08g4iUxPW7BnrgniimNLoX53k3WF4zjeYKKb
 UG7jA4oypawwGFobnxrtCg+AHIcPOTXw8ZpfoKsI2bat1RVoX4+eEyfTtf2qyHUoKbSc
 hAFQ3wjyPMfBe+xGX9STlLxv0prhekvTXlBUehPzVRuMQL/+UPgzYLbl8wgvZXsH23dx
 49awP2a1+pvzx6Q+3IapTOxq9UuAAr+bhCnl7OKIYzW1HiANFaSD/tSagyHyl5O9F6Hv
 Ft27Kio1ySpv/d1na+y385CDfca0UQ2FVbXeOuC9BhCEmiGWbsQFsjZbXIqIw+c21hXZ 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvsu5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 02:14:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15M29apP033463;
        Tue, 22 Jun 2021 02:14:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
        by aserp3030.oracle.com with ESMTP id 3996mcqnay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 02:14:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L55F5FGlVKBzpYfa1ctEF4TNBBY/5jYFJf3gbfTs0DzamkWOVAklxOLUVLbLwN16k2fejfDHiCs7deaeW6841f9QWHy6igjzPlYD8pm6NIge9WzPjMlgostM6eEFb3lneKOrXEgFiHPh0AmGZ8b8CQ8e4LtJrCvry5hY8R3aUKl/6KICKpXwESlNAcerRsvSD+VZt4l3TexNxi97pzB+2HT/NjWwyBRLkLNOOaiyk7ArXFRVuC/7NDpV6zsSolCcOQwxfnmKTua3ONq7MWXU+r5wW/WsLIKfmpayy5XJZpIzHaHnzmJWRFRuLGlBi5Fjs/XPm6P3UquhZ4N+6HcZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzCFuJVi1JWihrkH0U7iXWLRxWpAA8Tov5hTvpOQq40=;
 b=SdoexbbU5VFbkK2PzgvFt91ojiXylioT0Kkeg7MztVRkMSS46diPFLbDbJqTKd7PoHHfjtluUAEwqlAUP+oB5fgnTHwQfBLhHt4LLmxqB5WdCxEM3yC2Gy9wdYdkyxipG+LNuSzSZv0E2XTaMshCmPMB+awFEVt5Gwr+yvFwx/jApR2//WZigr6DP13YOk/9CfN/hvtDxEjODLvnTfRqQMtYZIhIFGC/Y00pT9s0EgCoT61twUYw9a+ZN3hoxjAbVoDZinyq4mZi+bfzMgSzfJJI1Z9rTZryTL7yerSpZaAcg36LvCf9Dr6D4Ioqe+kzochwVqGtsKXJP7xV8sRndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzCFuJVi1JWihrkH0U7iXWLRxWpAA8Tov5hTvpOQq40=;
 b=etHJSFGUB1776AQb8ZIm8IF4RohsFzhhOMF3h7ddE24bOQQfbgsWbGOFfnVtDcUK6LA6HAsOM/31O4DI0PBQr5weG2O+HsolPtAXlyKXvgC8kLcLPJQtzqlUidXwD5e6fCoIsffKOVKjBYVX814OSielhGOclVRLe8pANELMWfM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2664.namprd10.prod.outlook.com (2603:10b6:a02:b7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 02:14:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%4]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 02:14:37 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/2] Fix prep_compound_gigantic_page ref count adjustment
Date:   Mon, 21 Jun 2021 19:14:21 -0700
Message-Id: <20210622021423.154662-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:303:b6::17) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from monkey.oracle.com (50.38.35.18) by MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Tue, 22 Jun 2021 02:14:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18a62b80-8a9b-40f6-8298-08d935237c0e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB26645292BF44E0332F1D8AB1E2099@BYAPR10MB2664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsz0lZ6d20qcFPfnMzUCQM5xbWAQau0F8KA2tNzZRxxSFplp15fHxX7fa6jPCwT2GfO+RAhuIJXI6/g9w/91eYqokrMGj4Xl/Yl4v6fMFWpI1rLktKbO/Rb2Iz6bkOmgu2gP7oF9UvIUsGjMlYRxHcYQLeeSj8uUroKdNmVaP46cMQqduX3pEgfrGRAwuxRH4e3R7313xV0tD62e1+ecT7qoG2CzXPDDDZeOu6gRkA0RHj0vXoS6/f8fnHiHc+Qj3Yjzl/6mYp/BGw7QiJ2T6hq69gic/uo/FnoVPGo8V4Bb5OEsBWiVHMIle6YpORtH/lTKk4Nk6JepusNXZU91cEKRvwasHKydRp+c7GVUQPtqmHJqzFh0o5rA4kluzVtuKXXG129LqgDvcfSNTdnyF2zA6U5T8CdFsjo15kP6/12XPipbY39WZg/1FgJL4Lh6033AWQTNTDM/1jhsf4CmemG4Tl4WmDVQL9eDPIjaxP46LYxTrJLm9QNhZoj0k30UnFfl2tWJ2IJVieaWEntc2qbb3oGcCKLQDFbpOqjcbrmVnJcoli0kJtkAQydwvlI9VrpOxc5wasXmc3c6jhrvHACXfbNpDZFejuxyJSIL1KB4KTAtOT+U7udRoFC9yXUMG4zii4/ms3AshOFvvB3+pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39860400002)(366004)(346002)(52116002)(16526019)(186003)(66946007)(86362001)(66556008)(5660300002)(66476007)(8936002)(7696005)(2906002)(7416002)(1076003)(26005)(8676002)(36756003)(478600001)(44832011)(107886003)(38350700002)(38100700002)(54906003)(316002)(6486002)(2616005)(4326008)(83380400001)(956004)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jtdHyoz7oTag7daeCkJVkrgJegFGo/IMhXpMWP3HV+YmnHmI66N3arXL+Mwv?=
 =?us-ascii?Q?96qI0ka1at2eGJrG+i44GXR05+3PB1z1mFvkJZOmgEIgwY1mlfFT5pKvG6dN?=
 =?us-ascii?Q?XqVHmj4QiShSpEBmD+9TqGDLhReE0RtFz34BoVGPE/xI3HZf3oZxMR5yY/UZ?=
 =?us-ascii?Q?pWkWOgT6DFoQuX46jzihAR92Hq9zGDTiJnnCcUDXrDcAO+JDn2MrU5dmuJrM?=
 =?us-ascii?Q?/vDWrbQxl32LLePcOLm8pGI49/MA0w11oHr6KBgRepiPmUu/dZpRZjbHDFzl?=
 =?us-ascii?Q?nGn5SHw5WwSgyYT5vwzPZ5Tvexlw3YHhWldFCY1OD9pqGFV4IiOTegv5Z245?=
 =?us-ascii?Q?PS2+gBaSX/CYXfAvm0iG/adRtgEUa1MJnyhSYTqlO0IDF5yr0fgKaY7PmoCj?=
 =?us-ascii?Q?YC3rEwyBbpF/RVJtSUkiJHQr2zEkN8/pZKqjGJ+bC8TKUseXEG590yj6lweM?=
 =?us-ascii?Q?opdcq1HdCG3Zq2eGbnNpuxbnDKfzA75RiEqKUIWPBxecdcjYRf35GGKZhJrr?=
 =?us-ascii?Q?lyc9vF/+giYsq730kFAMZz/GLvSmpom46hcSCnZXOdrSpv6aMOONuItP86M0?=
 =?us-ascii?Q?iqnyHHQd5/ztxbBH2VFeWLbrRt1N5lrEJhB9zanwE3gPyY3i/XGKu7jao2UO?=
 =?us-ascii?Q?0w9IhUd3LJhKPdaZkhX6MdERk3iHkwTgvQN7m6qTBm0JRF9B7cAYRssCZ5cL?=
 =?us-ascii?Q?2qTe7jFx0N8LgOrOoCj+1EHKh6KCpoxV3lpPa2WVIlf0cx9CG4icEWS3MSSE?=
 =?us-ascii?Q?EVJhhbJcsgI8fy9jcjWpoVgjkY3MjN4G85cWrLtB6bSoly5L5J+6pUMRc7bB?=
 =?us-ascii?Q?+gcR2LVhLinq8Gpe9nd8QxTvSKDh+0T/b0ny2r1S2lKTOJsfLDpUyxlnT4GS?=
 =?us-ascii?Q?OssB4iDx5VAWd1LcXnjAU1O0cDTQRfIMV9kFev9hPF2SA0/0TFnTJMlyFBzy?=
 =?us-ascii?Q?K7C7d/fe3awah95mf++DhZQBV4nVM0XUJfVpkha5siG1xtuIbCup3iIa2nE6?=
 =?us-ascii?Q?bRavE2x7EWS08YRWWvBSQS1H1+YDIIzXCNFM4gRWO/iGi29R396hap02GHXQ?=
 =?us-ascii?Q?w96JyVPUIEt2GjgKNo2TTusNv9VDdwz0jV+1+tWxOg5uICugITq9/mwmweyG?=
 =?us-ascii?Q?drWVh6Se0YK5zuD81592c3E2HKMZj99b+oxvbHcTjjY4ZkVA7SyupQDLTU40?=
 =?us-ascii?Q?JrHN0Fjt473KPpYFWpuhWBsYi13yQIxVJNPf0qeDoCEhlqSY32G71+IDWbA3?=
 =?us-ascii?Q?StVyWiWX92446chwGIV/mIK093e58mpU6q4UqpokGLwml4ONeTU+Zet65txn?=
 =?us-ascii?Q?DFOAnoimBYgE1sFg/jYs1k91?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a62b80-8a9b-40f6-8298-08d935237c0e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 02:14:37.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bn8eSXlAHtWvJ0C279iwgnUxo0txLiFyb6g5PDCwarSMDnrJRBwVYBOgEOX2zFzsdhcWcyPAk4GVh84d4x48rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2664
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=898 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220012
X-Proofpoint-ORIG-GUID: oYkU3KXzhm4cN3k8xAyCAQ-cqeo1A_6I
X-Proofpoint-GUID: oYkU3KXzhm4cN3k8xAyCAQ-cqeo1A_6I
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches address the possible race between prep_compound_gigantic_page
and __page_cache_add_speculative as described by Jann Horn in [1].

The first patch simply removes the unnecessary/obsolete helper routine
prep_compound_huge_page to make the actual fix a little simpler.

The second patch is the actual fix and has a detailed explanation in the
commit message.

This potential issue has existed for almost 10 years and I am unaware of
anyone actually hitting the race.  I did not cc stable, but would be
happy to squash the patches and send to stable if anyone thinks that is
a good idea.

I could not think of a reliable way to recreate the issue for testing.
Rather, I 'simulated errors' to exercise all the error paths.

Mike Kravetz (2):
  hugetlb: remove prep_compound_huge_page cleanup
  hugetlb: address ref count racing in prep_compound_gigantic_page

 mm/hugetlb.c    | 99 ++++++++++++++++++++++++++++++++++++-------------
 mm/page_alloc.c |  1 -
 2 files changed, 73 insertions(+), 27 deletions(-)

-- 
2.31.1

