Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8423E8AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhHKHBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:01:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32316 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234855AbhHKHBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:01:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B6pmpk018183;
        Wed, 11 Aug 2021 07:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NuBRdQnEBD3fxjQg4kOb4Z9BD9fmDTZa+lQzzKxpL1U=;
 b=uFjZfljWq6sdbehhGiKU0X61c87CkAcFL11fFVwP+5HQ57WSY5MMD1FSxQafE9LCLf/f
 9s6FW4OOQ3yT09zc0OhfCdP3u744/pu5vrjwAU9STm7iEB5ysfm48VvhtomVf9ma6cMb
 HtcdqAzfodc85gQS1S3YI4eDkSHL9RWovAABNgfx1kmRdZxsPkUPFdcZJ/RXyMaO/qFq
 msx9yw/pozLOcdo0igHHr4h+QVOOfaIcRMRCbpd4IPG9MSIuZnAYlT26BDN9Li3dYHvU
 XiAkOWVjGE3FNY2wmKs0DwxyA17c0yMaPLY07vLKvJts54PX8khGATmOX961pkC6dz5n NQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=NuBRdQnEBD3fxjQg4kOb4Z9BD9fmDTZa+lQzzKxpL1U=;
 b=wiLj6CmFwDWw/V30tweUtTpI7bAXeGE6DDxsMHgf7WNMjRstHQ+CCtyhouIn8TVyjk9C
 Zonh5EoRhNFBQIdDABv5Pk4C3yHvI551MKG9Sk0e3iJ+84XcpjOMV99ZzrsUlVMMRFRa
 WkQTVruF4Uknr1v3sMRYX1irATkch5VCYabM9ZbVqzsPh3L29XGxaondV3bw42sPreZP
 rcmCtTRv8YZyCKFaOiWoo17yITyw8Ja6OJ1FNysdITYNkZNJ8zqufHXzuGzwD3QRov1o
 TU9ic1K2ZTVmgfYN66I+MTORcg11a2FhdHSbncLcY9aWlj0XIiihJeDq2I8Ao4/GZO8Z 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwqgs994-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 07:00:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17B70Cbt126410;
        Wed, 11 Aug 2021 07:00:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3030.oracle.com with ESMTP id 3abjw5tgus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 07:00:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsXl0uTzoZGBeYVJkXYKI3PfibpCHLHtrYxN2jovSujaF8b5TUOpD781uplRU41vkeowtpiLrgr2ZWWZk8KSPwY4Bs/WMIA9SuwVsBVEHhxkogs8eox52Kzi/sBo/fzXl6VjnxWGInlXjXxTRdpfE9ux8wOPB5z5jPnQgg/RuAQHgCg+e36jnGMaVfYPL67ys7FX1yy1NOfM42SM0jk83bpiNyt5xOVriWe88q3LL0TmysDr0XGVzYRumLuG37fKysta2kvjMxDWcF+xQsQuiu6amseVkVy6ptfN8evpNivpnGdT21W0asmJddLT/G5+f6g34Poee9Li3uwjO/6P0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuBRdQnEBD3fxjQg4kOb4Z9BD9fmDTZa+lQzzKxpL1U=;
 b=IS3wNndfinShd4kgeVtSzX6M8WqEnR2DXGyne4q+uQgpxk9xjexOtgYUh70aXiaUtV+WjX3V3a+ZPosi8sXwCU1MVHrDtVhYFsIEpbaMSO7X4HxvXgFaEfEk7VmXCuAQZrQ8Vkicyo56JsnaHvzhxXvBd2mXRduRSNpLbFulX2F0SJQYwoUn2kLKbvT97NJ24zjAPFHSHSBz3U4KoPxOV1LAgN++i0+QNnIe8mXM1JzDBplCK5haySUAduzxo0SOXBSIAa4huYju9CmMDZBa/NvTjvsNd1/+5/+XEbB+d5E3FzE3IlvYMXNeock5GNkYcGc4OAH07vyE9bWNDvY4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuBRdQnEBD3fxjQg4kOb4Z9BD9fmDTZa+lQzzKxpL1U=;
 b=CTeba+81h5mVbya8SlQnHAAntfOuNCuFuUOP8s5Rc+jqZqU/985PcOP9+nELGMdlhuOKgH2VZfpGoJTQMe+B7+PlMZlxc7QLi9zMLsqbkZdZ4gniB7AQPOZnYL9ChekWBKmxlF0Xsf4iAEb4NzVZXnlJMRRjngYNg7f/b0SvImc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 11 Aug
 2021 07:00:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 07:00:00 +0000
