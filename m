Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D95331439A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 00:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBHXSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 18:18:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30066 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229615AbhBHXSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:18:37 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118N5acK005397;
        Mon, 8 Feb 2021 15:17:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gR+zmlX5ByxOGT/r5cesQRTXdyT+rILMOthqsowLsaM=;
 b=mdO6f5dvTId5XwXDN4g5Ooxaj1ZPnr/na4EObQKar8/L2of0+SHofHplE0DhfX8De0fV
 UlihFdqjoh2QJFAhBZNhhPWbmLEO8P++po0fiEkJoctQbCaSx+nvHhDSKx8afjZM03Sr
 O+bgg390aTNLAJc8axAKm4jN4u1bQ9i1I4U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36jc1ufq3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 15:17:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 15:17:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7OtdSpJEq8XWJ2iNjOrvn5LqXH9TpbvBz9PFS+3o12r7lc9OGLcLS99EohNwDG92JW/zibwddkG/tSE6+hIG/dsYHXutuLS22JQTgOsgEEY4IfMYtvlKS+zL0RGFL2bdgfQ8CFDk4cg4EFvNG7sNB9rEYJzE0nlYgN6E1otyDNlCh2qchVM8n+DNuonr/p6yr3EyJ7NivwzsuBPjXxB3cd1wisSIyo87mLWR+bV19RmCH+zp4t6+tuznlCTD/M+ihYESG7hCdbLstkuAWlnEk/spf3icGqYmIsiGGt/TKHP+vaTLij6RecWXhsn7g/5pPRu5xOUbNRU8+FF6quGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR+zmlX5ByxOGT/r5cesQRTXdyT+rILMOthqsowLsaM=;
 b=dBEWaqyIugRS6ozvAwNuIhLg3bls3whYhW73PXIb2fsz2ca4wvcya0RCAPgsz4ewZccDhZsKdAPPJeplCzeSy43/C4rtyHum5s6rVoUjLKc5Z2Usym6iI0zndFx6ZcLcLFOI/U4Eynq6mQpsFrfV3bmFiCP3jAe3WiirrfMiybAX+wLSBG9XRv/WkfYyauMtwUT0ACqK8DIEnJJ0qV7FPfAB4CWLIA64ubml66GxA2TloWx4ZlXj7gNsu5utXxcU27IV/Odh1wN+lP1DXzwcYQR3JShZTm+0vyAn1RNYjjr18Q1tcr8QS2U/vXkS5HrBLM8kYCLvaRo8P37CBvkAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gR+zmlX5ByxOGT/r5cesQRTXdyT+rILMOthqsowLsaM=;
 b=ZPt1f91xn0v784GVRpNhkuiK7Ri6rYIPpA7T218TaawB/oLe+pdcWeAiFADtEuQnnwpWbwUBUc3Ooi74MqwAMcfrcGd/p9ugChoHpaESXkT3M9GkCVe+7s0AXpMjRnPYncrD+rjEOSHd8H86fUToCkHbjJ3p7T7sVPwRKjXxSQY=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com (2603:10b6:805:5::14)
 by SN6PR15MB2416.namprd15.prod.outlook.com (2603:10b6:805:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Mon, 8 Feb
 2021 23:17:42 +0000
Received: from SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::55b5:af77:c6ca:96ca]) by SN6PR1501MB2126.namprd15.prod.outlook.com
 ([fe80::55b5:af77:c6ca:96ca%3]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 23:17:42 +0000
Date:   Mon, 8 Feb 2021 15:17:34 -0800
From:   Saravanan D <saravanand@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, <tj@kernel.org>,
        <x86@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-mm@kvack.org>, <songliubraving@fb.com>, <tj@kernel.org>
Subject: Re: [PATCH V6] x86/mm: Tracking linear mapping split events
Message-ID: <20210208231734.3i2moh7q3gbchwsn@devvm1945.atn0.facebook.com>
References: <20210128212048.oopcyfdf4j2lc663@devvm1945.atn0.facebook.com>
 <20210128233430.1460964-1-saravanand@fb.com>
 <YBRhkSIuNvkrZo5o@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBRhkSIuNvkrZo5o@cmpxchg.org>
X-Originating-IP: [2620:10d:c090:400::5:6c3d]
X-ClientProxiedBy: MW2PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:907:1::48) To SN6PR1501MB2126.namprd15.prod.outlook.com
 (2603:10b6:805:5::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from devvm1945.atn0.facebook.com (2620:10d:c090:400::5:6c3d) by MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Mon, 8 Feb 2021 23:17:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11b9a77e-8d17-4ed2-c23c-08d8cc87bc22
X-MS-TrafficTypeDiagnostic: SN6PR15MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB241624365211C0A40D7B8076A28F9@SN6PR15MB2416.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qw5imN8foChVi33jlvJxpRTEXRYOe30TZZNRh3t/BrXpCl6H3/5pPfDZ934knPxOLLu9xSMN84G6R+Mxc/3okV/6pUDrSVJbFkK2rfElbrllevXXmKtZo8Dri6xMYPWvW69EqOsj8wJGv3ZPQhcexuSy/Ple8uUFPbkduxRRLXco/ku4KF/t5pS2/lqc7IpHAAwS1zH7mkRRzA86PRYUQNnhWKNTQlugis64QP6fWeT4B/CkuL+KznTnl25r5UCzU/h+Q1fm7dTWfXhOTeI8mW6BC0ixzjPKT+V4EBUYcmbsue72rIC6tE2t8k2qTEqZfL5k0hBUXg3OyhGUF5D63OH3/zpMI0Y/FePFpSG9HdrYSlfk0PETWfC/5yL+GBI6XHwJjIkWRP6gKYwvVWncbvN4wg8B6SztKk5IqoF8WDGIBIZ64f37z/q7DAAg6IBSmzXOAwf5Xu0RUvECFpLr1Nem8OLh5DAggP6z6bfC9RSV/Z7OFVK8X31fSqnb4YpGU7l2+KFO+rIWYQ7fslmkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2126.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(136003)(366004)(396003)(6666004)(66946007)(55016002)(66476007)(5660300002)(9686003)(186003)(478600001)(66556008)(316002)(7696005)(86362001)(558084003)(6506007)(1076003)(16526019)(8936002)(4326008)(2906002)(8676002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AGMeodfFYNnjkfZq5P3u0qncDAiV4GCyQZxuMXKByZCdAtAU6g8cArqTYqpQ?=
 =?us-ascii?Q?dO7ipeZ3AhOWwPclJlgcic6usftDI3DNOHj+dPak3d5au+be2Mk1E+x35GQf?=
 =?us-ascii?Q?zWBE/d5kCNJDdCuOJyUTwbg9Ngqk02iDGeo4b/PZOUEooisStG3gK9rDQU3j?=
 =?us-ascii?Q?7JMXiqt0cWQYfCImfl04VvYw0E7N75y6DKgHT/mvfySeZ42gxGi62CaaDtN7?=
 =?us-ascii?Q?Ja/JLO0KdlLhuA+qgueP5BNMifjIQmX3ouOxa9MwpYOqzchpyMxKwOdQkr68?=
 =?us-ascii?Q?sloxmd4uiK8qKCevitZCc372MOk1LtBvehKmfhPCioB7Cec03C932haFrvE2?=
 =?us-ascii?Q?60AKA56uWByezLz2rZ4h9LK4sznyXY7ao0KSRYr756E96mjpn+ErO/4iOtwc?=
 =?us-ascii?Q?zxd9wMvYGxoOURVERZvutkVMkc4lmd/4msf6//bzeS8x7wuymjM8eHMJgyP+?=
 =?us-ascii?Q?GNH3B5eby3bx/JacrUFkNiR2XZGBau8J49wgBEizzXcSUVEb8CQwto7Aa/2a?=
 =?us-ascii?Q?D++TIOmz4YNNWdekP1cvzm7Rkn0qQeuYqlSlZetNx8R7AFqCoyZ4GfCXspnw?=
 =?us-ascii?Q?90L2KtCJlS+o97RRaG4KihnbXSstsHvdK/w0KwFhbQ8s8Gbq3+Fhu5yi9V3w?=
 =?us-ascii?Q?hMHvF8jnqtZzB6kFVYXUuTxP3GQmci5RzOsGL1mUWoLw1WFqlRWTZgpY0V6D?=
 =?us-ascii?Q?bEcb4/L8JU/E7FCxUkRVmBYNkimOkOcUBBX2WJAkOT2jbLRS9z7TSb9/D39E?=
 =?us-ascii?Q?oV3dcLlE6oYomT7rflSBKWJffvsDzSt/A0jU9Sr8T0JHvL0oIKT/grsqn+WW?=
 =?us-ascii?Q?MkGSFufkh7iRwgfDcGAqcQ+JV2tL+o6BRsZ96kN7lplzpf3SsnOSY644w2Q/?=
 =?us-ascii?Q?FnV6eh0Md79x7UWvcjvxoZa6TvvQQNZMpNs1Rap/eibK3BI/X5UoneftyQd9?=
 =?us-ascii?Q?ZfQmWtyKH0Po+TSr8UObGoF38IrAIO3LBnrLE8XXJTzKQHMRyIIRtFmQp9Kd?=
 =?us-ascii?Q?WUjrd+ESC0Z7803aGTHIqyX1lACToYPfu0/e8RfVOalP7+hhnsYXt4xYoWn8?=
 =?us-ascii?Q?qmmEJB2NaZ7vlgEg9EMk+MLB3eYugrDUzKoVbkuBdtg3O0q3wVs4WRbyZbXe?=
 =?us-ascii?Q?fuT2RlBxE/mrahHel6QAOGddXcP4kGmU/n7/9/V3GIGneKrzByHR77l23uyp?=
 =?us-ascii?Q?kzIizOqGO9ItC8MQiCaJrXIjVRHH1M0d+AzAPDaBaUL+RQhnM6K0E5QHt5DT?=
 =?us-ascii?Q?QKZ98WR7LUQ6W35SxmzrN+S+rfM2X5OuUrp/x9t6gFlnCTPU9mCvhEb/oJbN?=
 =?us-ascii?Q?OlvOO0b0A+SZLyo0dIyg8ety9g7ZJvTiwSG1FuL9zGk6mhdqI+p7pafOEVEX?=
 =?us-ascii?Q?AzKdQ6A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b9a77e-8d17-4ed2-c23c-08d8cc87bc22
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2126.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 23:17:42.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptAiGeZGHgr6C7tfX3pRQixXRIcPrTwv6MbUd5CyRmwt8IijOk7NbvmcJq0hK/l4UfIV/nUUru5+CRW1gpWtiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2416
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_16:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=986
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

So far I have received two acks for V6 version of my patch

> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Are there any more objections ?

Thanks,
Saravanan D
