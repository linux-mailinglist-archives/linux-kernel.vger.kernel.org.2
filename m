Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DEF3E12A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbhHEK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:29:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11914 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240392AbhHEK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:29:26 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175AGtwM016391;
        Thu, 5 Aug 2021 10:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=E5I5pLV8UV1qnifRH+rb33743qu/BLIr3NBLQVrto/4=;
 b=rDJ/RsjBP5/Pr7mY1Op9Ofj0NV/rb0XPaMr2DqRAQf3IF2xx/niwJxmJ+MBuPwn/VabD
 qehobbsdwtrf6UV5ETxy/sa6yf+u7PNSiQfCApBj32aBmTaXhghVOmwNKcprqVvw9h7u
 LuTmzUZci884l1ZiIvjD3X8d5z60nARovhflqyizw77Vqw6M6LOXwMObgX1pA2HPIGzE
 EN+YCWD1y+0AKjcQ/Gh8rJubF8Z613O7jQLDA3DT5PaG4b/j2FRtRG4O5UKJ/D0KuYuV
 KjRpFlAju6exYjgeec/93jPqeo9GA4m3H9FYWola8G8ZNMLabF9/k9M+bHT2sePZnM1V Jw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=E5I5pLV8UV1qnifRH+rb33743qu/BLIr3NBLQVrto/4=;
 b=JB6wbznjbNOiKIhOtOm3cu9YFE6M6u1ViNyO5SuBa7RgEXkVwFDI4alqgIpH5Btpc9p2
 vZP8/FxV8dGJpAgZTM0an92Vma2B31mWCWzTJDHv6qKbCOK7bZ/WJux92uGuI9abMr6g
 CAw5j7sSEHj2bI0KNCRz46HfmHvlnMbwxkux+gG2i17w0LzZlIQJuWyALdtqa5SHUSUX
 nsfE4U9LbMokYZbxdJZtmSJSevdvCgeKPqED+oOkQ113921pN9YhcCzB6aNydatXQ998
 3zlpj3F46Rmgl6PTnjXi5AkXYFHb00yVd0BSaEfiEZT9rO65QYS5C4kJhjmdBXUxdnn3 RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7hxpkmxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 10:29:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175AFTgJ026290;
        Thu, 5 Aug 2021 10:28:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3a5g9yxsmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 10:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKrY/bEZUiahcolNVUdy3c5k1rXqdwFOLaZ6yadNWF5WrRQezbgqD1pBR3gmHtqN2uM/dyQdC19CEdDU2J7VWP7jnZsEz2DNQmwwORMe+K+7sKCfGnOYew7D+fJO/+qZgNeDfLslYXbuZyKemB2RHvNwyDQTpR1GTKnHLeCggzqCzKGmfRSPoc4ZFCHOQUhyO713y99F9Chr4POELXG8M5h5vSpcRn+MAK8tYgoscyx8vH81+xkR97JBTpLdEmk0RAI85moCMI54TuJlPzGMv/ZQPWdxfS6wV7fS+Hxy4Wkpr4gndOCUka5VOU6tcJMpbm/5YFXWwo5yaTxyQFeUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5I5pLV8UV1qnifRH+rb33743qu/BLIr3NBLQVrto/4=;
 b=WWXb7r8AT129cxoqjwmmijv66LFBza0RNuwB2AEh5RylA3jTyNekJ5KBRniIvhXWnPsIVVhaq9046vjtpMS56Kk4aRBQ9OkWnnlRQE1GB1og5wBrShz/2KKHI++xzFk8BT9PoAOIKpj33DrjjKR6nDVFDMDhwaRYQ765cQB/92LFOFu18nLX2xtuKLbyq1oU+y0NvBAI8/n2H1KNNcbGtHo/em0rl6CuyXpaaAnAF/Ix/xhA9U90ZaI1IjS23v1VdyKEvdmbpoOW+yUnLZVUSu1DVGYBKfbNBEZt+9gucQi0EokGPPkgm1iAykNBTF5IxqpTPoH+Vx9shqn0VXdXiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5I5pLV8UV1qnifRH+rb33743qu/BLIr3NBLQVrto/4=;
 b=S2v8N7L8ubyEP5qFz1kARJnAIfZbFmxn49s5xl0sCFGcClPhNrD0FQR5uVDKH2wf1RiXvFfBTz8dJTo1DhX44tOEfiIusQDK6Phi4xXESwrSQNlWZj54F30EYeXTPl+eb/0RlURnyajtEavj9N/1UGZJU/sIvFWyT3ICfs0a94E=
