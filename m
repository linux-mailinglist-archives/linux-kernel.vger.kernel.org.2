Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FCD42B6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbhJMGSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 02:18:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33558 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhJMGSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:18:13 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D5CfeN023376;
        Wed, 13 Oct 2021 06:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=OG85GYGa60T4pBjHaV/sldA25pncqeKkFvVDIrcZiiw=;
 b=gV16A241gEiwQISdaqKK2IIaEnkLi2kd+CnbEKW5i7/N3RRzG7RJwDFmTcHDQe6Jrmmi
 +slvFAvzNsSNan+3SF33UQZhn7tteq7e79cekmvB2bHfF2cTLnsnc/s+rfP43vywBw1y
 gQP7L3LECS5jyJGtGcfxBKuS+MylRizXYocwf1jMQRnWyjfgFjSrLorLHWGMWv7tc8V4
 GzsBfq53n3Qf2NwqaLjXx5CHpNmq4QkfpuzogSUSh14tpFExw9hC8QOAWwEXCAEAMmnI
 KKugYeTRAotxQw4x2SDvbRw7vXVlkBRp+9pvlXjbgFNVzjb+1dyR/E/uzr4GlxuRCmae RA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbj1n73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 06:16:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D6F776050743;
        Wed, 13 Oct 2021 06:16:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3bkyva7538-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 06:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgjqEaT0tXm5+pfM8dWjnafjg1rhL1/GA0UyxP9EDdf5jqWonPbO75I1MeOV9xdnrT6ABLtKtUojnnAbL0aDiiP1bBptPGDrt0JWbZLbApGAM+0YJG6tU/dehvJuzwdQVNI1QC97Q/MgKXHEXBJ4sqcQEtKosLWBW4rCXmvuHhbs0fmDp51vptTtVX6yjE52Vz/C8Sc4G8yLG1a+EuNNIwqY1UTal0n0TXLmdVzQSkHfAl0Cjp32I11IE3pmIWSUtiUpc4Q6nfUiRjGV/qoYscy96xkV+V64yYHZzT6vGQ0Ne2EPrU7DN1NLzHtMlsCgc2o1u0aMqMhPojvVuIA7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG85GYGa60T4pBjHaV/sldA25pncqeKkFvVDIrcZiiw=;
 b=jbPxDvyg0fLtc8qvrWAjiBJ4RnfWVMf1vFTWK8I0PEgyIoDpBrR3/70dvr1ZGWF2y/j9mj4+S4H+VXKtl34fo8kjVKkT/nnkhQz9ZjwYE2/8QWDIG4aFLyn1vGWWje8I0dWTAm3+oiZJbxfbqskNy4z1/HnQ3Nbv7Hlx6mOBUffX/OvmWP74q+A0qtmB0fVx3ZtklG6dubBjmp3nIa3iU2+fh9VqCi12mmOKNOMVI2PAnEljwsOJjZv+7o3Fr3smm7okVFIxAQUyWI4PKnrDKoVm1v1hoGdtUkz/ncNg5MOLRPnRFbYSgUgfDgksV/XoF89A+5ZGz68FTdBmv+psRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG85GYGa60T4pBjHaV/sldA25pncqeKkFvVDIrcZiiw=;
 b=Jko/4EeN2aSxElv3RjX7bt52/vLNUWTrXS3nCtCszwX5f1eUbKUIRc6zMBzmq2eCyO0yw1Q9unMgrr1Kn9hgShGvI60KX7w1Loy4oP1FgdVqDlxfMuUkBmaxvr1M5/MhOVGOXT8+1zhxJE6RRtI1ILrhNwhYB3SCBOyM5h2MDq4=
