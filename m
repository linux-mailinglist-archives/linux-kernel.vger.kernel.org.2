Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F73E4838
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhHIO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:58:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31608 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhHIO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:58:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179EuGFo014944;
        Mon, 9 Aug 2021 14:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=2jlBbXSHq+E+avTPv7thmxCGG9ocBZ3GoX/b6UharcM=;
 b=A5LJf2Kl1mfaY8CTO9FAJttuCqavWFuq+EgU5+vnpAwPyFJ8RqF83/OVkQgekW+GvS6w
 UNGeyF9KAANmg8z1wMmvwzZdRPz0TzZw6B0Fxy736MlsNszrCsclzIq7vF+PKkUwK7zO
 sCyW879vDaSoXg6zjlGK58MngGfj1sApu8ss3wrSQht4+W6b5026zhoOTxxml0/3f+xI
 ttD3sTuOnNeg44fCxOvf85SjBteb02opOGUjzY6qHvhuKFUU1P/IfsDkU9snm888tYd2
 iEdHAt/1d7wrggezfGYZh4w4KYZvjamCJVaiFHPyhdguYN62NB4T9RLi0EDjokON1Grh Zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=2jlBbXSHq+E+avTPv7thmxCGG9ocBZ3GoX/b6UharcM=;
 b=sQwFK4FvkdaDtiVMzsJNaAQmYjGUJI80TfttrVoFTFS04WDJFdxUDoff/1HuDYVdtOd+
 C/3yNByLX92z4tDavGyUUOazboxrBDxXTMh1KbUAQiNLhRD1Q71HR3XxCNaCiWuxmtup
 d1+JKIjIJgvSUcDfWqHcEe/T3Y2W9gaIrSRGqT8F0xvZokuqX1+JOE02s2kS5KBE9SC+
 j+ImSFyN9yuKsclAAv7dozxOOunD79wqprN+/UExs5jOkDpREGZweR5bLMYGMolcwl53
 dLjo52M5BVZCQMWvgMf19IEkY9T0v0y7gRhtTWuxiAr1wodjmpLq5Fzj19rQoyXlhhNO JA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaq8a9h87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:57:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179Eu3D3162203;
        Mon, 9 Aug 2021 14:57:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3020.oracle.com with ESMTP id 3aa3xrebp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 14:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InCSUuchS8OQD7TFgFWV5y21cEMND2bQ+VIRAEh6k2DFqOFLPLZWp6qhtZpT3fbDuILxzQQ7RlXZC69Ct2KntLw/es7BAcVoIxDJ0v4rWzFL0HM9OZHmmDDjWTu7TG/6XuxMielbmLaP4iWdSGEfnvKIjZRKaI0s7IIJR1CIFWbw+ThVO6d6kd35uN1JJzbBsoX6UmehIewLdH4WIkBSVPz3qnLtc5YrjiZdBWvJf1ftUWUAFrtPkYOn0tPiGPS/3Mc+O64B0I2SKNPXCirgfRZ4jEwo6hH8K+jaAwEoN92L2NuLM1tuZUEvPEDn1r8wQx70PdgRuqrwCoExVz206g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jlBbXSHq+E+avTPv7thmxCGG9ocBZ3GoX/b6UharcM=;
 b=fLnVnxdjyQe1DPiCM5PMnURFlhCyOqsptMepRW/GEiEvTs2alJuWFEDIfsTEeGkibV/lhbwUX3paR/KYeCAfYSgvBkKadNMWmkO78NSZofYfHdeY4Srt1u6YVkMDu21VXQe87XccNJxeWLW8O7J4q8ZxJIPWGOVnw7+nKFYQ7GMT7oVdv1wb9amwLNeIrjj3QB2wxFbhvgCBpHBuO3jzXQTbGGgAq4LSOwsWzFb4fCljOh9rQO/s3TDRVuPDngAQPxN9P5wd4k6wg0adIj3k54iKnrhvtkuuBhYnMx4F9FUD77em7SzbgV9j0H4J/5vNG8MJNa52cnkixmKQNVWYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jlBbXSHq+E+avTPv7thmxCGG9ocBZ3GoX/b6UharcM=;
 b=OVxvn306eI2SVDVNjNAcgeRL073rexVM7cCe7b4PVNB46SGTI/Iay1uaJPmwiJbsCBlB3WBdSJQfxn00O2vv0DLqWjbmQbpGwz1/yVjRcDolWokAkl99YeElx3DtqqqOIB3BMT3Npebccn538+W22rM2x+dlVyV3BW0/zHG72RQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4708.namprd10.prod.outlook.com
 (2603:10b6:303:90::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 14:57:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 14:57:42 +0000
Date:   Mon, 9 Aug 2021 17:57:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] staging: r8188eu: remove unnecessary parentheses
 in core/rtw_p2p.c
