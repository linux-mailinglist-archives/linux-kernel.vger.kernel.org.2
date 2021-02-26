Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA09F326915
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhBZVB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:01:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37626 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhBZVBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:01:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QL0HKT157633;
        Fri, 26 Feb 2021 21:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Wzko8tN8AC3KoM1YoFRoQjAeq7qx9dbGu3Xscz42UDQ=;
 b=UkB71Xcy+7w7WPZ8mvQhnKjVy+nMwziBBGEw51GYg7Z4tWFW9b+wxgGMczcu3QoTGFEC
 fPxyOaX3KW3LCJHTbLecaIiAL8FRKArxiHzq7CSiOId1l50Bq2LmTz/4eqtj5ww30nf7
 0y29Wom//XHN2mB6in/mV0XEkSSpcEHP79+cQqOO6Kd3DfoDM1XbLgABiPS4JhHN97rA
 yzkra/8R8om0DB4LMXEhWfgC86KeAJ6Oy6LBO4zzusZaQyvhRv9sy7bktZrJMVE0gVxs
 kbI+Eh+e5EhLkJjfBg3ElqzHXaWePtTT6/qUOwIVmq9Txi8oGBvDdqFwvQ7+mQHD6MWK 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36xqkfau61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 21:00:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QKkj8t140821;
        Fri, 26 Feb 2021 21:00:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3030.oracle.com with ESMTP id 36ucc33n15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 21:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQZJGybelbrrd4Jbr3nIFtEMXL7JK631t4V0+4mVBF/dErtHUmOLJplM7CyySFT6b3GstmqKpnDsbXWqF3iVtCpLtMvwfmzvueHXkyTVWauo4jGVqJe63/Ov/zz91mOQWjFFbIFfjg+x5EhgYKFKMNYBQ2xjaIKFqYcZNe/0tAfpmbET4RPMO+BGt+8umfFLgDOeZJp/dpYfG2fsxQFwtoNOGFHIRycLE6ze/e2xR3SKPHn2VNDX9xoDJ17p8JZbfINEtU45HI+z6HuUrV3uCkCHxgYNdYO/qvBIeGzygaEjAFMO+NxaUw3TsH2cm/PoXOXENRHAaoTSmORmAkK5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wzko8tN8AC3KoM1YoFRoQjAeq7qx9dbGu3Xscz42UDQ=;
 b=eRff7qSgi55QQk2eFoBJ99Ysp50sI4dZAy6Vhp9f9IDAl2xFi17SAxiR5O9OyODfsZxoBq2O0Gdu5MDIAx1jHmTSe366UfBzOA4jABkQFVvGGrURa2NTPrSaCp4aFQklaTvn4ZKfUxs1Nr2F9cOgzv6kQaQK81fRTlJ92eztMKnHGPHCw9xx3B4Ivz4qpPOwftnKHzTneA7YrBmbWrRBn0DewlakMq6b4ckaxYU5uHkCmDzLXCuqL0aGOZlNu9S9+n9AV0uo3pOHWwhSmJq34ROmxVquTP+2bjxLPLivqNet4HscYi7Lnz4PASKGgyrjQ9YSKQ5u2foTQnJD/S4W7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wzko8tN8AC3KoM1YoFRoQjAeq7qx9dbGu3Xscz42UDQ=;
 b=PVrGN6BbhecMnib/C9RaBdoZ0GArXnJ3sUboFmXo+HVi48DuHg4IrXDCLip2ChKbtP0tkM16+Ss48WOvkk2NFcoh1LgygI3CPCsGO0NBMfWptaDA7BXEE/aieIHjBFGoZa55kfLWRs1CSAP9yTP1bGISDNglNFW+MgIMCeVhpT8=