Authentication-Results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2253.namprd10.prod.outlook.com
 (2603:10b6:301:30::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 06:16:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.027; Wed, 13 Oct 2021
 06:16:03 +0000
Date:   Wed, 13 Oct 2021 09:15:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: Use of '%#02x' is almost always wrong
Message-ID: <20211013061547.GG8429@kadam>
References: <b04a10ea9682c51764053c1be73d4b3be59d1e7f.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b04a10ea9682c51764053c1be73d4b3be59d1e7f.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0057.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0057.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 06:16:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 522b0972-1f3d-446f-0755-08d98e10ef00
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB225375E5283B32BD8D657A5E8EB79@MWHPR1001MB2253.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhHbNLkPML/feu5cx7uNTqaC1AaK0Mpx7ux9BMmjMNSObhi4C5YscgdVAH6G/oZjecwYbpLiYMJ1TyKBdsEaexy9ohX4PKGuZU4bjGG/5gDA03esvXxJOMzw8JpNrGulJxe+zJv0GCof1hgL4wzWlPV5HHDTOwAo2SDU4khQNT30/5Yqevi/0o/yDvaPnZebEpSin0xg8++Y07Vwc7pTc1xQrbeXiYe4kM2AQse1D+8VCHmoz70lLncuAf4Y9iqgssyofZf/bpf6wrwpN09cHczKAPuDWEAzkfhtbusjacB+8yPVyKUp99T71DYIpo638ZKHpSwI4EANgNYcUSK8zB5lvLcFb6EdwZRJsHUm3uucYYT1Bp5kFx6NfnN0xNmjURUUomy2noVbUlgEzgPLbOhwFcPRPZ4mcjqunScFEGjzlIjD8X6JF1WiMOzT04FxeIb6pvRAQm5RD4x7ZxsRd3CJxUEoWiQcCfZhcfHzc/5MX3MrArrG2heoWkZnbKQ1UX96UqzaPRKjonY7wwVENhFwwTLz3VAxypNiIbsEXaRNIz4AkWJ2uP42hXRjoCoq+G+WN6Wu3Lh8N3UF/Rj5AWUVTYnMLkkZyOqeu1A0P6CooO1KK72613zSgehfKGkKNd4IMPxblWAlGkF2PIVlR/RbzB+Z/eqBwxw/SdNm5MIsFvN7VHk56P0MSqdYHWVp5OUGV2JuXSl1T8D16cKk4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(55016002)(66946007)(8676002)(54906003)(38350700002)(8936002)(2906002)(508600001)(26005)(4326008)(6916009)(38100700002)(66556008)(66476007)(1076003)(44832011)(6496006)(956004)(86362001)(9686003)(4744005)(5660300002)(316002)(6666004)(33716001)(33656002)(9576002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nbHXOJ+wro2ZPURFIWQb6hp57N26Kl6RftEV++vTwAo3JF/vSm+KJzNLXWlL?=
 =?us-ascii?Q?kY359xsUD8BpOQzrmvWq1yjnad5QCdm8hFCZWVuokS+VXH7m/C+T4Zk+QyBu?=
 =?us-ascii?Q?nl9btvl1a4B1MGDiGqH2cbwga+J0jOWkvvDdLkybdnTPPvXK3/SKt9bwDLFs?=
 =?us-ascii?Q?SrqZ7hRKrgPm0spEwlDnQHi6JhsNJYwfbzqd6niL+7MnroeAhd3x10GhjuuZ?=
 =?us-ascii?Q?+0zBTNnazrSADqWuk9/Jyc/8B+oH4kiwevzPpa80/yPZU2KxspbYuUBfpsmC?=
 =?us-ascii?Q?0CFjceqGh6Cp/MXb7ZraDnw9CBIUNmCttMM4n143qd+wfQVqjYlKaGrXYQ3h?=
 =?us-ascii?Q?By9hsbuupp7awEykdbp5zAGWiRlV6DCJovV8qxfuCmLOeNheH1a0/5C4xOj9?=
 =?us-ascii?Q?UB4bJG2ez79+DOjSoaSKpoPeBqYgJIT8eK31TGAYpxCh6Rwf2lPuO6Xc1jeS?=
 =?us-ascii?Q?14/W4oT2CQkGD0MLksqJprHx9LMr/f/pRAZq8gJegpgR6Etsg0pym9S7pIH+?=
 =?us-ascii?Q?vDKAvAw4CKW7NqZpuLSXoJ+3QJVKEtPtzHeL1zjMUDDGa6ULZYNJePmUoO2G?=
 =?us-ascii?Q?zbVSmTix4l01LE9EQMQNrLZE3RKC4hVNPXDsMvDhuovyQ5zZTmaolySyAgIW?=
 =?us-ascii?Q?EUxgAjob/Q8WYniFjQ0oj7b/LJ8MPxNM9t29uzC+SHx2v/k+6hjTHsT/6PQ1?=
 =?us-ascii?Q?EFBoxTloJusuOCRissv3Qs9KjWmV+qGY7aSfV007tvFUE088a71HNNaMbWqW?=
 =?us-ascii?Q?IjoLvbiDvPNhyS6CNzaOWzt2unOFoEw1w2UaHBABgvPY4TUUtu+8IGcsQ5AP?=
 =?us-ascii?Q?ow4kw/XMGVdw+0Z92DXgLm9Ru0xbHRNfF7oR+w4xAjm0s9lb0oaoy8J5/ag9?=
 =?us-ascii?Q?gUbFh0gAndv1vJuOYxxW1b6GXvMMTQEqd76vnWbfVIFMsu0e/yikAib3vrg3?=
 =?us-ascii?Q?mlnO5JUr/zPjnKY4BlwQOftcSNwqN1iIcWKvs13tGiNpPud05mfmn0Ezay1r?=
 =?us-ascii?Q?P4LFAzBKtn7KSeBb0m4tNT9C/XFAeA8lXlmy6S1JG58WblR90nUQFRFYc5hN?=
 =?us-ascii?Q?v35zjg0Bi+2qfg5sMQOLNfCC+nr3Pjm9MjvQc0wBMeRmD227aUEy6vBohUZu?=
 =?us-ascii?Q?yaGqmNFyic1d5FDEAvmbPAa9pO2t9KZBOnJCreSTVkHl3y3ETnIGroCs8fpQ?=
 =?us-ascii?Q?jxro0SW6VoVGw2YFvbQ9szoE3f6RLmr6Uiw5udXOSLVs8qGUZNngM3N47mDT?=
 =?us-ascii?Q?NI++My0JonPlZLPKL/sSLIrZibMSLkIAoX/ccWo2VLxrU0fEHRYJAj86n6OV?=
 =?us-ascii?Q?K6AyzVzaeKKBb0FusumHoDX5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522b0972-1f3d-446f-0755-08d98e10ef00
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 06:16:03.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csG9ibNITAKQkrgF7yFpK6eR1K6PLjlzgYYZh7S8rl6pWc8rTeirwtQKNV6BUDLvyBY465bMQ1vVM0PAg7IT1GjuYYTn9chPc0Aometmulo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2253
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=663
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130042
X-Proofpoint-ORIG-GUID: FUWAIN3or_sfRkpBRw6qR_3a_D5psJTP
X-Proofpoint-GUID: FUWAIN3or_sfRkpBRw6qR_3a_D5psJTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 09:45:30AM -0700, Joe Perches wrote:
> Perhaps too many developers do not know that using '%#<width>x'
> in printf output _includes_ the 0x prefix in the output width.
> 

This is a good point.  Presumably you're going to add it to checkpatch.pl?

I looked at '%#04x' and you would think those would all be printing char
types but some are printing shorts.  :/  It's harder to deal with that
because 50% are correct from the tiny sample I looked at.

regards,
dan carpenter

