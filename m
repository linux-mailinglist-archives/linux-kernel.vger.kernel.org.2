Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F32423B53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 12:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhJFKRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 06:17:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48442 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237771AbhJFKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 06:17:21 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1969DUOJ003362;
        Wed, 6 Oct 2021 10:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2/F1NFXo+iB6pkEOfkU6G6JYE81XbRDELsn3tbDLY34=;
 b=avQM9tqgm/lo2RC8wJ9vU/fIBGiUHLTvz7I10MI+/mYQNfgyLxvr63rJ050p65DzY69w
 8z1ZuHCX8MGQNAKjp8mzVOtn7Y8R24teuxE4JhIjINWRI0C79aYs0cKQMd9SJWlKCQka
 V20RI/XLWNxOPHlyCRGHyUwU/gHrgF5qVrENC1hN3oawaHl8SU3xV+5ILgVqlUIY/xSO
 m6PoCHts+KHQ3dil48lBXnsI+9fEVEPTnoq7ECUA9mqqYJ3Q/ClNLUoFcikPrKL7UzXf
 O1FXOPfh1fT4FUhAiz+U+PdmQK7KubeVbygc104mGh7cQU0QF26Ybds7vOO+IWr65gd7 LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh2dnj6b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 10:15:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 196A6Fd6050360;
        Wed, 6 Oct 2021 10:15:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3030.oracle.com with ESMTP id 3bev7umkn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 10:15:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnEwPw56BXBJRwu9ISCXMevietyR+s0/Bk8O4aka6yj9yl4p0ZPf2ZrLWNAIto1WLxkL/gVcMzGHOr3t2sbqixmBzu4W0neSEZIiKV8h5jmbq8pYUQrolyitFShvDMIIho1kpwYrI0nYYoxdH2sS//50+rWZl4uoggaJ4DCbIW0jiKgAmwJa/xmIxzFSml3vI/6ogBCjteSvvamvvwW8DnH338c5+Pt4yLWbBDrCuKWZ2cgZQfguPib6Cm68k/+HSFFcU+dYV3BeoKb64n7UCFjbBkjF5vgTteYy0lIKlJTHqXDr72Ou+5KCy/cKYT2oo3MANUmFBIcADwPY7bHtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/F1NFXo+iB6pkEOfkU6G6JYE81XbRDELsn3tbDLY34=;
 b=IrxSumtOMGSHkOcLAI9UcYe5RgvkN48CHw+/MiJmCTkpbcSrS9nkE+VMVk3/pRLSah+UfGs6pwj2vbw3LCFF9yNj7d6ztKRomugv4IrRLeKcnJg85c/XPioBxOnKPmvdJuNxAGiTwqk7HksEoz1HuDh02M/234IlqrKNNiMjJFZ3rrB1wzypDYV5Lrn/iGdswyZx9haSSm/Nzp5XtYRxZFEHLpfEbHaZLmKYrtyFyWC+CR9URsfLALf8GHfJznNIeukkuPDFm1FR8TuVANGdpHcoDzF8jidxksZMO1YcJoZltpaRclGggAzxKjDyTGdmA/FrYANAfU8LpClcEllDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/F1NFXo+iB6pkEOfkU6G6JYE81XbRDELsn3tbDLY34=;
 b=l6V50/116CPcHX3IDMgTGbc8wKtb9DqD6NgR2wa1q2ZYaI1fi81OfUb17B3/W2rvy4wLaFvh+H6dIaOIrA6n5TgGorzf9Nfyqi2UTEuXn9THuExtTmhMAPZcJAQZneb04fHQbOiU6M3NCxSEl3dwiFZ8bzELw1ZJmJAeP0rQhmU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5570.namprd10.prod.outlook.com
 (2603:10b6:303:145::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Wed, 6 Oct
 2021 10:15:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 10:15:17 +0000
Date:   Wed, 6 Oct 2021 13:14:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH 3/4] clk: ralink: make system controller node a reset
 provider
