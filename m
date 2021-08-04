Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9AF3DFE89
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 11:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbhHDJ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 05:59:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23768 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237276AbhHDJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:59:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1749ualX029174;
        Wed, 4 Aug 2021 09:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=mNgGbcn7UuprlbiYrpJJ7+0IvcjWrHzY4n620BESfsk=;
 b=j07Ki7gC3TVMxqirmDBVVw/IfGdgv+fefchXwY0CgxwhtsJ/et4FZGAR+e/XL54zS8l/
 2p8ipjDE41Dwn7Lr1Ni2/MorkoiwRlZT1mV3iO74ZEvLEI7ZBloK4uiVHVEyvaG59prk
 TOf5jJdWbbgwchI8Lg2mHhD2cu/ILrHL61peIK/G+goB8pOFZ4qa98BiXS2M5dZbEybM
 0C/WykQN0+93rgdxvc/q8QEczudWkBIdKJ3AXnJWJlYUqoqprnqpnZCWbO7RWu8Sn06z
 ONjV+bx+J9783ocpvJkUtsj/rMlWoytD2Tn0A88Nuwi0vz3dvpz5AHrOxfxy4qth3VDX QQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=mNgGbcn7UuprlbiYrpJJ7+0IvcjWrHzY4n620BESfsk=;
 b=qFS5tUL+gfZyhdohxspsbozNO8kTOwJ5uJ4wHpawKvA0vXYNCEzye6ImbfXrCr32MakT
 Es8ltltwcGhK1c+021NJQdEtt78R3F37G3kpkBe3A0c6SD8By6kixpbKbMnim4JmJTVY
 /AoA5ZmGDjd9KQRP6SWVw2Rio9c2P5SiZiIWV5BqwbvG0PuPNBnIgZGa8Ee5xBSU16jp
 ezyV63wf5f0I9zlBX6wOdDMUIPh/phys3x2jzbBrZw7vaoK9UuUcAjd99DknTBP2M30i
 HqHjiy8gmbECWoe0JV+tZU3W6cDVEZv6Z+2b0tdTSDUYvps73AAJDn5G39ItEWmCNnFo DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7hxpgtjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 09:59:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1749tu70184464;
        Wed, 4 Aug 2021 09:59:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 3a7r47ht0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 09:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQDdqUOhX69Z7d3FCYkrBKGPxdl0M8AfiT7G0P0zOD3XP4UoJssOkqaLwRzzuCpdPxH7q5dEJL3+dRVpwgdQB+XNkuKAm29B7hrYq7RHI+6OCjyPtGt8EgctgG9AfEfxZ/qcHl2z2bmSmoO8aeo/BKDyygNmQjpMiqybV45VYTYLIDHDe0mFIvsif5CNMgsmyqvmjP7WkIxIQNtBYuY9MTSaxD2KDvW7rlpy3Pq/np7MLUgeB4mbMj9All7SZ+Gq97D0r2JRrHv2naMxIItG6QvA1jxDBIgcQocV4SZufpUsBPtGn7KKR9LGwCj9bflylZ+Qw+PMBhWH2C9GeoxS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNgGbcn7UuprlbiYrpJJ7+0IvcjWrHzY4n620BESfsk=;
 b=aheiSwPQH4eagDeS8C1DzgNF6wqs4sZoJePol2JO27NVxxcXHILIgSi1r9dvq3GMWbQiEkis7S2kbA9wp+8Tt63/BhWH1g+bUzvqyHyNXmvOOpyou2KCNK0aRUAW2DCnbjLowAnrAVxUUk+MoyBHl6BgXcxyT5448MqFRLJz/R/JqNRj2t3YXZWYbzHxChR2XuipJeYdFslPWreCzPygb+HttFSHE5UXrzfyBIf96gwsN0LvZNTPPwB2aRo91UgqL7CvoT1XfYOO6dnk2k0DaFWSPjELweGUZlU3EzlCtcdH11s0qEvSUshExg+HMOMURWou19ZG4R4jfzdACdt5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNgGbcn7UuprlbiYrpJJ7+0IvcjWrHzY4n620BESfsk=;
 b=wp4t0SHPmmWKbFABUCtt4+Y3Cbfo/0eKmZY1sim9Nxgla1aX08PXnT88qDai7cto58BAUhFZv3Z7kkJH7YGsH4ZZ3IUDMMS/XB6hgkqFCu4/oS00FZsk/w+gvfCbIgeBrsFKVvGhtE9UWD8qWAnpeNquXWV/5LNI/TPWA4SuRW8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2208.namprd10.prod.outlook.com
 (2603:10b6:301:2c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Wed, 4 Aug
 2021 09:58:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:58:58 +0000
Date:   Wed, 4 Aug 2021 12:58:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in
 assignments and parameters
Message-ID: <20210804095839.GC22532@kadam>
References: <20210730181452.23062-1-fmdefrancesco@gmail.com>
 <20210804075930.GD1931@kadam>
 <4550286.edLFIWPnRF@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4550286.edLFIWPnRF@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0071.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0071.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Wed, 4 Aug 2021 09:58:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d51df38e-ab16-4047-0d6d-08d9572e7a8d
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22080B35E942F4B9B71BC62E8EF19@MWHPR1001MB2208.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcI4unLX/hizIgkNcqvnOTAIDuI7zLQvVksfSM82Ra+VG1W+E8fv07DO1AY7UivMDQwIPnPccim7p/LKE5UM32GPjooCSieWf58w2+IOXJSPCvVF9OEvIvO/OGYUhPkewgKT4S5UoiXL2yOszpJ4pzivFv73puwpIcT3Pc6KQQF5JrjiMa5ApJM0uPpwk3OXBOjRWrn0tluThWN2xM54tzu/L6A3PkvFQx9X698bCGjOTwrptaAoBT9chQmY//ODWGWLmQi36Xaqis0uDaGFR6X35B0ufUTZgGGSN5Tz3e8PPnb/WL2VkSb0bXvg6GC1xUw2VDTHnGi+lE0V/HyamdLDBUQg9OH0FcES4s/WCGFiKq5aMT2h05+gRG2s7EWIKw7bXl9ycTpHL9sTUWZuS1TvFs+5OcUiHIuus+jn592CpptSYembHmfhneLUdfmRbd4p7rCFrzEfT4/sxXHDKQXGsc8OPLsoMxPcPtOBKtmwmS8+j0B8B55D8lKygCviy8+wMzlXvicvDQbawPLlQME1lNTzC4nFCBX/l2s0C9wHYVd3rEIJZfaBzZGSNwlToI2bg0biiHNc+GLo6UphmsNwQCcRkbMyQQkMMrMfTjncwN4qyQ2H2PFSbXiGziUP4uX/ydy1Yiz93m7BrOG7AvwfGdnLi8r9pMfoOfXahNpur49W/OVOROsdSM/9DO/Td33g9uZmDtKgU+EsMj3RfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(55016002)(558084003)(186003)(38100700002)(8936002)(6916009)(1076003)(38350700002)(956004)(26005)(2906002)(4326008)(9576002)(33656002)(54906003)(9686003)(86362001)(5660300002)(6496006)(66476007)(66946007)(66556008)(6666004)(8676002)(52116002)(44832011)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhaYbJf8ZRNTASOJSnX0wg0TczV8pM9bPekurXtwtmzgKe6f4zoUkbbfhrgl?=
 =?us-ascii?Q?91ZHsnNq3k86INf+8uZpTMGfdXmhwp7rMwJMfD8UQx84RqDnrNj/O55a2fuh?=
 =?us-ascii?Q?bwoGnZd+3DNLE22jYWlehoV6foh5hvn74jp+3cNrVNXG/ujJSxTZQ7gRIR5S?=
 =?us-ascii?Q?mPZ0x9VFWQeiEoxMPHgcjG+t6CcjYang3niRoDXWQTKdWN+xAlQV4qLrCqXr?=
 =?us-ascii?Q?dxzE/G6s3uDsCkb/tnFNUnxOpmmaHMKkex06q12+Tmv5ostwUnpvyk7yNCbC?=
 =?us-ascii?Q?FMO3Rp9DSP3kjYozcjIQ4CLIupdt/2WnfYl5NSMvchK5MkmsMYYQX8RGrlV8?=
 =?us-ascii?Q?mRHkmfCL0bascACoy+qRW02quBIUWbMwqeThKGs9dal701PzPqg9GlG2ZYwc?=
 =?us-ascii?Q?J9Y4YhNwf649E3Ojo8fIi24to1sIeXJqEfbn1aKm9EIWwthDtmoBJOx8+bk2?=
 =?us-ascii?Q?fD+f6yzyNk/ELj95lHNW+kpxvel2lr481xtQnnFLChaByDveMKL2TSf6S2Io?=
 =?us-ascii?Q?P89LKtx+LFef6Ev3SMEEhruSfuCpqp4d4USW5s5QAyd2/+mDEoenBjV2Asxn?=
 =?us-ascii?Q?/zKO+0ZFwrKjKbt8UnGFVqk7ABC2Wh5kqcLMJMBpc3bvC9GGzfnPLj+wnJBl?=
 =?us-ascii?Q?crhDPPBTpdz/x3VD9UzDg9H4v40S5yYRBMtzOQjUIr+FhlToJOOrNbtygtPV?=
 =?us-ascii?Q?FGAdTCwnSF1ZCUwaeWRmREkVYrBxLzaRHRx72XSkRNBLFOz6308kp550D/hL?=
 =?us-ascii?Q?tUu59rlEQrPGVAYOO59K2I4dFPrlGPdWHKAT/4XYZxnMAWrw4RcRzUv2TWr0?=
 =?us-ascii?Q?+nPhYva1EchXYTQ/Mu9DpnLzPpUJ81wBa07aHsTsd42N3/Cp3VgympED4qss?=
 =?us-ascii?Q?sNaLy4CiYo0+bBO1l0rTLOZsewWiHfq9yXoZJsIbHId4cu+G+m4cOhw8drDp?=
 =?us-ascii?Q?y6TgA7w7LsbWMWJKLDKtwwv1Tc3cKUMe92ShtFM8MO7BrQ13vakh2k8MqWIz?=
 =?us-ascii?Q?eU9sYTb9D26DI1uDTsfgL8Sgs0Gtjmre91hDYa0tZivWOp+Mje3y0G/eevFh?=
 =?us-ascii?Q?1qgbrb81M4r3bDD4UEizs/m/T2v75kPio+cWB4DxY9So+1cS6JUFO3CZqFh+?=
 =?us-ascii?Q?0jug1H3IV4hFo4pFbN+xdKubcxXO+MEt1b8TzOa/3XmIMVRY9vL8ne4BlT3M?=
 =?us-ascii?Q?aYx+1P16GgBpaM69lSstPWVmKxeKw0lIHDClpB1mS9MrWIphFONSxrw7Zoly?=
 =?us-ascii?Q?JbEc4UQR5S1XC0V7ZWKPtc6lHcbgIf5Kx17B1Qk2L7tVFq13frfYTKl/VGce?=
 =?us-ascii?Q?ltmvhTX/jrmXOckMc51SSHB+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51df38e-ab16-4047-0d6d-08d9572e7a8d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 09:58:58.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxoZVCORVZ6//bA+f8xfmIZlSNk3Z9aAy4NOiTcIGT/ha1e3k5TLP1KvGuwVBv5OOgtYQqxwVn7JxtKpcMgt8E3gPigUPbHI9K4N8tv79uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2208
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=913 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040050
X-Proofpoint-GUID: LCF-b5xg4JXjR0OisJrPhBlYvzO8MlR8
X-Proofpoint-ORIG-GUID: LCF-b5xg4JXjR0OisJrPhBlYvzO8MlR8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch was based on the faulty premise that the original code was
buggy so I don't think it can be fixed.  It just needs to be reverted.

regards,
dan carpenter

