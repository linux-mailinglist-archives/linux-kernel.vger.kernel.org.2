Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7697C40C113
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhIOIAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:00:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11314 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbhIOIAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:00:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F7iCqJ032082;
        Wed, 15 Sep 2021 07:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=5lfPBwFOMqsGfa7hBkZMuY89ElkAHRF7zXEYt8r9CAI=;
 b=pWTU/FQL37jtelx3RxwoPN+Bqn4qHEhum604e2qhGgCdHoTB7vksvhZuHduB3wWyY3r1
 hem1UO5XcPEDxxDmu5pXYREMvSybBRSnf5PAp/vtT6bb7q/8q9QUiijYvStu3FczAy2n
 URU88PaE0gNIvkpf9gRfENW7do6jaSMEJ5PnBy6zXYF9Q+iJca5UCpM90su5ywphF6o5
 VcU5HgexFoMxrq56CoWDsXZ/7jFBuBvgshIGYfZF9wnCVCEex/hnDLzWmhkIb3I4Vspo
 xzxHneh9fieAKcdce/hXmImM5pEIjcvIimCRU58MxI1fAjwJ70rQm6CZjZHSSLHtlgGV 0Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=5lfPBwFOMqsGfa7hBkZMuY89ElkAHRF7zXEYt8r9CAI=;
 b=etWlM1+rKOfSZ0ofOW++//VCJVF0rDWTdBQ7KtfjZ039dxxAi5DFCEItRZ04U8bHFcrk
 beJUDfrYsg1uW/yFx9CThpbiLQ4JZCq1MAwQgSp8mdYBI6ZJ2QXIZgFEFC9Q0cmDMrEC
 wBy+myP9Sk0bXsc76c2V7eHRPpOxtfFE4ADKRfM9HymiT1MOFLooIqmtK6wEXND6GG9W
 IsDrpkh+mj8FfK0OoQme3n2Dj2UGU3it8z9S6FSWZf4j1gqttNlomE6ADImjg+GyuTt1
 fEa9k0gHdtTkFIh0b8cWy1NQoxRFaS35mBNfl/jZrUh6NlhDJWLM3bwyJbXKygvkfMVT xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p3mm0fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 07:58:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18F7tC8q101565;
        Wed, 15 Sep 2021 07:58:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3b0hjwadf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 07:58:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkV+bPD+XyCSZY+xeL8pe9Td2l7F770evi46aXGp0YLMLX57kXBhVJT6A6BNT4cPMaKmzYcCYw395nMY6gITAP9lEMAWT4zWUDvuFRdkyhlvKgjuLJKPAHJ+NkuUXzCoFxqTsAV6vjsbz/t/zFJBzZ8Ok609bgRE8BIuxUzkJe7U3hZAF+TEQ36Zh2JRpBwoRnlsQ786rKO4JxhE7XLIEdZZjCeIrqb0PlunymUm0PIVRF3z95RyguOQPtUutc5G+jXkzzZzuG4RHVb5iz+XJ3MIestkWbvby3dPdqE55/wOGDJ9TpsVV58xUTtHauHIvNEPSIdEh9zvf30j9Bp19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5lfPBwFOMqsGfa7hBkZMuY89ElkAHRF7zXEYt8r9CAI=;
 b=VxJ0koxkh9qLkdHCshfqEJX+q+ruGhJhrwDhRBKhXzOPhH3MaChqJpabccOfVIqaoyQrFHAundrwcX6Ib8MvkP7+QEKxBljjAEAIaMzu19cYfJgPFyqoF3Fwu7xOGH+rii92ITEI+ksv3RTn38qPBam0bWyDX+R5d6OKGB+QiF6fT4kD6ARyJG4uDQ+bN3KfkCNOKnE+ERMvcXkj/fkp/VQfOGVvvh+DFyYERESBrBD+wy5Q370NdaAMkerhvSd0u995Bcgom8gzfolz3O83yd48zH4EFeuAA9kpQ5uXud4SPTSyFwUOuL6mV6qw0OGj0BpvrUETwobOt2B799MPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lfPBwFOMqsGfa7hBkZMuY89ElkAHRF7zXEYt8r9CAI=;
 b=MeWZhd4VrieL4ACNzhcCqOAochoTabArVjgdoCOT0KzvT5E/w5I6OE0UiMBaV9GB93wTxItuzV6OF/MidJuvDSDA+jV7qLMLWahpoyx+CqLDtRdelaLETbYH3+N5o6o6iEOa7SqpWNqzUwOSkKuc3LdtRvRAz7MlCyHGGuh2jeQ=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5555.namprd10.prod.outlook.com
 (2603:10b6:303:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Wed, 15 Sep
 2021 07:58:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 07:58:46 +0000
Date:   Wed, 15 Sep 2021 10:58:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jason Gunthorpe <jgg@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jgunthorpe:vfio_ccw 7/12] drivers/vfio/mdev/mdev_core.c:319
 mdev_device_create() warn: variable dereferenced before check 'drv' (see
 line 272)
