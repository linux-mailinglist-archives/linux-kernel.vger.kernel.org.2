Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC17A3F8C96
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbhHZRAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:00:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1704 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234918AbhHZRAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:00:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QExt8K004948;
        Thu, 26 Aug 2021 16:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1tuDjVtekeF2luVdZ6XRt1PULENF6ErCmTtMa3NF3rk=;
 b=xaMPiCr9PC3IoldjNomsdIAVW0bEaZV+RARu513Prsz8iQdkineK2u/RlgD5aPvsxUqW
 0/MGUt9kBQBuJX3WQHyU94mhybxvLNnmlpMIZRhj66IvSN1LxtKg8Axu5IwDu2bgenDy
 TX2LYrVPQnxdCRCKwmtGavn9iVjfKyKgSPutbnqJWL2KeWZBPSNFh/3ierJRoFbqPC8w
 rLyIHQ71IE19xI5chT48/yga2moUPfinx/9jLDxXfmJ+Uc+w//xubgdIRmhsIuWv8dJM
 KWzbC/3PjY7gks0uZwh4NTvFVTA4otKsD1c8fLjhgRz9ATxOYYkwq+lGiUDpcLtdDc+z AQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=1tuDjVtekeF2luVdZ6XRt1PULENF6ErCmTtMa3NF3rk=;
 b=O8FSvtSZCTaflAP7MBNJ2FCMtYx02aSmOyJIBb4bIEbtoXGNeUVsOWIDlLB6vFgIk6Sq
 myRuV+w+VaUe6r+vcfJ761L73xjm7KKq5iFkUCtxcv4lsS9L1TMAXBxZcvgmkKU6kV6A
 9v7qkUSti4c4i+anG7/XEYWHSINmyQtJn7bFNiRUcp5Ov8gvT5dCk4lyr28F40WwMpol
 JGHwFGAiPBFbVtmF2YXTFArEsHVrzfXm6Y2my9hF3kSrCYeHcc68pCV8jfIba/ile8V1
 pBnR+zi0CRltvj9ioy+0YuF5eCYWyR+Dw7GnOi+sW73DGpEizHd+stsFlsbOERuSLqtT +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap3easpq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 16:59:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QGtiKL055511;
        Thu, 26 Aug 2021 16:59:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3030.oracle.com with ESMTP id 3ajpm2xg4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 16:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuS55L2+8QafDFuwmGhzUfav1injPBDx1QW/+e0tJniMtdM4ybL1lhcf7CFbdKTbpJ98+sq90EmnFnvoh5sa2oYHYpDij6OduCzlWfUewRR8OFqnu5C6JCXQxn5Dz4UKqQaysWLW7NmkBNbx1nVP7LbDZZ4PfCa6e6HSyKw3TQa05GHKyw6SrtzcF5LbpuOnXYZEh84rKOLpkWvJ7Mn3DPc1+7cISBe9H1L7dsKtt0S4zaVEbfwH/stbc7Ep0mpgCj8k2cp0TvphYMFO8PcQukwFOU7EwFEvwrhlKscxxYG57szTvHBAJMpDu8lXbuzwp/iFO23E2QTjDewalpGnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tuDjVtekeF2luVdZ6XRt1PULENF6ErCmTtMa3NF3rk=;
 b=BWMmV5hPKDSAWsSeQzJcr61yZ71cIeHlOMYzNGlc6veIkvESSXt8zdqx+V6S0B8AKI7pZ3WAGbQFhzOBL/P2F520Hov0XLaGkq4WlQXsjV+On2y9st89N5LciiE7B42VvWJPqxlN3Y4rWuNn1aotXKYQsWGs04TToCkg2k4TCsfP0FlJH3Wo1BgKRLetmpaWP7rShh70mXOI1B6VOt3AXAjjF4Q6I2Bb263VXV7MgzRAeS927FBRT4PcAhYJnY6XA+FMZKB4A6VHivLQsHhYwKJojpYduXz91clK8mLt9+igysIlqUB85K+AzDOz47n6gsnaiHC+N8AbbFt+0sMLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tuDjVtekeF2luVdZ6XRt1PULENF6ErCmTtMa3NF3rk=;
 b=uWa1GS/jQh3ZEYrJ0tTuTPYjXm98LIbZHQWDDxSpxO06x7jFYPUX3Gy3IFyAuEDVCZ6FWHyATQYvSH3M9yWAEPfVL26B7d0CbBhMQvYS3bh87ZysdoBZSFfCjjMjEppCF4cW96w+TjMKjvSMh1fbSHasTAgAvrzqWVVJfA0uSn8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Thu, 26 Aug
 2021 16:59:29 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 16:59:29 +0000