Message-ID: <20210809145722.GS1931@kadam>
References: <20210807101119.16085-1-straube.linux@gmail.com>
 <20210807101119.16085-8-straube.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807101119.16085-8-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0011.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 14:57:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55916e27-067f-4c4e-cafa-08d95b4609fe
X-MS-TrafficTypeDiagnostic: CO1PR10MB4708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB47085172B504AECEE3C575118EF69@CO1PR10MB4708.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZF9pn9z2cJYxV0t9GGDSSq4jFyjPYEZaUeACDRE7q6VqEcr8Z6tvr/og2FgnDRxUWpwhsVG9SRZGlUSUQl99VI6yXfhOnTZE7Sqx2/ADMcyM0dFCIe8z8FgVXjJd10UvVxR263Jxpoa9SNwsGpk6SzczD7WfajlJBTm0BlI/olPQY/jK73EwVbMOJutdGqwYEz5iAybEDPPJUpnlN42PUX/X7N+b8epxzz0ClponApnIlmVLFVW+uq1BXvMW1lGodgb0EK3eHoRXNvJDUi/Sh2tyNbgFxPdLNnxy8Gt4ok8l5+jTGDhZrqr8tIhjz1al9mbagnSoucz7Up4ohdIf4Emj5V4L+invJ3smuxCyiU8uPVk0vPdsGASYufk5dGwtISvGhMlxgDw1o1T1M88ip3c8anRKrq0u7W2d+keeudPN8o3jQgXVwbgeBsNVKI4BZjpl3jqexvfyNIZGPTgvReY/kiR8e6T+8pJuzKZQGoWBDqxjKUmDHEJJaWyxFWYXDb6wdAssdbERETcfm7IuPBA6pU+NOGzM1G81LzxsUqIyab+gc+u+QWVz4MHVW9w79D2EUZHTyezecGJ54WxzY3Mi9iBVVnc7aq0uaQiFs1qtCpmIpmF9yMiiIqGp8mu7Hg42tryFQE4nvLgBSbk91JUutkgt8A5nf+kxQYIzeTrRXPNPIOMY7EpeqtWRbehULYSBDzHSujGU1+lOYtK6VFZbETmwZIF98NfNl+I54THSZqSCp36FJsxe/+mxUcx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(66946007)(66476007)(66556008)(956004)(33656002)(9686003)(52116002)(1076003)(8936002)(86362001)(6496006)(26005)(5660300002)(44832011)(8676002)(2906002)(186003)(55016002)(508600001)(9576002)(38100700002)(316002)(4326008)(6916009)(6666004)(38350700002)(70780200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ACktZrdV2NN1YqJv3HJORYy/6VLw7TCd3cSUaKRpy4xqn/7L6E87Ew5dJ0fX?=
 =?us-ascii?Q?M7Pcsm+bauZbVJ6TgUkVffF9mAH4D7/3nkvH55S04C85kCJVxakWNiL2QHb1?=
 =?us-ascii?Q?9hoPbI/ycdWDyI4MAN5aaaTXhgT8LjOZXh3LoCnv8jvjmV3zjjok/qtIrnKt?=
 =?us-ascii?Q?fA9HAblUjcjvwuXZUGXpVAqH094BcJmE51tnOkLcRhqEWVVW1R1EZg7v4jbv?=
 =?us-ascii?Q?Csll+e9VnW3TadlnJXa/hdgaKW3idbTtHx043PI1OlHJUNdPKaGIo9CKfbeg?=
 =?us-ascii?Q?dqGj55Q3WWlVP/i6iixL11Ufdgm4kYR7ttyNdDNuDibEv6h57n+/C34nteM3?=
 =?us-ascii?Q?dxFFaebk310WNEBmrAPxrbLfH56IGfY01FzMVhF21ZFgx40fyZzoRziF8/ke?=
 =?us-ascii?Q?INZOAJ8+/Kx3ydr4lQ2XZBoCVo8fuhZ3EVqsbZlUTrAuvn3Z1/yzpubxPFHQ?=
 =?us-ascii?Q?Gl77l7nhtyLFiOTLOHmvjTTyxGWdFHEGPeYYc09bUdKoGKDZarG+DLWFwDMJ?=
 =?us-ascii?Q?iEh6MP3/1quZ4nhTnHI+eo7QBHszefEV+YZGm8oOU5mLgNRGzslp/URctFnp?=
 =?us-ascii?Q?YZxX6gTDHkhRajOPPxejmp1W25W7sW1joSRMvEDaHNu81tL4ZPlqeF1BsZCM?=
 =?us-ascii?Q?jXV4BPsIlYMd6YfVZic+hbZPf9j4Gr3Q+C6o9dDiZzHQmsMnYMjXu69YeTe3?=
 =?us-ascii?Q?RGWJ1Tn9Q9QXHYhC94c61J0sLBntZxhXTVQsAPcsmC8hs6pHdWUmaR7ZxL+9?=
 =?us-ascii?Q?L1lGc9JjD2t5wrLeGFpHHgOIAETE3zaGwGiytJJ7gxgPLwO6X0EHa4QnDiF9?=
 =?us-ascii?Q?HpUXeYlFzwboBdnDLjE2UEm7+GdcH3LVPYT79X4ZdrJ0rGHOhWapKLa1Sh5p?=
 =?us-ascii?Q?1/ag1WGc2iZR9jvGRi5FRqXu0VJVYRCyWf/9q+sMVdES6UC+DijBbDrHd73u?=
 =?us-ascii?Q?ZQc+R/5Z1N4Izo0XE+lSHEyq4ihAnQoG9TI1l4ZAzxjkE9WfOnw/kxKOB2Go?=
 =?us-ascii?Q?FYHkANeSaBRiikiPhWDxxsEyO+tEXIsHg2G2OonDXAnYfoMI1mycmiHOUqM7?=
 =?us-ascii?Q?w1mxEdovRfJ6mfSISWR3NILGLu1igK5oOvItuDPvCAI+qdRvCxt0KCtZ5uiy?=
 =?us-ascii?Q?tCi3xABHzAMSTOGVLQKrQADqR1B002rWJ5dA+Pzx6wd8C2uxFmjdHezP75NO?=
 =?us-ascii?Q?147b3zjnCEtLrKujOFOoOOkewpYYjxnZd0gbieI5ixoF3hKlL/WvjTCpZl5t?=
 =?us-ascii?Q?9CalqJ18uPNX/16Nka1RRfqOb4Uc0yL94lTj6SxPDTALnFYIz0u6waYb+dyJ?=
 =?us-ascii?Q?JbORytjkJPQ6uyzfkoLIyAIL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55916e27-067f-4c4e-cafa-08d95b4609fe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 14:57:42.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NP2/umW8frjF9h+7ti3vnmV45giO1xEvjMqWBGe/FAitjgZ5Who26wL7As/tZb/c+xa3qwsGbUD123nbuVcj/K0CvPYLHus7ajUeH6DtjTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4708
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090110
X-Proofpoint-ORIG-GUID: enfj_NddC-A_Ze93gK9Se4T950I1qn-k
X-Proofpoint-GUID: enfj_NddC-A_Ze93gK9Se4T950I1qn-k
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021 at 12:11:09PM +0200, Michael Straube wrote:
> @@ -155,10 +155,10 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
>  	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
>  
>  	/* Build P2P action frame header */
> -	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &(pattrib->pktlen));
> -	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &(pattrib->pktlen));
> -	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &(pattrib->pktlen));
> -	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &(pattrib->pktlen));
> +	pframe = rtw_set_fixed_ie(pframe, 1, &(category), &pattrib->pktlen);
> +	pframe = rtw_set_fixed_ie(pframe, 4, (unsigned char *)&(p2poui), &pattrib->pktlen);
> +	pframe = rtw_set_fixed_ie(pframe, 1, &(oui_subtype), &pattrib->pktlen);
> +	pframe = rtw_set_fixed_ie(pframe, 1, &(dialogToken), &pattrib->pktlen);

Same thing as the earlier patch.  Only the fourth parameter is fixed and
not the others.

regards,
dan carpenter

