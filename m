Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E17423968
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhJFIMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:12:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35750 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237594AbhJFIMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:12:21 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1967FCua002190;
        Wed, 6 Oct 2021 08:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=MwoNh8okNmcGkLoTlTZ1dhoDLEXKxqqcug7yUA4Q2EE=;
 b=OVdLvKNNdq+sAg0slzVohxOcI5FzTbMOetzSjD52vHdXsqe5vBfV2y+Xrn2IagMTfq1w
 G/1dLJE+8lViHm3J4Rlq6x7EHNffivrnAfsq41iCI2J07QwgSyuEzmqppa+JDr4xTPTb
 ju5fEt3fYA7HBIi033gSWAkZZEcdHgfFEiVpDFnXRT8GBEV+EcZaVgtHOpzDea9JAAeK
 48ocgzNUNbw7yWikfF7m4my23GxzhDRiVoFmd830TPiNC5xTGO9F9nX1QwCvDNdtwQ2J
 hIZFxJNQKBsMY3DSxj1AFq1kccCUAP7KNeRRZPE2x81s/t8175CiDj+xvqMfmsmnEd3p UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh3yn1649-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:10:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1968A0Db142087;
        Wed, 6 Oct 2021 08:10:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3bev7ug2c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 08:10:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nglTp4ZYETIvX0ic4k1Tjuu7eQ5DMzbtj6jTttJZ/BCUET2VxWMG41iNxk01dJJV39Drt+2jt5CNMygbq0d3ii/O3SaBqjt2lbHaxf51ndtPkFWPoKkq19fK8TIuwrNrkyX89bNmkmxNicyYwEt5/UXKnfEr0rrvzySwwxrEY5IBaLkhs5gSCyhUZloZbOxGnZUekEcPDgN6PK59G1bW1SJiZenkXpjGv/EpufhSXnF+lFhWPIwGoV2OVNdH6527vBkp3obxMGTv9J/pmm53DB3QfjiZVcglBu/eJZeaQa9+N1Pp7UbtTCCYGHFPT+9rjwuLpJtguH7Orqdj/KXwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwoNh8okNmcGkLoTlTZ1dhoDLEXKxqqcug7yUA4Q2EE=;
 b=hqO5VsnUfY9/Ab9875/KpRm4KSJOjYlg+RL5qTGKh/veylDPTaitin9fuY5HngQS9WBqTsZ1fs6tFN0HhajZ9DoHts2jKstdCLzgeCpcnd1IvKf+5Znugz93c1PQqZzpcRfaJmUjAGXNu/ZXShqUlx8omJdMDmT0/BuWYBnrDHvmnDjpdvatR2hGlrBCw1aufh8snGgPS96Li+dku9HD+K8NfG3eKxj/coRG1nS76RJffigbgkY6yfBGQeOdHR1PC3VYuoVY9OvY7epx4ZiTA1zh/JiOuJdaMvQFZIJourx3XkPkmdJIIKlNIj2P0G2rQGc/pMYix97mX5D3x0jf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwoNh8okNmcGkLoTlTZ1dhoDLEXKxqqcug7yUA4Q2EE=;
 b=dSsngQSueQ+q442msP3YtNSbOXjfxFTJCNyhrFcb7IBB+X1YcRy/QQJWLPUES3AcP4qDBLJafBtz6WS/hMTHQgLm9jRZS+3CbvlXD5pO8HNCaIj9WSjNKKdt5BqJEOxsFASl0xTDSkx8cNOZAa52b7gu2yVwwCUlSuUCqfKYeog=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4643.namprd10.prod.outlook.com
 (2603:10b6:303:9c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Wed, 6 Oct
 2021 08:10:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 08:10:15 +0000
Date:   Wed, 6 Oct 2021 11:09:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Message-ID: <20211006080956.GY2048@kadam>
References: <20211005205702.14029-1-tomm.merciai@gmail.com>
 <20211005205702.14029-2-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005205702.14029-2-tomm.merciai@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 08:10:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6115ebac-e77a-4fa3-d20a-08d988a0ba2e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4643:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB464348B9D03E70F7FF59C0CB8EB09@CO1PR10MB4643.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gw+RRPxCMs7APA+UgL0obB7a7JTF9r43mwVt3+/NbYl7rfU9HydQNnq667iTq9xod1wYRVeplbTd3PB4zkE+UucySaf10IXrtaS8l/n60orVJcN16zaX45OJP09C0ZvSnKmOeMfqenLVUjBIfWRZTkWjzLL2ouboP6FHqJs/a/BbchMkSpe4uODz5t1nnYmpkFlZvraMcoo5JY87cvJfLimghjsjIWlI1H3xCYZY9NVewoMNB21hKTuLtq7SETwm9ewMxWOb1Q9c2uo7len5GI0V8P7ZggoZKnwWj54GaorsInv/FtwJMnYmP+1I0UNKavk3vcBpMM1+P5UPu42hNSwCbvqG830m+9kGj9Fp4z3tFa4aIZHi15x/28YRm+P+dkFAEKRYZP6QF+X+IH4Xj/g2vYY/4nI/3XDusQzJiiqWxM3UpF4cXlgkN5txmf3oJUZP7K2eOScI5cGBF342SnPnKLdk86QYxi4aHsfxDXsm6+JIhVIs/CFTLwaKNWuvZkoLwwdaQ15+wUuaCagVoeKq4mQaDl7rmxF6PrHK9/WRDSBNPlhbcD2IF2kRIJe7ZzdJwu2xwLYFIUnGsTsngw6RpWqag5cIh8HPxPJ40/Di2uFcqUJU1v8tR/S1qG3QxzLveG2X5nTyzQ7mU965FVb1c1hB+YTLM2q9RUtRlpPVZdDt2OEXAkO90KvCZfUCMPb9yf8YgfvQkpiZ7xQkPRs0B9UhF2PTejwxF8+w9tmRPgEsahoV36Ruq9cLNYELFa6UtDaLLOEtS1YXdaXAcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66556008)(86362001)(33656002)(6496006)(2906002)(508600001)(66476007)(956004)(5660300002)(9686003)(52116002)(4270600006)(55016002)(558084003)(1076003)(6666004)(316002)(33716001)(54906003)(9576002)(8936002)(7416002)(8676002)(38100700002)(44832011)(186003)(26005)(6916009)(4326008)(38350700002)(145543001)(145603002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ip+zcgcs9dqBceY63StzI3Wt5KpoA8puNsa/D/XSPI/8hNNA5K6kPDq/hb/L?=
 =?us-ascii?Q?zkpPFwlz8zXoYLk+E+8TuSH+NWJfjjBVWrL/rdU19feNGyQVfElVIU70BH6L?=
 =?us-ascii?Q?HK58vkc/zuC1Ien4gsL2/IFe9vpre9CxvMZTw1BO1ibdj0VPuhQ4bwpUHBnr?=
 =?us-ascii?Q?vkCL/CmadMUtp8R94piKGP8uI5xncr/feVpcKGxWtNc+kBAYJjfaeWz3Kmc7?=
 =?us-ascii?Q?lSxt04+LKXK1SK5qXiV7CAE91Ix4OZ32Tt4kKb221HmLGRvT4qdutU8VB88A?=
 =?us-ascii?Q?1ysObDsTf1F7KnbF+fwgegqA3/sdwp4JBOqdOBQdORT1RFgLeOQeyZeAdhs3?=
 =?us-ascii?Q?rGASX+42ATHnDrel5+yT/bfiIYO7blsdPEyTd+esQlQPAlfSKFnJxcwRHNIt?=
 =?us-ascii?Q?fgHyFrV9mZSi4vT41Mp/YGZbXDs4adaXvpivxpl9mK3ZG9t4w41j3mjucqcl?=
 =?us-ascii?Q?7CEwR+Jt6eGa9bo4m7jJifkEsrrMg5tLc7zvqMDSgzrJMKHooLHfleKz66E9?=
 =?us-ascii?Q?gJcfzD/EiRCN2hRPmr3dvZyl8frc18xBZ/jZf3bwfY8FaOmkzsBUmwSWKI7P?=
 =?us-ascii?Q?K/6JDH7ZO0RQX54rRJSHEYfz8kvCq6yNhR9gc3i3hXek1BOE4j+e3GQBLaWf?=
 =?us-ascii?Q?ILO+AxftBh3UpS006xHwKD5wqRIyZZfcOlK1AfxJznFml7xiHN3aNEo8/z+y?=
 =?us-ascii?Q?aoi0oOH+0GqnDkQ+Cq83L+1zUS0lhM93k+6f3u5YwcIXhJhw+v0cL0W+I8EV?=
 =?us-ascii?Q?UNJejWNd2cosmHa9CCqMPVsyi1ByqSZb2l4zrxgzBO9W5xN9bc1BbBOJrQ1d?=
 =?us-ascii?Q?6Ry5jQU5tchCw/lGo5MJlx22XE+nHU2DK/0wUtKzfp/phIBUbv3PaFagXx3M?=
 =?us-ascii?Q?VUcaNP7azQ74bw3Lrh1uabX6oBtPAVN5Kld2eel3ptY05Dr1jDZeZjmDGrR8?=
 =?us-ascii?Q?iy2M9X0RHVVrH99vvKeHRLF96Dp4y6cVeS3TeZsQwXMS6g0RCJg/VFSWmbp7?=
 =?us-ascii?Q?mvBq4hUL5vxiSH5Wzaw/zZ7pJ85hUixt2LL71DMuILGXxKuV1SxxALy5/6Ls?=
 =?us-ascii?Q?B6pamp2G9bG26ghm5y/sA2GAq1K1U3e8yTZNKabCtf7P7IYRUtMndXvwMRr+?=
 =?us-ascii?Q?oRCzI4yna9jWpTCr/YTcVhZvGiDbPmrnZ4P3dtXLk+ClZit7YUuKnfe0TvVf?=
 =?us-ascii?Q?g+fwSvILoebXET7/TcJfC5t4Tec6TB+j73WINHOMuZeGgA83Nr2WUtZYSed4?=
 =?us-ascii?Q?HuI6t5qHFKrQR3IWK5nk1sbSe/jgsiPLbF/LRmSDhBZp1rh1Wk/jcFXk5Zmb?=
 =?us-ascii?Q?5v9AJuf7dE+gogBRgTSxDmYC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6115ebac-e77a-4fa3-d20a-08d988a0ba2e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 08:10:15.6437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xR4cJ+Jirxi9UO2mi2Oe4WckgH+th+9+XPIMnu6+Uoav5dahiCYe8Ejfy/vdX3Jl7vm20ANeOqNAe2rpB9ebhmDSBR+OZP6BpThiRglJFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110060052
X-Proofpoint-ORIG-GUID: Pn6q5FQjeXbyQ3RBcVbJ5zTRc6cy0JfJ
X-Proofpoint-GUID: Pn6q5FQjeXbyQ3RBcVbJ5zTRc6cy0JfJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks okay.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

