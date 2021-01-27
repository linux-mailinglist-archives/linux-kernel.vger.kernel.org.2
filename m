Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4E730655F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhA0Usk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:48:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42510 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhA0Usi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:48:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RKjDkd058767;
        Wed, 27 Jan 2021 20:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=fU2DK7Xk2Tn/GutPA9MzOsjBoGRn9d8ZH3Fu4WpH68A=;
 b=MCelA4u6qCb1gWqF3XrnxPiTGW+7wIIEOrmx8TmjR6Xd6dL0itcDNT15dJLD0ESJPHQ2
 YjH8DXmpwEwrEed/QWMXLZwW3Ccxc3Qq2Ek1nUU4UM+T0090ij4dynXGtT1X1pzW6+Va
 ZqFSidjKPActBYX00aVLIZWk2Mh0ByxeKCsl2OwaMsKBrToaxAYrXlPLB4gBLjCkl5bI
 nMtbQSR5dzIFCGpqmzMmX7vqt5Y+Lm5SuNkj4WgEkUD+QSrY34VtVorgJXw5sW/5NfaP
 ZGZdjQEf6V0UNLC0p0lQwpLl78h5CkTlryvP+QWFAEBMEAAzN37Lwip4NDefVqwJPPLq pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3689aasbp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 20:47:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RKka63074075;
        Wed, 27 Jan 2021 20:47:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 368wq0qwyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 20:47:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGFfOGNsi3L/Ji3RISHeCx0eFqz0upgmlXDPcKb3X5Y2w9TR5KniIBoVbgqUxNvoSh1mOIUOMFQlwIS/ZoIENK5TRklJtcl6+sZ2kgLO/xNKpV86be2/ayYC8rQSQa0JeFENJ2yoDggiTKBKRF7g9q3f7NeDBXGLP/ASuIq55BBWi5DJrshn/uVDFnvooeuJbfIwycjvjKkPce1ctasI66D9hK0EqAdd/kAg9cofkiy/mu/DI42YZV2AIkqxnNaOyjJInuYMfJKv510gZ1lPofhu5n5s1VQxM6Nbb8RCswpcWJLKEIrfysMChjRr2grDZmcYMj6tPYg4AGgrOITCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU2DK7Xk2Tn/GutPA9MzOsjBoGRn9d8ZH3Fu4WpH68A=;
 b=fzyBwgDt+KXITe4uiTNlzcu0kWRYimvTMhjSH7PWVfAx/HSRv3wrAW771ckMlGpOmphde68fQsAR3GqnvpZ6O2mx0wL2ZFaHKjgCODGLMCHnJqfuAsx/8otco7hwN7u5wJvez9UEb5Aey8ly55YYMk0TsqoygGyNlJ4a7G8hjzbODYl0X+GZ+zY7SiRH6f2ofp9WL8ajK5JmNFMb1esbZEskCRUEmJRxU0h9g4B4UH0W377Qivf+pDFiLOlqAZLbla6TO4eym3cft6Rdv8YpShHXXXt9IGG0J0zU2iQUqvO2LH9fG72+feoxkbEdfrAJsuccD8wvMlRarqtiW/r2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU2DK7Xk2Tn/GutPA9MzOsjBoGRn9d8ZH3Fu4WpH68A=;
 b=m82/q6/HBZwyWYtjNu5N9Wnwjk5Qx1v/3nus7rgwvB6du1idiQLGUQaVgxthz+4KjD9l3OGtC715mPy5q+h1wU/YxcHIIBbRCeCAtBzuD7UPSkESPEG2p9lity/xsZAAvH1cC6p5AkJcmyOftQOjhKpif7ahStMx/hT18OqXu6I=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB4171.namprd10.prod.outlook.com (2603:10b6:5:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Wed, 27 Jan
 2021 20:47:48 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::4d1e:6f06:cff0:364f]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::4d1e:6f06:cff0:364f%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 20:47:48 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     dvyukov@google.com, konrad.wilk@oracle.com
Cc:     george.kennedy@oracle.com, kasan-dev@googlegroups.com,
        glider@google.com, aryabinin@virtuozzo.com, pjones@redhat.com,
        konrad@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iscsi_ibft: KASAN false positive failure occurs in ibft_init()
