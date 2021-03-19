Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628F0342698
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhCSUAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:00:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45112 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:00:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JJxKA4075766;
        Fri, 19 Mar 2021 19:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=f+TBwTbnpkM8PSZ1DISabSjo6WmzWsK5IhzXD9EJ2bI=;
 b=WYq2qF3DfgPcf66ZvYftR92ly6VcIgQ1G4fo+DHkPomCCzaaFSxGdtyXFMivm1xIQG20
 vr0euQEMW7jmQWrcC7rwE+5iJnWLLLitX8FtCkFeczazh01LJCgQ2teDEj8PomHJ0+Ym
 8nuuVkigs6s5maxd0fOoiWLkcbHvnTXhhmSmXcsbzf+o+qCSQEVk6cejQA912MiJyXG7
 hyayPcq1ItxaFMOjnMDVwCGLG2N2sqr9N0vbtOc/kR8NnIS3+O0zUy+2dYX29ePo2lwm
 I8ek+3Jt/qv3BRXEC7jcmyj6MkR37z/DGPs4FaMG4Q12Qp0WLs1whm0O+OVTHTkpYj/P 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 378nbmm6k4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 19:59:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JJovAN080447;
        Fri, 19 Mar 2021 19:59:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3030.oracle.com with ESMTP id 3796yxugsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 19:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBgdxrsgeeZbj7yeSUM1b3pAZ3asfo9pmN/3BNIKkcUC+oJKHeERo+Z/BJnF3nDWM8sAPjqO3fZtLbvVHJWO6olWG6aw1iIVtPoDI+4L6wT3JBB4MUBRdnSOa2Y7KsJkJj33kg9mw5cTY8VNnUu7kNS5BflmPyQ654Y4hE4VQenxW+6dvtllSbvHzGSRGTksVZmyDAPF0Cfs3Wd8cybFEzbRAOlYpg6gzMXzFdRmeu/9LLHNu0LgLqbCeQygbW4C/dmEqUm9L30dS+psq7Izy8KFLydunUB7ZoluQAmQertwcVqrhYBNR2rXX/ibVcTzDQsFImg4H+7HPusNO5GqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+TBwTbnpkM8PSZ1DISabSjo6WmzWsK5IhzXD9EJ2bI=;
 b=SXl7++NVT8IS2UoCn4fQrac9KTc2kM1USzdWQ0YmAL9flT36X/Bro3XiYTb9qTMsMqQ9X5v2dQiF6GkR3GUtP5ofa9hkrM0Kp6P2Ds7dT7O9yAHAKdEyy4V5OIAOXx06h5TL4HENNIxUkYjHWWYmV8PaOoQnrBgJwKhEUfAlbS94O2TAETANllzyuRp4GRcCUC9iSq9UxFxXZGAgMoh6w+RWm1tbb8lRhUR7I71HP6YJvmtIond5UAcT+oufTerPWHeCb3CPQEOUjgiGjtITUYfHDjs0TyFzcXsxUC3c6XmfxDspuvSEWsF3bm9sQRyUER18DsyA5ub/siK4UHezVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+TBwTbnpkM8PSZ1DISabSjo6WmzWsK5IhzXD9EJ2bI=;
 b=WVY4p2+zYbkG1XcbRBLXVcIbabLHhWdMeACxtgqVNoyUthZSKhSotGwGk7KXuaTQmJA8vtzy/hmBjurZZ1SPWB4s0ZKjtYmGOecp6Ro4K+pt71c2bkPcaggVi38tm1qe9CKo3Kimak2J1d8B8gG2cLDJBKg8khjYDAYWV78CC3k=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB2902.namprd10.prod.outlook.com (2603:10b6:a03:85::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 19:59:39 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7%6]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 19:59:39 +0000
Date:   Fri, 19 Mar 2021 19:59:36 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>, xen-devel@lists.xensource.com,
        sstabellini@kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, opendmb@gmail.com
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
Message-ID: <20210319195929.GA1346384@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
References: <20210319040333.183827-1-f.fainelli@gmail.com>
 <20210319130731.GB2624@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319130731.GB2624@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [209.17.40.46]
