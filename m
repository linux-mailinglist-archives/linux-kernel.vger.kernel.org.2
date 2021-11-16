Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0484533FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbhKPOXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:23:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45702 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237335AbhKPOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:22:27 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGEG8FL013942;
        Tue, 16 Nov 2021 14:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ROxK3nA0fQN48+3RyDCM2DimYopBoxtXxTeDTu6voMk=;
 b=ndoY9P0wpRKm/obhym49aWi3D3YUumN8+1rpNDzYrnNNDL1/Wml+lCdOZ18RlWzQ2etO
 P8nhiXqg/OTrw/dCtU3nf8s4RZWH2BO4LrUZ+lqBLcKM3ZhTjmnvIA5I+wAZdqs3UL8C
 Nq82AWtwvPjXcoyxxXtNyaevrnvUN3HPnc7wj0SIO7/YA/lnyi5eS34X4AHWfXUL/k1s
 qxmh4G3Q8IjzY/+rzmPYLQQSrxe9mX+lisSv3gPv1T8itEqszM3wZu+h1O6JXiSv70Bw
 QcmAVvvr8+Tbp5DCK0yecUmwVmbZ4PBOAdyvwiVF+UViZsm7nxdxmkkRxp8GfM0hISUy iA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv59rdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 14:19:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGE6N2R086554;
        Tue, 16 Nov 2021 14:19:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 3ccccnn6us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 14:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Co5pF2zBVA9m3NRx7hYim54MlK4uLiojyydoffioewTdF8FsltrTUfLjPyAPGvSc8/d3QQn1Ubyjfvr5/xP0+2ezHV1J676tNMsTXzMTIrQcmGLYuHmmhCW2dtqolAmywm8uJPv0sn3qYY/bcmGQe6L/1OasSgn37/WXbZE2zpiJAcAwDbDBklrJ5jnng5WYWA2ToTakGb4KwQ3FPPc2LWYfPB+HiQnyznht0X1Dt/BmuoWW32R6YKAYJvIono4sb6L0zQ7dCG1h6KPyoGdin82Mg0lwEKQARatvTr+ENgcdJUQwBPtEHNVO+KdQr8d12LwXItg30h8x4sOwsCuoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROxK3nA0fQN48+3RyDCM2DimYopBoxtXxTeDTu6voMk=;
 b=VjHuHPPRbSVvpaxtd6DaAdiKd294FNRJ5HiLJQCyyqPD02KiKLxTgHqwWy/7Kk8LXyfMKdot5Jm906M4IHgGmc2Sme3StDMkxTQ37+4Crl91jdGiJbU151pR80Koez8NQxAOIxnmf8RRxUiNRJQlHIrNI5hcyDGoQABxng0UeWFdjc3BWDcicKmDAQ1hlRjIb6uWbwBY2L5dh99dEGst8fu7+HkjEBQ/vTKJgtIK35U2AH2RXgLl66g0A3OeCL97RaGdR2gWHo5a2lgPu/pzLTHz3TLMPLG8zjOlMWTVQz6Way6ZhwVGR9RJiOGiq1XbjjJL6C2re+XSpvqY8ask2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROxK3nA0fQN48+3RyDCM2DimYopBoxtXxTeDTu6voMk=;
 b=gY/pciYQ9HYQxcaOd+8SX8djvTH5ZamVifVFCxQSU8J9NwJ32zy3X/QdmU+P2mGd/TWFcRSACRzeHzo+hzkYngqr+h0danIO+d++JrBVe3zfd2aX3apcY0NQNT/8fTvq22EBExSCJktpckol51KRI32xtotLxSNCuYP1WycYv2Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1487.namprd10.prod.outlook.com
 (2603:10b6:300:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 14:19:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Tue, 16 Nov 2021
 14:19:01 +0000
Date:   Tue, 16 Nov 2021 17:18:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Zameer Manji <zmanji@gmail.com>, gregkh@linuxfoundation.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused defines in wifi.h
Message-ID: <20211116141838.GI26989@kadam>
References: <20211116011451.896714-1-zmanji@gmail.com>
 <6d2d9c4a-3f05-1d51-42dc-b1ebbb4aefe1@gmail.com>
 <CABtXzjSPNxe-n9QTujMB7=CmhqPFp8V2e86BXmoErWm+6c5coA@mail.gmail.com>
 <22a48290-814e-bcae-81e5-c23e6310f8f6@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a48290-814e-bcae-81e5-c23e6310f8f6@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Tue, 16 Nov 2021 14:18:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca7669ca-e0ee-4d5b-0177-08d9a90c0923
X-MS-TrafficTypeDiagnostic: MWHPR10MB1487:
X-Microsoft-Antispam-PRVS: <MWHPR10MB14879CA710C40E6701B1541E8E999@MWHPR10MB1487.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLWRyfwWOjPs0OlvA7TDzIGbSpXkcw87Kef3AQwq89Bay3wrHupQ2FbtPOHkpKSCFFYOc4l4B/PrTjceZJTlrfonPmDZF2gDN5MLv+h8re2xZokBEjcmwTtMlz/rT7ZP+GR1294BPDIxKs74ydGGZ8+DzKWwkZrlQbQQNBpEhhAywVJOJn24YT4/3GRQc/roEUvQ/NNOgZ2JzdLxmMo1YwaOmZUOop0zgyLX1vzM1ILrNu1BfbxzDY1U+w3h+iz9wxGZNpz5bhD/TK1bcyIKpAr5dI9Wq2fxm2/3MYeUQK0wicS5pfKXaypQy5mibWGoSYcUHTa2GfXoGsA9ZtCBTh8vwnRWrLGtpdsGoo5WYAfZ985ONoUN4PSDtOBDmcep6Dg8JLmy598npxR56PpFbvY60nBfNYZ2VAmKKvctpNLFtNMwVQvGDcL04kFrSqUHzd4w8XB0f65KX35Xnk5hDrmeJzdJWyDg7o2LaRbbmsILQSAWz2VMG00blvO4hf2sAbcNyTZ1aYOBvuWFwOwIUCDgO8Aa4rj/93J43xlShLfhgSwgiazSCRI84uQDXy1zWOw1rCrjinQi32j0hY/guk7j2Wkoi0hdRuQSmTVEIrDsq8LJNbPaMzzlQaRfr+MPLnhbInO5ftq34aV1Jewrgpr7gts6Oq6NVyI/mnxF0yu81zEXEhci5V4Sk/JP5jgdTm0RzTYAIM3IMBHixPuvBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(55016002)(53546011)(508600001)(33716001)(2906002)(83380400001)(66946007)(1076003)(9686003)(66556008)(66476007)(33656002)(44832011)(38100700002)(9576002)(956004)(5660300002)(6916009)(316002)(186003)(4326008)(26005)(86362001)(8936002)(6666004)(54906003)(6496006)(8676002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zi135cZeuFyVVxqmK8dqXM41HUIPWLAJJgkZ4LU2eEcWql0kqP6CAF2X6iKy?=
 =?us-ascii?Q?YUfSXWsD7mABlr3m/1X4204YcGvljTqJ3WXR4gwEZTqsC2CZ+5E9kLKwcp0W?=
 =?us-ascii?Q?dYFoQgzlkq2o6FrpGAl78nTioY0spQuZdOPwxgyuUEq9GTbOWsTiKbt02suX?=
 =?us-ascii?Q?Q4J4KsXksIUvtqTabHIlOxfaRVorERunRjFeTTMz+WJMpfQN2qeWLGDdcomc?=
 =?us-ascii?Q?D5MSYHFg7nCjRTi4Bd1skwkItitapAFVLp3cBNfoq8dRPjbyvVJcOivEfo9A?=
 =?us-ascii?Q?kXE9w0vrDtfVB/NmI82mlAyB1yiPEXdsLQj8Fn+cy9omhAwNE13Ofhj/CtU1?=
 =?us-ascii?Q?SCmmfCRAYpzea6eQyYTWWWNuFLLYqk60h8vx6e/kQliS+X3byQOrqDhJ0a5e?=
 =?us-ascii?Q?8ejTyrfPtp0BIFNKyMe1ihzPQje4TAzZliu7CMH48pb2P1cw7EeXkw2kkZRd?=
 =?us-ascii?Q?yBkR6JaftJjEHGztIa7LAWuS0CJ1L+UTbbthcPbKMTGEOka6ej5BDH44TTEQ?=
 =?us-ascii?Q?4PqGSGO6Mn5wlWRoBM1x0e5l0v3yFdo1FF5rpQ+FRex2O4bj1jFP+rDk3Au5?=
 =?us-ascii?Q?GJSN570Q6QzN2CBfO3C1/PzN8IOXJ/Lnfsl0fFsc08MHJN8ehFG1OI8GCibm?=
 =?us-ascii?Q?pC96U8iq6XG8nSTCRzZ3YxCg0oSMh8Gze7qghBrGjOy63Xw51Wmr++fWkwG4?=
 =?us-ascii?Q?3MdYpjdn1Kl37KloTCWWfnykAsGmf3AeD9ME37IEOqFKvT/A3q/wmu3CtsEv?=
 =?us-ascii?Q?XBP7fFAxyilYBNdj7zJOQSxPWnWbNLC3d1TeuduSpUXeJ5duc2dJx0fFMavR?=
 =?us-ascii?Q?JX5It/pDvnT2YoO8cHyAIDhCkZVz/6FHxJvh6pD3sy8dmVFxv5HIiboubEEK?=
 =?us-ascii?Q?T5c4IuRPBSzGefsVp29wfn03HgzSm5zotIDv+Gn4EcX0ASAlYrM5T+Q4SL2O?=
 =?us-ascii?Q?V62y5Cyppj8t9KUzgSHxK8HEnzfGOY2d+pZQKUEvn5Bhup35f8td6Oyf5UuS?=
 =?us-ascii?Q?wFO9btcVBjAk3irVKPDf+0Te99nsn5+bC6IRmbmrscgX+tYEZxjIKgoKKubg?=
 =?us-ascii?Q?q9aZJ8w3SmkSdS/yjLUw5fVvnKHApr6SD67qyqIXHX8BaqdXynRggJh3thxF?=
 =?us-ascii?Q?+/HlYUO0Zk3AQENRMVpTgjC2yJf0coSznzOFLJ7LvlyrRuedxwLZbMGa7IAD?=
 =?us-ascii?Q?6neDsqTSGGfUpj8KAOyL0NyCAEcOiLtqx4RWUoCiJVCqj0DNzDNU1BEw23VU?=
 =?us-ascii?Q?cXkrDMcfW2tR3167LcgDG3+c5ediNxPT2aea0dIK8BZE72F+b8nU3yZXol0L?=
 =?us-ascii?Q?x69cHe/9+c8e/7vsOwVCrO5EM57kWYpTJqkmdFa7SmlByE3JJcMp80dM72s0?=
 =?us-ascii?Q?ZPbLh7e7bYXWb4FY68hDXqsnbjson2wzP+IZSJr9w9w/OgvHwhYYwxAUlTCG?=
 =?us-ascii?Q?55CG6lXsHeCyvH1z2qhhPcATVDXQlv81DUBBWvfj3s+uAxqZ79N49sPHT6GN?=
 =?us-ascii?Q?fJxFSIk0poeoM1qcRSH/3QMeQcc3LoV24Cn+696rJkv/hSvIkZHZ44Pu9jVl?=
 =?us-ascii?Q?U8NpHYs2QatU0pxvMfMCpcMhmMqdKbudgQlyWXQYquF6GDP1NVTH91dhIMpl?=
 =?us-ascii?Q?ESN0+r6CzEGqPLtR2UALJ7jJOemsIAjnFFa2G9Gvqi1LIL1xXKIT4CG7GKr0?=
 =?us-ascii?Q?ehDgldzA7AEWxhHq6Onyqosy8ak=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7669ca-e0ee-4d5b-0177-08d9a90c0923
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 14:19:01.0744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bumOfmQWYhTVM9HsREqBoqK/pA8MrYyuSfRKXuTztP+O+FI9RBmo5lll5bGSnPjoUQzdXy5Qvt7Q6V2RnYnhd4+C2ZdPgHMDlP+bpX9Uo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1487
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=845 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160071
X-Proofpoint-ORIG-GUID: z2h0Y8qByrQu8ACWSb5yzE5j9caUneih
X-Proofpoint-GUID: z2h0Y8qByrQu8ACWSb5yzE5j9caUneih
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 05:00:41PM +0300, Pavel Skripkin wrote:
> On 11/16/21 16:48, Zameer Manji wrote:
> > On Mon, Nov 15, 2021 at 11:56 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
> > > 
> > > On 11/16/21 04:14, Zameer Manji wrote:
> > > > None of these defines in wifi.h are used so they
> > > > can be safely removed.
> > > >
> > > > Signed-off-by: Zameer Manji <zmanji@gmail.com>
> > > > ---
> > > >   drivers/staging/r8188eu/include/wifi.h | 57 --------------------------
> > > >   1 file changed, 57 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
> > > > index 193a557f0f47..7cbc7015e90f 100644
> > > > --- a/drivers/staging/r8188eu/include/wifi.h
> > > > +++ b/drivers/staging/r8188eu/include/wifi.h
> > > > @@ -13,32 +13,9 @@
> > > >   #define BIT(x)      (1 << (x))
> > > 
> > > What about BIT() macro? It's already defined in include/vdso/bits.h and
> > > can be included via include/bits.h.
> > > 
> > > Most likely linux/ieee80211.h contains bits.h. Haven't checked yet, but
> > > anyway redefining kernel macros is not good approach and BIT() can be
> > > also removed.
> > 
> > This is a good observation, but the objective of my patch is to remove
> > unused defines so it will be easier to do the work that you mention. wifi.h
> > and ieee80211.h redefine a few kernel provided values, and I intend to
> > follow up by addressing all of them in one go.
> > 
> > Would you be willing to ack this patch as is?
> > 
> 
> I cannot ack, since I am not the maintainer (or even reviewer) of this
> driver :) I just saw this BIT() definition and decided to say, that it can
> be also removed

Just give a Reviewed-by tag...  No one is appointed as a maintainer, you
just have to start handing our reviewed-by tags until people start to
respect your judgement and then you're a maintainer.

regards,
dan carpenter

