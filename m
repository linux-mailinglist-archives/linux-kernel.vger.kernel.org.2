Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A644405A3A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhIIPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:37:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17414 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231600AbhIIPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:37:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189FU9p6029664;
        Thu, 9 Sep 2021 15:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=wnhuu5WkRib+gZq5qXi5uRyLT6HRKpgV+PWAz2/Yb3o=;
 b=DLuUoubmfBGa4OZFFB42YrA3iZfQJoTZDpzsT3RZuwFuGCN7sYdS11j5WEu9GtTWy5/D
 rk8Vmm1guVlyXLg+EYhI+HYk7IOhERGtEj/XkTdzkKUUiojOuWbBGoeQDZnm7px7aaWI
 4bDfpDlKzLMLbEKH/McyEtkFhESlBnAVb9YoosNXrDW4eBocgG/pvH5CfcxGvF1jHBme
 YBTlkqy0yXmD4fpZ08CRrXFNGJhGfk13WW0ASvphFVVPODRg4nGQ+9PJUeNTi2KcpMb7
 Tt1Qr4kwpNuiiUtQtDUXs8veopObL+4IXRcsCBbJOwew6p2aPbWLxH8HpscZ2uXhYs8T 3w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=wnhuu5WkRib+gZq5qXi5uRyLT6HRKpgV+PWAz2/Yb3o=;
 b=cztsFAAH2NMaeMfhNevXrjD5ijyiYT9fN098IGrz4KZ51knheR5ktLqHr57b2kWFwlMV
 N7IW1mJUKxS/vsAkWuHG3DruwyN8ZG+rad11/qxhUVLh+qPAzXLXF/UA9UJW8hzhkKJW
 6wCxs12+ft1/YHlv0MfZpD7mkaVlnhgeQxjyBOVHLJsK6tNit3TgweNXrPjE8ErWSSXn
 5bP9UdQhLDJJXqKHy3IXmmS5N9K1YkGFkgXgdP/GUlcs8P2TPYAORONfjYq7Agoio1h1
 cLMw+kG89BGQGsrJT2Jd0ErDI2ovswzL0NQpSBdCzN8enTb2e6oE73JJ2P3vVP2a3u37 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayfe915ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 15:36:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189FaHZM167416;
        Thu, 9 Sep 2021 15:36:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3axcpqcsmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 15:36:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBBupzWGtWTSTanMOXrIHIOC6y9Yeg331Zi1yDyY3BsKhd3RlftnGEnrGpSi2yIW4ctWMxS2YYQZFhwCe5/v0z+niyh22zzyjR0RwoAmnpfZfn3SW9qlsq5wudX2tEC8yLUB5FvMq0QwI77V8g2iPdYfmiuhhIHuRuVri+AhCAqUTVFV5pVL9T8PODvL6QwmuFFK4Jin7wPd9p3Teg2IdvuSzio1Tqf53YSQAeae1ZqsGl8lxpyjvX60rFU268uN5gyki6d+R84wIw7+PP6Z1rom1NjxoU1Nt0cPk9/y9okNhTTVmhknrnDFJ7ZonCbYhSJ3rV32tuMUfj0qN7jJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wnhuu5WkRib+gZq5qXi5uRyLT6HRKpgV+PWAz2/Yb3o=;
 b=fqh5Q03eG71gEmWmooeElpW98kRLeGqEdYWaNUv+xk4tIry1R5p5WzUSF1g9aEYRPr43+Q6GxgBu1BwUrxEYbAAXvS8Is1H3izxxgdtmKklr+EeJTUBAG6Dm5BoavPy64sVsCXF34+dwtMnNKO8xjTOklERVJ8k/nhmHjQxJf4qhDThiALXKMemp4JMBk6C90HkZxSaPirjMVGuHAK8L3EwlOUmgCfBllyiadnCQfXC53m/BO6uz3rF2+LrPFuUwLaeC7GdjZk1oTNNWETeFp6eSdmuXAwPkF1yzLCHF2qsoGJs3j9+thuXsfYDpqopYrIbnQytvfLRq9xCRqdKSqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnhuu5WkRib+gZq5qXi5uRyLT6HRKpgV+PWAz2/Yb3o=;
 b=gG2eBpjKxgc/SPlViWZxtxFOPQIwTG+qBTMyJz148QWDT7EUxjPa2ElCCydWj7WX9kze2VthnRTCzctsBoHQwLJxLyjRfTZbq7+tw8Ii1tUFA2LcTKW2WiGjus/+LTUZDYpiwAEku7k/yESn1pZS/RmR386S9YYnv4eLJQ018mM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3080.namprd10.prod.outlook.com (2603:10b6:a03:87::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 15:36:28 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 15:36:28 +0000
Date:   Thu, 9 Sep 2021 11:36:23 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Will Deacon <will@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [swiotlb]  461021875c: EIP:__dma_direct_alloc_pages
Message-ID: <YTop97GqcXnldiuC@char.us.oracle.com>
References: <20210908085239.GC839@xsang-OptiPlex-9020>
 <20210909150428.GA10436@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909150428.GA10436@willie-the-truck>
X-ClientProxiedBy: SJ0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::28) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
Received: from char.us.oracle.com (138.3.200.29) by SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 15:36:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a0d9862-1619-4756-e886-08d973a796b1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3080:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3080D0B0C40D697E9B06A71989D59@BYAPR10MB3080.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xWGv7kh7QxNVtY5cL8J5XwyV3HesJYhPSZ2U+rVu11yF4/go8kh0R4RM4IFIDtc+EVfXe9OGbLqumnmzF0cpwM2ENoL3gJzo48laz2gN6X1nX2GEiYqGAiQTBENWp5EA6Wb/7z36OXInrlIUSblQIPpN1eC2SDBf98u1SouBwkjAvESQq0YAdmkdjBrRAKH21pEdxToqAjueP4EqPcdvQgL4HcSWUqDv9E6/pSnL63UJOT5K9zqsOl3WwWREwnggRtAiAFbZl3FMyovdJ4aoZT3rpk297G9zSDlWLVpva971+rI/P9cxxtvDLGvTDOhL2e1iwWeB5AHdIAjhEMA/Q6NIZ4w3nCyWXwM2cMd6tyR7URwOg9zGyNPdPnihM55SdZR3t7TzMjwSduvoaC5P113VdlgInMGQS3VVZPY0H8h3zhHCsK/xrohJFm1hAaLQ4+8xNQg99Z2mT85HRk3PdLEhluFeouedKJVNaEZwEKEab+B/fLoErP8OE/vWa5XsPWBNmCkrXcchxWwU+QKlF+pUzQBoVpkN1rqDkNHpg1mbd8oxKKVPJqMJ7Ri6T60RoE3SBT2+tjQel9jgRq2M8BmHwmrGJzs2LtKzayFMTtmFbpOEg0bTtvF4zLZ2CHAppmgrXGa9zCYKpUub4ey9Z0wvZRZ/NCY7REWbxaw2DQnbNtFBJDHyV6HdInUDcIH5j9I2lfeZh6IAJ5cF2C4LG8Umz6Z2QWw4o3vbBztOlzDHLoSTht0t8L0FwXcnlbQU4CgEuvmaKbJngJvsE7DdwZioButPUk0z2JN4Z0qwUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(39860400002)(346002)(86362001)(66946007)(38350700002)(5660300002)(26005)(83380400001)(38100700002)(4326008)(2906002)(478600001)(956004)(6666004)(7696005)(8936002)(6916009)(8676002)(316002)(966005)(66476007)(54906003)(186003)(66556008)(52116002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9yUlsjWIIn+DA52pqQt3JRo2cnuyQphyWHQATt74VnCG41b7qkSOzOz2W605?=
 =?us-ascii?Q?+j2gdVpbpfgBKjuywzV01h4GdHZx9zhLa7KIsn6IRQcGKLJRNvn2h1WqrQXL?=
 =?us-ascii?Q?3IpF2NKaM9oeOAm12TQ3KfFfWRNjUBgCRTwXRAqaH+0cAruO8Xb2V7fJA/l5?=
 =?us-ascii?Q?v7mc5NyKxJC6BRYENiWkd+k7Diqz7R+ZgNxaSdHDBNmzEB3f5560G53w+kVv?=
 =?us-ascii?Q?p10nJMIS+lxkFeiPiVC/V/y8+Oe8ZmKtUm/k0GrTKMEHX5mjYtoZ8UObEMFZ?=
 =?us-ascii?Q?sT4/qQPWvRytWTygTPie3pYA0EX4ONEv/H3yP3K9EeSZh/zOb8L88BgXs4mc?=
 =?us-ascii?Q?b4+wRU/lFvrzbEB+HfT+ZQ/InRVFaOhz+7JSRiZBI6jNReTGIL4g4mqHvMcG?=
 =?us-ascii?Q?WRQrYEQarBX3m+axdg458+vgF11BCYKsudn0Ss1fU8C3G7E2Q5xn7NLD7FuI?=
 =?us-ascii?Q?VYXJyAT1HZqd4dxsBMtZh8CAK/th4wRcl+1UMOxa+BKjpsPasYuWSMWscXFz?=
 =?us-ascii?Q?o2Uvcrkxs3W401DMI0BYBhs9Qid5l7w29npMAYkZ8k4az8zTEnQ4VZ0rsOsq?=
 =?us-ascii?Q?8y49FC/zimBjbb09B6e+DJl4tppZCOz2iXKaDSPslIAsyxO4qmMjyXFYHczw?=
 =?us-ascii?Q?LytdVoNFiud+oM8mw4K0+a2ay+s44gPEAIt8BoGZUgUsKVuofV06UUzWduXd?=
 =?us-ascii?Q?UTAMpbzRArDaVGyRB1HBV9qtK4ahhOpkMeEK++8JrTWIsdtApB37QbHT5CVw?=
 =?us-ascii?Q?S3SOxFVzn8WdUVeHANPlHdus4ynkyUy9E9aDpXubnlly6kz7loc5s0G9O4RF?=
 =?us-ascii?Q?VZu7oRjHS+3ty1GoSqy6SqCb2ETPbxT62JKNFs8sikYnu5ZKe7ooJP2YOzFf?=
 =?us-ascii?Q?Etm7QyrtNJ2N2Ogsx5IvDfTQj7UKS0QKmlGxzTMVGA4En2bowkBPB/KkAPND?=
 =?us-ascii?Q?q7lGgs9qxBnlu4zder/jPKuvrf81aIrKxA+RPiURfCdgZ5UhSqFtp9QhwFuI?=
 =?us-ascii?Q?mz2yQO09VAYNoPnnheBCs16/zygX5KkCE15wKpXTWcFDfBl/4XDMyPk0oF98?=
 =?us-ascii?Q?seKNAHtHGDvBW+L1NrH6J1uZbf1BB4N6V1sIW83iD8qfCOLQtS5GXUnocfl0?=
 =?us-ascii?Q?0aBgF23tEHivYe+Vn3UI0Pdd7jvxBz7girq3yEqE4HGOcIjZ9sscPABZanVg?=
 =?us-ascii?Q?Gq/vaS6MdqcB7kIvc/1F1tkevxo5guE1VJ1EEpr7EzDZHetDBp368/IeW+FQ?=
 =?us-ascii?Q?4TqV55YAT/yrN75pgO0NRiSu0bsL9ZaKR2BW9SxfgTsxSGSY0rwLhsMtlBOB?=
 =?us-ascii?Q?eY4jutJBBbq3z+faoEomqUop?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0d9862-1619-4756-e886-08d973a796b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 15:36:27.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER7huzY5uYaxR9aGf5bQCfwnDnBwdiMECUFegSOFBtJJ0wTXHufYDNSHdhoaM7voFx3Bb/U+7V6/AVtVTKXNKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3080
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=864 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090096
X-Proofpoint-GUID: 8SpFM3oFU9HVdPq1L0XQylq66KTwc6Uw
X-Proofpoint-ORIG-GUID: 8SpFM3oFU9HVdPq1L0XQylq66KTwc6Uw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 04:04:29PM +0100, Will Deacon wrote:
> On Wed, Sep 08, 2021 at 04:52:39PM +0800, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 461021875c5057b3a408db0aa91b15119064ffa8 ("swiotlb: Add restricted DMA pool initialization")
> > https://git.kernel.org/cgit/linux/kernel/git/konrad/swiotlb.git devel/for-linus-5.14
> > 
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > [  157.633812][    T1] BUG: kernel NULL pointer dereference, address: 00000046
> > [  157.636589][    T1] #PF: supervisor read access in kernel mode
> > [  157.637641][    T1] #PF: error_code(0x0000) - not-present page
> > [  157.637641][    T1] *pde = 00000000
> > [  157.643000][    T1] Oops: 0000 [#1] SMP
> > [  157.643000][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.12.0-rc3-00029-g461021875c50 #1
> > [  157.643000][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [  157.650987][    T1] EIP: __dma_direct_alloc_pages+0xee/0x280
> > [  157.650987][    T1] Code: d2 f6 c1 20 0f 94 c0 0f 95 c2 d3 e0 d3 e2 83 c0 ff 83 d2 ff 39 f0 89 d0 19 f8 0f 92 c0 0f b6 c0 8d 44 40 01 8b 93 c0 02 00 00 <80> 7a 46 00 74 6c 8b 7d ec 89 d8 89 fa e8 c0 34 00 00 89 c6 85 c0
> > [  157.658987][    T1] EAX: 00000004 EBX: c2713884 ECX: 00000018 EDX: 00000000
> > [  157.658987][    T1] ESI: ffffffff EDI: 00000000 EBP: c1c43d2c ESP: c1c43d10
> > [  157.658987][    T1] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010297
> > [  157.666985][    T1] CR0: 80050033 CR2: 00000046 CR3: 1b1da000 CR4: 000406d0
> > [  157.666985][    T1] Call Trace:
> > [  157.666985][    T1]  dma_direct_alloc+0x50/0x180
> > [  157.674977][    T1]  dma_alloc_attrs+0x69/0xc0
> > [  157.674977][    T1]  ide_allocate_dma_engine+0x55/0x80
> 
> This IDE code doesn't exist upstream any more. See b7fb14d3ac63 ("ide: remove
> the legacy ide driver").

Let me kill that branch since we never pushed that to Linus.
> 
> Will