X-ClientProxiedBy: BYAPR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:40::26) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com (209.17.40.46) by BYAPR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:40::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 19:59:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8163f9bf-29c2-4693-6abe-08d8eb118787
X-MS-TrafficTypeDiagnostic: BYAPR10MB2902:
X-Microsoft-Antispam-PRVS: <BYAPR10MB290255CE840A606A9009D21C89689@BYAPR10MB2902.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kkkw+BV5HE7K3JydfdiDwUK6sxDPkUugH7m1yRNzPte8amwyOYDjrngPDtCShjOek+B+tmes4v0RuiDw41ZjtxlHBscWfxpXTHUqUsJyUVM9t/d6RHmUWmpR2SfOQgZqeXGCFCiqvoQRK7o0SmdBwsTonm6hv5dW7s5qDXRQKpkYqYH850uHcrhw98yj24ZI79Mm9dycIk1AvK7oAg/w3nPVD4wfB2TSIFwbyCXTo4PxMcDQzTR94smLYAUxzDg/qbzv4XNmJk7FXZ7hZt+sEwNltp6AcmNL90BbdpK/U3mi1BAbkm3+YmLMljYyrRnnd28eqqp7kV3uC93OKySx49VY46gbVLb4/WzXR+U1c0FzCXVeSkFEwiks2nFNpmKusf+hdCSDNJUeGsNOZjm071ZirVCsnehmY8JbGbFhAuTr+kC4r0mUWB8btgfQbEv7eIdEVDgpsAM3mZ+esBz9lGK7NQYgAke9bgo6bVhPs781djlqAB0bR4Oyc62ds+C/b5u2PCls3fa7Ss74gY2/LrGagGeLxmI8C+ZhWlZXl59FaGHpTjtapgWzS+Z6xDBxToTs4N64KYCoIEL0I4RDeUr8gxbD37e2wcMwteSysPiPnXo4zg4MD6xBStz6z8BxfpgkFDY3VS/ZvKMs1fFDSsp0aWLwp8TKsWxzQZDx6vI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(478600001)(8936002)(316002)(33656002)(16526019)(186003)(38100700001)(83380400001)(55016002)(26005)(52116002)(66946007)(9686003)(54906003)(7696005)(86362001)(1076003)(956004)(7416002)(5660300002)(66556008)(66476007)(8676002)(6506007)(2906002)(4326008)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DuGkKxV7V9VXTo5FoEtRUt81yXvmFReF14RC0AFcS+tpqCeLUyIxQDecY2Ki?=
 =?us-ascii?Q?DzAtLvchj95w3APyhLRLWhyeMpQcv2OYO+Sf92PObjqRFhPx1thEP+5IZhnh?=
 =?us-ascii?Q?MHttF80+lGwHJrLTy1N9vJAHVJRnYSBdZu+R+tc0UCnEuyCCQBm44GMaYPwg?=
 =?us-ascii?Q?pFgV+7zM68sJlXkvchLp/Aej+7rzYTD5GDxIBLs/q3WruIiYNURD607kaqM0?=
 =?us-ascii?Q?7c620GtaVkADI4Wxn31xMl8WklCUgS2O/QskW49jFAi/mV3/M/JOzgJyIio6?=
 =?us-ascii?Q?xpPzeE1H3GAAbYxg0YaA/a8x4Uifazrx8vPBPA7A51AdQFLwnGhnDHtjwkRe?=
 =?us-ascii?Q?mJaGa5cR6jXe/EqKO2zsv+UpJ8PCHQ12/w5dHq57C3LCZrPyVCHzjvIwdDu5?=
 =?us-ascii?Q?X0BYC/y7dyJSyfTx7Ryy0n7cU7Xt4G1Ka9AzX5XcPrpqBJVzgC1rnS3Z6xMu?=
 =?us-ascii?Q?SlEnzPJi9/tGvjM77dMvFHXiYZ0W0yzYDfrzFfPjqqNEmrILul29WPRY1Wrh?=
 =?us-ascii?Q?6GpvAkuMpi1ClWt/Sn/6d778WT9f2efPTBNUUTk2aIAuE2LyoQ01xpBGwjQ0?=
 =?us-ascii?Q?FUgpdXzxgE3J68uKeyPV2rykjEfQS2GuQKDCXm53RuDu88Hfcsw6Y9+YxI0S?=
 =?us-ascii?Q?VC9pzmni8VcpdF6nWibEs/hmzgcfeGuBjzYo0Ti8ekJxYPOYl391mV0k5LDI?=
 =?us-ascii?Q?keqgd6vsFiWlqSplf/rnr9UwxW0AnEaPKzIx1f7+qfYEoBpxaAfHN1yEZdn+?=
 =?us-ascii?Q?n22yftz9jKzYGJ246qovwt3P5mCfs3UCMm2oKmgghzX1tLLvQfFqzEkOu/f3?=
 =?us-ascii?Q?9zbXckvB8Mivb3bhzHQL2HYjQ3VlZ7Uw6VuO3P+800kM0foiZwC+a8Az2KcJ?=
 =?us-ascii?Q?JIws44IDw1BotZUYBA07I3ZoU43WNM/2uaLIxtFHFN+DUlBtCwN5Zxnu3DX8?=
 =?us-ascii?Q?Zi3XgiCaTBe32TBLQNTjkSOc2co8nhJeKb07lgaK1VO1zScuf3eCzrqOwIEe?=
 =?us-ascii?Q?s7Rgaj5y+U1uqNlHKrQZsKD9JQb2IWAMWrYd/55vQ6Y6NOF2SwWeKn8nzEwi?=
 =?us-ascii?Q?GjzZBL8U7O/Khl/fPw7EsTiDUasvp0/DFlnsf+1JF3bB6Yt58JtBXZjcAPvV?=
 =?us-ascii?Q?UMOtugU8gP3RrkwYklYVL6deBti7NslqKgMvojyV/ajVl2NyIli5KaPPcyas?=
 =?us-ascii?Q?BXDPSH75WvrwTv3/aLkgW5NoqhCHG6CTHWTa4JISeOgTTFJDbUmMniqo9dRi?=
 =?us-ascii?Q?RIoMNiz+v//uKKlv6rjOZaOUGKRYeM/JpuxOyjQmXEgd1v8ZUiIlLwzpEf/X?=
 =?us-ascii?Q?bNurDbfVLo9UuyixKVvtZPHj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8163f9bf-29c2-4693-6abe-08d8eb118787
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 19:59:39.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBqkNRQMRpCe+1OzC3Luu0SOQmYpe/dGrbLOXB8zVqzzyRORBds/iZnYSXDXbj8L/HC1sBSFwxwEz9OEx5Unwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2902
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 02:07:31PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 18, 2021 at 09:03:33PM -0700, Florian Fainelli wrote:
> >  #ifdef CONFIG_ARM_LPAE
> > +	if (swiotlb_force == SWIOTLB_FORCE ||
> > +	    max_pfn > arm_dma_pfn_limit)
> 
> Does arm_dma_pfn_limit do the right thing even with the weirdest
> remapping ranges?  Maybe a commen here would be useful.
> 
> > +		swiotlb_init(1);
> > +	else
> > +		swiotlb_force = SWIOTLB_NO_FORCE;
> 
> Konrad: what do you think of setting swiotlb_force to SWIOTLB_NO_FORCE
> and only switching it to SWIOTLB_NORMAL when swiotlb_init* is called?
> That kind makes more sense than forcing the callers to do it.
> 
> While we're at it, I think swiotlb_force should probably be renamed to
> swiotlb_mode or somethng like that.

swiotlb_mode sounds good.

Also it got me thinking - ARM on Xen at some point was a bit strange, so not sure how
the logic works here, Stefano?
