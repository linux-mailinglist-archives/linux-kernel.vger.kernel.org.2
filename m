Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368F844541E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhKDNld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:41:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42130 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231840AbhKDNlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:41:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A4C0i7A019894;
        Thu, 4 Nov 2021 13:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=6fJNTmLykuSXGDU/oLw9x5etPbrx007UqzyA+yUg7H4=;
 b=tmwbiJXczYlHURrpYBipAaQzemEVtwqGvld1xtWVXwkv93N3xORF8xIfiZSt4AnDbJ+B
 8/irSf3hkJKOekOfjmWAzIcXRihrXdTTGLH9023+2u5eFRyMJ8nVSt+tb2BIXooZeH04
 bLbsMK7mTAN3509cdNmZUuUr0ppTPLP7Df6mQljtFST/fyPDk+f5oHSfKIkthuePbFNa
 6bupWsUGdNDpx7KpTf4Xq2HrVH+q/zm6NKoPS0qrrK+OcaFd2xJAz4iUSBUnE/CLZCmW
 FwKcfBF85Kbw8ejPzZ1UVLG1vntsOt0REMEesnhNeKmtJY3VlMYHLVpLhPHXsx44S0h7 KQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3mt5gdua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 13:38:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4DV6sH167515;
        Thu, 4 Nov 2021 13:38:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by userp3030.oracle.com with ESMTP id 3c27k8p440-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 13:38:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvOAf0+h52xIFyuAzUgZ39F1QyiupAE5Cqw+JK7QCclhMtUwz2itj4owhL64Z5PBSNobe1p07Q2EopBw/GypbF/DAono6pLbYM+HktaWKZgaLzREUSeQqvTZ4kEtJqcAmwEZZ9u4ZlxL5eDEfPKt7iukxbKAffqTSGztmPRIyoDD/SbgMGTA9RxIhuvPEGo2e0T0T76aHZ6ePyolrTX9lppSuy8DMz0eJm77S2KyMey2NRQnc17QKCDkpxK2BeQu+tmEa4289w6nw7TbOV7ctKmG0M4OWwKvjThQRhX3NhxyY2parBcFux6kKLBO+7RoeEcnzUXnDjtBwMIstYEJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fJNTmLykuSXGDU/oLw9x5etPbrx007UqzyA+yUg7H4=;
 b=ZCW/cxQLB0onW/C79G/QXXxQ9dSnWuz0paezpAmHzdjHCe9Tbxr0F8oBnEFvLzpe9GZ790zcQPUKwlO9OggICvHPrvyPC1G6Hg0CiCI1ymcy28Jw+2T4CjUxA6pXd8iBvwnO/LG44YMCyS/uP91nX5l6bGfsOvUlqfS1S28zJVodmwhjn7YPjEzS8Wv7KyIkIOd32+4y0wDPY87JB4X18yF7rrwI40Ouw/bAgHm1qi6Ke2EG6PKmqLuSrXN2YL33HH0sKdsNwmao2F2496ZwGX/XVDR0R+YJgjocW1UCYHr1h8IbZDurw6KGLCmMgykL/2E4VVsw4ygPrkfO2CpwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fJNTmLykuSXGDU/oLw9x5etPbrx007UqzyA+yUg7H4=;
 b=Nozg7dX/R02l3qtJ8bvYUJLQ+JUU2a8IwsIBPh1CRzk3mWsMmjLKaFkd5E8ffdXd1j8G6x+YdqZX/KUZ9aEhDJnrNsx+E0CpP/x1rocn6ZLFhRFhegsz2nc100fBm2yHrHHgMln+zn54oQRp5M6hL7/m14w/D7uFT/O4B+xBvAs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1726.namprd10.prod.outlook.com
 (2603:10b6:301:a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Thu, 4 Nov
 2021 13:38:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 13:38:24 +0000
Date:   Thu, 4 Nov 2021 16:38:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] staging: vt6655: Remove unused `i` increments
Message-ID: <20211104133803.GC2794@kadam>
References: <cover.1635773679.git.karolinadrobnik@gmail.com>
 <79a4f03c8f2bfa555ea149ddd1c0f938dd431a0b.1635773680.git.karolinadrobnik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a4f03c8f2bfa555ea149ddd1c0f938dd431a0b.1635773680.git.karolinadrobnik@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 13:38:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb6d9c19-afcc-4580-9025-08d99f985fac
