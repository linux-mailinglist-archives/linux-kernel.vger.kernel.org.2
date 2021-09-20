Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A217412698
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347587AbhITTGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 15:06:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55026 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349841AbhITTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 15:03:42 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHs49X010392;
        Mon, 20 Sep 2021 19:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZnhY6o9sGA+J1RP/hDMBzBfF+j+bWhAjNbudupmFREM=;
 b=eR81QT7QEP2RiCEvIX2NaDFEQsOiZTCvdVIKdbK0yZcY0yQ7bQ1VblsTKWDZgkk5qBRH
 MTl2GWG7aIi078MgzY2UexpPdFCRo9vm4NoWyrt4ZW6TIbYyeCP0M6gNfxgEds+gdaik
 9+TD2mg2ThQDGccQJ1lDD1OTA5h6AKJ3enisPYFx56nL/Zg8VN0en8JI44i/4s7mMA87
 Og2zOO/lH0cNepyze1p5tg/4AnfvKACf68f6HT6jHCiG3s5KG8NhG5fGZ/q3EQN0aO+5
 KoLuy3zs5Em1mxirMXOpNU5+nYu7IbEDVgL9R/5jtTb7PzEwjvEf6FHvZoZgKFQAOhGD eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66wn475t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 19:02:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18KJ0vIt107644;
        Mon, 20 Sep 2021 19:01:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3b565d1eg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 19:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrtDHo6LwRFW+JvebcV/BPmw9TG9LYyJAEHmk+y0OGSvCrZSr+5nx25sBEv+cadxwuO0mTY00mHzhYVTOr0m6KTjm7GEFoMDOqaYMb8dXyiWnxEZB6Gw8NaPi7j1Om7vThbq9HVZ0uzdDpY7FGxYma6CiOLaSgty1TnqsZGzUa/dUAnSfp5CY9sGc1Gw7rnJPdR7vkOSFEw4G6sJ1rphhDoRm1wyKP6Ff5rcZ+qND31z5lCoTJuqxzRVJvn+m98tF8hNSHrUCDgLCwhnHd9pYwUd+SdvJ06ubcT0V4DtDLiwERAeZMUwdKCeUTVpczfOjSPSvR2k8HVi9PFsXUilag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZnhY6o9sGA+J1RP/hDMBzBfF+j+bWhAjNbudupmFREM=;
 b=COkhkhn7Sgji6xwbuucmXkoNKEhKNjaZSzh1G3DvHVP7aWkLXmaDBbTbohDJxiizz7hM3Y6MxMO6hLri5veAUiHQgngjTvwvO/6u3axs4yCqDEGIDvTvpVjpsTMkP3gilV2ROjvG/Gk7+Un/bvFnoIma8PF/Me8a2kUFuAWxAT1CCU+maiyXzKT/67N//1ZSt4Vx+CQIEYvEHbzwPiunvidOyv89pEWM6b4lmDhKF1eDebesqmdlzi/vleswoIrXfKOeStHNLd4Uz9WMNgV3L+XFDwE8nrtbTVl1N2dAaooLpysTTwpdEOySlJmX/THs11TPELIcokIdw2AwZwyZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnhY6o9sGA+J1RP/hDMBzBfF+j+bWhAjNbudupmFREM=;
 b=PEVnl7QCEt6+BT71h5FJPUBkKJX8/vVTECAgovtcX5zMLGVd4A+TEcGeoxeimdVar2bCNhnQENoynDQAzCzNA6jvlo2tSqVFx3jLha5xMqJVbXMtOrIH3I7DD2iQogqkYTNWNo6i68IEIJtoTsfjmbMrE3AfCiIVuHZxEPgcw7U=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 19:01:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 19:01:55 +0000
Date:   Mon, 20 Sep 2021 22:01:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 15/19] staging: r8188eu: change the type of a variable
 in rtw_read16()
