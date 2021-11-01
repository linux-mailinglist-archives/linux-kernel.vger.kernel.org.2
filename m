Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD8F441B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhKAMwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:52:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48516 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232051AbhKAMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:52:39 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1BeCQY015548;
        Mon, 1 Nov 2021 12:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=aHkwr3fx7D0G3iWZjGR96+g+DPxbAXN/qrIK/PMAqG8=;
 b=HpTH9AZixZvcNV9xTvgOVQm3oA/nrU4ZktCmCQDb/59UkOy0WJWb+fdIbFbvO98/qsRd
 TZoWAo7dqZFTuDGXKbEngoswn7+KcT7tiTu9oYE2WY7GvGRMoKL4oVIzbSCDmSFbBjqP
 cPn8qSQFnEHLAkKwW9Y2FEovnGlaTzaVcHGsjeMJKIBjAX417cQt04fDCYGj5g7eUjSF
 o5FewOpFUhXMks2Ho3QMm+9ZogTUbeP21rZQnz4p+NqLebPeeIvPLIj5D/N97yT7aq+/
 NANOqxispxV66NlJDtGz3RNGpeZObjSDPtoCDGaT/SQoEhKZ2urnVsFK7RXyperhmRsC oQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c27r59mru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 12:49:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A1CfXea146353;
        Mon, 1 Nov 2021 12:49:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by aserp3030.oracle.com with ESMTP id 3c0v3c3des-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Nov 2021 12:49:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A09MO7biB/UKsrwyZ4I3oh3fZfiUyeR+cCJeDXaG1Ny6UdMbAwZwnRZziygRONdH67ELdWs1uQMXqr3VaskBZKjPav++u1529Vo6kq/FfAuBwSahj4u9h86nozClCkTgQXB25I24tRrSeOe8Vh3N0oY/QyP1J0YMKvUnDf4tI+pU5fP85WVwBL6yE6K9+VIw6znx00CkTZsx+gpF4fg4J3/SYH8pInn9bCv+r1XpUJRUGYDsjoKkoozFfyXQ+kYIqW7vNuKjgyW2ezizPIJbp0F4s3u1prIyfkXc2GhflUW0dA/5JP96UkM5LTJh6SX+JDNLUtbWekchTyS+jxqbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHkwr3fx7D0G3iWZjGR96+g+DPxbAXN/qrIK/PMAqG8=;
 b=NDKlSwSj2RIIspyS2EGniMAa6zJLtHubFRoFgitz9sNEu8XAXwj0hA9uiu7Q7UMSeAqz+LUcbboAaDqclqBH/YhgNqLz1X4t1quNMZU9AHO1FWCvA7KrgJWmbkI8MBBDEIB/pZA1sg6dakyspBzrabrMQCoIq6AK+/MGW6zAOW9ehKqXnBljuAVTkTzfwtD0z8xsxkV3Byh7MQq9M9SQkrfBTJTZ9IUkv64JrosQuu+7DAMIMOkM6EoSmacVTbxI/DGcXeUecaKvBExTqF46NkEaTQ1jQZYmdN1p/000hdzxttlfpAhMwl9dW45jeTM668UBzsYnYrZs61j0tKfZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHkwr3fx7D0G3iWZjGR96+g+DPxbAXN/qrIK/PMAqG8=;
 b=zkXl9MlVQJf5OposXOMQv6bM9LFEv3Tdp33jWNQa1E9V0c9D4zmtb5d1DWoq26iIIdXfJ0uFLN5tO2bmn3aqKCYCPT7rZW8xg5RSvTwJmJOysasEiRKpoZk+KTicoJj/wvdjq/7o4I41RRr5uwVzIamOz9Pvkd3WpiWbOtmY8N4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2256.namprd10.prod.outlook.com
 (2603:10b6:301:31::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Mon, 1 Nov
 2021 12:49:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 12:49:51 +0000
Date:   Mon, 1 Nov 2021 15:49:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] staging: wlan-ng: Avoid bitwise vs logical OR warning in
 hfa384x_usb_throttlefn()
