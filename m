Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4E4300C1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbhJPHOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:14:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30068 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236688AbhJPHOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:14:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19G5Dvgd014135;
        Sat, 16 Oct 2021 07:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=78Jui36kFTiql70oTZzMQWTGNpwgkU1D99HDbetY43Q=;
 b=JKugFlvDczidZYroq3wUO+BvF31iceiRCQEtVsoKZ2jDXarHzcT3MS2GgOoc1nnqdnDQ
 F4tZ9/LGbTEfsJ6i5vgasb/hG5lEBDTwrp44XXhfQWsz55RO5wtVhTh08npaljkWVFon
 8iiNfPCUSiWgrYDoM5Mn9r2FNTE4QnVkAjKx6goO+oQkjhxfNkKhLwv+cFOGzp7+O7s3
 kftjo9YI7wBnlZyHLxYaam4053srjmHiHi3Stx2wzIJ/XVjVR+LbUbT9bkXU6mHRPCTn
 dRMP81FnCMOgk8XgIA0NDHrRbq9TbQmMXP5lc8gf9Hhp5/EwQPRpuyVOLcT8kmD8UfCx cQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bqqmar6wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 07:12:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19G6uZtN151739;
        Sat, 16 Oct 2021 07:12:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 3bqmsaygn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 07:12:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKpXguMst7F9NVRsyfA4+ZyIAYsETRRWk38INSYky7mV23JOMpAgql+7qB6kcfMV71qs8xacXq/6X+ptt5W3x9M2/rPWYx3697Dd4CTXaWipsi75GX3UIuh32cFCAi7XxIfTFgz8lYCc7Orfx1h5beFLBAOYuRXYqYV7OXi6O9MS6mPydCD/yLqJ4GJyY8Q/Yv1b9WPOcqUk7NpR3il5KGlDzsGO6chtU49uUy8Z4cWF/bpo70Vep+Wm0WmTZ37Dxy8vE8jAC5C6b4Z99B8Age1MPhkpD11byhkQgHK4/+TZJrPDU6y+d1oOD0FePTTqPI+lx7PNHxLW5sHpF2VZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78Jui36kFTiql70oTZzMQWTGNpwgkU1D99HDbetY43Q=;
 b=nmeiA8Z5+nI8d5YD3vbxCPzX+0/ZbOlgpCjlvnTY/9LIbUniLJk/VNJW2cKIWwqnxIUseBypSXVVMRtw7RoK+QZb8VyLmDanKHTNsokkblHSYwvrbtQfXQEaJrAxh0ge03dkQAQaqqhQhdvj1nI9EUoKzwBUZSX2+Ek3Zlc7ICaNFpZKTQ4c1R5I77PA71adc8tcOcyuUmmDfmYg11AldFrtb2zzPjZ/lB6VqjJq0g7KjHD6XSRp+2faHWUbM87jhpIVvcT5BQjMtDZbae2jagaho2IBV9E+/x7huo2qA7Ut6Ygpv1EOFWCDQ4IQsOn1wrGObbb1BM+VsDFRDozQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78Jui36kFTiql70oTZzMQWTGNpwgkU1D99HDbetY43Q=;
 b=ghEfFiyqNye76x+ZeI6mEdfT8/BdMPprPVOhAvTyeDhdRjCubgI81/Q1n99C5kPJQ3uYJMyhLshVvesMcVW5Vr2ZZEmVgSW6FBUOm7Re5eBqj6evrdMNcGGUz8flYv2jrqX0pQtijwVN48sADL2NG6NQWvz6v5YmhIB4nVrMHkY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1424.namprd10.prod.outlook.com
 (2603:10b6:300:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Sat, 16 Oct
 2021 07:12:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4608.018; Sat, 16 Oct 2021
 07:12:20 +0000
Date:   Sat, 16 Oct 2021 10:12:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] staging: r8188eu: Use completions instead of
 semaphores