Authentication-Results: pensando.io; dkim=none (message not signed)
 header.d=none;pensando.io; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB3972.namprd10.prod.outlook.com (2603:10b6:a03:1b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Fri, 26 Feb
 2021 21:00:25 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 21:00:25 +0000
Date:   Fri, 26 Feb 2021 16:00:20 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Brad Larson <brad@pensando.io>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swiotlb: swiotlb_tbl_map_single() kernel BUG in
 iommu-helper.h:30
Message-ID: <YDlhZDgsAZ2j0b1z@Konrads-MacBook-Pro.local>
References: <20210226204307.50413-1-brad@pensando.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226204307.50413-1-brad@pensando.io>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SJ0PR03CA0378.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::23) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by SJ0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:a03:3a1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 21:00:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf5c786-bd7c-49d9-86f8-08d8da9989b1
X-MS-TrafficTypeDiagnostic: BY5PR10MB3972:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3972FD81A8C42D97F988C69E899D9@BY5PR10MB3972.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFVbKpkEtKnfwgKtlXRIyLBKF5z+IE2pIj/wetPG68e9zPphZICpHs6nxVlBwu017JdF3JnLjHvXI/QXKgdVBXVpiW0kVYD3kjnVAd/3eGp3hW260M5Q65ghF8oJ18EugzKAGIGM4xVEJ6mhzXbb7WvAs7Wj7jzYxeWgq7lBZ+6S24bYtTNxN4eDq//GSaVOqrf3jzFLInfyfCqO6NGAHFt/f/aQG7kD3OtW2dazkN87LSE3zJsB5o/4QFb+JEjtrpJpollzEL1Meh2QwD2DEjwOmk8CpZxyP6LatEVcDEpcurTbJgzu+AhHwSFZ7tuMUK5FgZoZ2zyyv1MvMXZFUYyiK5ZdYBBDBFo5pc+EM1nR/6KRe/z154cMntDGnFOdkexKIpbBwRr1Lc1b6L+n96zqMY1NBvzge84e3y01+ou3IjUJW7SDfnqyls32Zqn1eoYeIWuAkm4vg0MVGi5j0x6Nd3YO8tjN1KkamD0PGgN3RI3G4ALMXl0u/fwzAZa5AXYFjdRaw3Pd6wsP4l89ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(136003)(366004)(376002)(8936002)(7696005)(66476007)(956004)(16526019)(86362001)(52116002)(8676002)(6506007)(9686003)(83380400001)(66556008)(66946007)(316002)(478600001)(2906002)(45080400002)(6666004)(6916009)(4326008)(5660300002)(186003)(26005)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: d3kqjirmaSVZ63IjrsAsoCd6s0hfuPC5B7I+zbWvltvdy0Ken2NTIazuCtkKrZuyx81NSjGL6jinj4wm1sXdvUUVsF5kBd9Yvq72WcQOpktROmbClMAwwQwKJy1NYxY7UjcbgLmUZCBue9RwmDic8ZXNKl/1wSaaXb91BpXckHb6FD+fIB1XQq9/h1aiigkYJBbymiiho04yRjGGnLRIYobuixoxVNmI6uzkkJKs6bWR6YUJFClL9WOHNbaO7vdLODuR2DAj3XG1qe+rY4JQLUdmAd4nCvbz5qkCB21PCU6XVcVjveo4K2Z4bhc5Ndx/W+pcM/QfZ3iLz9yl7Ve2R4xrYfoyFxjHGZ+66mbUKChBAiSrzFThhllsSf1xKLYuytZxqF8Ilx3uBAHEwWOZaXfISEt8dKGTAL/gkz+nbNDAx4NCgkId+zNm4CieXxhWO468UA2/jlOP3m2tTiQocGmVwLXlHAoMI6kp+mGmGT1cJp4WQa44z8qNIu/UEpZZdTFPl57jRH1LyUDIAZzIgt7d1VA0S4VCY3AE3bhlSjNzEPEU4zJUybtshp17GhdZ6uX1qep4KdlX6sT7qmxVUWWtVSoidM5IRMVJfZ1FXgYjMzj/ur0YcajacvTor2AwCt6jWlYMFF0qiiDrxIEaWGpphTkCQZ7dc6la6PamxgVPSyQOqHQ6SX+euKxfGn+MyJinxFpep7pYCfkGyUjnwKbHs2cIDCsJmm/fp4PK1wAOyALWKw2UuurnUonY3M7l
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf5c786-bd7c-49d9-86f8-08d8da9989b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 21:00:25.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjNYxQT/2N7iovAXtJ4y7/x6Yb3T19XbTGyyYeEIhhnUDlV9gA6I3PdXKuZhMDthCuNxRT6EQP6FGCImxtiJfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3972
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260155
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:43:07PM -0800, Brad Larson wrote:
> Kernel Oops introduced in next-20210222 due to get_max_slots return arg size.
> In the function find_slots() variable max_slots is zero when boundary_mask is
> 0xffffffffffffffff.