Message-ID: <20211006101458.GB2048@kadam>
References: <20211006061204.2854-1-sergio.paracuellos@gmail.com>
 <20211006061204.2854-4-sergio.paracuellos@gmail.com>
 <20211006082903.GZ2048@kadam>
 <CAMhs-H_qb=goRmfhO1P+mt_NKhJFuJgH6a483-6Wk8M9MA1cJQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H_qb=goRmfhO1P+mt_NKhJFuJgH6a483-6Wk8M9MA1cJQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 10:15:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca7264ca-4982-4162-5034-08d988b23222
X-MS-TrafficTypeDiagnostic: CO6PR10MB5570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5570BE4DEA6DCC45D83661598EB09@CO6PR10MB5570.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCZDtt4I7dtBdccMvSH1fpaLyDnG7nsqcXI7deYxBh3SgV5MnXd5I4nS3KMifcNpl4rLWlIpzNbSRSEIVIUIXG3je+e92Wxg5zxuAPDuulLeCgsAc44XIgoAXg9OIuU0PnpWh3zfg8Oyl4AhgzZn5wvW/RzrqDjaseD0PPD1RJTKPsg8tdOznxiREprh1a322DyfMtj5qwTNs5jM32MuknHlN/O6I307nDkMVuWRMGmAepAawt+Q4r2hqlG2uNrEJ1cbwfvUnILUa8Ngfv2w0+vMBqJ6GMQ8qmadJtkel6KhibbfjXTzLThCYpnRyACEX3nmwDx47BokwrJFiuFnN4eOLKsntnC2ogQWd9WaDGERLdMpk9DSmyHvE7caKrQ1t0wae5wCQo+Fp0bsAnCbkjf2GFZ42zL1bop9PLGbaWbt/hTlvO4rkP1ur9IUg710jWLeE649T3pXUvrDho6IC+Go8lqigg9+2s75oSMpd4XkXu1h7fRZSiMOE9vmyHSTcTu81e0gvfG0b0UvzMRcb4RyQEGUYOH1ZHhhcRj4LM11sMWs7JXSzWR2HTGhz9DjeM/LKY4X6J97ND5xkkitChdj7BUGFIpi5OSj3giYJKP2hp8Dm5o8NGDEUxzTFrdVDwvI0VH2TzmZQlxSrlZbYahXTdD4/RQLj4fzzHFUg2qsGhi9orOybFsllKkHr29EPJtaELrNe0GCGKqjvJjQHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(6496006)(2906002)(66476007)(52116002)(316002)(54906003)(4326008)(44832011)(6666004)(26005)(8936002)(53546011)(9576002)(55016002)(1076003)(7416002)(186003)(66556008)(5660300002)(38100700002)(8676002)(9686003)(956004)(38350700002)(33716001)(508600001)(33656002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aXUw7K8Y3Q/VedF2lmbFf7Sutkd/Kld+CPbvKZiT5QrcMjdpGAifkj+JU1Gj?=
 =?us-ascii?Q?Exz0dQyVvTRuANhMH6bEweiL9LYcqJxwPFsDGuoq3ZE1xTzuon8PD3GdKPvc?=
 =?us-ascii?Q?eqZ32Wvl/XebLxnuMEQ5tVCQWAyq6EoZBG18iajbJgw2fEpW3XAwmENRoLBz?=
 =?us-ascii?Q?YmBpyi4GraU1X2GMpSxyQXLvW5XPwGVixGfGU9uW3AnsUxBp7saxdMmQT0+c?=
 =?us-ascii?Q?HVZxAtujRxofob3faHSiG/nfwDzSsaGF/58CJ7hyLPC4oVpp9HMqe6IvNwtH?=
 =?us-ascii?Q?h35ehRdFlEiEj85ga3xrpeX02/E122JQv1kfC9MGEKcQAjL3Hu7vzVSWKiIi?=
 =?us-ascii?Q?lPaViSLfqJWRCmtQocKMnjTRwugprn1+Q212oflYGIm8TEJl7si7s3CMl6T7?=
 =?us-ascii?Q?oTJPAZVrlmWOadKx0SlMEVsMWYTbJzh6eho6NbRsAxLzq5QpGfYl5WmDngdn?=
 =?us-ascii?Q?C7iee3gb1lXD9AZv7rqnuuMkLF2LucC/NTxxNqHX2KrCYIAESoOE/jffEObn?=
 =?us-ascii?Q?c+p7Ab8BqI1U9rB4stkA93SIH/kugAwaaNETzlNxshuy6ZfxkytnhjtgpcXI?=
 =?us-ascii?Q?OTMFTzugBSgdaRCA5oiRIPoB0bRDVMhzkwkKxXN3FbvudH9jdeYAKUJ82ssU?=
 =?us-ascii?Q?MnbBugMa4M6owY0cjUxsOzwAenBe682y0hMZ8Z8XAwtlbzgkfhWDSIN6iRIa?=
 =?us-ascii?Q?+bgs7ts55ExuheKzp90421IVZW1njAduA+g4T+o13V6AYChepmz/97YqVBZm?=
 =?us-ascii?Q?chQrKbJrtQ134oxlcBolL0r+NZbjzBQ2xbtz6BynrwGS3P8cI5DMB2DpkDUq?=
 =?us-ascii?Q?2ZrbmiT0M85+oOArUyYcMzSumkfYhjTt32uSpDGzGXxjSy14ZSZwy0tTmpPd?=
 =?us-ascii?Q?OfqMy8WZHM8CmaYcQ/CtLQez19YQiNWd2h03ekAS97cO27MbZFOKArRB0Ark?=
 =?us-ascii?Q?6kJRzs3FZYwJY/gnap6dEgAL93AGbRMpJ7cDAShMgU8bqYXdmS3ILx+LkanE?=
 =?us-ascii?Q?sp7UN+SP+u3aTPZ1tMawCWJFUl8ceF7kcaH8QkvUHhqjKcqVIXGpv0amzSUg?=
 =?us-ascii?Q?++qUU7Xq2bSL9ZjZCxUcZC6zuNz7ViGobm7OicKSLQr+ITW8FAS8XgmYqgrb?=
 =?us-ascii?Q?S9C7Ptu26zrxQkyDBY602IAurLInTQeEoLqmr7cuIaWs75LKTqzVjhUdr/AI?=
 =?us-ascii?Q?GXc9T8nMjUnPv1SI9NOmT9wQVb0Ua74nOLziqrgaRZK454sJh/g/Dj88vX9D?=
 =?us-ascii?Q?cfsX7IqxpWKOBhuSpPB3ONV4MSn5Jt8m9/TuMs72mZXtQMh5VwefiTJJvR4W?=
 =?us-ascii?Q?iP/F0U2osSkc71oT+zARfdT1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7264ca-4982-4162-5034-08d988b23222
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 10:15:17.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4CpwBa/ZkcvURu8FNUIK1QnRmHnvkPJAooXAy2RPkJELTMyOtKCozEnoomqFrapuPJYvQledj8x7Er7OYyXVdhiyv5kstBUqhQkbLIxN7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060063
X-Proofpoint-ORIG-GUID: yqDMF6gmGGSqIW0RIxBfXfHuf4Ju6ZCB
X-Proofpoint-GUID: yqDMF6gmGGSqIW0RIxBfXfHuf4Ju6ZCB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 12:02:12PM +0200, Sergio Paracuellos wrote:
> Hi Dan,
> 
> Thanks for the review. Comments below.
> 
> On Wed, Oct 6, 2021 at 10:29 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, Oct 06, 2021 at 08:12:03AM +0200, Sergio Paracuellos wrote:
> > > @@ -398,6 +401,76 @@ static void __init mt7621_clk_init(struct device_node *node)
> > >  }
> > >  CLK_OF_DECLARE_DRIVER(mt7621_clk, "mediatek,mt7621-sysc", mt7621_clk_init);
> > >
> > > +struct mt7621_rst {
> > > +     struct reset_controller_dev rcdev;
> > > +     struct regmap *sysc;
> > > +};
> > > +
> > > +static inline struct mt7621_rst *to_mt7621_rst(struct reset_controller_dev *dev)
> >
> > No need to mark this as inline.  The compiler should do it automatically
> > or it will ignore the inline.
> 
> Ok, I have other functions to_* with the same inline syntax, that's
> why I have added also here. I think I will maintain it to be coherent
> and can be removed afterwards with another patch not belonging to this
> series.

Consistency is never an important goal.  It's better to be different
than to be wrong.

regards,
dan carpenter