Date:   Wed, 27 Jan 2021 15:47:57 -0500
Message-Id: <1611780477-1415-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [209.17.40.47]
X-ClientProxiedBy: MWHPR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:300:ad::13) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-152-35-102.usdhcp.oraclecorp.com.com (209.17.40.47) by MWHPR15CA0027.namprd15.prod.outlook.com (2603:10b6:300:ad::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:47:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41ae2df5-8e41-4519-0bbf-08d8c304cd4f
X-MS-TrafficTypeDiagnostic: DM6PR10MB4171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB41712D9504C8CF961F8F5044E6BB9@DM6PR10MB4171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSfxc/8NKCRAoy9Gp67HNvnq0Cuw5iTZEapzeQIHpPzetMO8MYNDFj/zpb7HW3M7rnylQ8SIhieLc69y/xe8Zy4jbyeBpzPxleeBi1ybFcwVdNffKxFpceJuIRC1tEq4MV8miDPBc7PMzm+C3OU6eT5+HFxAifuPIOff0gSPlTxRiWRyDmyhxb2qdz4Tjl/8E0UGnauGFdymT1p2REq5dUuhphIEhtzvBVRhFr09T13kGQDMfAh1Nq3HwQJd9IOY/8bT+QGFVDwbVXSbscDGmVmm4B9M2loz+GoFZexlj7CnnS+2EJvZ/IsZJEZysMcG26ulmtG20XuffbNs1dtK+XNxYHcCVGStd2OvLmJET/cqz+D3zMfvazxCHH52UyzMBmMCiEGxyKf6btKOB4OI5PYQQ5j9M+9RaZ43YuVky+Ieqs3uDDKQT4LlpUj1W8KB45reA9ZA9cxQXdol4cu1+tfAXM0dn8l+byL67rCYugb/9ynXq50B3oyILr+gNK6PmQcGABhQ81kH05Uc5jhRew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(366004)(136003)(83730400007)(52116002)(2906002)(86362001)(8936002)(36756003)(6486002)(6666004)(16526019)(478600001)(8676002)(66946007)(83380400001)(5660300002)(6512007)(2616005)(956004)(316002)(53546011)(66556008)(6506007)(4326008)(26005)(66476007)(44832011)(186003)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?12C78EGKb7snLzV5gJZkqO8xjffTPhDtBc/M5aMexABZx3nJx9ARlFUmBti5?=
 =?us-ascii?Q?dkm9ASVQTw/Ig7NJh47cvONcxsORzcJbvtDh8klKYjpOMnNiMvFwgy22cfc9?=
 =?us-ascii?Q?uS/dyB6GJQN1711Nba5eT/W3p4OwU1dc274wGobd6qPZ6kVrQAE8x460freM?=
 =?us-ascii?Q?iSwJTns4jSfOacgKEx2O8r+yeg19z9fyNWuXT5hKy5R27RxDlW9iUAv7zIZk?=
 =?us-ascii?Q?33YNGLIjfLH5Teovdl7EGeCYTBIdbmfmvBQqBNkF6I+/ZPK2cUghk4TCwVZ9?=
 =?us-ascii?Q?ps8w4EPK4xrShZlZn5flDiRGz1qUPO99XT1fGVS7e2u3QZo1VXOXCN4LqI7y?=
 =?us-ascii?Q?fYIh/y6HIeNjTNWr3xT5SD9KQS/2s9G+q/QZZwuIFGBbfNhtlxEDekdiE10R?=
 =?us-ascii?Q?Uz3FEEdUwBgGfKFDMwPKUsJig2v5mxsQ5j8VLBQ20o7RIidReDJWEb0RydqQ?=
 =?us-ascii?Q?Ct/ZgSBAnc0NPkg+zdI312Qs5V2YcgcwVHVzqbt3mp4eHFgIylwM3bPTwftS?=
 =?us-ascii?Q?2kMTYI8EG9nO5KC/xrJvguiRw3ERgd9eFGwSXuoH+1EIYkx//5uV1WmvvfaP?=
 =?us-ascii?Q?UyoZ2SVosJfxxvbtycJ1wxFd2GVrO4heY3xDpNd2cyNt06AQ/r1ENPuK/9JP?=
 =?us-ascii?Q?/9OMiJp2MjXpTZWpEvqggti/gDWc/b8za5bEWeFNzF2/44CxkULRBzFxZbGi?=
 =?us-ascii?Q?HUVkyS2k6pqXZKEBHa1G86IMHp/e5WeWpATJDTZLdC4uO3rCmA7sATn8vocc?=
 =?us-ascii?Q?zAhwWOKwiYZD1QuEUlhO0R+hAy3In1oXpi1BYZtV/5XlZgiJ34V32MffJhVI?=
 =?us-ascii?Q?LLCfRDHPNEg4/NvjNQ7WEdKX6l7fgFsa7AvYI02J/OuI3JfEbUUtY9f7Lnru?=
 =?us-ascii?Q?RT16nJMcD5egJgk5PQdLcDIikoEzImqf+sHmQaubEqrlMmeZrTW9EduFzoy0?=
 =?us-ascii?Q?Vf7Wl+rU6ZC9pniI3/EF9VybPwzE/NQRiqqrw6byis1vuiY+0rmlkNYZuZ1x?=
 =?us-ascii?Q?YTdJBqByA7z+50SrDP8DNpuGHokZPMePst0CvuHeul7ERFsnf7qpcBDKADXn?=
 =?us-ascii?Q?B9dECtc5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ae2df5-8e41-4519-0bbf-08d8c304cd4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:47:48.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkMRff8BRJXa1Xu/koywuOiVbX2V8B3McRVTMbSJ1ArMIvxr54m29XUYFPV80STLoLUn9NimScsUQRYdCMyq05gzfrRAx1waA7rrGXX4U9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 1/27/2021 1:48 PM, Dmitry Vyukov wrote:
> On Wed, Jan 27, 2021 at 7:44 PM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>> On Tue, Jan 26, 2021 at 01:03:21PM -0500, George Kennedy wrote:
>>> During boot of kernel with CONFIG_KASAN the following KASAN false
>>> positive failure will occur when ibft_init() reads the
>>> ACPI iBFT table: BUG: KASAN: use-after-free in ibft_init
>>>
>>> The ACPI iBFT table is not allocated, and the iscsi driver uses
>>> a pointer to it to calculate checksum, etc. KASAN complains
>>> about this pointer with use-after-free, which this is not.
>>>
>> Andrey, Alexander, Dmitry,
>>
>> I think this is the right way for this, but was wondering if you have
>> other suggestions?
>>
>> Thanks!
> Hi George, Konrad,
>
> Please provide a sample KASAN report and kernel version to match line numbers.

5.4.17-2102.200.0.0.20210106_0000

[   24.413536] iBFT detected.
[   24.414074]
==================================================================
[   24.407342] BUG: KASAN: use-after-free in ibft_init+0x134/0xb8b
[   24.407342] Read of size 4 at addr ffff8880be452004 by task swapper/0/1
[   24.407342]
[   24.407342] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.4.17-2102.200.0.0.20210106_0000.syzk #1
[   24.407342] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[   24.407342] Call Trace:
[   24.407342]  dump_stack+0xd4/0x119
[   24.407342]  ? ibft_init+0x134/0xb8b
[   24.407342]  print_address_description.constprop.6+0x20/0x220
[   24.407342]  ? ibft_init+0x134/0xb8b
[   24.407342]  ? ibft_init+0x134/0xb8b
[   24.407342]  __kasan_report.cold.9+0x37/0x77
[   24.407342]  ? ibft_init+0x134/0xb8b
[   24.407342]  kasan_report+0x14/0x1b
[   24.407342]  __asan_report_load_n_noabort+0xf/0x11
[   24.407342]  ibft_init+0x134/0xb8b
[   24.407342]  ? dmi_sysfs_init+0x1a5/0x1a5
[   24.407342]  ? dmi_walk+0x72/0x89
[   24.407342]  ? ibft_check_initiator_for+0x159/0x159
[   24.407342]  ? rvt_init_port+0x110/0x101
[   24.407342]  ? ibft_check_initiator_for+0x159/0x159
[   24.407342]  do_one_initcall+0xc3/0x44d
[   24.407342]  ? perf_trace_initcall_level+0x410/0x405
[   24.407342]  kernel_init_freeable+0x551/0x673
[   24.407342]  ? start_kernel+0x94b/0x94b
[   24.407342]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
[   24.407342]  ? __kasan_check_write+0x14/0x16
[   24.407342]  ? rest_init+0xe6/0xe6
[   24.407342]  kernel_init+0x16/0x1bd
[   24.407342]  ? rest_init+0xe6/0xe6
[   24.407342]  ret_from_fork+0x2b/0x36
[   24.407342]
[   24.407342] The buggy address belongs to the page:
[   24.407342] page:ffffea0002f91480 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1
[   24.407342] flags: 0xfffffc0000000()
[   24.407342] raw: 000fffffc0000000 ffffea0002fca588 ffffea0002fb1a88 0000000000000000
[   24.407342] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[   24.407342] page dumped because: kasan: bad access detected
[   24.407342]
[   24.407342] Memory state around the buggy address:
[   24.407342]  ffff8880be451f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   24.407342]  ffff8880be451f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   24.407342] >ffff8880be452000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   24.407342]                    ^
[   24.407342]  ffff8880be452080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   24.407342]  ffff8880be452100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   24.407342]
==================================================================
[   24.407342] Disabling lock debugging due to kernel taint
[   24.451021] Kernel panic - not syncing: panic_on_warn set ...
[   24.452002] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B 5.4.17-2102.200.0.0.20210106_0000.syzk #1
[   24.452002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[   24.452002] Call Trace:
[   24.452002]  dump_stack+0xd4/0x119
[   24.452002]  ? ibft_init+0x102/0xb8b
[   24.452002]  panic+0x28f/0x6e0
[   24.452002]  ? __warn_printk+0xe0/0xe0
[   24.452002]  ? ibft_init+0x134/0xb8b
[   24.452002]  ? add_taint+0x68/0xb3
[   24.452002]  ? add_taint+0x68/0xb3
[   24.452002]  ? ibft_init+0x134/0xb8b
[   24.452002]  ? ibft_init+0x134/0xb8b
[   24.452002]  end_report+0x4c/0x54
[   24.452002]  __kasan_report.cold.9+0x55/0x77
[   24.452002]  ? ibft_init+0x134/0xb8b
[   24.452002]  kasan_report+0x14/0x1b
[   24.452002]  __asan_report_load_n_noabort+0xf/0x11
[   24.452002]  ibft_init+0x134/0xb8b
[   24.452002]  ? dmi_sysfs_init+0x1a5/0x1a5
[   24.452002]  ? dmi_walk+0x72/0x89
[   24.452002]  ? ibft_check_initiator_for+0x159/0x159
[   24.452002]  ? rvt_init_port+0x110/0x101
[   24.452002]  ? ibft_check_initiator_for+0x159/0x159
[   24.452002]  do_one_initcall+0xc3/0x44d
[   24.452002]  ? perf_trace_initcall_level+0x410/0x405
[   24.452002]  kernel_init_freeable+0x551/0x673
[   24.452002]  ? start_kernel+0x94b/0x94b
[   24.452002]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
[   24.452002]  ? __kasan_check_write+0x14/0x16
[   24.452002]  ? rest_init+0xe6/0xe6
[   24.452002]  kernel_init+0x16/0x1bd
[   24.452002]  ? rest_init+0xe6/0xe6
[   24.452002]  ret_from_fork+0x2b/0x36
[   24.452002] Dumping ftrace buffer:
[   24.452002] ---------------------------------
[   24.452002] swapper/-1         1.... 24564337us : rdmaip_init: 2924: rdmaip_init: Active Bonding is DISABLED
[   24.452002] ---------------------------------
[   24.452002] Kernel Offset: disabled
[   24.452002] Rebooting in 1 seconds..

> Why does KASAN think the address is freed? For that to happen that
> memory should have been freed. I don't remember any similar false
> positives from KASAN, so this looks a bit suspicious.

I'm not sure why KASAN thinks the address is freed. There are other modules where KASAN/KCOV is disabled on boot.
Could this be for a similar reason?

Thank you,
George

>>> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
>>> ---
>>>  drivers/firmware/Makefile | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
>>> index 5e013b6..30ddab5 100644
>>> --- a/drivers/firmware/Makefile
>>> +++ b/drivers/firmware/Makefile
>>> @@ -14,6 +14,9 @@ obj-$(CONFIG_INTEL_STRATIX10_SERVICE) += stratix10-svc.o
>>>  obj-$(CONFIG_INTEL_STRATIX10_RSU)     += stratix10-rsu.o
>>>  obj-$(CONFIG_ISCSI_IBFT_FIND)        += iscsi_ibft_find.o
>>>  obj-$(CONFIG_ISCSI_IBFT)     += iscsi_ibft.o
>>> +KASAN_SANITIZE_iscsi_ibft.o := n
>>> +KCOV_INSTRUMENT_iscsi_ibft.o := n
>>> +
>>>  obj-$(CONFIG_FIRMWARE_MEMMAP)        += memmap.o
>>>  obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
>>>  obj-$(CONFIG_FW_CFG_SYSFS)   += qemu_fw_cfg.o
>>> --
>>> 1.8.3.1
>>>
