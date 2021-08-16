Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF133EDD9F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhHPTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:06:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44092 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230271AbhHPTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:06:23 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17GJ28tE026204;
        Mon, 16 Aug 2021 19:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=/Nji3+Ye2xKHfipMyFWyCPnxbNlyV5UP1OAfZTzZ6Pg=;
 b=MgOIZ/QGut2Al8e39AysAUeK9WBuLkj7W1zB5A0rQ2Yq96XCyiRrl3JjJrs5uMCCVr0T
 lDIVB5gm7Ngp3F0Qh+zzWrYrjhizCo3jKqvwuuOUxpJ0zfRWCyM1s/dLC3TafiyIHtvz
 xV/JgBdAQ1zylz49ygaTlkjtps+IuohNryS0dGtMsz0YdB8mtUjVxyUQdzmD6lu83iSe
 dWRxf5XsFDt2ZxAoCyguUbm5D55CULZE+MyZ58PqO8zN76CPdWI/zkVPiUSZuJ3e+l4X
 VqAsxMv/lG/JwzGy/8MVMC7fqpSXwLIDPTrKPmLpWs3LzowIUpR3fFnlh7z+grP9awrn ZQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=/Nji3+Ye2xKHfipMyFWyCPnxbNlyV5UP1OAfZTzZ6Pg=;
 b=y0mMsEAeI38dGK9oHgrKdTuxGPJCezzbW/PcOZMygk6/o1pkoxu7DXd6o3sRPok6Fr58
 KnnRoOC9iOc+PlhF/PedfSy5+hCz/KuHt7mK1Jb25+ENN6ggsEfDkZL17aiHuTkcaGog
 7gVWzft28uE/cA9MjpaLepGHhsuCj399GzCZF7LdmE6Hq6Jm1j/ZjjSGrFZHqRRZBMh4
 INvIpw70U2Err+w7WAxiJTI/Q0rPSyZN4CN8B8INf6oAU+m4Dq4amkctESRKATx/e3mN
 AFN+GfKddOAYuITzJ+2k7EryVRfbf6iG600ycVSECl0Gm/EvH1Sn7SyoSUOmRZnhjDon +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3af1q9b1f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 19:05:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17GJ4uBS157060;
        Mon, 16 Aug 2021 19:05:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3030.oracle.com with ESMTP id 3ae2xxqx72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Aug 2021 19:05:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6U7kdkAN446jMzQa45zNPs6TGD/lMaEOkZpt3Wz5DgP+e7yQe0KPh+CHSpyZFGhuWnc9ot4LoNJz10pDOl+uoFCk1UtnEzVXwkcw5A2bl6aa6ssSEzqq7O+1nceZ7gEbMzmkPkfmNIswwesivn2vYN0DEiu12i7unr33wv22gr2nJu0qv6omRnSReuaKzxyRTZvhwhS8OSfLfslLuVru+2h2z+EgaJYkudTfLzuRmqcBSF5pbuiwzpihQ/4a56I6Yi8poulThjgih5jY66M4FayXl4mAgYu7G/IGnYnZ4B1oRdeJHTDCaaBRgqzHZgzc8zAxTePqaOkOy3x6dhjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Nji3+Ye2xKHfipMyFWyCPnxbNlyV5UP1OAfZTzZ6Pg=;
 b=g5kRPuimGGXqEOFFREluF1REgPfJXRxBgq2/bTPB/CrVkJ/lf3ezc8T9MpxMoglNxxSk4VQ/DqaVrCcpUVKhzLPF9N84OJTpXsa4JVZlJSBI3ilBDvKoflxJxQYM7dl+YHH4EYtnNux3byL3SB2JZXLE4Ftm3TwYBbNOLCcKht49ZHTq2qB5I+6q0nhZrlfRNgk8ZIUrmZvZpYlRfGaxQZhnPEjdetbihodLTiOx/6FrouVNehloOwnMtYLyEK6MA71zdS5uboS3k3jh498OpEyxOvAiGU0UjkavnGaxGNDSk692CanorFjSuqyUnV+eaTms60WXzVv8w7WDz9hc2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Nji3+Ye2xKHfipMyFWyCPnxbNlyV5UP1OAfZTzZ6Pg=;
 b=w8yrIgyKsFw0iE6hoTJq3U+FJhCzQtTqtxAALUMbDTqqMWbgkMgDOfFQTs2CTA1rNSF76fFw6ax5DcNWv9zcM28UDi+wN7UYslQa4V0yUhGi9pLF6wtXXsRZEAi2scQRATZAN91hqcIVEC5SkTKgskuz0cGTF7paaFDgN9ktoEU=
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1296.namprd10.prod.outlook.com
 (2603:10b6:300:1f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 19:05:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 19:05:38 +0000
Date:   Mon, 16 Aug 2021 22:05:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Leon Romanovsky <leon@kernel.org>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
Message-ID: <20210816190518.GK7722@kadam>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
 <YRfYr0fsM1R7O5x6@zeniv-ca.linux.org.uk>
 <20210816065552.GE1931@kadam>
 <20210816072344.GG22278@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816072344.GG22278@shell.armlinux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend Transport; Mon, 16 Aug 2021 19:05:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5cbee00-2caf-43b5-31d9-08d960e8d502
X-MS-TrafficTypeDiagnostic: MWHPR10MB1296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1296CA98381B26A3C787B05C8EFD9@MWHPR10MB1296.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnC+Q263FTpCwKXuxnuWJOziC/+7KsNR+t0kojoxeIqJFWQsraGfQpSxglUOVV39hML7qoS1WDDjhit6eUdF7YQ0ZZdCs1NkRFJR+Z+UUXSy9iDj/FPWlp9mIsox5ET7N4lo7yvHiiIJMVDY0ccAhpCVNas0uHsg+Kv1TGcfVNbv6/zUNAxHeDmTVyTz3fYZcLT7JytN1l5LkSZo6S08XHf6XSk1VD97d2SIhfRZJ6cx6mLAgz9F2MVSDiJZej1j0Oik7H0V0hzOv5p+M5YCebpIGAzGSyS/zf9ito6OXLUnU/1JMjAOpA5tSD2Z9NnRWHWFSWGbB/Ah+jSn7N1I0KFJxxgVYRcbbQIqiVz+pYpPtUiDOt+1in6pdmX+H2jsgPjTkUrybob0gzT3/iW+yiQmH7zykUuUuFGLa4J+oYvIgFfWQddMA+tt2jzjcDtyQC/B/wSJsSb5gZdJ82tqlqTKTlvD1kGvjeTfEwg17Kq/WPTGw8kKscJXZGG31suMxS63FTFVcyrlujTvV4cFks3LbDQoDNMeOBLlyLdjT05NP0ENrDL4lDLcHJhoWQ8pbkqD8GvQQYMf4+dXPwparP6ULd4kAG5pv9RyyHhUE2rYDsp8KB2PHDvMvRb1LUh7Vh1HKpLqFEXXyA4VxEJ4SfXJMszkZad+KltdKKnDJYkBNLB5qgSsmynLVirOe6oDc8eG8j51QPOfr1TlG5bAjRsJ228dlNmEkzviurxEbHHsnmgGqFJK83rPl9dMg6yO/Q+Zo8NF2/uJyunDNgQX9aqclMIKotUYIj4h+14Tv2XgSnL09iVn8s44UaQdlMLA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(136003)(366004)(52116002)(83380400001)(956004)(55016002)(6916009)(6666004)(9576002)(38350700002)(38100700002)(6496006)(44832011)(1076003)(86362001)(478600001)(4326008)(4744005)(66946007)(8936002)(26005)(33716001)(9686003)(2906002)(5660300002)(33656002)(966005)(8676002)(7416002)(54906003)(186003)(316002)(66476007)(66556008)(125773002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xJ7UWllohUVL7VZUl22U4rc9O/IX8B1jJuODKb9M/AK0muqB39m1zGmgr9yW?=
 =?us-ascii?Q?4GkJy9X/3Wn9lamGMx2idSkJYmp/PS4H8uxTWdv4gvBjPNZmDO64CG8uBtE/?=
 =?us-ascii?Q?KWQt5RUc5Bq/0G+4SFLx66VPD/6XxkyfyTjqbXH4SCTMJVpr+Ji5YPSbgWqz?=
 =?us-ascii?Q?gxT2YXn89c1o3rHDhJ6t/2druQe8eb6o9Vp+wi4qGMxiHVcVe7yJ/bQs/Th1?=
 =?us-ascii?Q?ewhKMvx2dqGmvR7uVQbKWj6ynsKevapkDUqRsyVcMDQda50e5EiiceEW6RYp?=
 =?us-ascii?Q?vcs7NiTziq4QeK7QCGU2ltGmmjc2oRcoNgb4px8KIOnPpHhU7Mv/eiWVmjXx?=
 =?us-ascii?Q?3gUSLVufG3hlHMH1R5+Vhb98y73V4I5siKAE//AUQBrvG5ZVnammI2mqrIN6?=
 =?us-ascii?Q?yUOaEaiM9t+Hw4d0rvI606UV71Y/f8BQmC+iFJK+7P5wAeV/Xc2INyD+7eWK?=
 =?us-ascii?Q?Ji/VeT8glOnZimiFURbS5grB91sa7D5ejjTfsIOcbNzOmn7+VwitzSGr1GEc?=
 =?us-ascii?Q?+lZbk5fyTiqNWTb0BEnya0Nc+xG+AOZOuOMM2f8xPv+X3UmK+9v4pd5T430g?=
 =?us-ascii?Q?Zqc2AAGPlqQwDjUXdVcLX817XUsHTDWpUVWM+72pGBitKwMR+dvaGPr8XFRA?=
 =?us-ascii?Q?qyQWzrV7oLQwlGl30FQBJnvaNNGXgd6j66kn63k+Nq5aLBnFyNcaWKiNBHXx?=
 =?us-ascii?Q?pnTZ8mbih/Xy3uMAned1yWe45m7ZvIL1TRLAh4Y6Y3cZf3B/tNRJbMSbYZ85?=
 =?us-ascii?Q?qr1X/MLHd5j3bD3SKvCT7DZ7m+6gnXkbi98sXAHpmljgTOLM990Qgz/k3I/H?=
 =?us-ascii?Q?+J5CXGzJek5SmkU5wvzPd1K3rsSShlH2SHpYV0voWhZgvLGxhavSUAyFJsKu?=
 =?us-ascii?Q?Cpr1euZ6xX18gxV4xiHeJoOk2sq0V73PXDauL5jpuMoAHMsGeWC7ebZZkmMd?=
 =?us-ascii?Q?kiVFvAYxEE4oTN6ajBVdw2VH8W0UjwY2+mp+7e5okH/SNI+eP3UCvqjFd+oq?=
 =?us-ascii?Q?PnsS8oT2fMs8o2dIgmN2xriylhriHOSZ3MO5wqf2baPPOZC3tqDFWMqHS6YL?=
 =?us-ascii?Q?UeYLeiLxfnYtmKz5WZS9udTCX86CNnZ4OrzqjtoTGJgojwfszqSnlLgy1xkl?=
 =?us-ascii?Q?aJ6TD5Q0ieM7iCtmiYtt8sOdgSMDJfVx8qWuiot95j6NkysWpT7VwYEo9dsn?=
 =?us-ascii?Q?7T7PWSr69e2JBD01ugtDcvB60kpCUaEuKBsYy8HH1FtewaE6p8cVbskx17xZ?=
 =?us-ascii?Q?+aETLFsFU5W9E3qougkA7e66w3h4z3JjcVs2VoyisVG7ZjAnvtmRopdc890P?=
 =?us-ascii?Q?82ZLldYIqon+9L8xrL7pWktF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cbee00-2caf-43b5-31d9-08d960e8d502
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 19:05:38.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmlhabErqvUaPDaaAb8pjZNwVmtNbqaAivNtwv2Vhxlp5weoiabalXBXEO5FrKoCpsRc+gpNIqs+vwhTxY2pYiVFTQeb501AW+BRJIAq6j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1296
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=990 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108160121
X-Proofpoint-GUID: yWK4d41a8jZyWkpgSl-j_D1WDCMuFKME
X-Proofpoint-ORIG-GUID: yWK4d41a8jZyWkpgSl-j_D1WDCMuFKME
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 08:23:45AM +0100, Russell King (Oracle) wrote:
> > That's out of date.  It changed in C11.  Both = { 0 } and = { } will
> > clear out struct holes. The = { } GCC extension has always initialized
> > struct holes.
> > 
> > http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf
> > 
> > For partial initializations then all the padding is zeroed.
> > Unfortunately if you fully initialize the struct then padding is not
> > initialized.
> 
> If we're going to discuss which C standard applies to the kernel,
> then...
> 
> As Kbuild passes -std=gnu89, the kernel expects C89 behaviour with
> GNU extensions from the compiler, both C99 and C11 are not that
> relevant, although the GNU extensions include some bits from these
> standards.

That's fine.  The GCC implementation has always been okay.  The question
is if we could rely on it going forward so now that it's part of the
spec that's very reassuring.

regards,
dan carpenter


