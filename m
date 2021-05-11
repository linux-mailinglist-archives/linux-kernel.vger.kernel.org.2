Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30562379B95
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhEKAf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:35:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16444 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231537AbhEKAf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:35:56 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14B0NakS004767;
        Mon, 10 May 2021 17:34:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=b6Whvk3b6i7DS2SZqhOm32c4UmnjeaxO4JoiSw1LqW4=;
 b=bllsHLMJ17x0oqXellMu9d65w6nC/1MnF+yo47ocRUCuzw8bgYYy652lxapRPcm30u9/
 gYPnmy624LwHSOT2R0JtAxSqn8EZk2T2gBPmUVH9RAyUca43vzk0hi3gFlYLcu1Du/uM
 AnYQAsWG+kKbvWM9CGNXmOnj0rx2zXKmpUQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38fahjhu0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 May 2021 17:34:45 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 17:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3uMauaDVXce7nHmKSSmIH+tFq/MvfhGYw2xYZLj4e0NsBzhOwp2KlKcXmTOFIXtwyttD1Xuw9SUvZHgkAw6Etqd073hk55YWxe/4M9jqDH0GPKlU7Y1PX++fHryoBFyzXqC4nw0LvR61DTRm1RCWeKjTssYMGQjMiflmX1SCHYN9Y3sVYuePmdnD1LUEqcCmUrl1nY2Ir0NNLCoYdaBZgxoVnCwK09h+HeerjPLC2JDuT1k++tLgus1ADPtABefHnCXkuiaTBrR8GsEabnO9ljXDiNQziq0ymq+jU9wfcymWTQliWnnPAIY4aDzBcSXTxpM35Wx2Dczu/aWB3wXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6Whvk3b6i7DS2SZqhOm32c4UmnjeaxO4JoiSw1LqW4=;
 b=aapLyo0BZkAJbP/gsO/m4iclmiv3hA4jvQ1IIsMTNNsOIkDMZFCZpdy1ni32Kf8K/MDyG8E6lxXyUIEpPeFAtJeH53ctbX0/40UtqGUDfXie3aKxLh8RakCOrkhDXj2QZcNtjMWM5/wfGpfdZYTFEBGTKLSu2edPKBu5vxC10EIZZWFxV5xEoqPflvJVjc4MJs+YpfbG3evfBGTbH1zPKO367bG2iDx4yJfB/7gY78N9e6GDcdDqvsiQKv5aMWQC2cuiuMXNf7Qj7icTZROgH02HyEf0LI9xOuYtH+M8sUDoa3r5YNsnj3gzQVsOpMwvzksxhmYOAPgTKA4PQWvUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3029.namprd15.prod.outlook.com (2603:10b6:a03:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 00:34:43 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 00:34:43 +0000
Date:   Mon, 10 May 2021 17:34:38 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     Oliver Sang <oliver.sang@intel.com>,
        Pratik Sampat <psampat@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [percpu]  ace7e70901:  aim9.sync_disk_rw.ops_per_sec -2.3%
 regression
Message-ID: <YJnRHhK+2AVTMOfh@carbon.DHCP.thefacebook.com>
References: <20210427073448.GD32408@xsang-OptiPlex-9020>
 <YItcfQfZlNZTmQKR@carbon.dhcp.thefacebook.com>
 <40632FBD-8874-4B6C-A945-F2EBC96CF12B@fb.com>
 <20210507030606.GA27263@xsang-OptiPlex-9020>
 <YJV+Vn9eGfIlxDQE@carbon.dhcp.thefacebook.com>
 <YJWQE8AFjyYpsLYA@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YJWQE8AFjyYpsLYA@google.com>
X-Originating-IP: [2620:10d:c090:400::5:6bfa]
X-ClientProxiedBy: MWHPR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:300:16::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:6bfa) by MWHPR13CA0008.namprd13.prod.outlook.com (2603:10b6:300:16::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.20 via Frontend Transport; Tue, 11 May 2021 00:34:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bf97e33-c396-45bf-e11f-08d9141491c5
X-MS-TrafficTypeDiagnostic: BYAPR15MB3029:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3029F91BEBF1EAA7F4B1FEB0BE539@BYAPR15MB3029.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgZhRVnLGfQ2Ex4gFT2K4i+/sIsINwnGQ2iXrQJ+KT44DeeVyZq/TZNlKgvaXEMhbLsMCtdgve8XptbCoRoJ27ACCmRDfDSEGDZKMXRgwnFJILTsLSbxMBlS+AwmR3rLERhwLKdW0R9oE1fUQ17ml+jJn5qihFdjeU9Ek8DXNofGR+/X9g9kqkbAnyw2AI9t+/6yNJLw3D1YNZ2f14lm+jrA6UxBb0JdrXF3F0+sfVS0au0gxHjxD0Y0ENCE1VYMO6bNkXnMie0MyJuSQxxe0znaQ8adifSUQuUsg5Zp/VNiQaG1WpWslwSEa6mLWqAMULpB+DcyJ6N9apzJk2qTZIiJOaDsItOlNOEUmXwXt0mu7qtGHmyLtvT0bLi4DkjnuC8CqH4A406IQI0tjH8ygsJ22Hh29cK8L5mwuQ2N503Sk0f4BChGSKiIBBCiwufbZUbp15zAAhvbZCya4FcBImCZYJOY7wbspe6sAY7u6Px6N9K4nBbzQR0H33T2R5aHeN3haUq/bjpV2rseurVEXlmP4/d9O1lERd1/Zi7i8wkbsI0rT0qRNS6MUa4uoMHk4cmXxsNYk3KWWZfCasBfcRAFRFfK+6zEp4iCBhQPLi5XoD/fPvVap+Sn1JjiyyHAeX4bY3ZliXjBz47IqHrVaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(8676002)(9686003)(54906003)(16526019)(6666004)(55016002)(316002)(6506007)(7696005)(52116002)(478600001)(186003)(5660300002)(6916009)(66476007)(66946007)(2906002)(38100700002)(4326008)(8936002)(86362001)(83380400001)(66556008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Tn0ugLtWbZ1SwQEE8oirgyW7M0pO03yMizY7OiHP9nziWpLv4BeJsS3zAgfA?=
 =?us-ascii?Q?IMafDWqIf5EAOSUlXWUTVHnyyBduauVKTF4LyEjrRFlW47GvGLAeKR6/TAxI?=
 =?us-ascii?Q?5iRwWLbcToivtli8YAWRc7z++5UjEbRYTycs3kxKwXAYnor1Z42C3q4Cn9Ja?=
 =?us-ascii?Q?fTRy3GpQBrKfE4twMspXSEed5dLEuLNTTtxoSwjZN1QlGX4gq7A6kyzYyt1f?=
 =?us-ascii?Q?pCoCYfL2DNbkXsu5ek8qZQwUn3BoquFxOheMYu39mIlgprezq3/8ZiV8wBMT?=
 =?us-ascii?Q?+U4NbVwAg6ACfd4KSuTdhBll8GouEfgX67726Qpy3T25d171inNPqM2z39J1?=
 =?us-ascii?Q?ZdoYeCKofOj9BaKGKYgag3rR1D7dcHsisoHsei8VcEQ3H4WIMXBUk72jL0Iy?=
 =?us-ascii?Q?Kamk+8yyurpeB/PyUNJ6ByBW1Y7lt1ZpTOa417rh+hkrPCCMWZwrrx7ga9ZG?=
 =?us-ascii?Q?sEgnN53XXzORnfm/yq3rDYMbi9xZdCZTzMzJ2/T2qlOm7Bc188pOtgdwOsqO?=
 =?us-ascii?Q?kIdolZlUMk+MRczb6hWlF34JOAO6ZOSJpvP9Xz+NyX3TJhyX7azs2NMSC8Fv?=
 =?us-ascii?Q?ADuUJOJckQJXmf9RutLbxC8+3QFLJKhoG3LLYCuhR05xBBtWN9iWVabvAUYp?=
 =?us-ascii?Q?8bMDVzZG5lyBWZBZw3OkYMNnOmsNB8/xDL1UA1g0btik1gyfCsNYWHnhCWfs?=
 =?us-ascii?Q?nItjwSllECvFKCkLrv7ez9WGFuqSVO3y+lapbQ0hgCUt9zOev8BaQhivcx9+?=
 =?us-ascii?Q?gGig1wsTOzCCXqq17EPjtVIuWG+ikO83LrHyhWx9bU6ZcqpPm5LyavTlyUOT?=
 =?us-ascii?Q?TpTPErzqGousLgm3sXlzamoqq2G83E+Utzbvdz0Rnqks3o0zBxoS/zhGTwak?=
 =?us-ascii?Q?pRwKekg52o0ZwFAxQI0QJTALs4AhSyZ3Ynn1ZwryNrkt+n3elhY6VRBFh2+w?=
 =?us-ascii?Q?cu6pa6yjE6OiueLBZ6qhe3O6Oy6HAIwKTgeIwWyAL8cFojNoUc9XgXBPWa1M?=
 =?us-ascii?Q?MnT5Fy20FF0oAO1n8FzQ4GOA0hJdh7X4qog2LYuCqo0fpLJDUmBwttQDsR3e?=
 =?us-ascii?Q?+l/e/G0REJB8ut2/V5anYu8F68XgxLKu6x8ACNcd+WlLqg4TujXvbPIH3sfc?=
 =?us-ascii?Q?PKKOwrtLYV2YrV7bkqunxA/jTJu0n5cOsHIjo4SIByaWUBatGlgHyeh8I7aY?=
 =?us-ascii?Q?oNzl6eXRbv7Yvt1bX7dCP3P/05Guy4bR02ir9gdPvMXlbmWJaKK5rCQ9HzcA?=
 =?us-ascii?Q?/A3SV8knhCpB8gIbzSQZUzPlYV2QXEAtad+GBukODuW+EVDXVMmESw0xs55m?=
 =?us-ascii?Q?ExiyodgWWq8wx/gf7U7KF0LXJCK9ChPIguBI3ybnMIBZfw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf97e33-c396-45bf-e11f-08d9141491c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 00:34:43.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NndhdCqisqxhVlXUli1zMQ70HzHdPaxaQUjUMLbxU7APMEXM0oxLBypBex4PCUtR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3029
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: L38iZvf17_xdtds648jehE4ia5yO6QNv
X-Proofpoint-ORIG-GUID: L38iZvf17_xdtds648jehE4ia5yO6QNv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_14:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105110000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 07:08:03PM +0000, Dennis Zhou wrote:
> On Fri, May 07, 2021 at 10:52:22AM -0700, Roman Gushchin wrote:
> > On Fri, May 07, 2021 at 11:06:06AM +0800, Oliver Sang wrote:
> > > hi Roman,
> > >  
> > > On Thu, May 06, 2021 at 12:54:59AM +0000, Roman Gushchin wrote:
> > > > Ping
> > > 
> > > sorry for late.
> > > 
> > > the new patch makes the performance a little better but still has
> > > 1.9% regression comparing to
> > > f183324133 ("percpu: implement partial chunk depopulation")
> > 
> > Hi Oliver!
> > 
> > Thank you for testing it!
> > 
> > Btw, can you, please, confirm that the regression is coming specifically
> > from ace7e70901 ("percpu: use reclaim threshold instead of running for every page")?
> > I do see *some* regression in my setup, but the data is very noisy, so I'm not sure
> > I can confirm it.
> > 
> > Thanks!
> 
> Thanks Oliver and Roman. If this is the case, I'll drop the final patch
> and just merge up to f183324133 ("percpu: implement partial chunk
> depopulation") into for-next as this is v5.14 anyway.

I doubt it's a good idea. I reran the test with some debug added and it looks
like it doesn't  trigger any depopulation at all. Everything else looked sane
too.

Dropping a reasonable patch doing a good thing without any understandinding how
it affects (or even can affect in theory) some benchmark sounds like a bad idea.
We'll never learn this. It could be that the regression is caused my some
tiny alignment difference or something like this, so any other change can
trigger it too (I can be totally wrong here, but I don't have any better
explanation either).

Btw, do we have any similar tests?

Thanks!
