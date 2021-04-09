Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0574335A72B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbhDITdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:33:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59980 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbhDITdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:33:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139JUGtJ046061;
        Fri, 9 Apr 2021 19:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=SqjgvYdy08/od1v88kjfgPoL0C14jHGLqIgim6mYmXs=;
 b=Q6Lwx+ayP4NH+cEgFUXD2jhVUeer52oyNNY94ryJzu7NAdE85e05mcVJ6sf3yT79SZCz
 ijMmnBLAqgj/p75Ftwcakj0SEAVprZDkrNSYCQcDVuQtiZvKPthdrPYlmgvq5NyaXmd3
 d+4kk1uhxShV0GgbNGypHX9UHWSUP7x+/JvCJjxIJace43rnxUGyWQqZILnLnw5mMdzL
 h/LxvFl2VK8A0RNqEgo590mVGWS7fRw4PUUqhaiN8UrWGAZ+i8di/CesYMl0h4RyCL7l
 shF9jmjCnPbGMTRcKgq0cxV19xdwuRVdHl5r2bMOHGXueHF//829bDUIeVzUFWb5j6cy CQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37rvagjhkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 19:32:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 139JVRxC111849;
        Fri, 9 Apr 2021 19:32:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2049.outbound.protection.outlook.com [104.47.56.49])
        by aserp3020.oracle.com with ESMTP id 37rvb6yc3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 19:32:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbpHgPwInZfhYGArRCQPspw2em60G5OQKhtMaDSB9nQmGh7CRSyZwUIs5B1yeSohLX9p8trd03rlR6WuhCj1ibK7c7FET4mVm3PPRjxb9Sk6rz1CjEw3iZ42IPUXmTrMCM2uxMnrKQMLLcCBwG3fmIM2UqGtuP7IupRClStQ7WoYP3m8XDfDjiIVVr8zwYznh5dc3E2nc3MdVTt6TYqNYKzJxMz7D+aT1ON+bcv1VRVdWFv2iF7ls1w+vwUuE7kSjjwu0bAeLtOAoFOzBeEBKDvN/2ZooDdtRqqxqy00WdipLyQkez6ZL8C4pWs9M3azBSBdlN4LBz/ypnnpIGm1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqjgvYdy08/od1v88kjfgPoL0C14jHGLqIgim6mYmXs=;
 b=CrxB47qbJugg/Czsm1lgCDk5DmKz2N1mRWTdRzMWp8qS2TumUilNUzg4rXwSh8HvGyNDSUcTKiLWxVh6urdpi6ePj+xkAVZqMHojZ8/PN661pS36jh5lxn0wNruL6I+fpEMEPUZkihZavXoWcL2Ax/AHMVJeXtQMh2bujuZqgNZStKb7J7l5BMmpCWzHToHFjFyCyOfqYa0rg5tPKOaV9lRFT9BZGCmza4XC0FC+alZDixos3GrylebLi7v4seGqvQzehFzaFC1roBZG8cDclevmFGu4+o/OxFkr3l6ucGbwmRTEKybW6488mNKeIz3vxxf02Tym/JHkvQoQd1aI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqjgvYdy08/od1v88kjfgPoL0C14jHGLqIgim6mYmXs=;
 b=f4gWs0c2zAj6MuEeqc7nKWDf3zlZADHg7scWNE5/fnwhHfRjGfjUnM6MZHc6+t9kbvT80CrXhkba2/CBYb81LIqidlWAAxNY5EilqjEdCF8+ySRHlLHCn9BLies3kBjbWbxcmS/6M0TOijthhnKJOs9um2PGn1U4bCOCXJcMwAg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4701.namprd10.prod.outlook.com (2603:10b6:a03:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 19:32:48 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::50f2:e203:1cc5:d4f7%7]) with mapi id 15.20.3999.034; Fri, 9 Apr 2021
 19:32:48 +0000