Message-ID: <202109150907.zXy9cIVX-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Wed, 15 Sep 2021 07:58:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ced7dd-506b-44ca-607a-08d9781ea4be
X-MS-TrafficTypeDiagnostic: CO6PR10MB5555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5555998FD55BB793E10A8BBB8EDB9@CO6PR10MB5555.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QIjtkc4Cb/Zq5hXRcIdz9b6X8qkp84SND+pw/NnLXkRcEulIlZPuYxrZksNcAfT+qvXMK7mvRvYEhDtf9i6JkOyNRG1+5dyYhpaDVqFEMKNzqaNLFT8RpTc83qSImbL65B8CAUCBQmS//dyX8cCMebwk3iik6hm5jqX14t4eLf6j+n8IWgNKm6CSN3nwtCr8k92s8GxLJMB5h3sPUPd1clj+nYbjqDAyMZRiViFduCUh3NtA2dzvH2TMhQXIKBPgIXqZoQv+b0p+s6qm/MlD3LUf+prmpBfP+gaxa9YJreprqs/nARA3AdB1Q9pU8HWXRzPXX0dglTzxl7/+XZIPn876rPc8IuRUUArBN4/UrsNO37CC2czFf3OmqU1V0xUByLHNuyb11+LO6fHqhvsr7USA1ENtFnFAX1jfDli3Iv+7udzkk5KoIndSBK3GXobpsZ3cOUc/7okeyUrmBqJkKXZELypaAJU7aGopXn8Dau/vlEQLTjnNuZ7L5A5cze0kUzWokoWUZevAljAPs891hGOkAHlRX0Gh5Xt+KPh4+nmTUas53Zwl1TYeszPmMFVfdDnM+H/3N07pSrX+8DJT1F3MRk4IS3ihrsZoGMAzeS1B1ctvDgB85Gu0QDw2hGuFDqTnnlQQ3EiH+gSstPZ4YXFS5g7syfiv0K3dV0RGaUlC4IO3mXAIsKH+NrZHnl0LRg6C/bNIDsdp92ifkZr2VsOQLR1D0dlD9UH+hgd411hKnZxm5xn9iZ9IOIoRjMsrr1kyN6VV32tmUCCypoPU9feFRR7psNPz4IbwBTHDLgufra83nFGuyNvPGxIqI+6jk+DVWdLqr3fwmWk/XqrFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(5660300002)(6666004)(1076003)(956004)(44832011)(2906002)(4001150100001)(86362001)(36756003)(83380400001)(316002)(8676002)(66946007)(66556008)(8936002)(6916009)(508600001)(966005)(38350700002)(38100700002)(186003)(52116002)(6496006)(9686003)(26005)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fE5mXC25iO6ySwSLBUmk7fOuTLc+iOjKWMgc7uKupGdqro1lYHE2a1hx/WtP?=
 =?us-ascii?Q?Pw4JnS8TLWgN9jnWEZlpm0eUCkfNXLEiwL17kW0LkFjaEhc2s815RzSw6Vns?=
 =?us-ascii?Q?7lyyQnf3SfO7zGpqW7NwrSipjQiXhBd4TJay+EOT2Bc0gAlKkQnrxc+Iea7O?=
 =?us-ascii?Q?oAorhBMTvhzCMMNbDujupURFAChjNYREryS1fYxn+2K0ze6fRFzdTkG5Rom3?=
 =?us-ascii?Q?hwjhmWNiuWKJTCxL4XGffMrL284gvSkmHcOWWwZmmuqKuSkmMKrdbGGG0MZL?=
 =?us-ascii?Q?bc62l2FiZkWiK5Wjr89FzZ6rVBpZ02DWwZ95NAzZ/ZSp4Bfu3tGmiRkjZ0GE?=
 =?us-ascii?Q?QZjffVSJzFClkV67tIKOBpC8sx+m5gAD/A6Q1G0L9H6HTM/hKRZUQBX6mca2?=
 =?us-ascii?Q?Aa78JEuk8yQKzIPEpuAGB7/9X7ES1VBhSwqHnvn7LCSPeReUa6ddmtvoyxD/?=
 =?us-ascii?Q?fqm+WIsW4lk6/+OhGZh25pQ3ShfFu7t7LbGfraYoEoUq3JIvJU4YKOoxDWnU?=
 =?us-ascii?Q?MhI7e/yI5fmQKGKwvMHlhjNj00F+ZJ7MWznfC86+eYnz1BXsdJCgODzOO0Vr?=
 =?us-ascii?Q?NZYumxMwyWFP45yCSU/G5w9RTBS9b8XmCr/ILEU1pZ6pqv/1fRBDARlDPCet?=
 =?us-ascii?Q?EHiKnqUv00wjBoMb8+8Ye+UskA+8W5Bx4XUH9LmDm+FDKq88yq6Uw1OmM8tO?=
 =?us-ascii?Q?su6SqEtSWZRlZcWEl1k0cMnwHhCJ9XfanfClg6DTHBICY9lHY5wRFQMkKPsn?=
 =?us-ascii?Q?pBm7Yx2neydAM1kQUQ7sO4EONqT7PjTB0g23aP8+MxXM6eLPbMswWwLLuoOF?=
 =?us-ascii?Q?fNyBLLFg/fskYk0qxwb87pkzBA95BvM2pnuFP+ZmSm9OvtwvPQY4x7y4KARy?=
 =?us-ascii?Q?l032Z5UJEMLuBqX1FLA1JKtfrXax1wBouHbKBFg9LVd98KW3hesJ7bqgGNpH?=
 =?us-ascii?Q?DrH2MD33AL1R7LFK5TaNPVEjZzAlq9kWR7FSGXwx20sYJcnU46WYaSpTLyEY?=
 =?us-ascii?Q?CSXCYpHh/AiHY/CN9affcMlLwcJ+OUc3EI7q1aYw8AaVhf+bjZaW4kPPG9EV?=
 =?us-ascii?Q?0A0tal74HP3Qx3j6wdTEEn5wxjKuL8nUiPEuO75VNbxTtFouFfBykCZ1dHJ3?=
 =?us-ascii?Q?08U/tirpvYC3sqTpl2aB/ItKOyswrWsFOaL+krdBllPvla24BnF9iFXMagn4?=
 =?us-ascii?Q?SlmSVr6fkIfpLJzcdXDVB65MX2n5ejZKJrkTQP8bxsPiO89JXu0XVYnZOBBW?=
 =?us-ascii?Q?tj8rNyFWs9jb1sO1zpgKL/PzZXraFAMWaxLMFDbgFR+BQnEliJF+XZH1SB8G?=
 =?us-ascii?Q?rz3h2n1JaJF9Ky1qA1rd29x9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ced7dd-506b-44ca-607a-08d9781ea4be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 07:58:46.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPIgqQKHCCs/Km5zSE0obankSKmHMr0hyA2eXTS9jRDoC5WF92qB5qQkEAkVcRV6gVxRi3bCm3ekuDIA1ufC41t64TwwhTnju+UDy8FTIUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150050