X-MS-TrafficTypeDiagnostic: MWHPR10MB1726:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1726E40890339BBBC58D120A8E8D9@MWHPR10MB1726.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqr6lRd1VAnsTQBO0QSHB094UljLH7DtDJp+WLe8Oz9iHBJuilXbqPqHM0yezwh8DzJBHLnNWoItNUAbOXbtoN60BgVGiuT/kXYceWpN4aTP5Yn/2h2xY2rrTXYKD4RAz613rguC+wnlMHANVXf9/krdGpjX2jTAg9kf7BDVQ+eFUfd8//BIY+fTb/o+EFRCGpPEW7Fm3M1U610DkbCdU2h0mR+xP6UecnZsss1PkBlvOV1GmREcRFLb2qRf7gW3EDJcwIH/8ZRWIJ0DYG3oEfmGVwy/qSeJjxP7V3rDl0OT/73AMRVvOjwHOHcEUoX5DBFE/nDNJaWMp49gaBCjB3CugKcZkWkKC4WD4kGRByl+XTARkmZUV3zyxYoN22fwiJXttPlg3dADh1ZscGObrsVI3gx4XyzNuaEHrAtuwniV161iJcg3u9380Im5ZwQXL8XiucgFoc9onCYQLWjSveoUwC5HsdTU4AyloSRIdBcnpbe2IR7wrKAITV8mXSJ9mg6HmLjOCu6U5i5hLpgPVPstvpRicgVnmkPccCKlChD8tSTwhCqcV5HwpxwO6y2AQ44MOuQAQ9v7uiZwdCFBdEUc7ahVcqNPl9xencIgOWTF5Qk8GDRx1Zyd/ialEg07zqA+fIU/UBoAorrx4JoDTgtTYXLI7zpiQAz5HcNzJZzAgCInhfp/Qp8zF1I5MuKFSN5LQFwpZyGuhwlcgXTHeYiZzqtILCcEzieOxV5oRwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66476007)(8936002)(6916009)(66556008)(38100700002)(38350700002)(83380400001)(9576002)(508600001)(4744005)(33656002)(33716001)(956004)(55016002)(4326008)(9686003)(44832011)(316002)(2906002)(186003)(1076003)(86362001)(52116002)(26005)(6496006)(5660300002)(6666004)(8676002)(81973001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?77hi1HS64SrD232BuXtl94CxOoouC5N3rgNrh9lxoqnDbcWouNU0BQv941W+?=
 =?us-ascii?Q?+qlxTKOZXfUNMTsj4XE+FNkLbQ9SDHsQzmbF/ptmIVMllV41sQYEaArsu+e4?=
 =?us-ascii?Q?DXzr/OUu1JEmtWGusMIk83g9pwUHXmbhh/YVsu0FsbQ0JdodBxonTcMc7rrR?=
 =?us-ascii?Q?B9CtBrIxL/rtutEtW1hywaDoZqLpzRv2vPLykc43LK1qU5mC7pSN9Fgp8BRF?=
 =?us-ascii?Q?+sGD7yEes7+PH52+I4iWIogw2BEMDX31XAMsKTs67xZWMCdCQOy1WQFOPeG7?=
 =?us-ascii?Q?ctrdIor9L5JpC5SC9hCN3KpCXgjPGQ4Dz0soyLN9KV7X4TK9LEa9mTd6APw7?=
 =?us-ascii?Q?1Miy+fYICdFfC+f7AwzhT/XRG1aVL59rVjsLNp78RwKaXzwk4SKr1EyqQZmL?=
 =?us-ascii?Q?vfNN+4q8kq9B2FdBx2wT3jbFZtlDiJifuosFG36j08ascVIQMOA5zHBRmHWy?=
 =?us-ascii?Q?2fHqIWNQwuUWKBsAPIpjo49ow4WeIYYMkXEZRRZHw09+zFDeZ8G0Qp2GhSwG?=
 =?us-ascii?Q?XXyLzkGWmhTXOQQ6zg5UzVRadVDtqgY8mf8aV8Jgaq3pcBP7e2e9okr2rY0R?=
 =?us-ascii?Q?/bck6wtBQ1XWbmNrk/j4EdjLNyl7EcOkMyfHjYv0LUM+ANkk2TYxtHNotGFo?=
 =?us-ascii?Q?fsB1NM3l7KZIg+BvBLzBz6op8s6UpVDEd3b17mCa50dPFsADNqUxCTMAcPI8?=
 =?us-ascii?Q?+iqeT5EZKhqfm0MJYbupIwa0/5T+QDip7ZqvgQVCVUBcCajqdVVhIZhidvc2?=
 =?us-ascii?Q?BC9DEdgFzL6pLJmiF2xUs/GrjlfPx0RSGArZKcm+sjXcd/oHly90C9BcTGgc?=
 =?us-ascii?Q?th7hnDSU37PECDpVh+ovJfsZ/ecoUDOZ5DaAwAOOYBSRzO2vUpM4doKgTgdK?=
 =?us-ascii?Q?eiNBLlVAb9KoSshMSrNELiKOoEoAWO6lFdOuDObu2GPRw3sxs5EQ/ZGZUC+3?=
 =?us-ascii?Q?h98ITOmFvwRNE0Hjkea1K4stylZbjQvYElwDD6JbEMuuSF/iaNXGJMO5/TF6?=
 =?us-ascii?Q?v5rsiXuHF9bXx+XJ7lXYDTtjcFjPO+EhUC6tNVOPLO/ExDHEFWMwjNdzOYZi?=
 =?us-ascii?Q?8i8XBwPh3lj/F3HvRRdYmJ/soIG+tzk+z7XxtMQB1A52r0OysxXO+Sj+itPc?=
 =?us-ascii?Q?SXCBtZeek6SUtTaFpe1jj/uIvJ4j6Gh+fJ1mjSm1PuuitWFAXSilsz8Tiz/3?=
 =?us-ascii?Q?NZyiu0ecSv5+AOPqk9PH0gsAUeabCahg17tgkS9uJJXiy4YcEVRsgecJHFgy?=
 =?us-ascii?Q?dMgQklnF6PPB46MG1aS0xvzaru/cLRcZWZb7NI2cTzrsrYb9jQyWOjmuEZYA?=
 =?us-ascii?Q?7E1Wn3z/zeQQGBIwhbHuuiX8R9xuPr11bdNFhy+kziIZd0WURKlXr1f9DuYu?=
 =?us-ascii?Q?qbi133NTzLYUFE2RRYrQSTqpQC5Wlr7DBpP0DiAV78goSMZtV94e2/hLWsVz?=
 =?us-ascii?Q?smz7JIGA/7srGwKFQaCkRdTZAqUV2P2RgpryWj6qD4zarGFiSw9Lp6bLplkx?=
 =?us-ascii?Q?l0BY0hgCNrFJC/PcZ/89So0T+4ZRud+os/qQiMTKrmGV28DIB0MApQEG3j4o?=
 =?us-ascii?Q?C4PwIQ9MjfWtPHfM4W24fhOzpW5BJcT1RCPYiE9MFDChQhzoKAkW235vbqYz?=
 =?us-ascii?Q?I+CsyPSfWy2VZkbPTgQB+NZcLDLwolSxiSm2X/C6FtnsYOYnRwNwY9Kkards?=
 =?us-ascii?Q?5pdRsdUUM1GuVHR/q5MFs0DRHmY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6d9c19-afcc-4580-9025-08d99f985fac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 13:38:24.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpO6AB9jeXYQZw30NlPfrO8MpOVP4nV4/Blxf1G7mn+qS0QInkqyMDxt0BCyy85hdb5Vr3N7fzkE4GlI1Ny7362NOkGVuSLMV7KkxVsg4f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1726
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10157 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111040058
X-Proofpoint-ORIG-GUID: 7-Oc1H1hxAJfLvzg8azbonRErVdMVpSS
X-Proofpoint-GUID: 7-Oc1H1hxAJfLvzg8azbonRErVdMVpSS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:32:01PM +0000, Karolina Drobnik wrote:
> Commit c569952d92ba ("staging: vt6655: Use incrementation in `idx`")
> rendered the incrementation of `i` outside of the loop unnecessary
> so it can be deleted.
> 

That commit hash is something that only exists on your system.  Commit
hashes are stable once they hit Greg's tree (he only rebases in extremely
rarely cases).

This commit is cleaning something that was left in a different patch in
the same patch set.  Just merge it into the original patch.  Don't make
a mess and then fix it.

It's tricky to know how to break up patches.  My suggestion is:
patch 1: remove all the unnecesary (unsigned short) casts
patch 2: merge the rest of patches 1-3 together and send it at once

The rest of the patchset is fine.

regards,
dan carpenter

