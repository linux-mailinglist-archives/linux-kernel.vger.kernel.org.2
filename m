Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439724005EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348839AbhICTjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:39:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5924 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235044AbhICTjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:39:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 183Ix9A1016366;
        Fri, 3 Sep 2021 19:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=JlVWHiwgMnzOkvXJW99AHogLrKgj9cuAbccl3rUMSa4=;
 b=XEdZ2KYrRbu4Phc9UAfuree6QTgwP2T7hjC9CD06hDsUQRLxL8wsoHKVHnYDGWZYMzTS
 pq2wN57tXE/T2dUO5owd0lSkXg0NgGlDGq7MYriZiyhJgomb9My7yrys0D07ORCQ/NNJ
 zBoK+NTErc+qfqu8A9BTCkaPpndkyd8GvMR416Jt6eeGulA/gjgjXojAigqXTLlXJfFF
 UpSvLnXLklrDrtkIAeuFGGCyxhVXC7cCpVrAREEPbkvKbCZ4icWkG72E4uHoeDQv96jT
 ZG1htBJAUGERHWIv2KuGAs8UW+EXYhej4VlItNp+ko7dDORbMZFjLFixOA0OsKb5pUgD 3A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=JlVWHiwgMnzOkvXJW99AHogLrKgj9cuAbccl3rUMSa4=;
 b=HBdy7aT0O0CuWO9/3iGaYRIQINy3XHBrkB9dZb0oLMAcz8S+eICTkcjCv+TObTT1hE2C
 B2Dx183OL+x42ry5jOJTInwqQgBXUss0WWwEQyCci0PHzysLmJ6mlR9TmjgIFRaEI70r
 UFkuh2ZlC0uF95liFI91XBb0NIPWlEzHRDYfIHx4/2OaRGpDl5Z56Jmlg9UZNBViH+zS
 8Ubud/D7J19aeNGocMZUSyjLnsMwI7syG8SxlM61mi/WMTnYAXTiifbHdsUifeC1Nbn7
 DMHswlFuSPUhSC5SeBblRPintVbNk1yaDyu2T2s771mvhd5PzEsmChezNKPIzAybvSKV dA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3auh1r1g9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 19:38:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 183JTuNX164618;
        Fri, 3 Sep 2021 19:37:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by aserp3030.oracle.com with ESMTP id 3atdyyw10g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 19:37:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2Nkeg1PJoznccXrsbLyKnveLZd0rrBf04b/tCtmP7l3Uq6HvnqS94ucE6wPNfrShEEthAadwKRI/eWR4ZSuslRApdk9L+LndBLRxkZrGtDtDfjMbF/z+IspvdY31m9uLscwnaraPuZ58EapO0EpuBuFc9PlJ8j6IFgfE1yb6xUrVCoXaJ1N+W2v2brhIOFTEiJm78qykkS+6JdMXe3jOyx4NWWySTJHTER/2FexUmgM/a7uOoMJarcmdAXAbrSSxYKVYtJJO0YrloY3e9bwlvr1oNwr3/+6PNUtQfR7VuQhT6f7GGw3gzQqTTKXXw5pmyW4Xjxc1X8ZuRsPjyEGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlVWHiwgMnzOkvXJW99AHogLrKgj9cuAbccl3rUMSa4=;
 b=Su1vQUM77lEFIVgGL5x5JvSrLtzuINNSoNh7wYizmHScibf2YzG771AinICbC0P4tym6NYvdXEdhcuV8aXhx9O69Dar7bg3Pv0szn1DIbdWrNou/IkFP6kXGvj5WosFtNOlZ9JB7wDGY8AF9Op146fsJcDXzgSOkPWMqPT/IKxiuc0q3DWjo3NH7Jq+C50p20rK4ZfjU0CSXJQ90g35E4LFqSa6P1Qru3wbH/5IKTx69XnBVJXd7vWD9vFq8YwOqjMc6nNFfrebjFgXqW6kJgUqDWH1A3rIuVHNQceGoMVVOQaAqnjSphJJ0saimrU1OnCRQww5SfDptAWTi0IzTJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlVWHiwgMnzOkvXJW99AHogLrKgj9cuAbccl3rUMSa4=;
 b=jFL6f6WENuJLzvSgTKx2lLZHVBaOjHvqoPK5H+tvi0PIsCPbJ6/zkkxzV8N0mrRghNIKYQsI5isFhL4WJ1KCzEjhnLApV08DVuxII5lvSZKIiTNVlWZDmeRD1kbDR0gNpDq1JGcaqdMocnmBLCJ0fEiVteXXJOPBe9rS/5RdDAE=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB2774.namprd10.prod.outlook.com (2603:10b6:a03:8b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 3 Sep
 2021 19:37:52 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4457.024; Fri, 3 Sep 2021
 19:37:52 +0000
Date:   Fri, 3 Sep 2021 15:37:48 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mlombard@redhat.com, rppt@kernel.org
Subject: [GIT PULL] ibft (stable/for-linus-5.15-rc0) 
Message-ID: <YTJ5jFf9iBC50pMs@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BL0PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:207:3c::21) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (130.44.160.152) by BL0PR02CA0008.namprd02.prod.outlook.com (2603:10b6:207:3c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Fri, 3 Sep 2021 19:37:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b5cbf55-9f6a-48d7-a9f2-08d96f125214
X-MS-TrafficTypeDiagnostic: BYAPR10MB2774:
X-Microsoft-Antispam-PRVS: <BYAPR10MB277431832D2DAEAC44411F9189CF9@BYAPR10MB2774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+3nQSjup4IdCGcZA5RY/WldaaCbWXcR6SUavdEfcTztFBCJ58knvrkK+M06K2B2qjUVbCqYalIUDFEJDHLWuWgQtBlHNsuADg5QjxzSHXX/5xSFGbk7NFiDhRTQodiTQPW0rCWdnqtXNRAncjn5iPVwOHSYWx098EAmVffCeGPcXNiR84H4diLqMeFNyaRoEHG033SZFESTjNfuhi4hmXnfIh7q+zX5X+39/JB7K02EPvy3yX8PMZ75L0NAo69VtrZnBok/ILioRzOVr7sCQmvJdkHOvnSuU//A3GuHCsZxDW/3BHuTaxtmdspe3Wa25df400+4ypfqKqlUMYVrXmL4yo+NCh+CzH6dG/95ooQZhADihd61qzl0b52sFo5aNYy80BblZfvt8DG4wr/2JsX2AyW1oNmYtiqD10RD6ViU7l4SH//+LXzGVh9JtnXf0DOpYHRo/MKKZQBxt4ioQo2e9wVFZHocsHjqqnLb+Vusc15mSwWyRUfyww4JlIisbpzTbMpSu5bdqh1diIvIg/RL4uALjsDkqU0p7cASJfc0ptgc8UZO6rLp8lebQ2wa1ukeiz27x0rCBj4rQhMHBte3T68vadIjO9mqikpxz00p6ufJEA0EEesrYWuFw//CzYRrkwpUGJKJDQlI13QT6aqH7El4g5MADI3JfBtgdXGB25FKyBId8GJLLz9ZAv0nMa8jQX2sYYF4SDmRaEUYzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(136003)(396003)(366004)(52116002)(26005)(86362001)(478600001)(38350700002)(8936002)(316002)(9686003)(2906002)(38100700002)(8676002)(5660300002)(186003)(55016002)(7696005)(4743002)(956004)(66476007)(4744005)(83380400001)(66946007)(66556008)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cUbDfRuuPsRX5fd8kgrWJNbi/R0XUbVZssTJoQlUeLP+cBHHBm//MB/KgZ/0?=
 =?us-ascii?Q?khIQgtiRIteyDO8De/GrxgQVNJTrD7vRcPkAEVZw80QD+yfFw9egrDYiunEC?=
 =?us-ascii?Q?nrT6VmXRDh33bEtndPBZnowEKRBf70RZLkn9iy5Ue4uVCtYaEGMNkOlj3aNP?=
 =?us-ascii?Q?KNKzJdZ6fGG4CP5T7uvKZi9XOnhTegcFELMG3KHdobM4uRPyHZ4gWGOBNby/?=
 =?us-ascii?Q?/wKStbLUu2J0naoN3FjO7ui5xFOHMs8daKM/zfKeFcHOYwsUnbYC7ZxMvdDX?=
 =?us-ascii?Q?giimgGdON0LvtttVeFV3S+dI+vSOfltEUdXSzAbq3+X4Ixf0ZypI9Ul570hJ?=
 =?us-ascii?Q?3RxzuoVr2kPq0pH8KrOkilW3nxDjZfXHnTp8eCdnSDBErpwEry/B0O87iC68?=
 =?us-ascii?Q?/qPWUQ44kLlMyG/LCnz+limXmP4RZ5PCKwbCjSSNtUkzPKzVVHWr/Q6HHaCN?=
 =?us-ascii?Q?KUQrmEhtLWEzKOu8BDQDXajNARlTu9sllc9x2/HjXH68SMldeXGcmnScsJgI?=
 =?us-ascii?Q?cJX3Eq+q1FOVThHFnWbAHKwHDKb41fq+as1uIBqqhGLKUSWBXHvrapRM9Q9G?=
 =?us-ascii?Q?V/6NPGP+UFBGbDFu/B/B5R+MXPtIYu0WijS2It7cUI/D8kJuZblWdgviGe5H?=
 =?us-ascii?Q?y4Z3znHhawnsRmzFYGcu13IPIMkv8vuMFHP6RhFy4mHQuWNc6TU/GE80O0uk?=
 =?us-ascii?Q?5R7Q0EM7Bdo6xQxwfsvraKhljZ8p7SDgstJpV0+5ilPuC+n5agUzH76lIcww?=
 =?us-ascii?Q?ddfqON6FJo8cMdtYxV6XawBWgffesuuwQUD4+B4E8Gcjy6i5YJ0RWIz6nKj/?=
 =?us-ascii?Q?YjZNLB0U5hIQbhjt7nThaExEfESz/bB06LIuDmveOr1/TkHAlYQZpdCQDpCC?=
 =?us-ascii?Q?ColnQCk8ojhnZrDDtyb+PkL/yk8eNdmgx07guCNDJmKso2x5AQrGW99VqS2Q?=
 =?us-ascii?Q?Dhnyl04gzBDd3cMnMpIfabVzFOkpn26oZFE3mmH2gHf9lSLzramhIK9uwI3M?=
 =?us-ascii?Q?6vn0CG3FmTvtMfSsqdsfuTQ1p1V1Ybsd75oxpHsL4xtQWtUlsu2565qH02b8?=
 =?us-ascii?Q?NKNQr3eSv0P3XlNE7QMFJ2Zag4Bbjnqq6sOSV5D5GHf5fxXLlhZT0h6+5a5f?=
 =?us-ascii?Q?H3/Almhu1bsr+z7nFmURE2Yv8DC4xXASXgnrJxJXina5Qrra/mfUQ+coT+lG?=
 =?us-ascii?Q?Jp7bscMgnJ1an//offeznt1+lqfqZAqYjkm4g3kGhuvT8PzeJF25t6ALzFOB?=
 =?us-ascii?Q?yhc/Y5bNcvuVAIJDeLcxEIPY8xvOlRhO9tsZ0wWmu8auWWixlxjYb4tOyF54?=
 =?us-ascii?Q?XZSfkemgvVSEFO/EjoutMZmo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5cbf55-9f6a-48d7-a9f2-08d96f125214
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 19:37:52.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFGHnyhc12e+NeZsr8RriL97lG+b92joNXmr0g/vEH5McfFc18x2sq0eHB4hj9ONsYK0VVXjm/fIjV+f1o3Z6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2774
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10096 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030114
X-Proofpoint-GUID: lNWFgEu13vBLBzgL55z93yqIXd9hlFNe
X-Proofpoint-ORIG-GUID: lNWFgEu13vBLBzgL55z93yqIXd9hlFNe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Please git pull the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.15-rc0

Which has a ARM64 compile fix for the new code that fixed the iBFT KASLR handling.

It didn't make the initial git pull due to me missing the original 0-day
build email. Luckily for me folks reported it quickly after you did the initial pull.

Thank you!

 drivers/firmware/iscsi_ibft.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

Konrad Rzeszutek Wilk (1):
      iscsi_ibft: Fix isa_bus_to_virt not working under ARM
