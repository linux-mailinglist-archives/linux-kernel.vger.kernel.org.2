Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C45441CD5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhKAOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:52:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35774 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhKAOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:52:09 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1DRUjp014433;
        Mon, 1 Nov 2021 14:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=CyvvhEiQCBZrtPVdgvy6vM4/M8WtsfseRIvLjKfu7NE=;
 b=jeAxereBlAUaQxFm0lsWpXxirUlJUFlnbhTn/7cPam9NY9N1qxCbLuBQtMeeET3UcPMf
 +OEswU/OLohTkAqpTu+ewM/U8taFVkGgPz97KhsGxfoymXEQEZ81L9RcuWyKxvKQ3jLd
 OexfttY2in+55QvdxNcZrkysC43pD52wyjqWwaNGfLaOECK0B9dNDiBWEidXqq9//lOL
 1Qh5TemunCUIeroU9nuGrPcvy/ShyzEJs14TQoJ740ZPv3WLLpcVJVg+7/TY+Pk2MYLU
 eWKTVAnNhfeI++6b0tF6Az9xNTnkBoEnmDEZIKMau62n/gbZVBQIv4xA7Z2RmuvC1Iel tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c2aa39wpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 14:49:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A1EeE7O061198;
        Mon, 1 Nov 2021 14:49:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3020.oracle.com with ESMTP id 3c1khs099h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 14:49:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8E9g0d9fu49wwokFl/MVjG2yLsyGuvbgz6gZrguc4/ppd67c47Wv4OWIiOJnxfuzpgEkVKVBrgxA0YEoOnrEt2TkXbnDZ1XacDnJEPnxE0swrT/mP/1BwF52GUxwlWCxqZ1Jm8VnrdTwl4PrNyQGN9UeScnwTRqSQa2v7ELUeVr1QSsh6pw2r/2nTyuDrP+JvziQPerQK3AwPEnmrBnd4zF4fiP6gPRgMPijh/lzhY/BTbfC4r8mBtKF49vbKK86/qnUS5/3Mj2fEGhPbtUnYDfqNVjR/eyoRk0KRn2IiSymLk72I3Bcb5TxFwtiJHgEEDcTwvCn8sUkZMsAJT+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyvvhEiQCBZrtPVdgvy6vM4/M8WtsfseRIvLjKfu7NE=;
 b=iuZdjUjkPFvR5P3KryN0Rhr8r5o3ogDNKFsswuR+Rksf9HLhURl/9S7lmrUpzamMLjDgh0aH2YHcBkkyaP75vMOWTnIYOhNcjj1XlLQFq1GoH93hfxqLh6vIGajupjS29DW95v0mVVC+XM4JNKda3WMIhZlZ/pOj9CJ1HYWCQ6r7+vnFWz/WZXmo4yNuPEYYeixRbGyqqXjqQ6gFZVT205G55pu4hQwbEGvpSgTthHjjAmImqV2oSy9J1Xvt8z112iIFfYI7FX4T4RJTaPmHhHjrTZnFHyKw7aruiByTf/tjl8JQjju1iQ29rOmkBv/C8uIQDhVRT1PDYEqXPKELtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyvvhEiQCBZrtPVdgvy6vM4/M8WtsfseRIvLjKfu7NE=;
 b=sir/hLISXguS+MBmAMm9F+tm7wi1tjbOAZgLbAKwIHWulfRwIaRsg+uUxC6XGTwTUNNd9oxWAWROroDn+Q4gdg2TzxmoDaCzzioEKVoHwnmwx7pDdZ/fgX2o6N7ZACied4zmIs0Rxtg4JF4H9T9VgslASuyIusx8M3llLe3ZYTw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5679.namprd10.prod.outlook.com
 (2603:10b6:303:18d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 14:49:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 14:49:13 +0000
Date:   Mon, 1 Nov 2021 17:48:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gaston Gonzalez <gascoar@gmail.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, arnd@arndb.de,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vchiq_core: get rid of typedef
Message-ID: <20211101144853.GE2914@kadam>
References: <20211029200012.45986-1-gascoar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029200012.45986-1-gascoar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18 via Frontend Transport; Mon, 1 Nov 2021 14:49:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e098b63-48d3-4a3b-8536-08d99d46c4e4
X-MS-TrafficTypeDiagnostic: MW4PR10MB5679:
X-Microsoft-Antispam-PRVS: <MW4PR10MB56794F7925AD4AE35624F1B28E8A9@MW4PR10MB5679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOiPYAD6qner2yzAgiLIXA/5mBwYOP6jtYX+28Q1ExYN602nG957AX//OKycQwaP62m6CvOJMrPjDdM5PS38/nQOYfmp2A2I02z8ktK06iiCFKmS6mELEQuNALOklGH6yppWb1OWdt23gfsGcn+DJb4rSTs3h/lUnF6B/akT5ys/o9VS+mziILEtK87WZbL0MFWyr4ZhqoPqfyh2jBo0SeCzdXWPoykuS0VX2SpcWrvu4PCg8Q05V+TtTi6NL10vHe3qyOUfZtexy4i4HS6Fz/VU69lJMseyyioPGDtfi11RpqJdl6HeleWVklEWsiOAIwggjuvRwVwHiUU1TwpMGER0gcGc/TmZfdJxIDiwTL9En9+52D1ShOjr09lENqOgcub46CJYOBvtvAkZ0vvYX5lyRfYjxBRLFvvBWO63s7XkPvKo+uDn7IxyCNBiybLbWtahh3/ynyx65AW7kxacD0n/rN6l3tr3SLAF+Y3zxM/TEmy2CzpMcuAzXDhndXLoS1suZh0rtWEuiJ6aPJcKpIYcykZz8aW7LWJAFtboAxgUfQsGFp2hTRK5Uxt+xKTQUKqCIsOb/N/CZav0KPNUS12Y2J+f0O+o2BwjC5sRAMU2aefwOX10MU2NYPuuLrZMLYAZN622nodD7Trlta7F3be/o0UkckJKEd7QIWF41ng8ua6ioJXzIkKJ1JyI4FD1OrIPva/9GtkEt31nhX3J24TewwOZEZwEue2+PO7lrK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(33656002)(4326008)(9686003)(44832011)(7416002)(8676002)(86362001)(8936002)(66476007)(55016002)(6666004)(66946007)(9576002)(26005)(33716001)(4744005)(1076003)(2906002)(956004)(186003)(5660300002)(6916009)(316002)(6496006)(38100700002)(52116002)(38350700002)(66556008)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ullGi3MwmaPVILOw3ky03kSIcgnzBRO+1WCNd4XNHJ1CaZzfhACU3JJg9BR4?=
 =?us-ascii?Q?sEKx0yFRxPqROvu2Qy2ykU33wY0m68MVvKyozGPEime0G5U6NAm3PLwsVT1f?=
 =?us-ascii?Q?Ug3KXaJLWnwwg7demMsvn0abe1+zT7/Q5u+Z8kPXEFU768HconLztO4eGi/r?=
 =?us-ascii?Q?64bLPFqLX65LlXVW8F5LmGWSPcB/Ydr/VxGU5vG5FgyVeOuOu/wt+4TwLjif?=
 =?us-ascii?Q?g6Ax7pWegThctXXWv6+O3+oAlD3Kc2Rq+5MXqYDnuDHiRgLpMT+d4ewGX9Pn?=
 =?us-ascii?Q?fnBItgoiHvQA2LwGB5zHh0IoX+2fxRB7i2CCU1B12vmU3fklVcKtZaCg9+Gl?=
 =?us-ascii?Q?tgE7h4DGg6DKObkbb3uOxl1JLEWADrH8kR22NNmbK6IMCdbTvZdJmcyG7pWE?=
 =?us-ascii?Q?VxVuNAtMpgWkkk3LcO42yXO4W+FHwL/WPnlpa++Djuue/fMK8x/Wp7bvVMD4?=
 =?us-ascii?Q?GLQpaQIMCTvqoobmIIKtfoNqt/3rR707AfeBoZ89X1fRQywD6ZK3H8RlFpNP?=
 =?us-ascii?Q?BFiyWgz5jQep0y6t2RKiYL19GL8kAO0FA/EgwwVsxBUdN6iQLJDWbYeDMqI/?=
 =?us-ascii?Q?TRGmgZK2UrL7MMxwRPTMkCDFdNSJhpNL3CMe97ZF44b20xP3PzR61XZUc1/U?=
 =?us-ascii?Q?7ZZCW+eFssr3yWirBdm97TaxTDWIv63N7JNWfPYyQ9fzQWIn/7k8hnSqxd7Y?=
 =?us-ascii?Q?KDtLEIqjkiPB60u9lBkQJ+pcG2SCM2zhCkcRzo3ajECSZFgGF/V85/iFGi1I?=
 =?us-ascii?Q?FP2D16BVTdQsTvygtkloxZu+n/Q2Wp9wp4TaCIrb6z2jvz1fkm3R8taP6xN2?=
 =?us-ascii?Q?P/AEMOANTb+5rOEjGpNVkN1iNl3gvIkk3ObY6ANXxDR+baMnJH/sypnBZcUV?=
 =?us-ascii?Q?zNuO5aMT27eKqc2YAeOEaFHuGBAmmqEzeZT1R5SiwYOpCmhEhNbTHhNDr7KD?=
 =?us-ascii?Q?lavijzUEnErjTePnvcDp72nS+ulh8PKQuHf7PW3H1ACPDB5plktOaNr3nOab?=
 =?us-ascii?Q?DUJqMyNkANpqEqCZvYfrtvTfpMw7A8s36CI5Sw6gC/sdg/sB5G6XPKenlY4K?=
 =?us-ascii?Q?uhur9kPJyaPebdRSfgRvsV1cBz9OlH9sCjBZ0wXNVzr1S5xDHVdXgiL0BwLo?=
 =?us-ascii?Q?rF9LGin72M0pQbVHJBrLhI5n2KDUefiSOTXmk39c9pReTZBUmZswIzAC2BPT?=
 =?us-ascii?Q?9/CDYbYB4cHThqp+HHDXzsdWCKnRayii8jzaNyvN9oERE4t9rd1kNCGfGnxZ?=
 =?us-ascii?Q?bn9dyWISr5aC0AshZfnafLYWUGc3Szatov916YEKtYeU+JuBqcZt7tNiRnVS?=
 =?us-ascii?Q?xVPSgmhs8A/08OswwiNZHG5W7gMD48wmZLMjRRyXDVpM9lMbRFF1mi4Fl7gl?=
 =?us-ascii?Q?jghS5JgsVCu+N/QJXooueaR5bMFJCl0d/KKxOFUZygFW7CvgawxDvYZcbaha?=
 =?us-ascii?Q?As3u5v6jmTZMu+uIxXt05G5mJxnErJZByoua9eV0iExdf+GLaDBVagWUSAc2?=
 =?us-ascii?Q?1GCsGUmGZW5ksF6gFc2atPD04ZcQdnAujcrpJcV3oq+0YTAj4QVg4I77vqtd?=
 =?us-ascii?Q?AIAH4IYSMnCGDopZNtAOaiC8fCw5Zs8IhwoN2zcRDNgtZ8I17D6I9UfssHT/?=
 =?us-ascii?Q?S8nbUAi6g60ILE2JXuczUbpSGpTQom1AR3mhD0anv6uOjJ80RnClS35Jam/2?=
 =?us-ascii?Q?BZXRrA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e098b63-48d3-4a3b-8536-08d99d46c4e4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 14:49:12.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8abSRU8hdkfmzQfAFjhz76V5qmwJGFoBuCAoIs3YErffv/da/wdatxE3hIQm8Yd98qXM0uyFIi746goK+Ym/D1nluZD0HgHTIdyTKUlsAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10154 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=967 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010084
X-Proofpoint-GUID: rH4kEpbxTLGQlEppneNkTI16HOOVt98N
X-Proofpoint-ORIG-GUID: rH4kEpbxTLGQlEppneNkTI16HOOVt98N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 05:00:12PM -0300, Gaston Gonzalez wrote:
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> index 3e50910ecba3..53a98949b294 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> @@ -74,9 +74,7 @@
>  	((fourcc) >>  8) & 0xff, \
>  	(fourcc) & 0xff
>  
> -typedef u32 BITSET_T;
> -
> -static_assert((sizeof(BITSET_T) * 8) == 32);
> +static_assert((sizeof(u32) * 8) == 32);

This assert is now pointless and should be removed.  Your patch has
already been applied so you can send a new follow on patch to do that.

Also the BITSET_* stuff should be converted to normal kernel bitfield
macros which use unsigned long pointers and set/clear/test_bit().  This
conversion is slightly more complicated so don't worry about it if you
don't want to.

regards,
dan carpenter

