Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2E3E0038
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhHDLd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:33:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18794 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237000AbhHDLdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:33:15 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174BPxkh025932;
        Wed, 4 Aug 2021 11:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=g6JaS4B1FTnhSGZhauSpzECaU7uIQ6GzaTwE23khP5s=;
 b=KlvQI90wW7sbq2vADd2YUG6Drg+WyFaWOQ8pqQO1L9/lYhGSjcBTG389CBx9TkH3dz5A
 nYytEUZHgjE1oGYCgutHLwEWP0DUedPr3ZpHiX8kDd65EXrJiu8ODGEgUxnwFK+70xdN
 7lnHYbREIf9z47/1GXYqHdjIx2+2BVElUHYsw2hRCntdpisNUdha7lLxLY/uk/NDOyfx
 YNWVVLNBYxGDUclMk5rjqR4FTjyH6NSMlzpX4Anvxi2pdBn+v+mXf81E0g2lQLq/qCn3
 En387evfydvuLOe81QxYvjX0O3jsHHjGlrwJmIDOY8v6dn6eE65xQJYl0CV5yNNDiFgP zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=g6JaS4B1FTnhSGZhauSpzECaU7uIQ6GzaTwE23khP5s=;
 b=Ey1k4JYQ4bT4y7LYBp2fNVCztefJTLiPcq51I35dXPq36BI1WobauliOfBj2qfgszuzG
 jNYNjb7v+pPpsWKY3STca9m2U+yI2ajHGUuLB7+Ett4X9o7dJPj/w1NAQgUCkPrUth21
 xfOPPwv/u/pQGKMGX19TJzMvAVdSI7e7cXn12+6138HJfcdGTa+msXBPoFuB422Z4Yjk
 52mi4aPME/HkQxDcWFYk5iIMlnkJX60VtXeI1yKkHcKO931IdKGQ9ce63Hdq8OPayZx6
 oenpC26JrHUgY3ITknPpY52qsP2CIyY4TVZuEKfMN/tZfrT4qOp7OddfIcIBBF//yXg1 RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6cntp4jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 11:32:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174BTwTJ127208;
        Wed, 4 Aug 2021 11:32:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3020.oracle.com with ESMTP id 3a7r47nnwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 11:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFhQONJyU1U3don6t1IVG6Zoc3l7mjlL871+cxmyIu5PwZy0Wi/p0r9hWetYW8ZxoIav9jWo/SNkny+8lhCc0P88N/kDj8C1s85aRzbvZCsiP65Nr/0WH6HS13eAmLHdhFYV3KbBx2/JNpL+J6sf8n6WNvRYwYmpVVUBeNQ8Q58dve2lEMu2yBxSNlLe0iNSz7W2FUJrdhbhmQoI9FNYOlGMtrvmscFJJkdj64NdhC127YYNZ3FXYZZ4+/6ungLWW9nvX1LxMzHGheQVPzAieydH5qGKrQaP0SB6sD+CNvWj4+3dfSnqL9ysxo7aDCSrJ2qyDsHasoMhLeWiQaImAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6JaS4B1FTnhSGZhauSpzECaU7uIQ6GzaTwE23khP5s=;
 b=dd2Jm+eaJMD43PrgfiYW1eMsVqRertaxhxD1h5KLdMZy+NMZEjfAF/GQRUBpvq2B5TAGXx6WuULNANeGxLw217UBwxcgru8mRSTgDaYu+T5C/L3PyOlYyhObT2YCgKv0rpxjC6e2PBcPdyRyzprxdAT3JMstlO9bbu/nBuluZcr8Gp9lFfO55JvX5gPuSt7jujihmPgYguWlutofcD/Zjz65WRdGHnlcYjV9nTXfJGEOb8nd0BMRh4KgB/JCzhf0HGoiWifygbciaUfumtclkWCzzydztdMI6mkut7LOfkrLsnrEGB2mScluREsTHS6kI2yBRi4SeExIJn+20L2dBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6JaS4B1FTnhSGZhauSpzECaU7uIQ6GzaTwE23khP5s=;
 b=W52xjpAZ/GQBEXBwC3AufaWsNc7/LEzooWkLlhoMtLsGTKt1ANKo9CH5ejPdKqN6VWA0d+mvIXGtXpHVoUOlVcm4T+8XiSF4wOqIXQDvxWpl+fWsPII4w5gNT50QfA+tDD/zQ7zR/JI2M9JOb/T+icdvgOwgv+vmNkt9nAW0zuY=
