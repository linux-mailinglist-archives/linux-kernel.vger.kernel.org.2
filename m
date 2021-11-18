Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2163456349
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhKRTTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:19:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45880 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231204AbhKRTTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:19:22 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIF0kBw004689;
        Thu, 18 Nov 2021 11:16:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=RR8udoL9TSy9U1H4DVd8qpYo+fUhvyfamoTxkTVwIeU=;
 b=b3QkcxnH8g+mJuBHGHhc5Mo2KfIhkMViEw69dyUeboUBTf5Zq9sDFS3krwKWMhOfKWR2
 bRIhHP02e6hvJf4CMyOGBoscZ/OqPP4pOoo5Mk2G/h4iLvvKsB/WpTl22HfFPTzf1vx+
 HChlzt1evsd8QW4/r/vvm58hXW6QgWbGggg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cds3f22n0-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 11:16:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 11:16:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKU5Fq2I43tGDjmnAOlb3IJq82TWZHb8ItcmCk1/blYE7yVG2EBq8yuiV5O7LCFsICUUq8j/ZVq+rBKEJwpga9nmkdK8t5jW/8mlFLzxQgWrkXGuwqImXLKOV2YHq2SJO59Y+DOKEmakmB+Yzn65Q8ZmOp7UpP127woFS8HrcAGOQTdECw4TCHtWk/j3FDyRdcbXSp+GHFJlpnniTZ7c7ZSLr9nS6av6pROcWLIVMM5uMloxyn2E6OSrMeEw9D0WN9NBH+a7T8PxPZfWWnBTfLA0oJV20/4YtHfN8Tu53grQuHcNcjmIB8cpolIVUotnK+rFawQWR7+z7IYPvDCtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR8udoL9TSy9U1H4DVd8qpYo+fUhvyfamoTxkTVwIeU=;
 b=lMSBJs3tu/bRQzPPY4LNrmOYFIzwU4XXZJ4/Mod0AZrbzgrFcPLsGGC43qOw9ccaXZyEmGgeOB4r8pf6og2e6yT7abuc7a+PIV0UV2raFb7sOD9nG3N+PFDnbgnAwIBfP1afvcubUJ71b5oSuhw8Ia2usRWcQ9pFwyaiVPs7g+HAuFUMrWXJGmf8r3g1KWBSRzwY3o89hin44qhfxj8gsuiOoJSqVaDAIb8hWp/MskoJqpgDcoDi1aBVltq3SW5Ovh1Iz+kDTenv28RjV2z5Lvx6jpTg7v6eF6YuTR+0hLJrCT5NXgv2kF+V1OF/6IfqgEAHcECN+lHanmwUKXYKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2662.namprd15.prod.outlook.com (2603:10b6:a03:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 19:16:10 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b%2]) with mapi id 15.20.4713.020; Thu, 18 Nov 2021
 19:16:10 +0000
Date:   Thu, 18 Nov 2021 11:16:06 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Donghai Qiao <dqiao@redhat.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <mhocko@kernel.org>,
        <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/page_counter: remove an incorrect call to
 propagate_protected_usage()