Date:   Wed, 11 Aug 2021 09:59:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tuo Li <islituo@gmail.com>
Cc:     gregkh@linuxfoundation.org, will+git@drnd.me,
        romain.perier@gmail.com, yashsri421@gmail.com,
        apais@linux.microsoft.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH] staging: rtl8192e: rtl_core: Fix possible null-pointer
 dereference in _rtl92e_pci_disconnect()
Message-ID: <20210811065937.GA1931@kadam>
References: <20210811031135.4110-1-islituo@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811031135.4110-1-islituo@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0061.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Wed, 11 Aug 2021 06:59:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ec71af2-b5c4-4d0a-5b3c-08d95c95a2de
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB47057DEEA0C30D8B010861CE8EF89@CO1PR10MB4705.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6viHAyQfZZlnakXY5sgAJLyBr8Dt5V6iiPbCQZRowIFYUvFUb21y0IQxZQ5/XHP4EGzcHDdNF+0s//JiSvckp0Ym6U7vi1csfMgkApS7N7nwHJXlj1SEZk0b2K5bqGo/eySX/gLfL4dVHWWznhqE6rKNxY7tH2QcCY6+NdBbZCiUNRxP+RzfGUOBtcm06dm3Rf1mEp7H3jiNp0n9LzS6U9UEmmF4pjK1GL42DopV3bRiaxjiKB3EBE2pItQNURHJNUUu8R8AScWxSwVg3qUd9n40rGrRMGGUmiI17WtOP1kyvi6Oh1Rctkqq7aPtciduWHoY5ExQHNtxuO/B32VisOJ83YXFNw6dY3Y0GE7/kukudAU3pzfoNV4X1lM/k+QtByKhbD61eJePuZOVF05zs8VedWuejtwW0/szBCNyR0mqRf/ptQcDd3dCwxBu6wauvqqmieIt7RHD7y8Nfp9cMKGeowIMyWpwQfsN48mrw8Q7higuted4Lu/tukoFaNxibo9MQ3yFKz9YQh40mMjD0sEnrj6yuhVKT6yDYMaMCJjmnsRlJRwYdLo6du5s3GNQTT4uDbmc+cK7m0PR04fc8mSqRSVNWHIcWsK2kUF+A6yxVbEqxM51U8PIUX36OSiYuVKpVjY3vbGoFI1t/cUMkb0XEcG4fDXKzokcH/zQQ0r1j1BqQOWIlmDjCvVuCgem5iVubqoVsFsO0dSjEUT1Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39860400002)(136003)(9686003)(956004)(33656002)(5660300002)(6666004)(1076003)(38350700002)(66946007)(38100700002)(7416002)(4326008)(66476007)(2906002)(55016002)(66556008)(33716001)(6496006)(8936002)(186003)(52116002)(4744005)(316002)(44832011)(86362001)(9576002)(478600001)(6916009)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?au2fVFKdk+SRxz4d3zWd91LxsAkE/m5CwqPsc8u0WgdGVpkKk9F8t+krW+Zo?=
 =?us-ascii?Q?virub8eAvrQvjLR5IKztAvRq5sd48P8Rk4YtO2l01JKvgZ7aZVvjIUwXpHtN?=
 =?us-ascii?Q?PHghuGvLAbvPLY2yAqY8xdlH/zeBhmY7RMb2YkL/PoLvZGZNip+9WyCYQGBr?=
 =?us-ascii?Q?PvrTGahxLssHv7sZYTsmM48xY4TXhOWTl7vVWC3+kp4pX4RVcKj2JL7Hdjkf?=
 =?us-ascii?Q?AEBjEL7Evd93KsExSqMFvmHfg2oCQxh1dOIh3GB7nQTDiZYGn3HA3TDD7NSD?=
 =?us-ascii?Q?O/RadjlP4SS7dfDxyHFcrGwmXp4PJne6Q1MRpfGjzXLrSldWmJA3EaHlWYia?=
 =?us-ascii?Q?1fn2TRCh8nkQgZrltm0QiV9Eg5q5P88g7vq/I6NiFfnEZZ7DTzHPhlSLvVaI?=
 =?us-ascii?Q?lA2F9oZ1MC1zUJkm5DdiTDRiB+B4ZBdE1s/rXiblAJAX8EDlj/hoSy33DAog?=
 =?us-ascii?Q?CJRKC17+r1ppABjlG+2ua5hTXokexM7R4cFa5pvgtylOY890Ykq9TGV+jJGE?=
 =?us-ascii?Q?e6yGLyXKitTsKirWGlYcQi9ovRBXP1bAUf4p2CPesLOuDeDiRzw1B+o1UEmE?=
 =?us-ascii?Q?d38dJjeWtf80IwK0j9VO5FU7XbRyEfFxet/r0TklOzkgTzQkBp0J0cyVHnhB?=
 =?us-ascii?Q?SIfuQzskZ2XxUWElhPCJ4zXoiAyiiZkho9uEeEGzHyk4FGdP+eCY1pabEUP2?=
 =?us-ascii?Q?UEEmOOgJJaMMdcXzL0Ysn3du2ETsUT8pVXAdwQzvUPv7/J1ANQA4tfEjN0Y6?=
 =?us-ascii?Q?a1MGWoN2sABIbj00yhaRHIjT/bl36R6OxISPCje9doQCtlxNovVEhlFrlSh2?=
 =?us-ascii?Q?RJbJ9qSQiVH7s4y9qPOiACZpBKQwCaFTVDXWLW1YSM/GiDybuGmT+qIqrrIh?=
 =?us-ascii?Q?kJm235eVY3I0ERymW686WBSBtox8S3K1fV+z4a4qpsTzJW2WMnWl5c/afGSf?=
 =?us-ascii?Q?1iNAnuMYlxyE7G1ixigU667cYm6GtnmqvgxBUDp1g6DPOlh8btKGrdq8rZtJ?=
 =?us-ascii?Q?wPujUO01rcBDtbZiud8p8waIseI7BYjRkrpUtJgjwSQ0Eslxgj6+C+vfVG6r?=
 =?us-ascii?Q?rr07SjcFMy28qa4VfL+EbVv3Tjbvc1Uj76mK/Ux8Mjeq/KYkhx9FxTRyz0Vw?=
 =?us-ascii?Q?qFEiPzB09iMOADvCWXfLvkETfPiQBZP2VEB+UH//7VkQYPqQkud7Z+AvoSvM?=
 =?us-ascii?Q?sFfVWT5IcxwbeAXsrO2JKMYDn4baTGbpW5n2Yrbb84E00vV5YIcMrmSTZrjr?=
 =?us-ascii?Q?d4eIOuJtskVGiHFzxL1okD8/rzJo/lM5mcS38AovnRubt3ljnKuA5SPFMf9/?=
 =?us-ascii?Q?9R/R3BYO+2aEDu/EwHYgh7FO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec71af2-b5c4-4d0a-5b3c-08d95c95a2de
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 07:00:00.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0hkeoUkj7Y/TMnXKf5SpKEvtbTm2IWLLoe2X7lLp+vs+3YgZGRtZaJ2liNZ20WkZ7rSlsNTY+2T5LXTtdaIzRAwCxZI+7IWbcpRB7fPEBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110045
X-Proofpoint-ORIG-GUID: jJxk9LevDgPzz29fApryFBwlwPqubExf
X-Proofpoint-GUID: jJxk9LevDgPzz29fApryFBwlwPqubExf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 08:11:35PM -0700, Tuo Li wrote:
> The variable dev is checked in:
>   if (dev)
> 
> This indicates that it can be NULL. If so, a null-pointer dereference will 
> occur:
>   priv = rtllib_priv(dev);
> 
> However, the value of priv is not used in the remaining part of this 
> function. Thus the else-branch can be removed to fix this posible 
> null-pointer dereference.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

Smatch was not smart enough to spot the dereference inside rtllib_priv().
Fortunately, the "dev" variable can't be NULL at this point.

regards,
dan carpenter