Message-ID: <20210920190133.GS2116@kadam>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <48009934.f5uHuSIIb1@localhost.localdomain>
 <20210920131036.GR2088@kadam>
 <3187315.KoBY3qX4Pt@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3187315.KoBY3qX4Pt@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 19:01:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5c0f5ef-4925-456c-9f36-08d97c691d51
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4468424161588F4FC8C4B86F8EA09@CO1PR10MB4468.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LIHgz8is4fASWeYJlzZJIG9PyUD0fPfBpAn1RHx0ACoM9m/mKK/wuWr8fMbdHtSnqXC1B/UyUHaMqzJFOKTXieE/XaF1i7htdRpIeFlaZThPz3sxdp638KaYb9Io5xzG9wj71JPCI9GDaGF3q5Kw7/wz1yRZ+6c/D0SRs5TuIfZWwPBpgHur4fzpO6gu4b2E8Rv5+sLwcVGowfavp8yiG1DupFdnDEhwQvLX9E98LW2g/kTV4jAb7Xule1PH61hndQDtCm46dT2QyADqZJ0aa24ffmmjMEyQGjQjTsh2Amjv1zV/aUuWdtB6xhwMyRFFIFIBZcB6r2Mgyd7dX0rGQkvwxV3byYqgV3sRXtT2/R/7s6WFQUib/NAmRzZPFu2//h/RswmHaIDsqWUUTu1hsSmhkIHvo9zAI0aw1PQdAiCJFpwjp0MAHBjdf3fiuwjg7ojh1Ar1NjOJm60mV6RgldYMUgOc3c0RQpckOn+KxxC6hPUHn2J00HGB2gQUizOPOagDUYXorZMd045oKWNlCNjJSFU44px2AOH4h5PlYeJNo/H0iDrSU8QnLAZ9JTsgnTD5oVlXna18Tbm9wR1Gkky2xLeT+LOu8nOrjYlv4pqFbwH+IJLhH849+om8dmmbUonx9CW4GmRm8j6S7Hsli6BNJvZrM7bvrVEMCWF72TLok+AWauefwDrR1SPApTh7zOJoUcYMB/NQE8sMuV4/Yik8xiWK9qD1jNTs5ZH5C7fnRDWhRXLqk8gWQVOjobaaOSbo99m86EZ7ZHqBi82AmFov4N6Clrrg61tWIPXxzIxjDmFxvQDcxLtEdY7dq8wEz0sfpoT1ENI8nms8lS6vqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(6496006)(83380400001)(66946007)(9686003)(8676002)(4326008)(53546011)(33716001)(508600001)(66556008)(44832011)(66476007)(9576002)(186003)(8936002)(54906003)(6666004)(2906002)(316002)(1076003)(38100700002)(55016002)(38350700002)(86362001)(966005)(52116002)(33656002)(6916009)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8DlKmn/dPk9Pjqy/WU9sLgIcevQ+iQJO1J2V69MtWlGuucwNUsAiDgUiJNh?=
 =?us-ascii?Q?mf1RCBxZuGHb2s8jXfXIb1DusvVOMK80MIPrw6Qgj55KlWRzoseDc6u3//7+?=
 =?us-ascii?Q?sRy1QG1QQwJngAkdolzIvfsMGw+1ogH6uVnfmxO6ZO5EUC6BE/qk1IFrFpRI?=
 =?us-ascii?Q?uh3q5UxigOaBd1hI1jIrW3U669DzZQR1T8aeD7dJTS8n96XJ55mbJEoumeJg?=
 =?us-ascii?Q?kWkFBnhdWTvGCSPJBfPtNpjjBW4RhwyHxHYzJbZsXv2OncpUSR4SyUzp7h+M?=
 =?us-ascii?Q?fE4fcBvVO4esk7S1Yu819jz5rwvm+3SrUfe/RKOtct1fWSQZJpQL1g6p9qqq?=
 =?us-ascii?Q?nmJH2ykC+4naKTp5xTXz5xLpdgIXT83xeJT/tgM3cXdajW/kT4s/LAOAZ6UT?=
 =?us-ascii?Q?MYRQDQDgJFfVphqcjHLZPorhvKwU7LbWQoLtwyMrH9lB5s/aZXcMXRTDq1cF?=
 =?us-ascii?Q?whMFiLzR5NXKbFBT+cTko9z46Yjel6GsQtg+Wy5hPGbuywTCZphX4rdO7Cq4?=
 =?us-ascii?Q?nDTDqLUnnRi9S9GeXO9KWTzVFT/oVVt7Yx5zQ/MmJIa9Bs3AZI7yPp4+z20L?=
 =?us-ascii?Q?ZZ97I8oDwTwPEDFyDlddFTiCA12zz0D0vMp3TQ2wIpA9J4NKfUTy6eoOt5tt?=
 =?us-ascii?Q?tNnd4Iv6+hqwdZ/PB2Imuv3Oa2PmVLo0moDfTNarlHqLj5U4jjNSo+H6+ala?=
 =?us-ascii?Q?Sp7/PG+uIH7Xbrk7pZsQ2GqQPg7pdxTE2KcCNnrPDl0msc0ILUOsP6FSGqRh?=
 =?us-ascii?Q?ifx/dMhE2mFa9/p0s0EuYoqZAvxZgjOQx7Lz0C0d3syQRKTcGMnPY90ODYnF?=
 =?us-ascii?Q?6YJKhkaIVLcKYrk2TvfpumaXJuCigJUTfoAOEWRq615afT2S/EugrpFA4IGC?=
 =?us-ascii?Q?nHeEG2/Ar7lpG3S228kkzv8QaPs3SLmjewx07d+J088ilEK7GExQ47wpMJYp?=
 =?us-ascii?Q?PBZgX+aSsDZCrLapRGf3u3HGq09P7xnWnsDMMg2PT0uoEFcmGvpnZ+VhDCTR?=
 =?us-ascii?Q?sMQhzYTlQzmRARuGuHOJvkifiFymxvCUhkjHwWt4NXoKlJVZsKFaslv2e10x?=
 =?us-ascii?Q?0TpkkirXHcUrh0tVy3MLK6s2KWI8EnyGNS3IZlrzinXE0fPCMhhx2rZ2JFQ7?=
 =?us-ascii?Q?z3Z/HdyMA+6rF/6prTxmn3FVhSZ8BMkW17dzEEDD0R2SpRnC68N1kFZ6tL4s?=
 =?us-ascii?Q?ymUw0z5bX5S+664Wf+oaFI3VQdEqssTanW+8IBDD83bj+dfFUBaC+rMs4nqf?=
 =?us-ascii?Q?EdMiwbYoAL0b0UEfrGMVgJlkUA9uzjFiehkXdu1wOfTnaAgfyqTtGZjmmPBq?=
 =?us-ascii?Q?Z9pqsHfebbTIJ0r3nHutEQF1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c0f5ef-4925-456c-9f36-08d97c691d51
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 19:01:55.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFaay8tLQlM10ZMYSkEi/vegC7NLAhN26lnmYRyuUUv0C8YJHuvUB+ZkW1nmX7ucb1gtffcohg04Yar8dO45uS7rDsogaHkOHb+BNigGnfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4468
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200111
X-Proofpoint-GUID: HGfH5zVQ39FqUSunxXXSVmPEaV9EMZT4
X-Proofpoint-ORIG-GUID: HGfH5zVQ39FqUSunxXXSVmPEaV9EMZT4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 06:17:36PM +0200, Fabio M. De Francesco wrote:
> On Monday, September 20, 2021 3:10:36 PM CEST Dan Carpenter wrote:
> > On Mon, Sep 20, 2021 at 03:03:44PM +0200, Fabio M. De Francesco wrote:
> > > On Monday, September 20, 2021 1:56:47 PM CEST Dan Carpenter wrote:
> > > > On Mon, Sep 20, 2021 at 01:53:52AM +0200, Fabio M. De Francesco wrote:
> > > > > Change the type of "data" from __le32 to __le16.
> > > > > 
> > > > 
> > > > You should note in the commit message that:
> > > > 
> > > > The last two bytes of "data" are not initialized so the 
> le32_to_cpu(data)
> > > > technically reads uninitialized data.  This can likely be detected by
> > > > the KASan checker as reading uninitialized data.  But because the bytes
> > > > are discarded in the end so this will not affect runtime.
> > > > 
> > > > regards,
> > > > dan carpenter
> > > > 
> > > 
> > > Dear Dan,
> > > 
> > > Thanks for your suggestion about this specific topic. 
> > > 
> > > We thought that, since "data" is in bitwise AND with 0xffff before being 
> > > passed to the callee, it was enough to have reviewers know why we're 
> doing 
> > > that change of type with no further explanations. Actually it seems to be 
> not 
> > > enough to motivate that change.
> > > 
> > > We will surely use the note you provided. 
> > > 
> > > However, since I'm not used to blindly follow suggestions (even if I 
> trust 
> > > your words with no doubts at all) without complete understanding of what 
> I'm 
> > > doing, I will need to understand what KASan is before copy-paste your 
> note.
> > 
> > Google is your friend!
> 
> Yes, it is :)
> 
> I think you were referring to the KernelMemorySanitizer (KMSan), a detector 
> of uses of uninitialized memory (but it seems to not be upstream):
> https://github.com/google/kmsan 
> 
> Instead you wrote about the The Kernel Address Sanitizer (KASan) that seems 
> to be a dynamic memory error detector designed to find out-of-bound and use-
> after-free bugs (this is upstream):
> https://www.kernel.org/doc/html/v5.0/dev-tools/kasan.html 
> 
> Can you please confirm?

That sounds probably right.

> 
> Back to the code... uninitialised data is not a problem in the old code, it's 
> just bad design. The new code cannot affect runtime, it's just better design. 

It would be a problem for KMSan and the kbuild-bot will email you about
it.  From your commit message "Change the type of "data" from __le32 to
__le16." it's not clear you understand why the kbuild-bot will email you
and why it's correct to do so.

regards,
dan carpenter