X-Proofpoint-GUID: QcYb9hkoRnP9MyUZS7LJ7fLOCVo5F1WV
X-Proofpoint-ORIG-GUID: QcYb9hkoRnP9MyUZS7LJ7fLOCVo5F1WV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jgunthorpe/linux vfio_ccw
head:   d0d01fdc87368c19ee6cac8e7ab2c0ef7ab33efb
commit: c7863bcc74538df3d39bd9407ae77f6ef778f7b3 [7/12] vfio/mdev: Add mdev available instance checking to the core
config: x86_64-randconfig-m001-20210914 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/vfio/mdev/mdev_core.c:319 mdev_device_create() warn: variable dereferenced before check 'drv' (see line 272)

vim +/drv +319 drivers/vfio/mdev/mdev_core.c

417fd5bf242d76 Jason Gunthorpe 2021-04-06  255  int mdev_device_create(struct mdev_type *type, const guid_t *uuid)
7b96953bc640b6 Kirti Wankhede  2016-11-17  256  {
7b96953bc640b6 Kirti Wankhede  2016-11-17  257  	int ret;
002fe996f67f4f Alex Williamson 2018-05-15  258  	struct mdev_device *mdev, *tmp;
a9f8111d0b5f44 Jason Gunthorpe 2021-04-06  259  	struct mdev_parent *parent = type->parent;
88a21f265ce50a Jason Gunthorpe 2021-06-17  260  	struct mdev_driver *drv = parent->ops->device_driver;
7b96953bc640b6 Kirti Wankhede  2016-11-17  261  
002fe996f67f4f Alex Williamson 2018-05-15  262  	mutex_lock(&mdev_list_lock);
7b96953bc640b6 Kirti Wankhede  2016-11-17  263  
7b96953bc640b6 Kirti Wankhede  2016-11-17  264  	/* Check for duplicate */
002fe996f67f4f Alex Williamson 2018-05-15  265  	list_for_each_entry(tmp, &mdev_list, next) {
278bca7f318e6a Andy Shevchenko 2019-01-10  266  		if (guid_equal(&tmp->uuid, uuid)) {
002fe996f67f4f Alex Williamson 2018-05-15  267  			mutex_unlock(&mdev_list_lock);
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  268  			return -EEXIST;
002fe996f67f4f Alex Williamson 2018-05-15  269  		}
7b96953bc640b6 Kirti Wankhede  2016-11-17  270  	}
7b96953bc640b6 Kirti Wankhede  2016-11-17  271  
c7863bcc74538d Jason Gunthorpe 2021-09-07 @272  	if (drv->get_available) {
                                                            ^^^^^^^^^^^^^^^^^^
Dereference

c7863bcc74538d Jason Gunthorpe 2021-09-07  273  		if (!type->available) {
c7863bcc74538d Jason Gunthorpe 2021-09-07  274  			mutex_unlock(&mdev_list_lock);
c7863bcc74538d Jason Gunthorpe 2021-09-07  275  			return -EUSERS;
c7863bcc74538d Jason Gunthorpe 2021-09-07  276  		}
c7863bcc74538d Jason Gunthorpe 2021-09-07  277  		type->available--;
c7863bcc74538d Jason Gunthorpe 2021-09-07  278  	}
c7863bcc74538d Jason Gunthorpe 2021-09-07  279  
7b96953bc640b6 Kirti Wankhede  2016-11-17  280  	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
7b96953bc640b6 Kirti Wankhede  2016-11-17  281  	if (!mdev) {
002fe996f67f4f Alex Williamson 2018-05-15  282  		mutex_unlock(&mdev_list_lock);
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  283  		return -ENOMEM;
7b96953bc640b6 Kirti Wankhede  2016-11-17  284  	}
7b96953bc640b6 Kirti Wankhede  2016-11-17  285  
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  286  	device_initialize(&mdev->dev);
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  287  	mdev->dev.parent  = parent->dev;
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  288  	mdev->dev.bus = &mdev_bus_type;
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  289  	mdev->dev.release = mdev_device_release;
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  290  	mdev->dev.groups = parent->ops->mdev_attr_groups;
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  291  	mdev->type = type;
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  292  	/* Pairs with the put in mdev_device_release() */
fbea43239074e1 Jason Gunthorpe 2021-04-06  293  	kobject_get(&type->kobj);
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  294  
278bca7f318e6a Andy Shevchenko 2019-01-10  295  	guid_copy(&mdev->uuid, uuid);
002fe996f67f4f Alex Williamson 2018-05-15  296  	list_add(&mdev->next, &mdev_list);
002fe996f67f4f Alex Williamson 2018-05-15  297  	mutex_unlock(&mdev_list_lock);
002fe996f67f4f Alex Williamson 2018-05-15  298  
18d731242d5c67 Jason Gunthorpe 2021-04-06  299  	ret = dev_set_name(&mdev->dev, "%pUl", uuid);
18d731242d5c67 Jason Gunthorpe 2021-04-06  300  	if (ret)
18d731242d5c67 Jason Gunthorpe 2021-04-06  301  		goto out_put_device;
7b96953bc640b6 Kirti Wankhede  2016-11-17  302  
5715c4dd66a315 Parav Pandit    2019-06-06  303  	/* Check if parent unregistration has started */
5715c4dd66a315 Parav Pandit    2019-06-06  304  	if (!down_read_trylock(&parent->unreg_sem)) {
5715c4dd66a315 Parav Pandit    2019-06-06  305  		ret = -ENODEV;
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  306  		goto out_put_device;
5715c4dd66a315 Parav Pandit    2019-06-06  307  	}
5715c4dd66a315 Parav Pandit    2019-06-06  308  
88a21f265ce50a Jason Gunthorpe 2021-06-17  309  	if (parent->ops->create) {
c2ef2f50ad0ccf Jason Gunthorpe 2021-04-06  310  		ret = parent->ops->create(mdev);
522ecce08ab20b Parav Pandit    2019-06-06  311  		if (ret)
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  312  			goto out_unlock;
88a21f265ce50a Jason Gunthorpe 2021-06-17  313  	}
7b96953bc640b6 Kirti Wankhede  2016-11-17  314  
522ecce08ab20b Parav Pandit    2019-06-06  315  	ret = device_add(&mdev->dev);
7b96953bc640b6 Kirti Wankhede  2016-11-17  316  	if (ret)
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  317  		goto out_remove;
7b96953bc640b6 Kirti Wankhede  2016-11-17  318  
88a21f265ce50a Jason Gunthorpe 2021-06-17 @319  	if (!drv)
                                                            ^^^^
Check for NULL too late.  Probably move it forward.

88a21f265ce50a Jason Gunthorpe 2021-06-17  320  		drv = &vfio_mdev_driver;
88a21f265ce50a Jason Gunthorpe 2021-06-17  321  	ret = device_driver_attach(&drv->driver, &mdev->dev);
88a21f265ce50a Jason Gunthorpe 2021-06-17  322  	if (ret)
88a21f265ce50a Jason Gunthorpe 2021-06-17  323  		goto out_del;
88a21f265ce50a Jason Gunthorpe 2021-06-17  324  
417fd5bf242d76 Jason Gunthorpe 2021-04-06  325  	ret = mdev_create_sysfs_files(mdev);
522ecce08ab20b Parav Pandit    2019-06-06  326  	if (ret)
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  327  		goto out_del;
7b96953bc640b6 Kirti Wankhede  2016-11-17  328  
002fe996f67f4f Alex Williamson 2018-05-15  329  	mdev->active = true;
7b96953bc640b6 Kirti Wankhede  2016-11-17  330  	dev_dbg(&mdev->dev, "MDEV: created\n");
5715c4dd66a315 Parav Pandit    2019-06-06  331  	up_read(&parent->unreg_sem);
7b96953bc640b6 Kirti Wankhede  2016-11-17  332  
002fe996f67f4f Alex Williamson 2018-05-15  333  	return 0;
7b96953bc640b6 Kirti Wankhede  2016-11-17  334  
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  335  out_del:
522ecce08ab20b Parav Pandit    2019-06-06  336  	device_del(&mdev->dev);
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  337  out_remove:
88a21f265ce50a Jason Gunthorpe 2021-06-17  338  	if (parent->ops->remove)
522ecce08ab20b Parav Pandit    2019-06-06  339  		parent->ops->remove(mdev);
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  340  out_unlock:
5715c4dd66a315 Parav Pandit    2019-06-06  341  	up_read(&parent->unreg_sem);
fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  342  out_put_device:
522ecce08ab20b Parav Pandit    2019-06-06  343  	put_device(&mdev->dev);
7b96953bc640b6 Kirti Wankhede  2016-11-17  344  	return ret;
7b96953bc640b6 Kirti Wankhede  2016-11-17  345  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