Message-ID: <20211101124934.GA2914@kadam>
References: <20211014215703.3705371-1-nathan@kernel.org>
 <20211015094344.GQ8429@kadam>
 <CAKwvOd=eEyjLMSEiBd25-Jkvm0DTFtvcB_EmuRVwqWYjQEvD5w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=eEyjLMSEiBd25-Jkvm0DTFtvcB_EmuRVwqWYjQEvD5w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JN2P275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 12:49:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e16d3b-ef98-4a4e-4f4e-08d99d36185e
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2256:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2256A5ACD1ED8DE44590C7D28E8A9@MWHPR1001MB2256.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eB2M14265sogLSrIIs3ObJp9ZdBjxpWI1qRK31i0B3AGSfIILvfY7fqn1ScR+/K9E7axqbr+0ZaD4fjY+wWzE6KchOccv4+hL7TAknLcPcznWLMXDBCVmKDXRY0jaAfCn5LeznUXYAiForX3KfgPAHOdPllVGzBbugR4nVJquz+E9QnvhBtOU1ZKfNz2VcYhsPsbNs0eeLWI1cV86H9WSVAGUxXnKfkhr9BTz+qOFZZbnI7Ti+haaPV1yaN3eLcHD7xDRWoxGXCy8NAxd3ZwvQc0hnjzSOTRdQllD86dpMYv8n9bT+w7GkIAeERu3Vvd2ituSvUvIh/TMtPd+4OQbcJxUzX7vg1bb7TjR4boqd28rq8W9q7eEY0VGOM/r0qjrau/VJJGpqL2XXxQ/7dVilRiznTGpirgrfFjlTYFDo+cQqaZq5lfVB7lvFnlydySG9NkAKYMLGMiFhPeF3ZJ1SeIAjgxQyE/b1gTPCgUk0+rhYAzhKKIXEChQhRF0mYHrt52d4UFbmMXNQWllLeE45RQsWi5mMmCGEtgYjKBrAIRRL6mTvpY1cAvpfutRiWTmWioz5D73Hpi4/5yWJfl1oD4yVY6eVWcvJEQogfgurj7Fn5eRXx2e0RSixxGaMehYQk3b0QqywXeKkFSkMIpQoeUjt1CchlN2zI4iUHoXQti4t3vH0u7RYFLUsHoUtTEfJ4u9XUNkc3LVhOT0vXWRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(26005)(9576002)(44832011)(956004)(186003)(66476007)(66556008)(6496006)(66946007)(508600001)(52116002)(38100700002)(38350700002)(83380400001)(33716001)(33656002)(1076003)(4326008)(5660300002)(316002)(6916009)(53546011)(54906003)(9686003)(6666004)(8936002)(86362001)(8676002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?koV4ENWBFsI0jV3RqQY/TzzWUg7OGaNbBOIMDStUXGeh16zHkPg6mFmFe1Q0?=
 =?us-ascii?Q?CZfkbrt5xMh+q4QQ4Xc5rAv6JCAhXYZH8+oCZpf17f0dHnvE36Egb8pj+oX4?=
 =?us-ascii?Q?dnkPusAUvg/YZN8ffqniCEkgRJbclvROaFzWb621LPwCRirWOdFm0OHrNohD?=
 =?us-ascii?Q?6Y8o/9VWznj9OMeRY+WyI7QU0zmHuBNoRJso4nfsrz01Jj9XWrSWyu2hakvj?=
 =?us-ascii?Q?NxJoH0mj8dr6QCwVoVEQle0LUs9hec74PoFbGAY2iyRmk6UdFIYnF0JwU1s/?=
 =?us-ascii?Q?8dMJTRu/gyLv6Lxr/Y9IJ1uR7uzotT4aW8x7nHLcjYbYofJ+6D6s2MlxBkEN?=
 =?us-ascii?Q?z7/GRl/BBiDMDlDropS/h4EW8j3FOo5T9UlGJW6q7FOkREK92RL4EBu5HiT7?=
 =?us-ascii?Q?Vs6GuK3Ac+icao7c/lIs44haPboHn5f2Ytqlyn7LoGm7NBPBzHBBSsIaHZj6?=
 =?us-ascii?Q?+g92Y7yjDxnLA/vu/s4T8GvYIBRxVKzV7+uKadWxxXs3PRscGQBVoaS5B7wt?=
 =?us-ascii?Q?Wm4ztmnq5a6jp8FVD3+xKTUdu90jau4sggFK3QR9ay1nxcyMze0r9iyfQmqp?=
 =?us-ascii?Q?Y+IgC4WhzZAhieNbJRctBS8QDXxc6HyyXtrbKlWHdgGJWcGAfFueucP7RYx7?=
 =?us-ascii?Q?tmgiLiE0809qV4G5CnkkI7QYtss5S5pw3+cyu/RKYY9GVfqPkJ7F/EK6t/X/?=
 =?us-ascii?Q?c5rGCUdGbn4koORA2IIu54j91S9818uT3Tr/KeG4jaOCdUIwkcKfqEnlQf1m?=
 =?us-ascii?Q?60JTMbaY6MHEsaAvN5ttALzDcVXtl8YHyCsbGB4+/e1QLGCy1u9KidN/g0db?=
 =?us-ascii?Q?LKqgwVZXOPMTD9HRefD+/dmmXFPtUxMGTPA4vNlFWH1BUrqog7NSV+dpchqT?=
 =?us-ascii?Q?SgUdwrRcDq5d3yNtkKUjsW/lUMaOFW7uSb+i204z5XpNvY89bodjjPZA6aW0?=
 =?us-ascii?Q?sSZ7h6viQXFztoHh5AAMQr5J5+KadRDYJPOFh+U2XOAepYxpDVgzgg2lV2MD?=
 =?us-ascii?Q?UuDOUNxsxJ0EXLs5paXAXMvUSOfRKD7ajTLSYkKjiwqMo+x40Lt6PuDV1KhL?=
 =?us-ascii?Q?ANmpfbO3nkND4I9/i6ysdpkfvJpzq8+7sFxzhzZOS7gFBMcXkMGWVGSayp2I?=
 =?us-ascii?Q?iW2Zz8q1BPq9qMiwoE58osjuESQQrEhpHxAnxplIrcQs9+lGhP+axEGfe3rZ?=
 =?us-ascii?Q?ljCgPlaPR1UWNpnGHJslRPzztJd3ZHaNTd0x5nWbTfgDt+KD1PdiqfgiaI/z?=
 =?us-ascii?Q?i/BsiH7sYlw0xxyCKX8U/bPr0+gX8IS4hx6BjfTif/mHxffyCrx7JvZHE9wO?=
 =?us-ascii?Q?GVn4UfSXVRWpys70/Te9yqQa+CxuhaKX2ROFRCeM445Nkp0+nzU2GXY5Axb1?=
 =?us-ascii?Q?HwtRCHlaXSV1ixD3+ZSSvZToNZs6nP8AmXp2aRQ8NTvBSaQWwrrlZAvU2OdU?=
 =?us-ascii?Q?dNweqbC7SvxOq439D019a+OZr7nYF7kmirC+3EYLMtpeq/LrX2vOn0d37wmJ?=
 =?us-ascii?Q?lJSEdJPqZ8bxmz/UXEZ6n0N2SCLjh7Z+qHMAWFZxwPYXByb7MeqFLvGnTjOm?=
 =?us-ascii?Q?x80o/amEY91+qVZio6O2mi1EZ3/spj5sDj7QUgvNzuZKu+DFbhjC6IA16lXI?=
 =?us-ascii?Q?+dLOdtR+in+yObqMjBik9sE85yAENZHlgyvQ4khoGKh1eLO2q3B9I2nV5kK3?=
 =?us-ascii?Q?b3aI8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e16d3b-ef98-4a4e-4f4e-08d99d36185e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 12:49:51.7251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UICmUPYYE3PM1pZYaJ6GXpaU3IEW6Qr4Z5exLykbkR0sqgal/AxcFskugfug43009Ck5RKcseYRZtEXWCVTUpfqwl/hI4SR7rAnf/iczaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2256
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10154 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111010073
X-Proofpoint-ORIG-GUID: VG4ZOXfCpYZrXFar2d9viJDJ_rgufgyS
X-Proofpoint-GUID: VG4ZOXfCpYZrXFar2d9viJDJ_rgufgyS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 01:23:45PM -0700, Nick Desaulniers wrote:
> On Fri, Oct 15, 2021 at 2:44 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Thu, Oct 14, 2021 at 02:57:03PM -0700, Nathan Chancellor wrote:
> > > A new warning in clang points out a place in this file where a bitwise
> > > OR is being used with boolean expressions:
> > >
> > > In file included from drivers/staging/wlan-ng/prism2usb.c:2:
> > > drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
> > >             ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
> > >             ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: note: cast one or both operands to int to silence this warning
> > > 1 warning generated.
> >
> > Both sides of this bitwise OR are bool, so | and || are equivalent
> > logically.  Clang should not warn about it.
> 
> Not when the LHS AND RHS of the the binary operator have side effects,
> which is the only condition under which this warning is emitted.  RHS
> potentially sets a bit, and potentially would not be executed if `|`
> was replaced with `||`.

Yes.  But as in this case, if you silenced the "bitwise-instead-of-logical"
warning in the "obvious way" by changing the | to || then it will
introduce a bug so it's a risky warning.

Ideally everyone would try to understand the code they are changing but
that's just not true in real life.  What happens is that every single
new person compiles the code and sees the warning.  There is only one
or two people who understand the driver code and a hundred people who
compile the code and look at warnings.  So there is a slightly over 98%
chance that the person looking at the warning doesn't understand the
code and they're going to try to fix it.  But instead they're going to
introduce a bug because they're going to change | to ||.

Of course, Nathan and I are a bit experienced so we're careful but other
people are less careful and we've seen this over and over where risky
warnings just introduce bugs.  I saw this a month ago where Smatch
complained about a missing error code.  It was ancient code so
the original author was not arround.  A junior dev saw the bug and
changed it to return -EINVAL.  That Smatch check is very high quality
and it did look like it was supposed to be an error path so the patch
was back ported to stable.  But it turned out that return path was
supposed to be success so it broke the boot.

I haven't looked in detail.  I silenced these warnings in Smatch because
my impression at the time was that there was a high false positive rate.
That's still my impression, but I haven't looked.  It might also be
different for different code bases.

regards,
dan carpenter
