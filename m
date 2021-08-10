Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDEA3E54BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 10:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhHJIHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 04:07:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34502 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230006AbhHJIHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:07:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A82Cuu019501;
        Tue, 10 Aug 2021 08:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Fg0CJNObn2V0TKYqBRK7b1hIjX7fGUSt0xfNEpEOnmI=;
 b=kgbfbSzyLSIF9PdbPkt2LyBnhX9AoiezJSTHY1/swpGiv2AhFuJpzse6eqC4KWmn1OYe
 YppPE5WmfQ6z6KRgO2Sh3hQ8XDENzXFwuqOhlMEfiSouAbPAF1Na7hHEQ31RYBXhZeet
 pj/Y2UIpcQKu9+jJS7Fly1mpRhty5MJLG/h8tnIWjd/fRxl5q9AnEHNCdCHogqyYN+Zr
 fMvGqzc0wThz0EGK6gXnIfnB850qFteZfQeqp9YUKzyQOnfiH3uTOXGsaKyMGRPcpzDC
 kNawwiyF8ELOpgqo25aq/xjnApXznMgikADbyj/qrG+PRGqFIFa8XNugXeRGLlUp9/cf Gw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=Fg0CJNObn2V0TKYqBRK7b1hIjX7fGUSt0xfNEpEOnmI=;
 b=ixsmURRD6BXFpYk86NXkMVBSpXl680lTiwUFoN3EYhgaxLz4teCk/QKwD5Xf8dj71vgu
 FSphGCEnwRimCDqnX2/Vve4XotKiZJE7bEqFZSWo7+N3vCQ8tFfvLVLT4JcJeAQv9O6S
 eJxzqwHnumrfeGm32MsCynYJjXWGZ0lrLSra0RBP/tCLx/+wSqYvpyThZI+usjZFGW2k
 G9dpZe6uzqrGSlu/jFBZgXxMVUMCcVuenrx+BkhenWZnd5PWxozc6wm30dD6XwEFHRW6
 lWPZPs/+gC9F1/iLVr6e6VXSkVMQdHKPO7s0s27lzry9m+H4Mg/aq5EN097Fdui3BSKP Qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fu0bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 08:07:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17A808Ho013408;
        Tue, 10 Aug 2021 08:07:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3020.oracle.com with ESMTP id 3aa3xsngqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 08:07:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1IG1i/yq+m7ibA19Ns4FyYDtgPDYRJhmzab1m4UxUukObHAu3mKv9URT+SSBq5wxUAk7+iVzaQ/JZVgoMSYNzMO6Fg/B8iQ2v0KlI0OSGt3SUxC7neB3SyZ9FU25wAf5+TY0iiIv1svfqzPrPjm0yF2F+9JbEOMz0fBUltqUgqJfEnzJrYlVEWqSzP6DfV7D5CjFsROLiHjlWz62RlD+VVZCyBgJO6jUPnymCfj6887t7hZjk0/zTkq8MA604NUdZkPgAVIsdmlBBVE1DiKJivhpMYs/T1xcJlpB5DjuRcbGId8dMKuqMsF43Jm3ecrX10c8m/H11iazg8wlQ7jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg0CJNObn2V0TKYqBRK7b1hIjX7fGUSt0xfNEpEOnmI=;
 b=R0gngpLi7cvb+GP2p+oRZmQmRJTZ+VVeInepFypD8DXgGPzb+32SNpxtPxg5AAaioC/52ai7Iq4mjnfe5lkgWK5hGO2bwsGyfTO25+p3Tq7XA7uUPw1Yzj5IQ2HY3i1ztV8HCgIgvXz4b3UEsZSnpBrKvx1Z/FKXjtAxYo12/q8ZD+vf5u4gCEa6C89LpUev3nSU9LeoaylQzX+LWID2m3h3ky12j8uPiy3mEQW2avS+mZZzEQoElOdAGvaZUZlrR+Y6XoD6pyVSMhSWEx+nPvmLsEwAkCzS1VlM8uDpONBaiHNZOKWzOc2q/R+EQLr8Mb5gvHtiL+4TSYyN8cxpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg0CJNObn2V0TKYqBRK7b1hIjX7fGUSt0xfNEpEOnmI=;
 b=DsPyy9Nl+G2NS/VayWjMobRifBjUpFWKQZkg/CoAJAoldqssviejxLZ9XVAw2wLZ9bH5DcrF4Hcgcy6ERqVuI/9j8jeDpSVhujD6cUhg+XEQaqdWSspJT9uOhppQw7gBThRFbhLY34HZ/nOtidkzKDsBAnisVlUT2y2JbxxL01w=