Date:   Fri, 9 Apr 2021 15:32:43 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v3] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
Message-ID: <YHCr2ziJxmISCcEW@Konrads-MacBook-Pro.local>
References: <20210321033740.312500-1-f.fainelli@gmail.com>
 <20210323015350.399493-1-f.fainelli@gmail.com>
 <20210324084250.GA4474@lst.de>
 <2ad22811-24e8-0776-3e55-ea2a4ac55f55@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad22811-24e8-0776-3e55-ea2a4ac55f55@gmail.com>
X-Originating-IP: [138.3.200.44]
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (138.3.200.44) by BY3PR10CA0028.namprd10.prod.outlook.com (2603:10b6:a03:255::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 19:32:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3de7908-6de6-4b09-f326-08d8fb8e41af
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4701:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47014E3E2FED4FA411C4B57089739@SJ0PR10MB4701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qn2BHNkciKXy3g33nbkvf+SomsofxVRq3s5Q5/gHqldy1nBR0mF2P6t0WlnniUzhxj7X6twQZM3cZMOl3zKRYi0CsERjJIanwEYWkCfEjyTUkKqrgF/yhdywL/EDhIEBsORUKR283pmcaIPvMSAdz1iSRIYJkgnhTEVlrvczfn2RdfxQqEpqRnHlzBrWtz1LYfQpP36iJiaQv4oirg/j6HHLTsRvLKbaIF9X/olXGdHvXffY7HSWD9UFPxuFXVHrLV5jGADlNkWJUnzfYzgHjygrXzZZu9Vr8jZQ9y6Vsmo1q6zv91Dn4NxMR26LQlA0HfR165btIxZQxQH+VQdwRxmWE/dREdOKuVqtPYuc+PGA+UeNxayO8pYvNXAvpLV37f6L2YFmOPFw7iMRr1+N0fsysGyTj+7+NwFSJY5UaQzuZyFbL6gtpzZt31/G26nUj05mRtP0ABEHK7PlAQw06rJiOJETei1opZFFErxzjyoBFuEUdijyVU0+k0EyrjbGCUGq+n/Il5MT68DeS4f7sVOnDnUTskc1q92oMXQ0LjLB5IfjHc0GiklFqK8KW1v+n06jRviUHp9tNO34VThA88cBjOwzCTsLx+cykEmhif7DItvaaZD/UJDzEXPXJRqyuBQXrNF9PcuEGUhKzCniwyi2/63ohiVEOtI7eEvadoT+TRbIovA8B6btTYsUC0ys
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(396003)(376002)(136003)(8936002)(16526019)(38100700001)(316002)(6506007)(38350700001)(53546011)(8676002)(2906002)(6916009)(26005)(52116002)(86362001)(7696005)(186003)(6666004)(956004)(5660300002)(54906003)(9686003)(55016002)(66946007)(4326008)(478600001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Kzj4SMjn1tvNCYyAvVgCKpeV17Ey6gI8TW41HXraNHuHao3u+/UsMz75TyQN?=
 =?us-ascii?Q?WI7q93qsjumGJ5L4zyU/BVbTH7rtPNHuGxZPj46IGCDeSfxJoAxwCr18c0ou?=
 =?us-ascii?Q?snfxnVsIvM7HOmaFFeSxT25vTkgTCvs0pJvmWrKge5EEzDnZaYB5q4+7QNiM?=
 =?us-ascii?Q?fnScwn9QlUAh22VT20mX1m40RYdtTK/OG7lBFN0BJGcDLt2a+y3NXzfyXkif?=
 =?us-ascii?Q?sMfp1B64GMoXBTgqJygS4FBz1Awdw7VHunTX3d1f5YWD8NqULZWmMyrCbeHR?=
 =?us-ascii?Q?snvMb0RfPiqPtRZCRdi8A4ZHNPFGBbQvFObrgqVdvCzrMQY3Qr3D3uDOptEQ?=
 =?us-ascii?Q?WOz+hXW8oM1IZwdZTHNFNQ3Gx8B/s/E2PEBfqywMH5KJs+T2MyBFDClu2IuR?=
 =?us-ascii?Q?VaBuA+bM/rcr7N3iqB1G+ET3eFCHaQjQzfASZEIJuqUJL3UjFUBqaZL0B6YK?=
 =?us-ascii?Q?072CBr3TanwOw/UbRonvRD94JM1pKC3qKfYAg+o+CsvKn2YYHex58VHHxmIR?=
 =?us-ascii?Q?JlXu5FtoLLHqRXuX4I88SpDIB0KQFxvLL5BYk5M4qJwbddkxOFNhtwgBEcP4?=
 =?us-ascii?Q?LmFVhjxX0UEYlhGlUbW93VlPX+Rd1zcDQAfB94r3bXm2du62841mrqcYpne+?=
 =?us-ascii?Q?YcsXa1g3rlHHYbL+tNsO75z3WQz9ONmSLM8NjKC4N0aAl6LkgUFGLT389JaT?=
 =?us-ascii?Q?ZygGDhNtjiQU3mqaKgAcOyG/IDOyycpNhKkKGMNwiPKrbPKUpxL7Doa87tlf?=
 =?us-ascii?Q?fDNK3yVLczKjJStbfXI+ZZl2Aq3WKqdUZ2ZqDB4rHDvoOdjzgjK+fLl9PrMe?=
 =?us-ascii?Q?MynbtWQ/awmcZIwTFc/L6uoB2bfyfyqPgCynS483Kwd6R9Ddup/F313CZWKP?=
 =?us-ascii?Q?y5l8UjyYQwSAv4V9EkQ4h7/cmmbguLCKjtd+QLIMwAUs2E2LoWlZVWQU7Re6?=
 =?us-ascii?Q?kQuV2pcbQGCFcHAGUsNYlCi5i+r1tFwvJqJkwmnYuM62WK6/xddeWzqIsU2o?=
 =?us-ascii?Q?XbG5Vi0pYwX63YVPQLE/ort3Wxu9W4pM4dyooI4dSzVDo1IfN99OZPWeLYee?=
 =?us-ascii?Q?rUqZscH3RO8rbKQZN3NQ4ah4SJ0gQdtK5sLW6o9AegiZBe52VH9khrmDB2/P?=
 =?us-ascii?Q?IDh2wiu4oUdp5iFpHXmAfLOZsWPjOisCmvdIRmGJ3UDd+NB3Ux6vEOLoM7RR?=
 =?us-ascii?Q?ZxsuP6JGw1bIK/cOb3K/+UuOCz8Pyd713+ikWDF8NqnYaSo2ETmCmCPRnnjB?=
 =?us-ascii?Q?jAuS+EXVOzZMaeKKWdVn9jrZUfcPrMKQdjzF62UiaPjCxn9KGo7+Nnkt7xxA?=
 =?us-ascii?Q?TNlCF3eJiMKlM5lv4D4Kzevk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3de7908-6de6-4b09-f326-08d8fb8e41af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 19:32:48.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2JpJG7i0/xZ7FfvN4im96Y3F8w7EOfdaMNGF6ilVFjQMWEip9A7ASOY04vZIHLJbpkPxKz1oODdZycmi1bR5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4701
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090140
X-Proofpoint-GUID: j_F1vw6AaHX5ST-NErWxURhuRd5fFDv7
X-Proofpoint-ORIG-GUID: j_F1vw6AaHX5ST-NErWxURhuRd5fFDv7
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9949 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104090140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:13:07PM -0700, Florian Fainelli wrote:
> 
> 
> On 3/24/2021 1:42 AM, Christoph Hellwig wrote:
> > On Mon, Mar 22, 2021 at 06:53:49PM -0700, Florian Fainelli wrote:
> >> When SWIOTLB_NO_FORCE is used, there should really be no allocations of
> >> default_nslabs to occur since we are not going to use those slabs. If a
> >> platform was somehow setting swiotlb_no_force and a later call to
> >> swiotlb_init() was to be made we would still be proceeding with
> >> allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
> >> was set on the kernel command line we would have only allocated 2KB.
> >>
> >> This would be inconsistent and the point of initializing default_nslabs
> >> to 1, was intended to allocate the minimum amount of memory possible, so
> >> simply remove that minimal allocation period.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > 
> > Looks good,
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> 
> Thanks! Konrad, can you apply this patch to your for-linus-5.13 branch
> if you are also happy with it?

It should be now visible?
> -- 
> Florian
