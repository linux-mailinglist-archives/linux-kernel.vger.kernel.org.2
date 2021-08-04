Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA483DFFCE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbhHDLEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:04:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36898 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237728AbhHDLEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:04:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174B1J5q016409;
        Wed, 4 Aug 2021 11:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=f2FzgFGY1LyX3O99PIGeR3wakP3byPPG4qPYE5iXqJk=;
 b=n9p7JFzejH4CwGu8gJxqGjSPdyCFGy61CaGCTa853gxNVUXrpDMMiubsCh577ZQtXMbM
 LZDK+uqsCFkAKFGFdImrQ0uquFu3xKRe5QK3ixLLkienH0ePxKr+oWAuNh6aOWqwApJR
 jiIO/UxNfwtsVcpNAEuu9caC7NTOOLihmaTUtCopBBXHGr3UdVJ0AuRECgB/wJRNk7QK
 MkBwEtxjQ6LiXefFHaH8i/nHccL2JJelY39HKe9TO+7f7c+7Swf0H5e4wfR34GmL1qF8
 M3zgrab4XyXmBAG6OHBU15w56SntjQAUbJ5wTa1L+NcAMewXMDB0Z5H5Em15+NlntLNT 7g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=f2FzgFGY1LyX3O99PIGeR3wakP3byPPG4qPYE5iXqJk=;
 b=ZeicIlwf8bXeJDUK6syeSTqa4uM8sW0n0roieL9fwwdgCzqCZ8nZYwqwTgB3uPFQk3yF
 nYI22CxeGtRBNWzmUIPg5s7DN+v9NSzIfpvkgqlA8OU7Rc71ayC+STLLGc8KUuJqgkqr
 bptT+cr/zZ0jB9Dg9K3R4FqlXuh0qMB1HG12fBxU/BIdIx3lt5sjaLdTTbX2ir6c/mzr
 /+PS5M2ClqRgY46GloW5kaHdNGv1U103Y1cEsg/6Yao1Wq8YYVV/IfqD7AjJ31Q6S2tu
 w09H0LkrHVIcokgGNmH7CRttRjTYrn7OlCQztaqEvr4R4cNqToq28yDl0Ryd2NLWsKQu hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6fxhdmfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 11:03:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174AtSLM159170;
        Wed, 4 Aug 2021 11:03:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 3a4un1gara-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 11:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHRXnYU83CVn/am+2PmDLa0kuiQsZnMvSD85FmRzi06yO5D53j8dNHviJLtT8FDSqovQnPvFLQDR7AkKPdyTTpJi4DIBqX3CDrrs+vt08qAwuPaU9BIJ/o4lg9lgTtbzJSFHDHpCWQocnBEAMqoCOUt7OqSKWGMHWkL5hE4hXY19Iah5XkIV2z/Xd4aXOBd8tWrg8a2liN+xU9cbaJ/vhA7/0cYD2XDzgSkCjqWgXCOw6UD3IzTHmhoYoadQzYNslGURCDBgGQhLKpKae46VZ2UgLr0a7a9Zmg+PpL/2fy72Qf2wigYKR2m787V8d3i7LJHu79//mcMn4bbK/bBtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2FzgFGY1LyX3O99PIGeR3wakP3byPPG4qPYE5iXqJk=;
 b=hHDzgoSMEMy3vErLXsa+H7BAhWw+9bDGOXnKbbpDy2j9+nsLg/p2n9EEk6vBxOSVNP9a8iRolAiSJMQL7vEWGwpk69GBoDHn4OFi1y4MyrJUcOnJ/Ye0CeDUN+An/IFljLZfwwHy8ig7jSHXV6nwbIb5NFI2c8BVy80/eFjxibJKvPSyApgGjfs2lGm/SJ18VUXJU8+kNPcMy8RmG60zZb8WvOGdN3z86/e+QmY5K/xlMXsmS4Zvtr07rP5LRRBWGAbL4Gstz81aEuomQVFu/kxDfBetD09iWyyfjsf/QusCIL422Uun5NY970CtsLbzAOQzYKfxCKT/19MOomS1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2FzgFGY1LyX3O99PIGeR3wakP3byPPG4qPYE5iXqJk=;
 b=TB2AcEvz/8Ps/vzmrpMltJsi4htAEPJSrKhhCgkD5evOBzL4xIpdecf69/XKwYoBQ7buzVR8y/IgWFaUpeUXkv27eHKNpJIjfp5a07DLmXN+qgqExcmJSlw0YX5ZNZrYiA9ETQ2ATtYne4nZwFgOCtHACtibWKczTxAkRxY2nWs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1775.namprd10.prod.outlook.com
 (2603:10b6:301:a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Wed, 4 Aug
 2021 11:03:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 11:03:35 +0000
Date:   Wed, 4 Aug 2021 14:03:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Brother Matthew De Angelis <matthew.v.deangelis@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tablet: acecad: update the reference count of the usb
 interface structure
Message-ID: <20210804110313.GF1931@kadam>
References: <20210731160938.GA909566@pc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731160938.GA909566@pc>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 11:03:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 286142fd-9bfa-46d8-81d9-08d957378116
X-MS-TrafficTypeDiagnostic: MWHPR10MB1775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1775037145DC27F2C90AA84A8EF19@MWHPR10MB1775.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98LVWVzm/+xTvOXZZD2Mze8QeHo6S2L+d1dclw1BPrvE8JNe4LT15s1nqsZ+MVyX11ypkP+udhvjhbkrrzDfWgDb0pEb9E3rqgVlhFbuUrJHhsFdwfqIMGlheblhrQKFwOeEc4ANX1yx5nF0JM9gFlwsevRogCFS2spd2LYtOctv6v/p8TKJ4aBAxK95m9XOdOFUsNCnv5fglR6P6leJXWvE44Q75WEH7ywC53/CmFpHHJ1M7VUbvWG7uazv/tgKR9Uk2w3F4vCwQqdMpPKZ2P84hiZl9QWuqqpBGYghMIENz8olVNVF9T6OZpI5UDpesj1pgIFKMr7KmtT7ae3SZKLQDdoknAeTXrsbFRhppyyVGDkHZqOhduRseUvjMEpWqJ2gNkZ08UJHbqAzBvO/dC0DcLUAsv6Zhod2M9DalJf6klEvWh54XZldt896p94V11Q52qq308q5TsgUDVwtFNg+a8XuDprsA+VJDD/VckIyMVNvtA+d6sUEKZ2yWyvKE/L5lJHC+th0q7dTeUfk4YaaB/5B0VdhIC8NKmF8vUGnz9GEYMH6mHXso7fQWiC3sztrSplsMy1uRDIKg91NEAVBfs0OXagNQXUNhiMpdiiWsnHMTv+/ARvbf/Zmh2QfEzELP1+/NRLZnxx9Q5ieQ5NINpI3Iwwi+wIoW4WVl/zoMa1h/IqKgs3tvIqKNohQj9PrSdNrBwqrZVcWF4YmSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(66946007)(66476007)(4744005)(86362001)(83380400001)(508600001)(6916009)(6666004)(8676002)(5660300002)(4326008)(15650500001)(33716001)(33656002)(52116002)(6496006)(44832011)(38350700002)(38100700002)(2906002)(316002)(186003)(8936002)(54906003)(9576002)(7416002)(956004)(9686003)(1076003)(55016002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2doa9uQ/rWbZCgDUMxyzmiY96/0nGkIDZCbwJJBHeS9ZtEsMa+AJjvxBsX6?=
 =?us-ascii?Q?8PTHnT5JBhn0FoLbEq1hEx55zRUp95DzcTkc8rORnGqXEDAlAMXj3mpJdwHx?=
 =?us-ascii?Q?ptuOrd5LpbJ+NON1DRsIcrcuC6AQRvu88zoDoFbqxW1aAMv8vZiaGlEthF4P?=
 =?us-ascii?Q?rIRQTmnMxFZ+tPE0uxXV2k5LFmBnUYPpSSx9N5uvwUlP4xPsDcy1IK38+xzR?=
 =?us-ascii?Q?WVHV/AvM0/HbWdwWzhuurkarIScsTDFsOYIUD5czKrfs9QDmqq79z+aOITrC?=
 =?us-ascii?Q?hQGDdYnFwM6rns0eMztyRm2LjNoaKSsEHC/SxYddLMgGH9ibS0fYFxHpFBPN?=
 =?us-ascii?Q?YNTEAyJ7FASpZIG/Hp6Jf8ZJ3WC7VsyU9bKcsulxWeGh1UYl/ORtW4vWQmp7?=
 =?us-ascii?Q?EfD5ZS43IIeg/4n2amh2H1JVH+62Le5FlodthefsWW50k5RFDBqZeUIbzaiZ?=
 =?us-ascii?Q?D2bl9/3wyV88C3zsotxiZJDp0UhDfVYQQT51QEDlx+XBUIKaCvGuWw0wCkTi?=
 =?us-ascii?Q?RJCQJ5b25H18dq5NJ0B5l509aVkorW7Myi5SmOFNXeWX5hICFEU5020shkII?=
 =?us-ascii?Q?4z+out6a2JLn9bJkY3mqcdNYL2zrct9UIhJWfimtNv5kApnJrtXGIok1Z8jR?=
 =?us-ascii?Q?1eLNP8EYd0awr6QJNyIQat6HqsIju902hxhC+7r+At6xMMZqWG4BD2//zJzs?=
 =?us-ascii?Q?qbh1fabxRpJwiFEPmxQKHSTWIKF2utHXx1siT2McQkuoFw4dq6dQBNPpTPfK?=
 =?us-ascii?Q?WGbHn6ofjEro7lXyWTsltIiwLjV6sNVb+p5oIuk74XGZIl588zIe/oeyYK31?=
 =?us-ascii?Q?KhOMN8shMcZjflf4LQL7ajK6P3Bu6M8W4Q91NMCx2/+CHJ76yevlTp8P9hjc?=
 =?us-ascii?Q?AcaDRhlCcDy2vrNPFZFiiJV/fsAvgJ9VxrBBrAH0QhU2/PaAQsQKYMS5kgcf?=
 =?us-ascii?Q?p2HjDyfKV9EUB1k/xFcS2qZ+9UBoFIzgn2SUmE24wPi7pB3puD8YcCikWnhs?=
 =?us-ascii?Q?UghyRxLCWQeW7DJ3DQr4HAmIpQY5OEdUpmsCMgux33msss/p/Iyq4wQL2IOu?=
 =?us-ascii?Q?2orTmo5UWDDonstzPspENbr4BXMal9PyJVRXp55DB1s0nFJwqbKl9d6euvnF?=
 =?us-ascii?Q?edOCCcMN3ajpk1jUsHcxyY5G1LCrkXCjtWJtClXRZTRvy8efenDVMaKyHhSK?=
 =?us-ascii?Q?hcRRE1F0hiGeUpiULs401qHRdmMn4HRAzHJzq5NFnWxs2WwEZpRPgaLc3tX1?=
 =?us-ascii?Q?oi9NdNAvfVY6lwZGnSgNNgVKjNwKWqIsL28yJWhK6w753upJ2oTCwLAvU8wh?=
 =?us-ascii?Q?I7czli4aeaiH389OJdyQfB76?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286142fd-9bfa-46d8-81d9-08d957378116
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 11:03:35.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJtHiI3/CxS6CUMQ6m8yirpkLTOusn8k8RZrNhcYlPukhRH6jaM19NK/QPc4caUDv97AWg3bdj9hCZ4f3YIbA8AkVm/QeNlIy/8gXdIui+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1775
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=938 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040056
X-Proofpoint-GUID: h5-Q6BpMetTTt3iqEIMJpjnmDJIzu55y
X-Proofpoint-ORIG-GUID: h5-Q6BpMetTTt3iqEIMJpjnmDJIzu55y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 05:09:38PM +0100, Salah Triki wrote:
> Based on the following documentation usb_get_inf(), use usb_get_intf()
> and usb_put_intf() in order to update the reference count of the usb
> interface structure.
> 
> Documentation of usb_get_inf():
> 
> [quote]
> Each live reference to a interface must be refcounted.
> 
> Drivers for USB interfaces should normally record such references
> in their probe methods, when they bind to an interface, and release them
> by calling usb_put_intf, in their disconnect methods.
> [/quote]
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>

Also add a Fixes tag.

regards,
dan carpenter

