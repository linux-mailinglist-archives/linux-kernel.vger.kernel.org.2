Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C953FCD43
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhHaSzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:55:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15334 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232420AbhHaSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:55:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VIiNco030576;
        Tue, 31 Aug 2021 18:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Mdp1grqo+qShmV+bZ3X50Q4I6Ui9j8eoKF6XQTtrzcI=;
 b=COZqGZrILTfTcQxuK0ZmtW+VrPbztnryPswjzab7oA5b5EB6Y6uO8+mod45a5LK2aplg
 58BjYvo6JuJ8LM2kRQ491f259W398/zHC2+MyESQ+2J0/OflXv2Jn7zaglMpqXSyFhII
 ivX3gWvUwfLnsc1Bn6knzOrBoM/jHptI1ZG/rhb0bNiv7GsmyHctWmXt7lUeLHzTvZ+0
 wxgQDq3NBo3L4e1yblINnqA5NlvTuaqef7hOkSzbJ85nHLu7BreA/i9aXlNAifM7IH6S
 sl2nCwXqwmnvKu8zPR7TZShQvb+5SLmo7sUERS2lC9a7PTrdcifPUCaUgaEIsWWnMurZ Iw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=Mdp1grqo+qShmV+bZ3X50Q4I6Ui9j8eoKF6XQTtrzcI=;
 b=m9OMcCq7e2rwgDESp8xAKJUKoXcwbqz8hncUNNWzh0JrnpceBo046A70Tnwdk0QR+Bdj
 I96z5S1GzLoryN73xIoOivUY8lz90aUuDfHThmY58i4hqnpjfY1BpyEjSVexhc1w9XXG
 5x7DghugjWpXRQZtdEQqd4usCTit0ITSleOq/pKpAVc4p5Px15VJSuMmi+KIy3GjFA+t
 z+lD9YCFwZzqEXIMV30UaqC2BRwNcytTQ+ul/UN/YEvgj9EhIgtRFHTppD4SgI6MqiYC
 h64Q7L+8t98vCXUIAUF7zPoHaMtxuVe0PImGExTXdufN2jZCQBPZ51qxrc3Sab34s2Cd Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ase02a527-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 18:54:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VIpk90105309;
        Tue, 31 Aug 2021 18:54:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 3aqb6ecnwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 18:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIINwLmaa3Tw4+kbegg8y88XdvAO6znpUwXJH6gxBKq06PHGDr+NjzEp6Gl72cxRyJTGcPVFHGI4F9ab/0QrhCg9SwhEinln7uYC176p8FdSiFh1Ecxzz9IXgFmz+wuReiPAzi/5+yILNbDeH4kp2AgiRGTiKRuP7oWNgVgtk+kqbkBmCS8boH5Hu9XPZANR3f/hoBT2Kkj60XHh79ZwnOSYkk/4XInSrvv29Qa9pUdoFZjxgioC3HqSPtTmnneEKINgBcLIv1D/77fsinqPU8l+FsobtVwljROyjyQThjHJKoJX21H94JdirzVmyxsrINUlYRzWPrlVCcx5f3ttBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mdp1grqo+qShmV+bZ3X50Q4I6Ui9j8eoKF6XQTtrzcI=;
 b=P4a3ewmEDt4+1yf2yRSHUIER/PevTpYYOxjjanDXx3frU1XVrVFLdZmVIrTDUMcjt4EndcN6gRNsnlYPHHCwp0WZ9kchG2UfCDQQp0zK9w0fhJRo3vsXtILV0I/6sjlPfSWZ0YM37GVnMYX1uPssKVQRoc8xZwPvBCtIzjAmvrr3fCqVfwksrahWIzZUkbbBFFpZsW0mZAZMZb2U92JYu/jW8WOqYPr5bWN8vlAh+R9dGIsWva9n3rilp5m0y9s6pfsdPQ/5ad9dimIfacpGOV6KAL6tyI6bTJZZP8Q5E0+mH17O80/jTCZ6FDqLqQ+2qR1kgPgpy2CCBbUurMnIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mdp1grqo+qShmV+bZ3X50Q4I6Ui9j8eoKF6XQTtrzcI=;
 b=UgSpHpk0oHok2pypeyT544NXcgg/TmutrxZiYXEcsBJXcpjtz1FhjO9SV9kUajZX4ZnMGRXZzCcBFiiEajFCK9wHhhzYDvlAr8J910bSLZZgi9dYYaS10hEGZ52nYj6AXrp7tOXxs6Rc8sVWyJBnHIpDZ91mRmzDamErmGB8Rhc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 31 Aug
 2021 18:54:47 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 18:54:47 +0000
