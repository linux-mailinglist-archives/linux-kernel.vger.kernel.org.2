Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA3D40B253
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhINO61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:58:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51978 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233828AbhINO60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:58:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18ECqvmo006269;
        Tue, 14 Sep 2021 14:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=FcIYiym1rZ8FLKXWV4Se/AkKmMFDjTqnPlXq970CoYY=;
 b=byhjUzeobYJFfrT4EEIAn6iJusgQUumpXqLMRIqgqLbW10lBjZ3woNeAOVprG9RcjMc7
 MwaRC7KR3IheK5fxcQDRYWZ0T1DAi1GjDxl65lCoIzD+7EHARQIGpC3RtMvLMrzCr0ur
 EDIi0vHxLA3tfa0bW5xUFEtDkwS2AVsFJUC0YGldvAiJKRi6P9xFtUfjpNosFxgQOFND
 kWdo32+shb3SShdavreQKxuQpWUzZeGXzhXR2lUQ5eCByii7DH/noQ/whWIKCxVAru7F
 ndZ9IWjsNyY6TGEZoinzMW6PL0NK+fGLS3n/IfVw09dhtYRZEM4B6Bp6ghYaX2sOGXFp 5g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=FcIYiym1rZ8FLKXWV4Se/AkKmMFDjTqnPlXq970CoYY=;
 b=bbTdcPhVKxo6IejLUp91i2DHiyvZnNZHyk+jx5zemvDU4LgZGuMJRlP0N3n9Mx0SBGTL
 tp+1ZXVuEmQRUvUs6kSLwTTgCX0Wh/GKeINk7uwi/4mbNbWLpsMnVLJJNqrzVAvO+6Xa
 u7Gj/NNvaIf7yXgXCNHfYVV6eo+CwvDQ+Ltlz5oZ43JbuJIsD25I3t4lLPCDCgvtOLWQ
 Mngmj5atRj8P7PaZYKSiF9FItznu8XmEW0kzqAPrtiiHn/es3L/N8WKaFeLB87l/irZo
 aug++b9Xfhb+4XGG0u8LweXOk7WKwuCq4QRRUH/Zmd8y5sLO+pmWw7oVfvObNBRVjAzS eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2p4f1tu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 14:57:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EERtbD013570;
        Tue, 14 Sep 2021 14:57:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3b0hjv9hbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 14:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+zY5wixMrb8t2MJtzNjm9RWZL9GveX3ouHfMs4NI8NO8Stx6clQyf3+k+5Fr17CSsOpIHw8D8Ll1eS4o3WeOW2ANj0azOekX8sJtYD8mT0siQNBOQtIu4kLxwqszZO7LulrUG/Wht95fQE7JiI7oO0wz+V3SD0NSkJQvmICkO+UImSowwgLdQ0Dau46gGIcvoXkAyNUkRk9bQPzCXNaURY67uGPP0+eNH19xTg9dSq3PqK1tRc0pYbAzuUEvcAgqhPh5nE2cugfdVMj+PLR+O2fqWFqbUS7N50LA1j6wLU6bjEeDZR0WKo38bGxY08akV4aYKjso0nKYKnoUUv+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FcIYiym1rZ8FLKXWV4Se/AkKmMFDjTqnPlXq970CoYY=;
 b=DLxASkldahgUJFsHpEhUCLwuU9a99YX47MISBOm2QeyeDySfonxyyIgNxoJ29dy1GWgJAafppJ/0Eb7DXiSyvQbi6/t4onZyN52rwxl3b4xV/AUkb2oq/12ydR3qoStw9AxTuTkQO7d1+mxdf2ZZ52k7lM9cl3htfo0UJ1uwTDkNgoAVzSGrnGPvBxwyOeUqLW0V40+MdOovOIogh1DhrThuFDDfz3kH/G5yeSYrJB2SY/brlFENTv6mkiaj1GlmXujg0xmi34x3+XTWB3jGHjGhooaTq9utH02TqDCF3XkhR4iJIxHhPTHHQpiF1ruFPyD6jdjrZ4sW/iRTuvnFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcIYiym1rZ8FLKXWV4Se/AkKmMFDjTqnPlXq970CoYY=;
 b=eMjgxSiQ0Mlypetpu4GU+tUGJrCjy0qEpVETgB+GFRGjrLGPojqTaDo/1XPTSOmictFXRbsCkvkWAt6k4zGnhwLj3rtxO8kjB1cyRlQjMrH4WuRrGvBmQMnDpshYmmHsGMrKqdzhGDovQPgIW7ZrS4WVFqn8v+Rf/SjfXwpsXYk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5556.namprd10.prod.outlook.com
 (2603:10b6:303:143::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 14:57:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 14:57:00 +0000
Date:   Tue, 14 Sep 2021 17:56:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Srivathsa Dara <srivathsa729.8@gmail.com>
Cc:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: sta: Fix 'else' coding style warning
Message-ID: <20210914145643.GE2088@kadam>
References: <20210914143107.18436-1-srivathsa729.8@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914143107.18436-1-srivathsa729.8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 14:56:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8c9f3e6-37cd-421f-e3ae-08d9778fe765
X-MS-TrafficTypeDiagnostic: CO6PR10MB5556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB555638FFFFF913A00749C69B8EDA9@CO6PR10MB5556.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4lTwrFdO/Pa/sQwmrd30QPXkRPNSLAgvq2cSEmHUqQRim5vuw+jVWMvgNG2MaNcxCs9Ig6/3GKalHjI1zsRqpOd+rKQSvTIlJk+EugibvBeZvC7vCkZtOIAv+4sALviMkmBEQ4W3/zf1Azi+bupA8Umf0WA3rNpGclGnjznTkptGvOl2hn6m7zeZN9bVIZLITb8HCh1DLiIEilKisrMXn210V6azXrS/Ax5a+RZ5ItAa5v+nlQ2+6ZG7SYRYUCbFVEe1dukul9KTiSYpqg0/LHOjPQJPZZhEdLfPonZBDFXxDo7VOqteuNJrv9JNmGkIXWTCE375YV8hK6H/ai2jUzqKHM+Bx3nABaJUx0vT+EKf+tH4N+lWpjU2FR0lNcyCJFBxfn2wXMkHdL7lnQuQYIwZdpNFukrsprQTozFl6wIR+1OT8LeBJZzUO2ectTKcO+reJ9EczTZKWfvw3vv9YBxJ9WR9yhoYKDYRk70y6ug+2eCCjKOcMCc/fd6mk5xqN58iZybpVF2dakauxcoc56P/npnaBw30gvo6XuqZXyDcmVlwy98+pDyr/sUZYMq0/k+BFsg2ChhtZ46+LRHddNngJP5OZ7Y3ES1yN96CkWdcDoUYT/KxFbvQzsiVB0EPiYiaNSAnSraJOcQgY8hsHF2j8r+WHYv807XWWg3LmOpwX5Hu6BLMX5vfD5JKDFscWyS8eR88oA9wwA0wrk0AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(33656002)(6916009)(316002)(33716001)(2906002)(66556008)(4744005)(66946007)(86362001)(8936002)(1076003)(9686003)(9576002)(186003)(38100700002)(4326008)(38350700002)(55016002)(956004)(6666004)(66476007)(508600001)(8676002)(6496006)(26005)(52116002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0V96Ja3xZa9xVmfPtHUk2Q5aLgbjvxRiSp3KhGOBpJvLwk7GTALZacRNlJ0U?=
 =?us-ascii?Q?hnX7GHptQTtj6rqcZM7wHEjxcXf4SveG4KjyLUYfsssHETnKlS9vq3kSBKqz?=
 =?us-ascii?Q?m121UANg/hVDFc+TW/N61W/nCqapFra70lZM42kqYAsji4uXOljJv4g//32/?=
 =?us-ascii?Q?WYiMduPocGR6vvV6i1gYCxlHS4TSnZ665gWIVAPHVYXKfMUjBK1d9+Mcfxxr?=
 =?us-ascii?Q?pYtN3XUZeJpYuy3n6jaZvRWXPPexm/rjH93Y4lZ9y0dyUfXd4QSt0xN3ov80?=
 =?us-ascii?Q?sneYV4ALo2nSRFABzUNVsW6Hut1kYXT/gwh/8pWPeRVfbnJ4jduqtLrrIGrA?=
 =?us-ascii?Q?5DGWfXY9NeSmUrQi4pBch0f0eF4l4fjsBMEZCcswQjOJqzSfIbkbwV3MTh39?=
 =?us-ascii?Q?oUSn6mtl0a+9e7WSIuRIKTRD/3QH/896SuoFYCv/m1sle9d6oSnaUF5ZWX8z?=
 =?us-ascii?Q?xksuIL4iLqbFsNeiD5dPfRYcQSj34i8oS4ogeISRHULRiXnWONo0VRAyjeLx?=
 =?us-ascii?Q?Q1iAutsESG/jAeKbhAQroTohcZwywPzdyRAnTIM2RyQ78XrxhgTuRPxX9Ndt?=
 =?us-ascii?Q?6XiUzWfpg6tP9NX5REdhnRNbk10BsodueRiGSgxEGhOyhSLYgLlpHjaAtPi/?=
 =?us-ascii?Q?loDNAxEch8me972C7LAy4p3aZ58zU/Fr5oAEGobQ4rwy+9vhoi69suBSXqBA?=
 =?us-ascii?Q?cySKaO/PdwukVYC7GTu0GEnGyXQCjSMKrtCNoC9JH0wQVsP3AXJaq73Ki2i5?=
 =?us-ascii?Q?f9c7Ci21+uZiym7bOhGdYx393QdeFGWHH/cfhEEdTOUWD2Cy3wCopyB+KWV/?=
 =?us-ascii?Q?9cfSxDOWDDAIhykMlOhz5+O0J3QMna/o/U9SzgpRUOh0vbD1MbmoBqR/BVr4?=
 =?us-ascii?Q?fL4jNzQF41mTqgImW1S+088FHiNLt5JcdbGs4fhXqpdd15nI0l3hlbM9gTtS?=
 =?us-ascii?Q?4Vomj8V9+ggTuQUs/yo5DJWdPDEE5WQBpWjMlH3k25ScFJqcVFAwenJHchkq?=
 =?us-ascii?Q?MS7yGoBreEEEs+qTN4UC/m4abrWxarcO8aKi0m6BmQw3Suus5TLCkk6QrPDI?=
 =?us-ascii?Q?6hqGfFf3g0cBmSlt9lnANNHF7WdZuGaNZdrty+Tb8ZMhBLpq2SnhYmVSO3uJ?=
 =?us-ascii?Q?OSJp//q1m71vUNKVysfIdWn8PYZ4WuD6VZ52schHDu792dDipy5bLqpDjvDp?=
 =?us-ascii?Q?/QHAlYWt1v3xnob3pJQNSZ9kJoLQZ6Ya3bF4ITMhp7El50Dobkub/YPUFc0b?=
 =?us-ascii?Q?yzLLXbbTTFBy9H4xsn5mq3LU2sEz0eIIytCY/sD1kTL7vThpxYnAjwVHn3un?=
 =?us-ascii?Q?EWmqtyzEGfxSaJpGxXSgloZa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c9f3e6-37cd-421f-e3ae-08d9778fe765
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 14:56:59.9206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jsTtf4/ecH8soGLXZA1tOwcrr+Z8kLct2ZlnsY+7C1idxgQJgVF8GvOXkTP5+BOWwGm8wDWIJupv61DzB+5XpYvNV0KtgYdAsg363PjmNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5556
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140090
X-Proofpoint-GUID: 4fbwoSgzgrnvc5rqApAZZUAm5Xy2sGnb
X-Proofpoint-ORIG-GUID: 4fbwoSgzgrnvc5rqApAZZUAm5Xy2sGnb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:01:06PM +0530, Srivathsa Dara wrote:
> Fix 'else is not generally useful after a break or return' checkpatch
> warning
> 
> Signed-off-by: Srivathsa Dara <srivathsa729.8@gmail.com>

It doesn't apply for me.  Please check that you are working against
staging-next or linux-next.

regards,
dan carpenter