I am looking at the stable/for-linus-5.12 and what I sent out for
a GIT PULL and I believe this is already squashed in:

531 static int find_slots(struct device *dev, phys_addr_t orig_addr,                
532                 size_t alloc_size)                                              
533 {                                                                               
534         unsigned long boundary_mask = dma_get_seg_boundary(dev);                
535         dma_addr_t tbl_dma_addr =                                               
536                 phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;     
537         unsigned long max_slots = get_max_slots(boundary_mask);

Could you double-check please?

> 
> [    0.242119] kernel BUG at ./include/linux/iommu-helper.h:30!
> [    0.247793] Internal error: Oops - BUG: 0 [#1] SMP
> [    0.252595] Modules linked in:
> [    0.255657] CPU: 0 PID: 93 Comm: kworker/0:1 Not tainted 5.11.0-next-20210224+ #25
> [    0.263245] Hardware name: Elba ASIC Board (DT)
> [    0.267784] Workqueue: events_freezable mmc_rescan
> [    0.272592] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
> [    0.278612] pc : swiotlb_tbl_map_single+0x2b0/0x6a0
> [    0.283505] lr : swiotlb_tbl_map_single+0x440/0x6a0
> [    0.288395] sp : ffffffc0122736b0
> [    0.291713] x29: ffffffc0122736b0 x28: ffffffc010e30000
> [    0.297039] x27: 00000000bbf58000 x26: 0000000000000000
> [    0.302364] x25: 0000000000000000 x24: 0000000000000001
> [    0.307689] x23: 0000000000000000 x22: 0000000000000000
> [    0.313013] x21: 0000000000000000 x20: 0000000000000000
> [    0.318338] x19: 0000001241fd4600 x18: ffffffc010d288c8
> [    0.323662] x17: 0000000000000007 x16: 0000000000000001
> [    0.328987] x15: ffffffc092273367 x14: 3a424c54204f4920
> [    0.334311] x13: 6572617774666f73 x12: 20726e2030207865
> [    0.339636] x11: 646e692078787820 x10: 3062653737317830
> [    0.344960] x9 : 2074666968732031 x8 : ffffff977cf82368
> [    0.350285] x7 : 0000000000000001 x6 : c0000000ffffefff
> [    0.355609] x5 : 0000000000017fe8 x4 : 0000000000000000
> [    0.360934] x3 : 0000000000000000 x2 : 18b0d50da009d000
> [    0.366258] x1 : 0000000000000000 x0 : 0000000000000042
> [    0.371583] Call trace:
> [    0.374032]  swiotlb_tbl_map_single+0x2b0/0x6a0
> [    0.378573]  swiotlb_map+0xa8/0x2b0
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  kernel/dma/swiotlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 369e4c3a0f2b..c10e855a03bc 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -534,7 +534,7 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
>  	unsigned long boundary_mask = dma_get_seg_boundary(dev);
>  	dma_addr_t tbl_dma_addr =
>  		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
> -	unsigned int max_slots = get_max_slots(boundary_mask);
> +	unsigned long max_slots = get_max_slots(boundary_mask);
>  	unsigned int iotlb_align_mask =
>  		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>  	unsigned int nslots = nr_slots(alloc_size), stride;
> -- 
> 2.17.1
> 
