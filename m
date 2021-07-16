Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E823CB81B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbhGPN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:57:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56618 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232808AbhGPN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:57:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GDkDaM003258;
        Fri, 16 Jul 2021 13:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xyQGQXWg3ryKc3l1ElmquUUkERdWJ+TsvqjXrlLJg1A=;
 b=ami9pwUiRg4jHkKAR3WmkoFelyLfR0zbP1PNIkyLNF4O8rffP+ykAfhTgCWOFG2AGeV9
 A7GUQe1yv8PGgl0Hq9NJr3Th4/9Szbw9PinYyhvvyXqaCv5PIRdDZCs0vE0xDEEADprt
 wok4XKlTpS7KaG3w69iPtqk6nb7WTV/V4QYqMju3TNWREMzus8UxAUAFF2Q221VgD0aF
 CWtAV1o/l8UXeqxIzW2MBbRk7q6S7dNsCiWBOd4UJPcyUAcgzN012yJf3QiKmAfEUV7I
 GpyCiIA0MoqDC3oiQcMltyZDsvQiG2JhUylwjSIAJ5jW2fa/13g43zk7A4lhtCzmqmDp mQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=xyQGQXWg3ryKc3l1ElmquUUkERdWJ+TsvqjXrlLJg1A=;
 b=ejduQOVEDdmuhmePhAVZ+fE4/7ZFMBfx75ZuOCQYnv0ZIw7gxopE0lKTsajnC7AFI4wd
 g7im/U4G1ixkGAKpU7HKxvQt1fJ8RtWLcK1CIuqBFFoINbb628FTea1sRUCQPr3k6IfC
 jk51c7M3I/NW8nIpzq1f4S9wd8OtOe/3XB4GZSfWe6KN7UlME2n0fgr+ZvshmFF9ePY7
 rP3Wc4DQXTzUfeJPTSHpT7MuIPQYVh9yTDkNyLWuObyzaaZ639KxwTnKkLicxAO1duMp
 yAuXERIb8NP5K7k/4FB0tHlyjlXfOfXAS7a7d1VXgtc3R34gq7pPoMIglWe+uW+zzXIW XQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39tw349e8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 13:54:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16GDoCO4146177;
        Fri, 16 Jul 2021 13:54:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 39twp36ugt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 13:54:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRiA5bojkI71e9EFvbVzwl3pvqrn6pGWLYrSXe4h/iyxgvAU/tHjfbSZ6TSpR2LG+0rdWHVMwIrDw0JDW5wuskm4J94xWjWAROBd1z8ssagv+RwPrdZkQGFzW4A692Xww7vjuHsiVb/mBzuDtcS3TskcRnGCJp0dvGcKCyia6sLzEpb1sncgROMexCiCoQNJmO6z4Za1DIpIpe6KtWcH6V9vbWfFP+/16B8tR5H9vg22mP/i21Gq+up0CtIzMVr8/TvNVWcpWvIHCegUrG8o1cZw9ejDCl8Xr+UyHUju0TZqz77bDGoZ3tdo5rq8MrvkQClCRAuYdnddtJW+IvNZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyQGQXWg3ryKc3l1ElmquUUkERdWJ+TsvqjXrlLJg1A=;
 b=LSsVwz57h61+mg+egqesc8KTbe3WT3cTN7IVLV6eMwudDYjHLOYoytqtwzX5vLawdSb0GeYRdC1a78MYldlu1T3xb1bO+VSlIIAwONEWJIcJ0WlmRh3A291OMM9RpmZgw0a/haAKXXXQzpNSYfSCdcVrYOH83+uKRUN3VHTnElyJVC2YqSs7k+shgsf+2VDCL1r+OFQlxmMginjD+ToguAMuXfopH2wtshfn/2+YDd+y2ICADob1oWZyBs4LprrBbQhNcEJTAKQmplkaWF7l7++VkRUpGY8DPb/eyVvgc2TN3t9kGZVa+FwDaXBFz6Z7xxD2tDLFgh2gv/BHD6h3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyQGQXWg3ryKc3l1ElmquUUkERdWJ+TsvqjXrlLJg1A=;
 b=Z/QPrwA6+DQlWEPOTEainTlIuaXPhaoROuHBAcwz9AD5gB77sqJI9wGqifIJOz9mMKUwK7X95to+9mKAoiAYRsqkreRaFThTUGmsHOyosWnSiFGZwhmRrGWLRfEQnz9nQAgMM/AO7IeOoD6TQiz8OB7ZR53vv3rITkGnXQpeEQQ=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2966.namprd10.prod.outlook.com (2603:10b6:a03:8c::27)
 by BYAPR10MB3333.namprd10.prod.outlook.com (2603:10b6:a03:14e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 13:53:58 +0000
Received: from BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48]) by BYAPR10MB2966.namprd10.prod.outlook.com
 ([fe80::9478:368e:93b4:6b48%4]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 13:53:58 +0000
Date:   Fri, 16 Jul 2021 09:53:53 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, pjt@google.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH -next v3] sched: Dec cfs_bandwidth_used in
 destroy_cfs_bandwidth()