Date:   Thu, 26 Aug 2021 19:59:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wenlong Zhang <yixiaonn@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, cyruscyliu@gmail.com, yajin@vm-kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: prevent ->ssid overflow in
 rtw_wx_set_scan()
Message-ID: <20210826165910.GB1931@kadam>
References: <20210826154622.55361-1-yixiaonn@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826154622.55361-1-yixiaonn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 26 Aug 2021 16:59:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d93f6d-79d5-4db2-e641-08d968b2de65
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4754676C96EBAC8CC0E57F4B8EC79@CO1PR10MB4754.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /nBM8/SwliHOo6gcaSM6suq1P7eKWUk/brM5Pv4fupK0cwKRTpnre6awDQI3hSo+I7lho6kefBQq8j9plK62LrR/wx2UNmdrNwa7iOvlrPj4EohbhTOw04gNcmV9hNyNQ/euCF76XUDYi7ZYfLFCFKbeaSfZY/JqUu0Ju17sYbST4Mzk0UC2NQnujJEXgZRYuszw5SWQDrQDOxElQxOdg4WRGEobPxuAowFPhEPFWl+SnGvaMCjbKItEXkZ6N3g2Smr3T26JDtWGLqfKzXqZhF0uuEAucYPsYpzZYqbNpWOBHd5D3H4+wrxV5dMkEp4tWXOAOkcakvd4JMNM/UpVS+R2nUMSCFDNYqS3EJv/tbQDmqEooFbsJYFwypOiIpxHtbfT06bbVIKWdJCowqWuMYuxa+WFLxGlRwpm6j1dnnlx8BYt3IwJvluDOV4yDWg3SgOGl143zqZTJsQkeY0+H9xuerVEhJNo2Aax7I4Tf4OXlJgFYeWh9paQ4fX5LD3kylVkIgPUJ+nXMkaRMjwN/De/kgGcYyl8kj6JZL65+GG5b6EjFOP+8hhhTbdN/K2thriRBVXE3Gsl2L5Li+2piRcoSMZjUSOZgtzUSmC4bbPeS4+lH0kKh4XCDv1dsW9Z8B0XVL2NR2t2P5peMEMlOduqxXN5FoEVRNp6mgYr2Kthe7yyCH4iQORbofSnPC31BDkxlf6xD08PlFVHgQm5rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(39860400002)(366004)(33716001)(186003)(4744005)(9686003)(4326008)(6666004)(8936002)(7416002)(66946007)(9576002)(6916009)(8676002)(38100700002)(316002)(1076003)(478600001)(38350700002)(55016002)(66476007)(26005)(44832011)(66556008)(2906002)(956004)(6496006)(52116002)(5660300002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CT6VevrCzN2entiXEMjwSMExFk4pjNhUNotd7E5Ur5RQLCLBW2g8EYcXbsDF?=
 =?us-ascii?Q?R5ibDmO/ZGu8/0Sy3hAYaYyAz7lUFOwLfTcgQhXWGVKJEajpSrNsq/PQkJlN?=
 =?us-ascii?Q?ZnAMth1vYjUyp/8HKuxW/4JpTfeUItzbsQWmkwTTgW+lnTA0OM7gVlPSL0Vn?=
 =?us-ascii?Q?nxoyisiVywPRVlzv5tyeGyLsOwg1sOkJErQMLRlJJrGhUt9a2v38VNSpJGaU?=
 =?us-ascii?Q?IqSsTiD1+QnKpCjgGedqsGn1x4NdQnEQ88qXXfB68rOMCzQrb2sMlWuz9Zns?=
 =?us-ascii?Q?2fZ5IHqZxJtykmQYqfLt7vjxi9Qr1I92JuEoDU0lRU4AqV0UmAT1fzD49Xoe?=
 =?us-ascii?Q?Ii5EoFEP13LzR8DDtqiz2yR1kujeiccSZsXmsFJYaJjwl/jkcp5p5Y9bo30u?=
 =?us-ascii?Q?fXsdNwJQxOtrOLqMPIpJjGrKICNhytHURNepPco5mZ+A3qPgf3gUcxMNf45r?=
 =?us-ascii?Q?5+7oc2esveYrHKm3h/9OEDz2tEX5Fnn3h1vs/NUairl8zmvOfne821TR6+PR?=
 =?us-ascii?Q?bQDyZnhuwMv63C/tymjNLJpMi8fpHKrjVhrtSueqy/KP+aKGGIHuqACFzIqi?=
 =?us-ascii?Q?C0k7hKyLsSo+CjvmA+X9xAxM6A/2JH+JKy4qTZXjvguBlFFWg9hki7/tp675?=
 =?us-ascii?Q?GpVG3Obr73CibWTY7bnI3Gyf8vMnwOKgAH3YGg3cd/MUSAtUyp5ReKcxx7qY?=
 =?us-ascii?Q?+9cxvAGIHtHK0QbUu5TvOx2qVbyQCxgSCehmMEzpjheO5r6HYrJl6g6TBd2I?=
 =?us-ascii?Q?Q55nzqMOvilee6E8mPMNm/hKnUI6hPU7R3SXz/yiecM82pnkfAqREpTto68b?=
 =?us-ascii?Q?eHM3g5+RHWfTeoAhDgLIIkhoPOh4ZadSJ2oLl7xZ8w8Kv2LrgtH/s0bYwM7V?=
 =?us-ascii?Q?OUTVtAms4rqew9tUQdRbR+piEAP+7Agzes1AOeHkMgfSHDN4Dzg/jkQ0tjSi?=
 =?us-ascii?Q?sQk/g0LMk5RJ0TdpmncRQnVYga2nulImBb/Dybs72FO5AhgRTpnTMwsFRZjJ?=
 =?us-ascii?Q?LIeF87vU3bjOiKgVYcjDi4TmAV3BWsxjZ3MsPplan/9NpcBtt6p40+Bq17Ps?=
 =?us-ascii?Q?H+xdilNFuA3BxemiiW39wK7ba0lugR9WISL++vj1ahX2lkJLgUG73JlhmNJK?=
 =?us-ascii?Q?B8btf3h5KyypqiVOKEwPvl7exKbHTd4RKIWIZdGS17iJ4hHZTSukRsBy55dj?=
 =?us-ascii?Q?O+Bx+ABgyhX9cptIISRclmCzGnnDBUjxNgIt6HQZVuNJz7iLngC/MuSdxUaf?=
 =?us-ascii?Q?hufzvzzveFAS42p4OnP73bi0+ubIavKpp3R6vqzL1LKwdmNTgd1rRHbUgIyY?=
 =?us-ascii?Q?5zSyvtGpjO3CP6wqrO92re8m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d93f6d-79d5-4db2-e641-08d968b2de65
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 16:59:29.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6gaopIpRCzj/mH+BkOEkao2hV2046JGCJrWDlsg05v8I/o//VQW5R5Q4kDuN48RTm1ajlD8jkL3+r+gZSyrXeBj9sjZVenF9JTGZuMGvCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4754
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=991 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260093
X-Proofpoint-ORIG-GUID: qGLB-qJoXtR3e6caG3gL9P5OnDxnXeDZ
X-Proofpoint-GUID: qGLB-qJoXtR3e6caG3gL9P5OnDxnXeDZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:46:22PM +0800, Wenlong Zhang wrote:
> Commit 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> fixed up the staging driver rtl8188eu by adding another check 
> to prevent writing beyond the end of the ->ssid[] array.
> 
> Resolve this by properly fixing up the rtl8723bs driver's version of
> rtw_wx_set_scan() 
> 
> Reported-by: Wenlong Zhang(iLifetruth) <yixiaonn@gmail.com>
> Fixes: 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> 
> Signed-off-by: Wenlong Zhang <yixiaonn@gmail.com>
> 

The patch looks good but somehow it doesn't apply to today's linux-next.

regards,
dan carpenter