Message-ID: <20211016071201.GU8429@kadam>
References: <20211015110238.1819-1-fmdefrancesco@gmail.com>
 <2060953.sJFZD89sIB@localhost.localdomain>
 <20211015125020.GS8429@kadam>
 <2097763.mHcV3lrXRZ@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2097763.mHcV3lrXRZ@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNXP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Sat, 16 Oct 2021 07:12:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61cf0ac7-1682-437d-5c49-08d990744b07
X-MS-TrafficTypeDiagnostic: MWHPR10MB1424:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1424753AE8D90733CCC066768EBA9@MWHPR10MB1424.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1YOD37MixXQ2JV1rGW0DYynC/6AkpeVv2c8qPM+1sb4Z/4T7xUuJDGAEsAETtfodQGsT0Oi2WaE54aqSruyV+rySyVTN5xZVPjrwnqmtR9rIs02KFaOI9yp4gpWwpLM6W4XmnJbUiArpp3+6gw9SlFwS6HmQoHlEVXTRwoZtUSaytXd31AVOCeNZJ0oSl0voL5T6daC0bnHTslr6PDJSAJpVZ46O7RAZJ/cIqDaKoTqPcJMcrm3ifHmrLajq4ajKve6T2aSS9KFbPAiDa737sibmH/9Vsm4hgPcF7RV/+GDj9MlzgALUqBGP1RDDwOwSoDiSiXc9f7OgSZrYyUKAD2FWLdvvEYQM5LdDOoLsfbXTRD/+Tvhlqsn1iRO2ZuGTwZeSQMMNdqhgwR7z0bp8qjZPYrjSJlSSJaFw/REvL5a/i8/LbWMIgBC3C8vmp25mQXhTt8M6o/XybxSH43xXnKGncwXP8faypxef0Zxt9iUS3GrCduzbOe5KgSGDbKQ6SwfNRIxq6G1uRjVIPyDIeYK2T8/QvRYst2Xp5iQDp9bsJLJHJ0zPWsIzNxNlQG/tpNI5b9d4HQgSC60MuYfqvayoQ7yRODozWHL4+jKz8+FPHUJv3esoIC4g0TxMTEnlLLiKp74WeiGIp6QJGssAC5vTZ9HOuloKbJPSW+pPw6dd2FSGYdIsp1tCHvpvaVHjxOjsUI1RtgiSGydTBezzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66476007)(4744005)(956004)(508600001)(66946007)(33716001)(55016002)(316002)(8936002)(54906003)(6916009)(4326008)(52116002)(5660300002)(86362001)(8676002)(9686003)(33656002)(26005)(38100700002)(38350700002)(6666004)(83380400001)(2906002)(6496006)(44832011)(9576002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D45+WdX3p3njkMiT6LZmmLeDUp4Ui+QbA1ouXWok++tUyaPwaaiNUYQG7fl9?=
 =?us-ascii?Q?CaZubd2LIEYl5Mzkb7eHATSUJujO6w3Qgss8B0+qPtp7gqaRXuprBet+wt2O?=
 =?us-ascii?Q?+EHyAdrUp5XSmKf/n0fl75oaEf+esOK9AyS3ssR0eQcTD5REhYellNPqRzCt?=
 =?us-ascii?Q?U8PV4EVp5f1cfCe934N79G2yu62fp5/CuGg0Nj7Vn8VsXqnXUcvyI7F33ozx?=
 =?us-ascii?Q?aZsOmaH+fWhm8Mr0+55ELcf7P3kTv/D9CLl/YuMX3dc/0PxdN0zYYBZqA2z1?=
 =?us-ascii?Q?yxBYjmmERspjnex03hfIiWjVOWr+a3/iig5XRgUsPZs8R6X5JqSYSQqZDj1W?=
 =?us-ascii?Q?Pu5iMaPk/4tmEVm/mJhFLb/b3wAZMrApJibgPriPXQa14Hag+t/MMi6mnTFL?=
 =?us-ascii?Q?F7dLGfIeKZDxkiqMWivwp48wuGuIRmHqKB2SVi7XWgsyCUGrTxQFTaNGIOAq?=
 =?us-ascii?Q?R1w6Ju1xqssEvqXKh+ijpXPAYRS+rW3KTUWQ67ewoDi8nEb3fS2f4+YgXuS7?=
 =?us-ascii?Q?z5+ENZx+O1KSoOF/nieqFKCUmpSroTpWT504FQrT/wXOfSUnYHO3CvkqH5sI?=
 =?us-ascii?Q?zez31Ag3EBmjMXoeEmYI1q03E7VaGatCXmoc2GdwDmU6wluVkpO1bzAuDi4V?=
 =?us-ascii?Q?22wWfYhAx6UrN1NUPgjtcdv14uE6rOSUqTZmkw/qPemdckkUiY3odj9rtcLk?=
 =?us-ascii?Q?9okIIC0TNpZl4A+Fr4ZtR+XMNARxna/gEXnxH3tUZKCk7tfpDH0bUO/gs7J9?=
 =?us-ascii?Q?L0U5ekThPyh/zZ6XlMQYLRpaDZ86UyenmE1Jh28mFehR1EmL67eVyn49UpKc?=
 =?us-ascii?Q?ds0T2XSvYfKgD0Ju5k0pB2rJByddUgjcj/OOFffsz3Pr25A8f0/3+FD82Tg6?=
 =?us-ascii?Q?pkt37s1AqBJ69igYfLMNY8J+EfQqb+mOI0zW1FhzF2r4mNSxIx9tqxKsPUit?=
 =?us-ascii?Q?yN1P2dhsGg9mah9FXCDXutuxaO15Uy3Dijy+OaO4k9FSATQm2lu+ATKDhPqK?=
 =?us-ascii?Q?Qfz0gTnq9TZU/dLiBh5h4nP78VYwcnjMt1BBudU16hZs/aOPowmhWPuWEXdS?=
 =?us-ascii?Q?nU+tXoFE3+oslYWIYFmQWxkMrUZt0Qy1uXWJ5QZkButO467SAin9I8pCZuwR?=
 =?us-ascii?Q?e1V5cR0t+oEYs1p0XUoUCPPuTGW9re4WmmKxCtAPtz5gK5x1f6WlyXxysEV8?=
 =?us-ascii?Q?bQa7OOqhjVu9+T0citjdT+qZBovRB4JfC68WTWAKN4le5bTKR8yqd7Wu6NQ4?=
 =?us-ascii?Q?gjeRtodlDfwDtB2q8c0MlE+W+HEh0AAM5NYe0w8qIBB41qdS0zYYYJ/xrt2i?=
 =?us-ascii?Q?sOmsCo0VS/ryCINV77Eph3ro?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cf0ac7-1682-437d-5c49-08d990744b07
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2021 07:12:20.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/LMcBFCAIJPPp5mQXzcujY9eWG3gDV5J6sNFk1INXMA0BdffpYWufu1Je7gg0UNiG/jT5byqtTXH1TgDB0Yj92/iHBSDuqvYn4wTDzfbgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1424
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10138 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=823 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110160046
X-Proofpoint-ORIG-GUID: dULyLSWmJM2zouNY7LdYtO45RN-wwGww
X-Proofpoint-GUID: dULyLSWmJM2zouNY7LdYtO45RN-wwGww
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 08:43:32AM +0200, Fabio M. De Francesco wrote:
> 2) The second semaphore came to my attention while working on the first and 
> trying to understand what rtw_cmd_thread() is meant for. It is there for very 
> different reasons. There is only one relation between them, that is that they 
> are used into the same function. Nothing else.
> 
> So I prefer to write a second commit message (in patch 2/3) that explains 
> what the semaphore does and why it is better to replace it with a condition 
> variable. Obviously, this "why are you changing it?" has a different answer 
> with respect of what I say in patch 1/3.
> 

I don't think you're correct, but I will wait for you patch and look
again.

regards,
dan carpenter

