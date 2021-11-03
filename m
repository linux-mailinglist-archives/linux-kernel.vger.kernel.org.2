Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFF24440D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhKCLz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 07:55:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40814 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229816AbhKCLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 07:55:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3BOUtW017352;
        Wed, 3 Nov 2021 11:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+RQRDqBxEOIue+Wf3/s+C3cI9HUjy5f2Lnef9JJCnI8=;
 b=hH4LXtqJTeMPc8TwH1d2ikAkvfTikwzWEgGbmYyBGRHlxE9tz9GLCAYxxQ7tmtxBTbv9
 V00NbkLAYzJb0asEp9ZlBEy9x/+p6MNCMh4qA3gUS/QoP1CO51fcBw2P0U7Jce0uo0jm
 xCvF1o9rOCCdn+tttehmuScEs32jNIjbZcDSpE6rc2AH+y93DH6lQQPTA5j782EzRdX7
 sg3ECTGth1qK91GJ16GrKH1KpBvcaUxJzhOtDlbnnEfISdFYXrpYQLgxa/+pf5FUEoWb
 XHznaz0HHgMtZ6IBTnzM3vTK4pXDJBclvzIVv2KVUjawtGpNKW7N/6RGTehAH+NR2lR8 Dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3n9xhbjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 11:53:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3Bp3cH114839;
        Wed, 3 Nov 2021 11:53:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3c27k6w91j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 11:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBtFZFlQK5BCQIn/uXLyASA4GyG72+vvoFB/pq4c0VX6Psv1KBxXjiEJbDItWPdDIXdGvtBTN7GMk43xMwPfLSipPRYaMz4j1CB+iC1qE720Pn0UPRXKXHnKK6Ees+RCfXTJf04Tju1D4t9E/9pRhB1YatPajp3MLG/8+CedxOXBlainJM7WkTVIz0h+c2GuCsVdkxnvwuRj13rIHSW+i4FUSjkjRYLB3AN9o1OujXVDM1IUmC3OLvpjMhvvkRnfp3VAiHG014U04veetk/EVq5f/RhDLnR5u8pFxxYB7T47FfSAaaFNICJxxHFKDaoNwbc0tyHdEUpZgNNhLuWl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RQRDqBxEOIue+Wf3/s+C3cI9HUjy5f2Lnef9JJCnI8=;
 b=Q+eB6XsC3nWnmLWtg6fj2OyrgN65gOTyDR1seOMD1X69RCHGks5ge/yDQxQS3DUueubgIifFOJjYDJYYNxmbk2pbUw1k6Vtt5WusxO0f2YeUACZzKnLeltsf5RP1JtG46gDN5rsTIx3Dq+b/FTFgs9nmBqBKxhNMl7bOh2JsuesbHCWrGMZMJ12KbGyCmhsSePy9UZHbUkLrpKxRelbjEVOHnZPcnVlR/h13dqfHnp0X72GPkj71wRYuswVRdlHMgHxpCxs74lHvKvSWIuS1Qs+PZ7nar5Xbi9fedCJPHCXLY5IpJA276kB0jFIpFAC6RpxP214pQs1kRKlvMen3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RQRDqBxEOIue+Wf3/s+C3cI9HUjy5f2Lnef9JJCnI8=;
 b=C/qHD/AXiwgvDZLdkbgcWKhr0IOsL4OhKqGddEqkDJGYvN+s9Uln3+mUrFaHJerhCDSw6C0ltpB6lv8NP03N+j76GeygdYHl0ro2nZBPYtDD7GeNMr9LQyYhn3/NKDuOSpGx/v7of6DoJdhRp91dVpIl033w0N/ecF4viU8sZo8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 3 Nov
 2021 11:53:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 11:53:09 +0000
Date:   Wed, 3 Nov 2021 14:52:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Praveen Kumar <kpraveen.lkml@gmail.com>
Cc:     Kushal Kothari <kushalkothari285@gmail.com>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 1/4] staging: rtl8723bs: core: Remove
 true and false comparison