Authentication-Results: kaiser.cx; dkim=none (message not signed)
 header.d=none;kaiser.cx; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Wed, 4 Aug
 2021 11:32:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 11:32:53 +0000
Date:   Wed, 4 Aug 2021 14:32:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: r8188eu: remove RT_TRACE and DBG_88E prints
 from usb_intf.c
Message-ID: <20210804113234.GG1931@kadam>
References: <20210801173023.1370-1-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801173023.1370-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 11:32:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5019a56d-ab84-4ba8-e88c-08d9573b98f5
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21588AD535A986F6FD10F4798EF19@MWHPR1001MB2158.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Bqxbth0jXv+t2xwrwjxC0URXGZePSqzcr9hIgULT7/n5w//Iw2lpjjXzdR5LkL6CdMNmxfnjHbcabfCWjflBah+7akY1wmqoGJ7hSbUuo92/v00fdocWcYf4Kd5J47/OZVhabHVLJxJv+oYnFn00KXOVYr9BhqwM+3ReL8rSSPEQfCUNK2VzmWf/NQ4FLhMfH6nuKK3Di+sHZhcLul3w0msG9ttZMLPG7wWFQg62NX6jZcsHK41eA8iKDhqgY/kHks0xFAwiZCFGWi7Ur6p9Oa/fEVtf21Al/MoUMiMy2L4RVGfgQ/Dyl4snzvjfOxFyDa0oNg+d1xRCXRH3lWc6YiIsZphCJW6CyPsXA56F9Umf3rgWB3DklH+MKc9AKnRcsfgCea3O7wv8hME1s2N4l7OuWBgvyxWa3PFE5apQxRAYFjgo31JiOxTdx56DHPBSvc1c7lW5ZtxOeCilCl4/2UvXvp3P185I5gg3iOt54vd8Js3JZEznDvCxH0UbMVbY/yGzLJi2XeCN+mBDAPpOvpYwYWTyjtY94XfDMrq5EDT4R1oxQmhvKFO/CK52pgt9c/38bp1S2xMK7/orFzAjAMMtO3BS2MHJbmwapmhECVR/I8a9ofQfyQhgVBxeZmHrkzm6ODh7zelqGAca4ng/R691kG3EtyrnVJIlGPEtv7mZrVGf5X6Jp9NCnZyyyVdQkt+SFEl1U8bWIxa1x65Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(55016002)(9686003)(6496006)(4326008)(66556008)(52116002)(86362001)(66476007)(83380400001)(33656002)(26005)(186003)(33716001)(38100700002)(1076003)(8676002)(508600001)(316002)(2906002)(8936002)(38350700002)(54906003)(9576002)(4744005)(6666004)(5660300002)(6916009)(956004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zd72IdpPTvjMqT5Ok9QBZzL0AuaEDqZUBjYP25KeQdVSsan91GFyi7mnQogV?=
 =?us-ascii?Q?S3ga8ptkK+Be+NlvZzpqRz4S9rMEnFwpzdxCZoN8rGY8w6cPgsUnnr3lYdQZ?=
 =?us-ascii?Q?nX+e18FD0zBUbazQhOM6XvxD2FxA2GH3h2qau/TTqJ/PJiZm1M2XqUfGl4c6?=
 =?us-ascii?Q?65zGKvl/BObhiX4uqeXSK8dCXyVOfPnWeRTtmDWxX3egUQcPQ1Cy/IxXvYFK?=
 =?us-ascii?Q?r1xeFsvjAJuXuzO2dFShbBCm6d7e7MRBeXT8CFrVbQ0gs48Td4tmEALfTPAx?=
 =?us-ascii?Q?inXoUJCXl8M328dbaGaMnjDaCeKoNzcVHWJ35U2Uf8ti3hOby5GHSo9VfX7r?=
 =?us-ascii?Q?F1mPHkfHg2Oaa/76DszBm6BgcJ+xCfvqATqKsMN1ytNT6d4HP4cr6ErQroLL?=
 =?us-ascii?Q?lloX1vuhvAdn9STeIX9/qw6JR1vqsK+s3NUawdngeXXeynJb5wmWkzBz8oGc?=
 =?us-ascii?Q?X7R26pN88KXHzIGTuMo7WOB2fonLLPhP0JPHnU72fy9DvLwQer0tgfveJUlF?=
 =?us-ascii?Q?DmjzNM7puqOcHfhBqnvnj/PZpzzEpiL9mcn/TL/hE+0U+87DmTxOPoZGtoKC?=
 =?us-ascii?Q?0EwH7ohGm3xmdif7NpAkW8DG2kjn+qHuqAdFg+/7zJK3WeS6xssNF2aNXFuT?=
 =?us-ascii?Q?6GNnRzNPapFNPr8S97A/tnbOMUJ6FA0EwybQAEEUzZ0gJBY/l3JHKzmuoDww?=
 =?us-ascii?Q?tJvUZ4+/BrGPsqf7dn4OE1cFjU/p0iT5q+VDvvN9UFpuN6QxqleFl6oYc80L?=
 =?us-ascii?Q?Q34Ccs7Fy0xrMoOKY5ao3wFlHQEMkfiDV5uG0oXUJ/NMO59YF6VrSSW6oQVB?=
 =?us-ascii?Q?eL7RyL9hyc8Pk3zjyHDPeja5i96uCtVDCuLhAi2iW3whFje3vt2TRxpJvT5Y?=
 =?us-ascii?Q?jZUB7+Q2KVE2oxHmssEaZItVK+Rc31Iv0nXp2ALLSNdPmyZfmSeeQ7MMJStD?=
 =?us-ascii?Q?JeVdpMcw1lUbwz/7bUpXASpcbgyxo4PoyoZsEEsVsYEiKrWKVhT1fKSxRwsU?=
 =?us-ascii?Q?IIVrZe0De7JtTEPDTowLe20n1vqbIfGg1ox0ObdcoZKfaVzWvMJk4pj9O9u6?=
 =?us-ascii?Q?2RnYhVoq/b4+vuQSXLlOVAt2V38OiL04RGF6BWVio9awgXXHoh1My4vPL4rz?=
 =?us-ascii?Q?XR0LX0X4unuOLQ8Xr8k8ycjcu3fSW1FluxuWjdzSOe3mFzgxLhil6RM6dyL0?=
 =?us-ascii?Q?Fp9ypvpYGrOG683gpLwoePjJzxmwEfVZx4+PvfBUtFOiZ0I9LT3dbsySbCgp?=
 =?us-ascii?Q?43UQhC3Z55BhlP1vnt0YNRLfUe5hn/ppFBDpBN/fDK5kg4M1UP5DRSrWolls?=
 =?us-ascii?Q?pKAL9YaDFVUSJXjRWncW0N1n?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5019a56d-ab84-4ba8-e88c-08d9573b98f5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 11:32:53.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnW9EickPrTwqa2HN7H70mfxQY07cVkgX/zdVvmNxMDG78KR2oaX80cLdve5m5KhB30nRg76aXmYxIS0i8TS7132jjQV7qDIYZZjjD4LmaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2158
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=917 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040059
X-Proofpoint-ORIG-GUID: lTbxN443ZrUVYrWb4JFDkpNunrgu58JF
X-Proofpoint-GUID: lTbxN443ZrUVYrWb4JFDkpNunrgu58JF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2021 at 07:30:22PM +0200, Martin Kaiser wrote:
>  #endif
>  
> -	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
> -	 * suspend influence */
> -	if (usb_autopm_get_interface(pusb_intf) < 0)
> -			DBG_88E("can't get autopm:\n");
> -
>  	/*  alloc dev name after read efuse. */
>  	rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
>  	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);

This patch accidentally removes the usb_autopm_get_interface() call.

regards,
dan carpenter