Date:   Tue, 31 Aug 2021 14:54:44 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mlombard@redhat.com
Subject: [GIT PULL] ibft (stable/for-linus-5.15)
Message-ID: <YS569Ic7d0k9J3+E@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MN2PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:208:a8::41) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (130.44.160.152) by MN2PR12CA0028.namprd12.prod.outlook.com (2603:10b6:208:a8::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Tue, 31 Aug 2021 18:54:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28d5a65b-6c60-4aed-bcaf-08d96cb0ce14
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4606:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4606029FF50F9A2ED6D50A0A89CC9@SJ0PR10MB4606.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVTB2dy0tYuToUaI22PUIQA+uTB69ffdJxYkSPjE7VhHWC2QJXSzL2srvRKYYvEMa8nZazsu8N9vwhDF35IZIk2rN0JV8g2MgrolPXDIZjAZ6Drr3agWDLrgiB7tm27n+ZLmW/QO03+En74icZLAItbJvXOQEGl1TzHhPDY13sAEhV5hzDxK4BYqWAXkBnFqV46suc4IZB9GDxV+rTsdKrMSp4JTO4ppItN3+1ew4p31k7OqZZaVUJmpjolvTMEWeIXwOgPJr67btuvC0x0Tyr2FRjKD0XbxR9CH74eWGvqwOtZ3sxmzWWdiSwIlC5ZknITcRhi17fNXWqCWZ2OPK9RHZj1LumIQ3wyKvxTEz9W+2DjXeCzq6RXDR6Xl3I6OevZVUybjY3Ti/rCTyR/IUnOjzwKjIuNn7X8Vi7KeTrLFoXyccW+L/fAnne0yfs1GX+IGWJvEUiujubNO44dUrHbyuwxxSDdB2t3MgY+2arUxtmjs3S48D0ncB+rcMDcgdCRm8Boaz/6I1QbJiSZiQlxmPyr/0AkihuiEeTr6rdanxNVVBXCy09edI7DPjnB6KLdgG6auLyi4vuKiVFHOf+j0KLYdigitavHGbTLXxQAQBbwovBsoQOqfbobrfLs4gJsgO+emZwez030jXFAF7fdhPdpAa+UZK5fijT3UZE3TNxUizD0D54kYQKGOlRPBlECBDxisVxQU3LsSVOvcCLbQv2uPdYtAybQ6vFuDcW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(376002)(39860400002)(86362001)(6666004)(8936002)(9686003)(26005)(2906002)(4744005)(66556008)(316002)(7696005)(66476007)(956004)(8676002)(38100700002)(186003)(66946007)(478600001)(83380400001)(6506007)(5660300002)(52116002)(38350700002)(55016002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWqtGr1lFiKsI9gmBb3295KtyXg8e0XwgzLqTrtg3QEpC59unSkjSeQlQfDU?=
 =?us-ascii?Q?H8bfVfOJi7uOAJvHdP5bfYA2CFmRAbmF4XyN+xS/BWbsjLFQ7yM5SASArVUz?=
 =?us-ascii?Q?NbqTWUnF3jyubnjWymTGn6nHFbl8BEVWPCUiqn5eGYQJ5n2by/tNVSA1QCm3?=
 =?us-ascii?Q?K7kYqDXsNag8YjtgQVgE4QCn3oOHVmMj4COgI0bANQnQSYGOwC+9DQmE2XV3?=
 =?us-ascii?Q?6OD79bT5OalGIliJoTYzl3ZN4c+/XzgaaQwBrnGnhdUj8C8JAAVnDg86wGIq?=
 =?us-ascii?Q?XAm5Ij503TjQAdbCAzKcFz+OYZN3xwugqBfkq762svLqCSwZL6Amdqky0T5U?=
 =?us-ascii?Q?LdIvNHTrSnngMdyU2ZQX19jjsKMUwD7IHxXqwzOGr0LMtlv1fp6TCuSxqQo9?=
 =?us-ascii?Q?BexBDhvl0sy1jsj9+WDxYGRi+Bl2YPZShKuUdIuG5l4ypgvi6zA3L5qB4WcJ?=
 =?us-ascii?Q?TnxM9OCImHUNBVThxBcrOCKwSUNkzvwzc21oAZW2WhT+HiUHEkqKrAhOkB/x?=
 =?us-ascii?Q?isYITcumATYgzbT47ACRycGGkgS+yHhKrWbFQLLU9vvTLHIN3lMKqSbTBogQ?=
 =?us-ascii?Q?PhCRDEPwScLWv3K/gKfzb6T+/llGMh/bOtlKceJtY7AqXEcJ2A8yPmxfJNNE?=
 =?us-ascii?Q?16ViwG35wQPwhxGCBf5cR4D2On063kLyjhQV6Yzm57mA7/vKCrCwcs9AdDCE?=
 =?us-ascii?Q?tNl9GsGzx7b79viZL0tyK5beA6kDdbWrpz1ruT0hYKZWTHc/YUyp5GnL8KAz?=
 =?us-ascii?Q?fhsmo5YXeMpaNkvWOAow/9nWMjTVRgtywfHm4ALqJF1/dD9jmxF9+R4Eds9g?=
 =?us-ascii?Q?mzdPXWd9PHG6wOmOqLGdUwnbDHpWoNfvViiTgUnJg9qfo0XBqmShisbHs3wk?=
 =?us-ascii?Q?DJgG2aYLTAkLqFmlnzvQaMM6IOWYN5AoJAw6WRSuVoxJkDOX9a6gmQi/NE4I?=
 =?us-ascii?Q?xxc0wpONuzVQ76rKQ37QGxj+56tc2Tw22yF3aC3dScrlm2RCekivw5DmBegq?=
 =?us-ascii?Q?kAKQSL4qYRogD5eL54+IvY/kTyElStDlc4DcVelcGhUrEB3pE9miLqjmry07?=
 =?us-ascii?Q?79NhPNgom1w+aincddMKmENk1Shv9EaYvfAN7QTZeAYiuR71Pm4j79G6O+D4?=
 =?us-ascii?Q?oNdimoiswKiq6DRpVtsIxjejUBbNkSbu+JPhjN7N4OcaEVga48NF6fZV9IHR?=
 =?us-ascii?Q?osTQVXuedkgodAC2eh9NkkBprofi3aRiW0962+7dMl1JZQB7mg7TGC8N4lpi?=
 =?us-ascii?Q?RJgdd900wFoDpk8XxYz+XZ8pTvpkZuVo/J017eRdagyAMwUqm+IZtG8aB5ML?=
 =?us-ascii?Q?/Vm7LLMk30CtAZzuqhdDDmTQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d5a65b-6c60-4aed-bcaf-08d96cb0ce14
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 18:54:47.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOPEicMfSotv2mpBvdp0JPjKodPrrM45ghEFhCFxQIkPuy4IjgYigTFm0oAEcfvGuQ6KUOz9JUJT39EP4qkcwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310104
X-Proofpoint-GUID: EhFRXvlgaJa4Tl928Fs5toFzfFuWZwxY
X-Proofpoint-ORIG-GUID: EhFRXvlgaJa4Tl928Fs5toFzfFuWZwxY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Please git pull the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.15

Which has a fix for iBFT parsing code badly interfacing when KASLR is enabled.

Please pull

 arch/x86/kernel/setup.c            | 10 --------
 drivers/firmware/iscsi_ibft.c      | 10 +++++---
 drivers/firmware/iscsi_ibft_find.c | 48 ++++++++++++++------------------------
 include/linux/iscsi_ibft.h         | 18 ++++++--------
 4 files changed, 32 insertions(+), 54 deletions(-)

Maurizio Lombardi (2):
      iscsi_ibft: fix crash due to KASLR physical memory remapping
      iscsi_ibft: fix warning in reserve_ibft_region()