Message-ID: <20210716135353.zcuth5cqzuuajc3u@oracle.com>
References: <20210706083820.41358-1-zhangqiao22@huawei.com>
 <20210716022756.193817-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716022756.193817-1-zhangqiao22@huawei.com>
X-ClientProxiedBy: BL1PR13CA0348.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::23) To BYAPR10MB2966.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oracle.com (98.229.125.203) by BL1PR13CA0348.namprd13.prod.outlook.com (2603:10b6:208:2c6::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.13 via Frontend Transport; Fri, 16 Jul 2021 13:53:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a574903-770a-4622-c9ae-08d9486128b0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3333:
X-Microsoft-Antispam-PRVS: <BYAPR10MB33332E94CA9807B4F0486456D9119@BYAPR10MB3333.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GL9dPwZ9VJsqXv5thz6f0pyeddqfXkEtNEd4un2Deg8W9hKTakD5hh00Oo1hIPWXet9XW2MqNiLCDHHnafyPv3x/Sr76ZNyUNkGstHTIGvVvOB/mJ9RrV9T9YSUnW8xq1jTawCd1X1AaNAOmyWFP4BNM/kTS3+JQP3fGaZI8al1jvyaAI1KNyKF+jA+lkB1g7O4dnvfK6dVnTL09sAre6OeFc00RD8j1z7yrQ6LT01CgGD2gaaIVRSxPPzMXWObVlldjCnN/jL5icz9kQ/MXVES65lK9h/b2fI6Xn+DoK69O1d4nwKf0HxKFyipZRciNDq64RuGDA/N7ffBbg/jgQPZw5y2ic4dZMUFvRM3j4SO0HOS8AZxzIF4yp/TFhROoujR5yJrTENW3wyuhQbCghP49wDIQPrmAh+6E5xY++vGlos0PFtGHI+f5gpaHGmvwuBqprDdxXt9lSHW9wOqxRonMAIRd2DlY8MGHzGTjUi8OEc74CRq9gKQkY2B3Wlr69nNKl6Stmqg7zPUXg0ADkWW4wxSAzX8VE3mok98QmvpI4udaY+fheeZqbhj40sjAPDebCHSba8ol4Bc0YK3DyZXIifMRn8x1Fz3ztrD2b7G7k4ZfeaKwVkhdDsJ4MVj4IWat7Y6SjSzq+gMCbIAvQILHTldJobAUI0dumBTdzkDmh4ovW78fA+Zuw8IVcM+2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2966.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(2906002)(2616005)(186003)(1076003)(4744005)(26005)(55016002)(6666004)(38350700002)(956004)(83380400001)(38100700002)(316002)(8936002)(478600001)(4326008)(36756003)(86362001)(8676002)(66946007)(66476007)(8886007)(5660300002)(52116002)(7696005)(66556008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dRoT92MH+kgzMos9bSMByK7KA7zwWDHfHBKy4fcHrfbndhZsYCkHC+P4l+lz?=
 =?us-ascii?Q?0E2yid3UiTmHmkmDsXS+igw4y9O2/S1BlkHOHGKJ+wbfku3DZam95OqJz1/b?=
 =?us-ascii?Q?qhg0B9TJqRoKzmMKe2RetK867WIzRRcW2/fKYFTWHxE2oEAHPwCMqRmgnV63?=
 =?us-ascii?Q?RpjinX3kU20hhEE/DyfvA4X1ib8WkFx1WUQ65x0XdQypBlYbUov3HVdeMXlx?=
 =?us-ascii?Q?JY1bAtpat0gYf6ZfehoUXH3VkkwU221O+Sz45oZlFtdAACn5MrG3vBWHs9dD?=
 =?us-ascii?Q?LpFFIZisazTyOwCtHs0IDWLoamwftavgS9AAG/73BZcnu22FmN41/BmkUCnh?=
 =?us-ascii?Q?YtNcg9vYfGQ1sgAae5CAcL/axa036ffbH/hqRdI4aqJW1Xq/IX0423QuP17E?=
 =?us-ascii?Q?uo148PaRtbTcsDRg8L7kYj0uu2uxTvNdnfAshxCggEL/7y3eLjRAWQ1Aq+fh?=
 =?us-ascii?Q?XEIabd0vXhkldxJ7gQWndVZVd4aquXT2RZBOfHU7mJcSxOX4IzMfFKf3dMkA?=
 =?us-ascii?Q?eDlYG4oLIepsLTVoaEhr0iTNVfdQn1HTfZRkfkLSBkn8O87rwGFq16DjvhUM?=
 =?us-ascii?Q?lUAd4ONko/0mehCV6OlZEr823KCfcCSq4o7iDkWWyocG94Vi4gQ9cwR2JLUg?=
 =?us-ascii?Q?hxHXe5W04ZIcAOIP+3HTghIqr8Dn9JjZ+aXxjB4i5ceH3NgnjV9d1GyTqIn/?=
 =?us-ascii?Q?/FLgMOJBFOUxLRjyswYQCOyrFfsxVq9J8Ggi2RGEn3uVPFFkokNHES0IUcmO?=
 =?us-ascii?Q?czOnxj/1iyb1QqnN3iZ089eqIxuCvBttkp47CPOSLie+igyJyvoiiL5rE7mk?=
 =?us-ascii?Q?MoeLK/h6lYmfTGGlADWmecEPxiF14/y/iaF02hNEveeMO9NvmQO5aS6QPygv?=
 =?us-ascii?Q?xuyB0FOjmF2B4oZgYVefZXFAHEG0QRI1vpS4gnnr9sEGQsPWNqTfkXGDPZL5?=
 =?us-ascii?Q?ZrLiYC6TbjX7SznvtRKtfUg24s8A1dTifxWlL2U5yyHHqqX3x8RvGMi9kqVF?=
 =?us-ascii?Q?5f3jcCMjBFQJNl4G/7sQs9xhvPldDReh3H4Mk7NvDqjw4Fe2plk/CYLkpsRP?=
 =?us-ascii?Q?R3dh29I1n4Zivagu3zQwW1XMAMWsbr46zA2Z7JmTKFqLjWhl6K7ktQix+0j5?=
 =?us-ascii?Q?LnFpsPygWXqIgTxyKbwoEiBqhEknn3kXFeRcoRAqCthw4OVp7BDnSjFmiz6x?=
 =?us-ascii?Q?58q7qviLHPwebjDbfeuk0F8ClTvF6x19iVax0YGLsZLM9CIkPAX4PAqWCAlZ?=
 =?us-ascii?Q?K450G3aawlO80lIdILweZhZysw6oEJu3BhAvEkA70Y8GG4UPFcVRqnxHDWKQ?=
 =?us-ascii?Q?VIDQDIf+puSVVlIqeZMgoVd7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a574903-770a-4622-c9ae-08d9486128b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2966.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 13:53:58.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sMZPrXwYGe1aCO24IBfNJGolBjT0NV7thwo5ku8SLWEaqAQRMc5GCXlhJR1ADZJ7mGtHbzm5zY7sV5OLJSh0Y7AzvkGSeC5SZgWBsmDutY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3333
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10046 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107160084
X-Proofpoint-GUID: c6a2RcOKH9cvVN9x_e1VuWbLCF1F8Qtd
X-Proofpoint-ORIG-GUID: c6a2RcOKH9cvVN9x_e1VuWbLCF1F8Qtd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 10:27:56AM +0800, Zhang Qiao wrote:
> cfs_bandwidth_used is a static_key to control cfs bandwidth
> feature. When adding a cfs_bandwidth group, we need increase
> the key, and decrease it when removing. But currently when we
> remove a cfs bandwidth group, we don't decrease the key and
> this switch will always be on even if there is no cfs bandwidth
> group in the system.
> 
> Fix the problem as two steps:
> 1.Rename cfs_bandwidth_usage_{dec, inc}() to
> cfs_bandwidth_usage_{dec,inc}_cpuslocked() and its caller need to
> hold the hotplug lock.
> 2.Add cfs_bandwidth_usage_dec() and its caller don't need
> to hold the hotplug lock. And when removing a cfs bandwidth group,
> we decrease cfs_bandwidth_used by calling cfs_bandwidth_usage_dec().
> 
> Fixes: 56f570e512ee ("sched: use jump labels to reduce overhead when bandwidth control is inactive")
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