Message-ID: <YZamdpfPfw26i8sd@carbon.dhcp.thefacebook.com>
References: <20211118181125.3918222-1-dqiao@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211118181125.3918222-1-dqiao@redhat.com>
X-ClientProxiedBy: CO1PR15CA0074.namprd15.prod.outlook.com
 (2603:10b6:101:20::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2f28) by CO1PR15CA0074.namprd15.prod.outlook.com (2603:10b6:101:20::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 19:16:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dc893e7-2f53-4ff4-6847-08d9aac7e125
X-MS-TrafficTypeDiagnostic: BYAPR15MB2662:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26626F4ACDA11EB61F570CBABE9B9@BYAPR15MB2662.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EeBizogdEBpHG5Ya/aCkBtg5MEci2ta6zZcq+fYxZFw+DjZPsBITeD5Z+cVGIFqTuBKp5o7XKZx9iNuyAO8fmvfILrgXGOnqvkQ+aULbwejIAxuT2kSGJaXxA24aMsFqEYzF5n9XVV6B3t2SgbfqakDtMfWDk5ogsjXG3RqzJ/ZmVOMPioZqPapI/+8nxk7Bhtr8jMM5R4xXCKiVCL5p/7bmIFOF2jyMG3NNNGjaknTy1/PUIbqigKXsiE9GXdEh1rL4gSUMxHUL85oOK3YFXLvey0wdygovRSlZpvQiSZoqB/H/PCd4lCWOrfTaUtSGPRvyI8kq5k79qwPajUx9JGrvEMBGuOpO1JXVe6dLiOO4PG6eyPA83L6k//C2v7Hv4tMsIHQODVz1otlnX8NON+uMqBarouRp1xMKLr28jfEni/Plx9r663sEX7aWdDqfBDQO3tI92w6k406qn96dQdKIJZ3mrGHM19p8UoSSX7T3TzSFzrB9JCNLnXltU9ZS9SfLwVVXEzGlUhi0+JJ9XKkVVWZIDZhzSLiSWeHUsQOypSoUCCKoEaI1hKhb/6cXmskaG1k9Mrck4Es1EUYJYzuHfkDuDXUuP6jIvgdchVuzg+ErKtRewtOKDYhtpSxGFVyIlMfgo4Hi/dxJsZojAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(9686003)(2906002)(66556008)(5660300002)(8936002)(508600001)(4326008)(6916009)(316002)(52116002)(7696005)(4744005)(6506007)(55016002)(86362001)(6666004)(186003)(38100700002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eABLkWAg0eSt5TZf1YHuPMqv5Z+w+JGu5VAMkOtCxCtKJfpAQfBtWHYyvz4l?=
 =?us-ascii?Q?lcC791KSQQIrNr0ff3q6v9H+rwOEACzYsbowZUuXNfGqwEadCNKfeC+w5h0c?=
 =?us-ascii?Q?LnNUZP+OqVOlQg15U3PRGMosIPOHsdcNOntzU4rNnJhCbQ+9698qbQ2BbHnx?=
 =?us-ascii?Q?GPvLPTJtxBbP7FCE8n+ssWwneYN2nOMrn8RnANkW924igC31VwYb7FXHrtYf?=
 =?us-ascii?Q?ueqwN35YBNYRURnK+bG8ZSbI8unbqI+RR7FgTvnEzl6KiXRINqWpL9vqW31i?=
 =?us-ascii?Q?TXbmwpdQJBrX7KamqzLjiqDiNlXbGDDpuU9sDbtNeT0sq0SqlGVlvMgmsnjc?=
 =?us-ascii?Q?weOS3I+AV9QcpK8OXA6/7w36IGDndfoQwDQiq8vMU7vi/8dwU+ETrCvyiuOs?=
 =?us-ascii?Q?8haAcWM/DpgITcUwLdkquYhPjWycYtJP2rtjmiKdRHI7dsGIpMGnRjBMeOIu?=
 =?us-ascii?Q?mhHyz/K7g76YUa2NSj55k35eXX7iUezDT+/klNhityRJHbv8W4ereFeMWp69?=
 =?us-ascii?Q?66nIUQqeX5uTGesYr6egtYVCgzPiwE+67X3OqNaZcniRQjiBEM7VYN3g5mTy?=
 =?us-ascii?Q?T67HS/zXU4J2U60DkB1L1FcZQzkGpvoOZghY9sDieUJcOkvY4RohqHkG+EVk?=
 =?us-ascii?Q?2VlC80AaKXz7ALu6LgNZMJqs22XHFgDy5LnMux1VRVYJvKj+834bz2725jTg?=
 =?us-ascii?Q?MI3DPjbDYNTutGdwwHdJtHyP894V1f7PHEvhVFTP2X9ZFScbNuZEO0TAwBzi?=
 =?us-ascii?Q?uaO7pPJFFHa/w3BMNoaJFGGR+G9/xz48wSy2irF3fxQfzoGTKiFVtbGFvAc3?=
 =?us-ascii?Q?wXqAq8mUO1HwDzC6i5dWES74l19q7aMCoRtKuJv9tdb0Q2lJTXCIOeBgP+it?=
 =?us-ascii?Q?KFSfFFQmypJmlSMOs0E8MRAXMTfeC5/s0BdsotfwGy0nLEjDzEDv1tMmW8gL?=
 =?us-ascii?Q?uXEXPQayMB83Ga8V9/paeJoxjaHCLYZI3QB8+KEn34G6jaWMWNya39asATtb?=
 =?us-ascii?Q?qOmFuyPJhQDDxZBHjnb/GAEHNHCYWIoEvLegt25TlH21Q4eqALK1QDGK7/UP?=
 =?us-ascii?Q?BmI9sQkJJC+vRgG2XbJru+YxJMuMfPOYMcYCv3rrAdTztXo8UoCXDHeEsKxw?=
 =?us-ascii?Q?tPUZzYHDgFUZvxyKRHJL2DdN6L7uZXMIecP2mRyTcY39hefat6atv/+v/U7j?=
 =?us-ascii?Q?bpwxFKWqOHnxGUj65zEP6vowS7IyyRo9jgwcR3bEL61hoJqXeq/thcASwhD/?=
 =?us-ascii?Q?83XWgVVzU99Wk7jzXfP59OoWk8ZaC3+rYvfsANbZhldy1MmjJBE6vNXotFJ+?=
 =?us-ascii?Q?icEeaVGR4hMBNxo4+ccXqRj4cSF8Qj36yjuLaHJwjYbzUk2i8N8PS9m8W63N?=
 =?us-ascii?Q?Af1kj7vcxkKKmpHhSQh8SqmlXdNMQzQrDTG5KkDxrtUDEcH3mNjg3KmSzrgX?=
 =?us-ascii?Q?Pr1dWOwMekUg1Ac6aC67ikK9fVkcpxF0uYCMFhlFP8cvyRq2x22s4l7bjjBh?=
 =?us-ascii?Q?M7DhGOhTKYCvPxwgL+6RmAdGUaJ1haDC858UdvuR6NEcddTe2Ms6rQ+0fF3T?=
 =?us-ascii?Q?S5nU1pyB8c6MyCZkavkkQU6DrgsWkdcyRhcN54zT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc893e7-2f53-4ff4-6847-08d9aac7e125
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 19:16:10.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxWQyFzYZ27Axo1SokQllqpyuw4c+6gGTmDe+C5KEMD+37LdL3gPCnjIPXcNxv6Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2662
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: p5ZntKOwSuT809PboHnJXzOWAjrPP8ux
X-Proofpoint-GUID: p5ZntKOwSuT809PboHnJXzOWAjrPP8ux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=805 adultscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 01:11:25PM -0500, Donghai Qiao wrote:
> The function propagate_protected_usage() is called to propagate the usage
> change in the page_counter structure. But there is call to this function
> from page_counter_try_charge() when there is actually no usage change.
> Hence this call should be removed.
> 
> Signed-off-by: Donghai Qiao <dqiao@redhat.com>

Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks, Donghai!