Authentication-Results: lwfinger.net; dkim=none (message not signed)
 header.d=none;lwfinger.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4690.namprd10.prod.outlook.com
 (2603:10b6:303:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 10:28:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 10:28:56 +0000
Date:   Thu, 5 Aug 2021 13:28:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: core: Remove rtw_mfree_all_stainfo()
Message-ID: <20210805102835.GI22532@kadam>
References: <20210802005517.12815-1-fmdefrancesco@gmail.com>
 <20210804130136.GJ1931@kadam>
 <CAP71bdUDEX=B6Km9wZO1AyHpVzqqkGNw6xNvspBz3qUABSKMEQ@mail.gmail.com>
 <406c6f84-a2f6-1a0e-3a52-9406df41973c@lwfinger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406c6f84-a2f6-1a0e-3a52-9406df41973c@lwfinger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 10:28:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5479125-c77e-449f-19f4-08d957fbd461
X-MS-TrafficTypeDiagnostic: CO1PR10MB4690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4690C8703BE183357810F0858EF29@CO1PR10MB4690.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTLl7I1dN441+7UzO2jn2wIWRkWyQD884TjJjOkW2Q0PLp1CyisgMnyutpdvM0SEY3t28kk8JCtKfxt85uFPeQWKQV76PwxC727AYYUMFlFO1OIpYHRVrAa5I8yM05K2jIfBW5ornb91mmKnVtSEjwj/QH+9kn9gcW4HmpZbwhqaCyQLvPdVCgy6Gazzn1Im5Ez+rR+55RkDVO67gDSJ+Ps9un5963WPAu08fS6oDZFEuAT8+xuZtGI7tuw8kKB8zvF+gD3FrFtioITdYwlsRqQnEvCHFNV0zqu2FbkVbGNKxfxLCMEQYjxarjqGDSHBspDVtEb9kJJ8MW25Im/GFl6++AU5VO9PsRfB7jaYqFfa2+o5ETEkllU7qy3i9A55AkJLCPXbT8xW7tbXPogRG5YUBFGlcE0vztuVwbfHcgSeoFgdijcVHVvy5ernFj2EFVuqJV4M890PrNZkBeb1r8Yk4ETZ0z7RQuUmBc/w3AHwd3lnSdMsEJf4AyvGQ9I5nWy1gLKvCuQ+il8GF+DWEHpU+CypATqUtFnJ1a+uCPWqQD2M0H36/zTc0ikky57xYgjapLHK2sDzsZ0F4Bp0OIS/1Z6z8zwrhrbHtx6pUjdaKSEGc0ZOaVyiIM0zbquuj4dtNPvP1lpAQb8hi8cxdS+IBRfVHQ8Lr29ssaNC7vd7en2jU7I0nHdWWa80KFB7TL7ejl9m75b7esgRv6hpGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(136003)(39860400002)(4744005)(9686003)(53546011)(956004)(55016002)(66556008)(478600001)(54906003)(5660300002)(6496006)(316002)(44832011)(52116002)(66476007)(83380400001)(38350700002)(1076003)(66946007)(38100700002)(33656002)(9576002)(6666004)(4326008)(86362001)(8936002)(6916009)(33716001)(2906002)(8676002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nXZDjyQLroy/hmJ5HVbO5w0VOV8ibuZYjpTcF59vuoBwufElgySDZ51BRI0D?=
 =?us-ascii?Q?NgeN7v0S0z35y30SMXWR0c9Rp3G1/gy2NI8uIllblkO+6nCpzFBuPybSWZf+?=
 =?us-ascii?Q?AsncXageyU6jm2Pql72QIEe3t8oQHXDsplKh41kgRG5FoZ/803V3n5qJ30/1?=
 =?us-ascii?Q?dghXs5+9h4pk5Z7xPHyDsPZUI+lqPFx779/eDtoKrUn6vQqiNBmX1aIzrNDY?=
 =?us-ascii?Q?Iwk6QduiCh8XLwlJBX36d2Z8LwN+vsPSSG+JYeoWRCcCl7BDxmuOgH0KSVCr?=
 =?us-ascii?Q?Qi1tmwmxKb5vDTvqaV36HH+97zYdlBiNAIHX7aYDVVEn2hTOZ+dPsSK3T7oG?=
 =?us-ascii?Q?jgABd0HKhxex8bmo6t4npH6rZ5+oc2t2lz1RKp0XG/YJPG4+r06BgvCMZlhu?=
 =?us-ascii?Q?ZZTeSysAcfe4tB7j8t7ZBqWmKly48TXef4OqHpLiKnYfiWSDB6y6UWy4vQRG?=
 =?us-ascii?Q?Wk+7WcX1aOS4wZcC0pvi1nCcNLA5N4qFw4DgH/tT1VUSZqCklaj02ftUkhGD?=
 =?us-ascii?Q?kATonbsFLy+Pna5CesraVm9QeJQBuY1OzWWdH74dEiN1woKqZIClcA4s/KiN?=
 =?us-ascii?Q?Q3MQm3oRGFe+YLOYzputGfaN9anNF6WYsXoB5e+k56OFcoOaE5NFic5s/5g0?=
 =?us-ascii?Q?ce6M8ih9cDDRfv1/merNn6gcSyKEm7ppLL2mipQCDQo4Z7ipyjitgBk/smul?=
 =?us-ascii?Q?6pgUb2r/nS4AZKqRJJ54PI7vCH5jNANGPAtHXfHtLoy8JxyWNOKDDXhOVqpO?=
 =?us-ascii?Q?9CW8u2d8PfmFBFovpTM15gQgrvmlzJcIvEaHiwzBYYgzFY0bQfI6C6DQVkmQ?=
 =?us-ascii?Q?xusmUXx4fIxQGz36lDTT+GFhmlxnY1aKfHDjo7DTzNfeUEeAf4T8DvXG7yRm?=
 =?us-ascii?Q?j5XDsdL8CvrMH6xMW54l94I3+is5q6xyLMrmfyv+Um7T/bIQfkRBQt7QHod9?=
 =?us-ascii?Q?wIjNVD5jAsnd268M1fSky9zPoHymtPZxnhOP3a6uTaqyudLYaOaEv9n9kPdT?=
 =?us-ascii?Q?1Wj2QeKcHqDWra5xBPkFOPr36Do03gMj3SYpzSbVY4U5OQI1GgSCNkELcDsw?=
 =?us-ascii?Q?88n/kZ0A+E8rgQEW+BhgCCmsEQLMq6TvwQgzw68lh9m3RRcJGxnn2jDhocQL?=
 =?us-ascii?Q?v8p5b26wtcud25ccJZDO6UgzMYR+n00Gx6G1CWoMyGXzx7MJRKFBghtB0ypl?=
 =?us-ascii?Q?qAxhXYsCQaZhTXqNnPcwxs+slsbzcwS8b0rf0WUAIiwn02GY200/w6LjZfXO?=
 =?us-ascii?Q?uxclmcgvNWUWbuvrZR9lDnKONlQRs3N9ZBx8x3Y0Rdb652OOewyiVNMeRdZg?=
 =?us-ascii?Q?wyVQfbE6g2vcfQIc5FeBy9bd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5479125-c77e-449f-19f4-08d957fbd461
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 10:28:56.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28Qino1hw/5h2sQ11d8EB6qE627Pl/oUIG4iIbY24laXAJj4tk2u/6zlKs2Y9kMRTKKaA/hwlZwC3IQEigyQrlHyzqtBobttQTbJQJaTzJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050062
X-Proofpoint-GUID: txCJu6Yvxu1vibxfPUzGOBwmDQj1-vdn
X-Proofpoint-ORIG-GUID: txCJu6Yvxu1vibxfPUzGOBwmDQj1-vdn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 01:10:37PM -0500, Larry Finger wrote:
> On 8/4/21 10:09 AM, Larry Finger wrote:
> > In other Realtek drivers, the while loop has a call to
> > rtw_mfree_stainfo(psta). That routine does not exist in this driver, but
> > I think it should. In a few rare instances, the driver leaks some memory
> > - this missing code may explain that. In any case, this patch should be
> > dropped as the fix will require testing.
> 
> After looking at the original code for several other drivers, routine
> rtw_mfree_stainfo() just ends up calling a couple of routines that free a
> spinlock. That operation for Windows and FreeBSD is not trivial, but for
> Linux, the routine does nothing. Thus, despite its name, rtw_mfree_stainfo()
> does not free anything, and it can be deleted.
> 
> The original patch is
> 
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks, Larry!

Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