Message-ID: <20211103115247.GR2794@kadam>
References: <cover.1634845504.git.kushalkothari285@gmail.com>
 <a9b75b3ab7c83dc5cef541301263fe17a704f026.1634845504.git.kushalkothari285@gmail.com>
 <32059290-6c59-1cee-5edc-563fe5c2f18b@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32059290-6c59-1cee-5edc-563fe5c2f18b@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNXP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 11:53:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7149ace2-f8ca-400a-e96b-08d99ec080f3
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:
X-Microsoft-Antispam-PRVS: <CO1PR10MB450062FE107E090A6E402F778E8C9@CO1PR10MB4500.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/Sg6LyawcFYnYwQjFhW18Bxy2ITU8R9w32LMQtkcJ9i5G8c8FtidYrvEvYlzLDP43/9IeQVs7Oq3Q20tHWsyQqC10ops2yzhcjk7p2edSrEgjk5N97crz0Ia0bMGPTIVac+60M0YoVJ746MiunN1avn037WDDQfUQaopS5E7TXqdoEe3Xsai5AmhFd74MtWxG3gudBGRY9rqirDmMoZ2DmL1nDzhMBu2sY/BLwPwYkxPuYYQwRWSFnjl44LqdzIIQsfLt7yalbVj+835HOwSWP0MAqOzPgBUY866HbL3Ns0U+sLvOHnSIUvNKwo/DVxSaygC4TaJXnCQkYKOV3a9isBj3eCU0sYsRF6+iG7WNLvZHbq4sRMB5XNYupPJu/D5KbfraDhTrAzTt4W0OZMI59hzoZwhtcR89n+/jqk7c8bNHJp/LrLMWR4j+09Npf7ztM7CX6VbT9NxrNkinmsHRSFOHHAQaRA3ABZS1Gf41eP74AdYthjJva6Lhp8xlWTc5uINgD+jxyjOOGVKAacuP3NgAyWPr5d3NUvXzDtlVoxIffD2H7ytLs4tUorAje8wpP4v/76tBN3rp6qLVKpc2G54D15tnMnuQDl7BBTmWEgJ0jgiw6OsBm3KZWkpswwC85zOmYg6+O4zJyUpnj6i8PTQR2sVv2nf4nJyC2L1LLw5jMiTYca3xQf8BBWm6wGEVT1V6+KWL1gspIDpUGdYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(956004)(55016002)(38350700002)(33656002)(38100700002)(8936002)(186003)(26005)(6916009)(316002)(9686003)(9576002)(6666004)(508600001)(4326008)(52116002)(1076003)(86362001)(7416002)(66946007)(2906002)(5660300002)(66556008)(6496006)(66476007)(44832011)(53546011)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3VuCVAqdmk4jUkBVUiF7P0e+3RZc6V0nghwsu4OgTpQKVea9FBkLfLhnZCCN?=
 =?us-ascii?Q?yHyV8sK/U6heIlfnn2t6ONNuk920xEgQRZA1bks4TrI9T0jHSmZltXkPsIxd?=
 =?us-ascii?Q?oB2GB/z3DFOz5pYCYGuMtECT/wYFgrwuzLXcxO5N18VTihlgEyYSyz388cuV?=
 =?us-ascii?Q?HLX6xYjodV1KZqyGwlGiJGPByu6gIZMgmx0dGoM3dUh0XpN+BY8sO1FFRn+F?=
 =?us-ascii?Q?7BLGVo6211j2H6FCbyhLwrJm+eeFMVz9f0wcjTrmkWMYb5D5MJjFu2ljZl2s?=
 =?us-ascii?Q?ZdLfxBqj6u7uGPIlgtRLHEmI/CZ+piXbqsSmll0eXLY/YHid6OZqOHuBJhTg?=
 =?us-ascii?Q?ccXf69jVFqByQeEK/NdKYgS5DznWcD9GkDaJl/DsH2ZTywHNvNKgTucuN/Pf?=
 =?us-ascii?Q?H3xlnh8M5ohDoZqCOilymbElRQpU+x1rmWR26pd85LncS2KJvIBXzgtw9qDg?=
 =?us-ascii?Q?2zvaEQyWT8IKhXWTWKvE57HW1gKQLAaKB1GyN3XsKK+fkHKhWj9rcr6SBrMN?=
 =?us-ascii?Q?/uJWh+VeU31xJGg60+laHWaxvwWY10ObwBphqKKGy/uqIgG+znbgzm8k0gP9?=
 =?us-ascii?Q?qtnzC1uKzgagzyn98rGf6mJADPJLH3YktR68RLZALSYFe45hwdRugbprrIuQ?=
 =?us-ascii?Q?P9Y73vIpBed0nF0XbINw7SUvl+Rw/muAc438BtLhqoUS6yiUPyUSi3jtMqRM?=
 =?us-ascii?Q?jjqMKcXjileHsV4K0ShhxBGPJV9dBws9VRr5AW+xDTPn/ZVfSSG2p/5BC1NQ?=
 =?us-ascii?Q?yWRl2td9c+vGF9rTiBRsAJOCzswzKPqy0Ml5oyzkBrWsdKHzBI1MP1ZNiPnb?=
 =?us-ascii?Q?Yu2rc4+K9/MuCvYFaQeQ94P9daOZSufqRqsGYahSFLjmvM9FvOqOT31GAGHA?=
 =?us-ascii?Q?PGs1qzf96NCkNR3NifyPKx2tZvOLBRej8p7zjVSWOOA5ad/GEdfyPPT+v9GY?=
 =?us-ascii?Q?DwCyiCcjHqgJqRhZ5WisWNOg56IJEKpk/Ica5fY1VNSm+PWys1KxN5iJNxs7?=
 =?us-ascii?Q?6yrz4t6pKyDOFIieu5vjeEI32SikwRF06X5Q3EbvyQhinVJUjQHGyycim6d1?=
 =?us-ascii?Q?lSnFNS94CyaFEyXU7wZmiD4qjiMHGDSHlVylXEjd1dlNxA6M/BcJ6tJD1dZ/?=
 =?us-ascii?Q?cxXCMJHGTuHPbp0lkueGyzotKJ3Qx7AWs+S8ejd9U4VGpMs9hl+zndZPlr9V?=
 =?us-ascii?Q?HIRkKDXqTzjRgYS+iK8T2oabRVBeR7XxGO1XV/6fPBgN7oE8Cl84+VF1TYjU?=
 =?us-ascii?Q?GaKAwAOUeDTRDIHps90WQpuYE8rPi7ixhV4Meq3Ic0H+xu7+t+Le+pLzhPJh?=
 =?us-ascii?Q?oKB1B0R4Idlt+71dlngw67reQnOF4FWVJVQIiuuw7pv5FmeggIv77K3smvws?=
 =?us-ascii?Q?0H72NZmVyL4Ndxulg6IXfDgoChw6DXaLyRMQdTjg3k1sAj47Ik1mD4dz0y2U?=
 =?us-ascii?Q?8MozxN7itvG9dYcqK/b2aRwZMWU6ly+wXatl+GStL7ATWOLwEr3f0sCN1QhE?=
 =?us-ascii?Q?kUZ61SYBuML2+nR/uJJcAa10q6RxpAwUneUgHpTqAf1uucJpaGQsjMGqp0aT?=
 =?us-ascii?Q?lMfcPyrGD+p/JSe6MtIT46+eJ7b4qevQzLE08JLIDC6igfudZVyd65/TS76g?=
 =?us-ascii?Q?kTnFv1mdSlqcHp9cGk6HQzKaqJZR4xJdblqUDonWGHcIhXvsICabyGL4DbDG?=
 =?us-ascii?Q?eBPY7w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7149ace2-f8ca-400a-e96b-08d99ec080f3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 11:53:08.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1I2Qz/vZ74qIdCHls37Gxnt0b3NiTwsST9kX0kYZODHVIRNZ9xwe9PPBPzvsKz/AdoyxEP9d91WpFn6KFAdsZamPMjdCT1dAVgP3Bfe0w8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4500
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030068
X-Proofpoint-ORIG-GUID: bCdaTLdP2xcJXQLknkvspcwf9daDqKxm
X-Proofpoint-GUID: bCdaTLdP2xcJXQLknkvspcwf9daDqKxm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 08:14:29AM +0530, Praveen Kumar wrote:
> On 22-10-2021 01:27, Kushal Kothari wrote:
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > index 2624e994513f..0be3a8dbeec8 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > @@ -371,7 +371,7 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)
> >  void rtw_stop_cmd_thread(struct adapter *adapter)
> >  {
> >  	if (adapter->cmdThread &&
> > -		atomic_read(&(adapter->cmdpriv.cmdthd_running)) == true &&
> > +		atomic_read(&adapter->cmdpriv.cmdthd_running) &&
> 
> Lets keep it "atomic_read(&(adapter->cmdpriv.cmdthd_running))"
> and remove the parentheses in next patch.
> 

There is a certain amount of flexibility in fixing style errors which
occur on a line that you are already modifying.  But your advice is good
because 1) Then the inclination is to say "please fix the alignment as
well".  2)  There is already a [PATCH 2/4] which removes these extra
parentheses so it makes more sense to do it there.  3) This patchset
will need to be redone anyway because of the white space error in
[PATCH 4/4].

So, you are right, and especially in this case you're right.  But there
are always going to be minor issues with a patch and some of them we can
let slide.

I have occasionally waited for Greg to apply a patch and then sent an
email, "Greg has already applied your patch but next time do it like
this."  :P

regards,
dan carpenter

