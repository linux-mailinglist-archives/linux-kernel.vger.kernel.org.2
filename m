Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B6F3E2B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbhHFNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:37:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11304 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243524AbhHFNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:37:41 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176DbGig027203;
        Fri, 6 Aug 2021 13:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=6eoIKvoPaIsY/icE6Gidng+ABysKp552VE0FQV/Qlz8=;
 b=Wb68Nx2f6+BKSOwmfupI2OlQeRywZckGc7+x+5FR615V4Bw1+cZv9tg+6hem/igizyhD
 b1Q7ZSndWUJ2jo0lVyDy7PWOfmpDFSIijwwc6GQkaMrwH/3ip4kilvVzk1wJ098FUz/X
 bcgz8SkwctsGv435mnO1N4D2yjrfrPoMWFcLlWJFTKzcpj8a4Ju0mgpUrlLTZlBF1Rj0
 qvm2+oqd1xFdRJSKxO5g3wHNN45OfHpGf33Mxf5TOeNFhnelQAwmjey0BvDparCJewO5
 5rmmQfYX6ji5TpY5jTOBBeKIH8xawitIamdguHQAas+WK6qkscLKl6DcF/f+4tBX3c+T WQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=6eoIKvoPaIsY/icE6Gidng+ABysKp552VE0FQV/Qlz8=;
 b=L2fAew/32iqbP6QBXlzlCQcuQQaSul5UJmYELbdHY7F6VKd4sVHkwIkJPRqkXeHMa9AT
 tFl7e4vU/1PC1qsCHUkTVzNLCQYeAroA7UX63xWJN2u0w4Tgup54gxmpCWuQqXpxQkFu
 lxvBlgqtXZh9wkXu3Fv/0LN3nZdmx2kHQ6cfzjBNbnG/doYZaaijszzxigs0jsAjyhFq
 z9aKOhFmMt+cFandBid74b1+x7l2nYL8vR1HVBK7TS39eJHi4FBNowZIOGRPFlaESA0b
 9ovrME0zpqCoV0GZxEpLrOhhhCrANS8xE0iuidRVt+sTXjSE1wOPFy2uIiE2S7Q31e94 Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a90jursyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 13:37:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 176DVnUL180693;
        Fri, 6 Aug 2021 13:37:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3020.oracle.com with ESMTP id 3a5ga298e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 13:37:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsS+k3cUl9tUL5p17GC5dwd9SxZgi+3JbpKvjMlIGqCY9Ij6NsWk0UrbaEb6tPyggWlIQeYdlWwAh/X0gaMNQYsR7ZrJpxOF9Ovv6uJg4q1OkNnCD2GZB2gffFg9Lqp8LCui5pXMDblYdn3WzixqFaQOlMej+knuM1pGZFrv5FPYy8x6Rt2lIQyRM87xU/VKYaY3hUCtFmwxQ6vkFEARXhrN8+yUHGkGiFhT8jDFEHjYKwi9OiyDxsnETeZOlcZBEu2OzKtYyJAURxDSNqBR+wxpfpyN/WfH7z0A1pM/nFxL1nntfLFvS3l62XJrRvRTBBGej6reoY0AJaZ9QPjdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eoIKvoPaIsY/icE6Gidng+ABysKp552VE0FQV/Qlz8=;
 b=mjjXwI86CW5pEfFCqpP4rUxbqcVH8xtlfDqfWw01MkmkZCTQXCwwGbdunfl3HlEkQfpDpgOz5JG2Q6aSBqZmi0QNFtTEbCP+x2J6p8h970nypm8i69pqUqvbBwb+8qn8/+ABMlkSIgUMYLCcCdGoJBKavQigy1+KN3VSTjzqfmASU6y6+CdUwYoyxHXge0GocY8zLdWLKu423EFBNMAfczwLLOkUJo99pWF1n7wAyYFpqcO41XbRv/QW+R67jJ6fv6IhfMGqiiJVvrlqSbKNmhff/jOZT1gNsqs7ttdEN7raUMgWYOsRl1FHDLuFzbVEYvk3KAUfQREftiKCIPRNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eoIKvoPaIsY/icE6Gidng+ABysKp552VE0FQV/Qlz8=;
 b=TK5Vd67bd8gEdPWxaEMFWUnJkpBzZ5srFAObi+hFzoA4lvECVisobSm2DLUbkFYgwCZWPnOtgdsiw8F0rLhj5Ep59zPW72Mhjna8o2h9cSR3FVzeuTzCn3qjz2heIHhcdpfZA6SoSZkzgKsq7lStHv46aRi5eMTaU7j5qNH0ciE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1375.namprd10.prod.outlook.com
 (2603:10b6:300:22::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 13:37:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.020; Fri, 6 Aug 2021
 13:37:18 +0000
Date:   Fri, 6 Aug 2021 16:37:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Werner <andreas.werner@men.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mcb: fix error handling in mcb_alloc_bus()
Message-ID: <20210806133700.GP22532@kadam>
References: <YLX7bAD4UPCpIBmq@mwanda>
 <c4cffc84-be11-6558-60aa-a5217963b1f6@kernel.org>
 <20210806133240.GQ1931@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806133240.GQ1931@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Fri, 6 Aug 2021 13:37:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36b3910a-e588-4d9f-f5f6-08d958df4f69
X-MS-TrafficTypeDiagnostic: MWHPR10MB1375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB13751AC71AE1DCEB4355962E8EF39@MWHPR10MB1375.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yee1HYYG7SrpO5+WTepan0828QuRICHTnm7sKMDeF6MmeJhhA88IGC5AFCYzKUKEO3Rc1OXXDAduewc9PKv7UNbYxQYUMAId2+EuVozT+PgTfE1FnJipuJfCC1Se5mxSGZQlw+H7LCDLFf0NDZgKDoNi0fmaVAY7K4AAWUsJD1oNVFQ//O9fEeoLuByID6Wksy832IxlYQF+FGuzA7ZtRlAtuaXPoxY6BeuzlaxpBonVh3lqH5fXLdC8862Ch8fppuLx0wBzBNtPu4yy1kS0qF4ci8PyvbaGfwQYsdFkgYxEfKuf/csuHhDxcOyENt/DFnCFrgg4eVHFzvGlUGItGuC3RgcSq6971zT6G7UEJyAABg0akVRvr+5LGKPzOzxIkceFZcan7qAqNYND5nDHtkpIyoYV8AO+3J6T6jredMDmAvmISfjRzyajF9udDXtksqQS21ta0HlyPz7Dht5MIX4ajzQc054YJ87L2M2l/SpxKA0hrW+BwCmtNkcaddH2s0hI1T6R7PKkVt9HWUqJ+Y1GIzdc6xEd3YtVR4Ep+VDRNZZ3UQjsa9mfxbn+L5p1EK6iK75bkiYgU4KBCRC4aGnIVp3mMNdZR1AM2dBX/M9WsK5avrG91u+EO/PYyFfDUr6kZECyN4r2EXCQ9XHjbJ35hqXeGwbdY9OPixSuKxQmxR49ONPO//+/bUD3YjVY0GqVRF7Ze35bmafNAou9tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(136003)(366004)(6496006)(4326008)(26005)(38350700002)(38100700002)(52116002)(66556008)(478600001)(186003)(66946007)(8936002)(316002)(2906002)(9576002)(66476007)(54906003)(33716001)(9686003)(956004)(44832011)(1076003)(6916009)(8676002)(86362001)(5660300002)(55016002)(6666004)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BoH997kvAcSd/lZVtI9JDtrruFMYkxiGo2Sx9S01EqPTp5JjSUR1ewzIe3K4?=
 =?us-ascii?Q?ONxMmgF1ezn84i6NtaY3Z0CB4rLfDgemiw3L9obVOQvGAmL3u+bYXjrB3I+o?=
 =?us-ascii?Q?a+XXLdCl6ZmiE0VqRpGRYzrc5jJGbwo+9IxSLtvuLR2ojMAECKR7U4h75xXM?=
 =?us-ascii?Q?B/iqBsnyKBap02FYWeF7Ndf+B4RdFN2i4bZyp6XeOh0g1v6S5r/Tob3ZtKSq?=
 =?us-ascii?Q?kvtYC/Ou5/7TYlacukKBJKu6PJYfds3RQO4/N1aKvJ4ulrvq/dPJ9S/AB0jB?=
 =?us-ascii?Q?/XLFxODtQmoBGvc5uRMUgO8rFj0UF8y1RRRCQdqrVAsTsrUDs8aUiHNCgVBV?=
 =?us-ascii?Q?xhgUa/qlSoCVbLiUlqR3GgLCv685Nk5KNTEqF1jcAMWr4Xwgs5fW7CdHbKaU?=
 =?us-ascii?Q?Fw3w/tn/CL1Iz2dMIlER3k005Nh1pECrU7bANLYXrANF70lA895CV7Ds7xUa?=
 =?us-ascii?Q?bPYpVQYOSjL65/Mc25N13Fvmk8K47Q+x4UOayRcnDXxQSTDVtKsZ8g3HmYQU?=
 =?us-ascii?Q?NrfI0qZc5RtaZKPUT8z0Wz9Ll9KAKYOAXp978+UWsOnVybSJHWOs8+Jay2u1?=
 =?us-ascii?Q?aHcSS+C3i4/xEypPLkBDuD8d/gpfClMXC/GXM1HOKdpODt7RVrZn1QzxX8aM?=
 =?us-ascii?Q?cen+afRRedvUSvhov6FQ7KIPDFiXiEbROzBQOdetbPjX+nAs2imTPtdHt/Lc?=
 =?us-ascii?Q?raEs3E6Wf/I5WOfp8F98mTt7mopjlWUEr301byiiGty25AxefkIuz0nsTZfE?=
 =?us-ascii?Q?wmVNDxzMWO8duYyp70Do3JW8M+Zat3yqs8aXUJB3LHyNqMywM7gwmVEGG6CO?=
 =?us-ascii?Q?cLg5+qo+H8J2ekOTPtrqBl/yFPBiG/Eytw/FX7MvB7OjL4ZNCZRMHRmVVA8d?=
 =?us-ascii?Q?Rh2Ee7a33/PRo6jdkcyFBIYIyDSV9Ki8dIAYqR6t5K5oVj1SBBCYEaxgK0w9?=
 =?us-ascii?Q?R0d35FkqhlWtTzBPs/t2MDmTutqEWcAmnktAOGLP5HVJcQJXfTwP0ecEi02H?=
 =?us-ascii?Q?2jMpDOLAO5mQAoknDYjT/HKZoxBBUr8UmD9iG3b5wWdUjYxVuNaT2bJpXKYo?=
 =?us-ascii?Q?QIJo9gWnbMT6FmP3wwLPSwhkV1WP1GVb0rL3IGMAjiEKnZBKPVDxomfSRyyo?=
 =?us-ascii?Q?7y7VsW8eAab0mszHEMOfjg+nZxVvwmQZ//UwakSi1YKkHJ3hyeXgM2fh5chN?=
 =?us-ascii?Q?PlM+cGRjR8oQDczu3VIl7BDt3bECMBi1Qta9GGLDa842qjgkBtXsgWaf8lmn?=
 =?us-ascii?Q?HLzoc39qO14kYesIVYSmRzaIInpxYIfj8vcmbDvRsCDnzLb1tuSrTfY/bUDq?=
 =?us-ascii?Q?g9UDYQmrwVlrAF0TgDm/c8J8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b3910a-e588-4d9f-f5f6-08d958df4f69
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 13:37:18.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bABK6kJdJJH0g2CiLRyW1gpOafHoYnQxBJeuD8A3EXKvhJLkcjgFhzs4x38VgCGwwOUVhJH3liHH9fXMATSoLbUASJ7E9cfytHkPHPtqfzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1375
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10068 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060094
X-Proofpoint-ORIG-GUID: l8bGlghxdNGwYaBLMhHVoT8srOOGTFAU
X-Proofpoint-GUID: l8bGlghxdNGwYaBLMhHVoT8srOOGTFAU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 04:32:40PM +0300, Dan Carpenter wrote:
> On Tue, Jun 01, 2021 at 03:23:55PM +0200, Johannes Thumshirn wrote:
> > 
> > 
> > Am 01.06.21 um 11:18 schrieb Dan Carpenter:
> > > There are two bugs:
> > > 1) If ida_simple_get() fails then this code calls put_device(carrier)
> > >    but we haven't yet called get_device(carrier) and probably that
> > >    leads to a use after free.
> > > 2) After device_initialize() then we need to use put_device() to
> > >    release the bus.  This will free the internal resources tied to the
> > >    device and call mcb_free_bus() which will free the rest.
> > >
> > > Fixes: 5d9e2ab9fea4 ("mcb: Implement bus->dev.release callback")
> > > Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > 
> > Thanks applied
> 
> I don't think this was actually applied and that's a good thing because
> my patch wasn't correct.  It needs to call device_put() on both
> carrier and &bus->dev.
> 
> I'm going to send a v2 fix for this.

Actually, no...  My first patch was correct.  Calling put_device(&bus->dev);
will call the release function which will put the carrier.  My first
patch was correct.

:P

regards,
dan carpenter

