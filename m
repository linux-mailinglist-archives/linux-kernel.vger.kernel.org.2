Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F5844410C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhKCMIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:08:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65464 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229998AbhKCMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:08:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A3BOVNH016743;
        Wed, 3 Nov 2021 12:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xetH0H3j62sxnxYDqjFz7xYsfvZgswbQdhOS8V5LQYI=;
 b=vjjBpfU5Sk17r1WZEHux9HSdvEz3/04O9J4YfKLs5Np4FQlw9ttB95qf+n7mkIzYs5iq
 c2EvVjeMylZTT8rXkQ4HAB1fFQbQDVl/mxssVbQGGv+76VW1nAfPFeK9ArwJl/lZHIgr
 h81fAUC772RN6MrtEH0Gk9NrF1towBheMj3cew+Vr4CgueXPcJFc2gXhDRUdPI3x7SQM
 63aUzghoI7mKRv3GD+qK+lqTynTCZa0XxzCSRJhRPz0Ebnz8h1juy0tLI/K6Yj5+JJfP
 t+gy3c/SfRfvdeIj8nP0IWiOpU4u765s03rLwF9Y44AWmaTMtQv2lMoFKWBdROTn88zW 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3q1n8yx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 12:05:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A3C0KA7173169;
        Wed, 3 Nov 2021 12:05:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by userp3020.oracle.com with ESMTP id 3c1khve83y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Nov 2021 12:05:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwC3b0D+e1+/CWBJMYZKsppfpp6y6eDacY2qBbai18jX2sr+pGFDByOfnM6dCe8z62uZu1DBTHMSAd+my5RzyCKENEo3Z4AD+4wAxrQEM5F+fsAFRVX6/mlxZXdGJNHRc11jJYuA8vsEokhlIi4bgkAFMCF/izvIIsWBD+nx3YK8sYNr0wRBLn5BB8GaISR5Iyv2c95NYMKGPINIImAhPl4ds59scAXqPhp94ZwGS4qC7dVPCys8JgGVZhyLbmYmV1nWS0S/oVlncEDknc8ufhWcQntuMFZQhy74mG2EdyAP5UwoauLRuv4NFp9u4dpI9RgfZj+t2VEU6xriSy9+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xetH0H3j62sxnxYDqjFz7xYsfvZgswbQdhOS8V5LQYI=;
 b=ZlnObURGwehKGurLY6KqVr2RhTX6ZlKMH+/5czU+KUg9w3I7xjw69JDE4zCyVLktujKcA3hcGfpRqZEYWlR8xxabI3SnCcEgX/sO8Q6R6eXeh/eOMV5XhCr4+tIXKih+FoB2n45ukM2TSJ2o3MH3E4/Ck/RqOpp0CHgF0TRZ8LWglXc8iBuBtZZjmDCs+LMi8Yii281i3jDa7vBZ+QvGgrQUkkj/H9FWUxlELy41eZz9MIxK+uSjDmrqbLdHPnuqOxaaAj8PoSKSbMrEu60oBbw9rWlxL5CjEGL7lFUkGAd4FbyP0A+BqpLhvKukmltUqpJyjt/+N5fdem6+wS7Ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xetH0H3j62sxnxYDqjFz7xYsfvZgswbQdhOS8V5LQYI=;
 b=xE71JmB+xcoD0jRY2Q4jMTjSk1+K+O0iFfYHPNQ3mEA1Z1PzzSN5kV+OE7ZJEInK5zrVKt01IXHAPn9y/QxmENgfIC+xD0CC38tavn2fE2VUunt5fA75Mu/5zF46SvmS5QTQpHvFGiFkm3dwh5Gr7U5WQAQWRPkynjUvo5EVu7E=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5679.namprd10.prod.outlook.com
 (2603:10b6:303:18d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 12:05:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 12:05:27 +0000
Date:   Wed, 3 Nov 2021 15:04:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kushal Kothari <kushalkothari285@gmail.com>
Cc:     gregkh@linuxfoundation.org, kush19992810@gmail.com,
        outreachy-kernel@googlegroups.com, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, fmdefrancesco@gmail.com,
        marcocesati@gmail.com, straube.linux@gmail.com,
        philippesdixon@gmail.com, manuelpalenzuelamerino@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        mike.rapoport@gmail.com, kushalkotharitest@googlegroups.com
Subject: Re: [PATCH v4 3/4] staging: rtl8723bs: core: Remove unnecessary
 space after a cast
Message-ID: <20211103120448.GS2794@kadam>
References: <cover.1634967010.git.kushalkothari285@gmail.com>
 <baa1703e0c202dfb90e215b63b535161bd3ccccb.1634967010.git.kushalkothari285@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa1703e0c202dfb90e215b63b535161bd3ccccb.1634967010.git.kushalkothari285@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0051.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0051.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29 via Frontend Transport; Wed, 3 Nov 2021 12:05:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f94e2c41-3a2b-4684-88d7-08d99ec238ff
X-MS-TrafficTypeDiagnostic: MW4PR10MB5679:
X-Microsoft-Antispam-PRVS: <MW4PR10MB567939DE022878D3CA51C1BF8E8C9@MW4PR10MB5679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlc2Q1OW9JEGqeAZWzwYaGSOqfN57vZ4mwiRWu+lw3ilyD/O6f7vW2uKW9gtcl+KyCkhnQbguk9GcOsS4NJ9nbTc8gqwzn0xwaWx/qjWn2MgVe5/0FsifP/62RJxqfc2Div9wuQT28qudbGrwa5Z0oLlO8/UVXZxwPLiuN57IrDKtleDE/FaHDmej6qP3NUXDuK2n9bYWm+Vdj5ywI03wDNHyBa4tsavQTqazIKegGglcgpts93b/C6XOSMNqIqO2X1xMi6KnA6zDc4BK0sQ1azH4gAt8i2w+54UVjN/9jHMHg/mZF8gKhGcrlZgMqBeURdJXfSNgHinJmGqhKl1PUCTJ6ba5/xdKh+dArQuUEQx6vQ9u8x5HULPLlxhprhnnrKotDcK9g7S+yhT1ZonMHcs7Za+aznlzx0ltQR3ghzJAou1nIAAkeNb6Ijfaw7MV3xMN0TYlm2d7DeZBa5zg7UNoThq4NPZAsnKu6ce0dBwNmvjMiANEV7cCOhMRYxRMzAwfOtW1pZomnHsw6Z1cSeBWBUN/bW0mibokF7wbKaVuZ/I6OaBBz7ug4Up9A0EpXuwlhaBIiEhJ8iuMVVM6lIzszBBo75+8h9E+EAbtdVmWg8SyYE7ZRM/Q3E8o2pzbbBPB1H/owE4+T+6r84PHW1RLIp8N44nmdw3zHvi+AKL5QOnPonuPfsXlT+Pq8eessyWKL7OSuht+yOQfAqRLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(956004)(6666004)(26005)(186003)(55016002)(38350700002)(86362001)(8676002)(9686003)(316002)(1076003)(5660300002)(52116002)(6496006)(2906002)(7416002)(66556008)(33656002)(33716001)(4326008)(6916009)(38100700002)(66476007)(44832011)(8936002)(9576002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Xnebj7bk9qDzZRYokQO25J+aDGEJ4XpizPf1f8hWviN42/OIFLxX0yAXG8P?=
 =?us-ascii?Q?zqo5VGowEHdfV5zRaxfmsqTol0uyr1sWU6jPbvucXnAaXpqTQWCgNt1TwXSm?=
 =?us-ascii?Q?mgnqpt5hWV++E83YNkC0bttuBm2MmBFFLFzXmLZZerfn98cxZdYusR647VGL?=
 =?us-ascii?Q?ZoA9+/okgVW6nKn0E+wEswAwdxOQjs1ZDobvjxRrbSQjbAqcjVH/OB7bUNUq?=
 =?us-ascii?Q?nRuuDFBxzKJcafR54JYMtVkeXbm8SGYAmyqrPgkRFE1ry+8ohBE+BCHo79Es?=
 =?us-ascii?Q?t2zc5XHwayZs9DZCP1+kPFVPoqsgOkEWFDtVti83Nn1TexstsmIm1hWRam2m?=
 =?us-ascii?Q?xQipgfdK7XcjqBWhPvz5S2Wb+KyL21RbNYDHCrfyoX+LfKuo68fckqhS0N47?=
 =?us-ascii?Q?qG65jvhwf/+1KEh3Ut/LcMIQqiFIIxDo5iKAKIicYkEcKMrynJIChMegoGiI?=
 =?us-ascii?Q?6h/UmSKoLca4ZITW17x/7rGJ1tZ/k1cr35GBgwoMHGlFeU6LWXzwphkjiqfL?=
 =?us-ascii?Q?tq3Mf9yctEJ8IJ+qGvNmKY7QuTI4VziecE67Qy1G5vH/9gbhw35njRX7I8mr?=
 =?us-ascii?Q?/Yho70/6cWWOqfpxcWbqIRXGTbDDkpoRVDAQvpnb0WMh5gfwKKd1riC5jssK?=
 =?us-ascii?Q?28+FUSlDoMdpZAI2t1bJrMsCP2tcuSt/qdnj1e8d+XJUO7c1Pk4EUmHXmqBl?=
 =?us-ascii?Q?tAbVUKquximKnf6/WVrza9IDSoq02wX7gihJ3p8Wuad1YP5lgql3mWexDqlo?=
 =?us-ascii?Q?yRnafFsp+sKf/r2YoHmtkZA2OiE5/bjKhqlEzsaTlY/pFY4hMlXVWlfdicWF?=
 =?us-ascii?Q?Q2pv1RoiMTfCM5/YZYPvnK4piWkBVPKbLlVUXn5VY3fOfQnlSqePHNOxQO6Y?=
 =?us-ascii?Q?3N/qzxTPtnCeM6++ad0kxt1pVa735JCWbFBjrmbYsCkAIxxjlmA/t5pj5RFy?=
 =?us-ascii?Q?RRwrnCSfMFacSFW7MpRxUa5LskSQm1hfimIkOHaG7k77OXfrqDvYtLOeqUhK?=
 =?us-ascii?Q?dKL9SG7H6kCgIZvO0Z4DGI5glRXEwwGrh7juVcAhvMvd7V5iVKa4JCbRxyZx?=
 =?us-ascii?Q?PGvYgpanrZvfcnEMcZVb2S2KOeEvKDp55k4CaYcudJ+m5M/o8GFrQwakTZzp?=
 =?us-ascii?Q?4aEvs4YfwT+L/6GcdiLxnd9s09GaoU08/rhGV7VRCm+oetSw4SW+kGpfRT2R?=
 =?us-ascii?Q?NyO2eTjSTQ6lizImsanM09Uktt0GyVJzeP4CHc2mhIGeiVj3WiwM5MVzikLO?=
 =?us-ascii?Q?Tpjw/BqdomDLI5liqnMSwybIiXqUlUSsDMLfy9Scm5lnjIhsbYh1hQiEc9P6?=
 =?us-ascii?Q?iEBT0HlV8oCPo7bbyCFkmzRhuuLeglugKFJjYFZFRz+UYnSbeagCqzEISB6f?=
 =?us-ascii?Q?DzGDz/KJzH6J12jIDGoCWgoFsFW5+/ggsRXPVZB0R3FaMqbzdYTy8Du7gC5d?=
 =?us-ascii?Q?Oy3WO4V+/VQiI5dAizpVUgQuhKHM+DFXJ7ncThx8yifkHYCqScdG881GwnHY?=
 =?us-ascii?Q?S4BOzKKLcF5c6N3l27BU69NDdE6wKo3Og8l5ifv9miSFDdUVfAKCfDDcw1Go?=
 =?us-ascii?Q?ZIUuXtt38dHjTH4wU0rFZABdx54PnJJ9ilRIL2Uy1oxk+I6T5C22wNVENSn5?=
 =?us-ascii?Q?LX1oU54Javnf+vZG+tlyaLGJnHTlh1L/F2h+wjoncZSPE30RCuWec2QpcI7T?=
 =?us-ascii?Q?Whtx9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94e2c41-3a2b-4684-88d7-08d99ec238ff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 12:05:26.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMup3n+eTknA8NeBJP5sG7tL/T2ifmoyhUCHQ824OoR0SDFhbDcxKggRyyWeBjeZr1MfNx2TNEg44o0EgatgPX0cTfzc/mPVktMNTWOfxCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10156 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111030069
X-Proofpoint-ORIG-GUID: OG5gRwZro93kh7mE0itF_nJ6WOxh5-JO
X-Proofpoint-GUID: OG5gRwZro93kh7mE0itF_nJ6WOxh5-JO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This v4 patchset look good.  Thanks!

On Sat, Oct 23, 2021 at 01:05:49PM +0530, Kushal Kothari wrote:
> @@ -2027,7 +2027,7 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
>  {
>  
>  	struct sta_priv *pstapriv = &padapter->stapriv;
> -	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *) (pcmd->rsp);
> +	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *)(pcmd->rsp);
                                                                         ^^^^^^^^^^^
An unrelated note, if you wanted to send more patches.  These extra
parentheses could be removed.

>  	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
>  
>  	if (!psta)
> @@ -2042,7 +2042,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
>  	struct set_assocsta_parm *passocsta_parm = (struct set_assocsta_parm *)(pcmd->parmbuf);
                                                                               ^^^^^^^^^^^^^^^
Same here.

> -	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *) (pcmd->rsp);
> +	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *)(pcmd->rsp);
                                                                            ^^^^^^^^^^^^
Here.

>  	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
>  
>  	if (!psta)

regards,
dan carpenter