Authentication-Results: philpotter.co.uk; dkim=none (message not signed)
 header.d=none;philpotter.co.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4546.namprd10.prod.outlook.com
 (2603:10b6:303:6e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 08:07:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 08:07:03 +0000
Date:   Tue, 10 Aug 2021 11:06:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        arnd@arndb.de
Subject: Re: [PATCH] staging: r8188eu: remove rtw_ioctl function
Message-ID: <20210810080640.GV1931@kadam>
References: <20210810074504.957-1-phil@philpotter.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810074504.957-1-phil@philpotter.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0028.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 08:06:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e76f8a6-60fe-491e-28b4-08d95bd5d64e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4546EEB76E98FEDE0149F2278EF79@CO1PR10MB4546.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaE2BL+sDNXiUm/dLLYLCM0xN/8AIW8f2uDaDJNhJkLzyLN4GXrjgPFnt3FA4Db32bDZxTs36vO8Ru8SWsxiKJQ0eaYDOuf230lvbn+IIFyNid9obpYGUuUwGQUy51zsINqRnFY4AJoH9znebWEtWZmBd/8H/IS3nxjACIt2fQAsUlzlS1cakwLzuOu3qGWiWFW8ED0k+gdR8sEZ8IFrFcAUMig3kAgI+WiK+5W9OEi+8HDLgeSJpg9+5mII9iS2ru3R824TV3mgjezTydrr5PLE7G06/tsds/PRALFtmAuMssOa+zsfNsupoyPaXvfKeJufou4N54Hnm35V7AuB05ZN7dBI/yIxVLmbnEpADKb/laTlqf2QupiYy5PqtFDGtp92Xl1PrjZDGyBy+iW3Kbm/iMNQx651ZePwJkp10UQcQT8NIDd3iLmLQ+vzu9g1Yu1O70DHZhNogv1Zja+zbCU+4q04uDHnitHrcrzTubdUgr2kd1vutqHuKExLn3fSZLZvr5vijp1j72DhYIeM8UbyAzb0uGSHkq3jz9WbKCFm2CAijORy/2AnZwUDSFH261EOOWjjuvoaitAGo1LfTxqvaoVct6jyvVgpbRSHF74Jj4vSlbDG1OQwNWqoEiKTrM4LJiL2lzBoJzWSQdBhShuCmAI89Wqk3d0Of+DU/Lw2oNWfBoqqB1eu4gVmOtXGihYn5ZgSeJi6EMZjchbQbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(66946007)(5660300002)(6666004)(9686003)(4326008)(956004)(86362001)(2906002)(33656002)(44832011)(9576002)(478600001)(186003)(110136005)(558084003)(316002)(26005)(33716001)(8676002)(6496006)(66556008)(38100700002)(8936002)(1076003)(55016002)(38350700002)(52116002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pJcXlI+R7T7WUNDjfISyy5EFof39D1Jh8o7B3Swo1wRo5KPE8CP8qtMFtpS6?=
 =?us-ascii?Q?8R8VNeUCMXaUXjhRDz9Ftf0dp6JrSpb+hCcQYcOA5jyDeWtFqSmf4tlzGZAD?=
 =?us-ascii?Q?M80z6DvPfZNu17CkWZbm9cxqPLN3Xb3rrAOb3vRkaloACo9pb/Xz9y7Om1yh?=
 =?us-ascii?Q?R5Eyb8erMkICVntGoBo7pM745VCZ4zwf2mioIAUnuj2FiDnVbgy1fOb3FJGH?=
 =?us-ascii?Q?htoDucJdejVxSZ6X5DaYA9iy7pJPdoC87pyvr2Z14tuPKk24Q8qGupkrslZY?=
 =?us-ascii?Q?AgBcq6pGkFbpG/PINT4P1vltFBoYIwODYKZFULWvyeVOsdQUz70sB3Z+IN4k?=
 =?us-ascii?Q?Q3Mb53BU7Cz9VgesQ/Kmjj0H/Dfe6Y/PSQBw0hl4cSdR5HpdHDcz+baVcp/b?=
 =?us-ascii?Q?JQjZiozCiHLyAky10FIr7Ha/Jy3+ghWvekJMLdpgYlr3eLN10Ts5gs1cKSLk?=
 =?us-ascii?Q?e2oHpXwZsCrPuN4OTg8PIK7wpcmuioJoROD19NYBweR8Kqrjb0UJpIpypg7b?=
 =?us-ascii?Q?HlSLe4h09DEK48PpLj8A61Ij9PTDltQngs9tcPUwuOVTMhNLjDhGuS9UyCVE?=
 =?us-ascii?Q?NZk68xjs0l34Rs5mOhd1xZPFeT++JfIM0RV+XnQklvCQwag7PrDBLt1+UMy/?=
 =?us-ascii?Q?RRgxri4bEItyC/Bj8CrQLilFMMIf/9Y5bYTzgh13VSjm8wce/pjsyo3UAa5b?=
 =?us-ascii?Q?cTVdPn2QJIsVXpesSCRqDeTA+9R4HTWBb/xbplIidlkIukBdLIJnz7ZlNShw?=
 =?us-ascii?Q?yywQ4RZCzBUhtOMtvm5Uo3F8w6I2C6lZHr2ws+PdOjrTHMK4AAmXKoE/0NNH?=
 =?us-ascii?Q?7H8zSBv038Bd0N6Reh88zCMn1Y5nISlG8ZOJDg9YeD9Kv2lLYVeZN/4cUjr5?=
 =?us-ascii?Q?diRxSV3U1rcWt+FHz3DCDm99FbO+JbKnizI94N0uKRk/ZeHRHSkcNFgWDAse?=
 =?us-ascii?Q?5uJSHWAOODDeCfotq42sd694bt3ZRNg8o5Q/F86zaVTKpAJyGh6H2JfyDKJC?=
 =?us-ascii?Q?M8mmFj6IKuEl/gsdwKRsND5z/DY0wA4E1o/0tuOUBFL9Z8c+Ty4rw4wzbs7l?=
 =?us-ascii?Q?iZQ3jHUOW+ofPmTR4ToGjW5I8TxFiYyYVfFE+fln/gDiAYvPWgANJRm4shtZ?=
 =?us-ascii?Q?Hju05aLJcBPt56xq9ZfGKteSvsYhcbUbWv1To7ZngTULe5tvB+bpo5STOd70?=
 =?us-ascii?Q?kOnYfFeoSNdqnlZYTORLsZquyr22mBjWneJywG7RCvPNFfTLic/FMyvSifFs?=
 =?us-ascii?Q?vGCz729GhXb3C7L4JmFN/VC6laNW/06kvZwHUMyp3kKoBiqhViy/vkbAeSef?=
 =?us-ascii?Q?ZNLQWZdLdvPLNTcTsrxuE9hl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e76f8a6-60fe-491e-28b4-08d95bd5d64e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 08:07:03.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqQKVhYX+TAambN6t4VhV7j9xLKf87hw47rqXOi4nGqwqvJMOYhmuncG3nMQqTqekIoNVxgIKltwj8D795ISiJ4L03ZpN8g0xfNslsw2kV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100050
X-Proofpoint-ORIG-GUID: eiNK-uAjs--zm7h6eqU5sf1Ut3tAbbF0
X-Proofpoint-GUID: eiNK-uAjs--zm7h6eqU5sf1Ut3tAbbF0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip, Michael, and Martin,

You are all working on this this same driver.  Could you Ack each
other's patches?

regards,
dan carpenter


