Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C745D537
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353174AbhKYHPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:15:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15838 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353228AbhKYHNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:13:04 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6Dr4F002155;
        Thu, 25 Nov 2021 07:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=E02TyH0xOUgwepa5wAiNfllc/O7c372l+0KZqwQCPVo=;
 b=Iqw+9PdbSrhiP8f2F/iaiic9Y9g8JJvpTWhTYtBeSJwFdDdvVyfSre4E/Zi3UqqcXbsq
 XGs+7Hacy9TuXTWtlyc9eRvH2YJri96zU3Vstn++truIOTaon3NiSrygIeVJ5uGQ6Rl0
 Q232RZ2ouJRxN/lS/jBXUd7NcL16l6Fnoai5KljeEexgd6+crgmNCSeEC1VBJq5/sX8p
 OeRCGD1zxMfcm0uzYvRu1n65AeezhMS1ZXx/dagvkCwSA/IbNR4rPCSEHo3aoReKzHhm
 xMa/t7aah5ZmkwvlWnhJ7rYuvB1NgVr3rUTX09ZMUC4B09AZCXJOyOfLd+YU4jBJI/Te XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chmfn5fwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 07:09:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AP6pBUQ089023;
        Thu, 25 Nov 2021 07:09:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3ceq2h89b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 07:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw7K+EA3lOld4FCYPuwmtf5SyNcjVBGktyhlhEoyjmZpkT1mkplomQDwqcAeOA+l5QzuDcS6c+jajctKa7LnxzEiU/XzI8QIG3dpaa/QgT2WhxhdGup1QkaPXOGz7AY3SDevVGmMZn5WQMlah8UK8IWZKfJH/EKW7DuLxMDQtX5Cuav2JrUaXyiJBYSICiiYCodZgNw/NJStg2XnZ/Ut5GxLXPnZsve0GjpZRHidsXfmHwrseNkwNRvpS9KwtGemaL/ARBx/O5Qpt062Do7iPhoqN7HYdxj8KkMZisT8cbasqvQs+jIMTokVvre3CJNysIfya+zQU4ytQW3Rme5PHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E02TyH0xOUgwepa5wAiNfllc/O7c372l+0KZqwQCPVo=;
 b=H/G6Y1iutcsPQPhjRNU8ULpwCIUFsst9ZQ+tNuQTUcB2DqmHxWD0uSqOxK6fBdyfRiUD36RFVDc56oEGRXF14kZvnPI2ZlTI4jiYqKMbmoM8lyN49guqC+ubD0d+9Nz8jaTtI9WfqEBzafpvfEcMwBin56JJvE0Hi7qIXdg44D70PZ5evI3m4aq+/tL2nHRuEQ7xY6mExkvZsErws3JP7/7/o987MZMfux/EH14qBP5wXMBqGlUDln0p96dJ9MKmpxwV8o6bTB2wu+lSFbG/4IIKFMtMZhL6512GW7XrahD6t7YGTJrlI+yVTvW4iHHrf/0qhBCb4xPtjlzRWYmeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E02TyH0xOUgwepa5wAiNfllc/O7c372l+0KZqwQCPVo=;
 b=JaxxTmbt65aml0Zty41tu/YBH6HJkq+FUx6O4ZZq3utsuuFm6RPrXOK7xAH5h8u4XNoagTJhsJ8hDPn/HJffgnMu7ut8puOVa+VMHx2rhPUr1sUCz4FPDnr651HcuVMm8twL1ALlCQ2+6fWBAJVDXK4WKMJX3xr/7K2nofNKF0U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5667.namprd10.prod.outlook.com
 (2603:10b6:303:19c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 25 Nov
 2021 07:09:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 07:09:37 +0000
Date:   Thu, 25 Nov 2021 10:09:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Larry.Finger@lwfinger.net,
        Phillip Potter <phil@philpotter.co.uk>,
        straube.linux@gmail.com, martin@kaiser.cx,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unnecessary NULL check
Message-ID: <20211125070914.GM6514@kadam>
References: <20211122195350.GA166134@makvihas>
 <YZ4NL3TvLYMa/Tzu@kroah.com>
 <CAH1kMwRPLP998GjKx7bkL_LQE8hVNdCThwBJ7W8iNo1mPUyEZQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1kMwRPLP998GjKx7bkL_LQE8hVNdCThwBJ7W8iNo1mPUyEZQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Thu, 25 Nov 2021 07:09:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ed26a18-3359-482f-bb76-08d9afe28a74
X-MS-TrafficTypeDiagnostic: MW5PR10MB5667:
X-Microsoft-Antispam-PRVS: <MW5PR10MB5667BD36E965BD81E8E5D7BE8E629@MW5PR10MB5667.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xu9kVqYorJZpM75MZAE/HLRBWHEYEXAdWa2jnRm5iaQIWc6njvS0kNLRmLc817H3xgl9BQonJaSO0kKIOPX/2h9gXXVPaeU4E1g0SGzkS0fdb/H7Os10fQnDz5d3aytn/2Vr4/QuqpiJYb1M8s2PisRV3IIKBmSlBWZTy2N/ISaV/GESuPco1kX5fz4MG1q1VOQ+w1oJDj4fMklSd4nHdhhI3XpPWz0FM+zzAOzOt0isvSCTZv0+48sD+mznUe4uTyeCEi5EKLl1/o7nrt/2x5bbOfF/iyb0NrM02Mkl2xgzd9R/a36fit+Wf0UfFKoTzfCJh1smabI22VGByRGi6oKPDxjLZMR9eVhUmxT7+9lpsAMBRv9H5mTUiZDUff3q0cSPSEnHk8aYAMSqKELt4ClutNwUp3hilUKrNzM4CZStetcXcu1NojdD9kmhUsNLnwf/ae9smsYjMxMuSyF/gPtCxKGjOh5wUsIDvmse42uIvHJbq6j658g4+uimlYbyGrRgbzteDSYLFFxY8Vmoogjx0EwHgfUUo8lgYpBhcDZZiLFV/0QSztCs+1wmgPHJTzOQEgEGJWDnPFNwnrBCDkXKcEfII0j2ez0geRcjryhv0aE5cqNmWa3ay46hx+2+jz0NUVae8+IizPgpMnONBNKYED4l1cpyHpMhhmCAaCdvayqS9TOZoyWFQTybLKXSeex5oCC8sIt4esC4WdpJzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(956004)(66476007)(2906002)(508600001)(86362001)(6916009)(4326008)(6666004)(33716001)(33656002)(6496006)(8676002)(26005)(316002)(55016003)(4744005)(66556008)(54906003)(9686003)(52116002)(44832011)(5660300002)(186003)(38350700002)(9576002)(66946007)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wyVtZQcycXCpgxiTkNEslpr0EtDMm5rICbpITBt6y5e0RL0u2YoO9i0hJ0ws?=
 =?us-ascii?Q?OZgG9BO4W8vhGcXyJHMay77s0nA62PTYOQC+dg5X/dQOQLLH0+LjduM/KIii?=
 =?us-ascii?Q?CIiV7YsbKvNXlP9vgKkadfzuMZS1s0OWe+624Ne13hXLesprhJhjVoF+Spfa?=
 =?us-ascii?Q?pXSJzqek9MzE4ovimYFuGJ6C3PsDpbKf9aZAbZI+mxu62redDG7jnQdgvrTO?=
 =?us-ascii?Q?bS3AGIAKbk5QWjPZtOHCLY1uNvsj0bT0dHIYkWhC9Yz/n4DWUNJhDx8hoVc1?=
 =?us-ascii?Q?8OTCPyq9crMDpY1VWWwlt7EijRp0slJdVprfru9koN9d5sgPuLl928aCMPqF?=
 =?us-ascii?Q?XFp7E6YjD8njlaM7rk1cl6VAKQeTy6SdmGwiUr7hi19HFzSF8SvEbJQidP96?=
 =?us-ascii?Q?z8vQ1qmBBHkk/v6TNwovKZfW7/9wpBBgQaBANrAMFn/YQHTymlwONJEjDSrN?=
 =?us-ascii?Q?lVa/Ovs4qIFPvHi7UeqE652UNNnLV2eG222q26eVk8nBDKpSJA16uSulNDnC?=
 =?us-ascii?Q?BYrDNQhVW1JzFnXwNRrQFpkKtKmZ4h05WeAow7OHJVBfm3r7t/KNVrZuHHCN?=
 =?us-ascii?Q?F1JyzX+JhQd9pQhThwKkn7cov43sMHfFcq6TL2QHplxqTylsm/r5xQ5sTnbd?=
 =?us-ascii?Q?gQA0uSCb5ilurg6O2psLljERL2fdLziS450QoOeWualq9e+qJt5fk1JJnGHN?=
 =?us-ascii?Q?mCX7QOKTLzdBQ87+IvHDHFp/t3gkYxc/wMLtIXEI2qitWlP4MovME17R2xcm?=
 =?us-ascii?Q?tH9im9dhVvbc3Tc+Z3ix15sOSoUI0QPvEsi24+TsqPxS0ZpjZ7r2mbUjS9mC?=
 =?us-ascii?Q?BhHZlSU+ASRUsaKs7014Nhlwwmk+Ckn4cYjVIL463f1JGappCdMz3+nS9fgN?=
 =?us-ascii?Q?sv0IYOVqMxGql3J1DYDkJ9x/1ICRK8ruZhvbLlJfxFyk2gnctN7HuJypYlBK?=
 =?us-ascii?Q?s7tm5EK8y3lxakCcLVRxJLi9320Da3YuFM93lu+akR4Erb+H2z0dYTBhFfn+?=
 =?us-ascii?Q?KREp68UtH5/7eJ0I/lRsQGdkxAPuFldRWtnGg2T90+g3fOlHxLfePngotc/G?=
 =?us-ascii?Q?bIO8xJW8fMzgazgMrQEVVkQtBAPqDkRK6JA4z7JdgeuerAnSs5nOrxtT140v?=
 =?us-ascii?Q?RFP6khsKP+d2TPxINF+FVRKJrJBd3cmyo0cWPOVPkYPQkZSEXmlI/Xgc6QzA?=
 =?us-ascii?Q?nUd9DBP+l78TvhvuqWLF4pjoa6reaxERmSgUcl+XEy9/qKRKgpw+mMcaHPaT?=
 =?us-ascii?Q?cwovtHNB1kk7F9g0KgQB8MW99Um8UsMMBjZqpi1VvOiYof1/J8ultwk7g05g?=
 =?us-ascii?Q?8Js+KPYPwuHy471Eg5pMwjz/clClnOlHFFbrUqydDTCKLz10kAYfCZeXmdW6?=
 =?us-ascii?Q?Qhkef/j0cHvOBbbgCf17UYpqFATj49vZbKUaTuez7yood+Ul8hjer5PHVFex?=
 =?us-ascii?Q?C1u6hoX2gwkThWxy7lF+PnJ5GbI65XN0g0WjF7D5FlUrunEfZ6lmoQna4ONH?=
 =?us-ascii?Q?ycQHpOzEijJo8SzBSljGwpg8N0lqfcgUzhMOMw0s591I9U5q5fDhvFzb189J?=
 =?us-ascii?Q?sECpGcaaT2cFl4G5NUcUQoiwAxjfYoqW/Dyw6Yy8NmtZII2h1o9xYv0GHjVp?=
 =?us-ascii?Q?UaEe8Tn2CGgMPaOdD/TtA0WYwEgJIGI9w2hGAgczSUUJ00fZw1xxVZnXaNzM?=
 =?us-ascii?Q?kbPKmlcLX+hO//PVNJGGL+A3n+g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed26a18-3359-482f-bb76-08d9afe28a74
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 07:09:37.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71lCYub7VFvmEpcnflpsQ80CBmTrBXm+MhxlBip+iSfII659MYoHMU1twAsBE8+fYxaNAhRA6LmG8IdaGwi6eZDUpUyWzA6VdjwA+551NsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5667
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=826 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250038
X-Proofpoint-ORIG-GUID: k11-4o3hLgkQ7BFdEPsEw6Qh7qU2xc0V
X-Proofpoint-GUID: k11-4o3hLgkQ7BFdEPsEw6Qh7qU2xc0V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 07:02:20AM +0530, Vihas Mak wrote:
> >> And are you sure this ever could be NULL?
> Yes.
> 
> The function rtw_free_netdev() performs a NULL check before actually
> freeing the structure, so the "if (pnetdev)" check isn't really
> necessary before calling rtw_free_netdev().
> That's the reason why I removed that check.
> 

That's not the question Greg and I asked.  Re-read the emails.

regards,
dan carpenter

