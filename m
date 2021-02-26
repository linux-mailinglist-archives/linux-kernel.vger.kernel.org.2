Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD232652A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBZQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:01:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhBZQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:01:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QFrYRj171019;
        Fri, 26 Feb 2021 16:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=HUYfhR+23n0IyOXu2ZASgr94CQhI0a/4TpndNQy8RdQ=;
 b=nEwxJ+w+stOeLKRoZY7yilxMG2t/6nM9G9mLJMWlHrp4X2ZmyGKabUqjKWtMVPlcnm8t
 ZTUbOQ6+gG5p+7w7aSszRnDh8VcKjxDr5oNC6q7HkEGQEnFTWWsFIv2bY+3R3F0nY8Y9
 +rcn0tkidFWpNVRj4T3WZBLg+TgkExjOfZneXHA0YPfmjTOUO/RgYDHjO7kbZaokjDZp
 /daY1AGF3n/PHV4GhJlUwkMCDe/tiWW+xR+eHorigt8wyPJGYjkj0oRZkrSLH82u73hf
 nAubcA9n315YzmJAWGG2vupEprE5LC81ELMUfLV6nGCEfI/5FksQSniEIuIZ8ZIN51fY Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36tsurafqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 16:00:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QFugON037983;
        Fri, 26 Feb 2021 16:00:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 36ucc2spm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 16:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXEv3APDA5diygJUtu/VA5qT3ihhnawRKa81pTVTePZr4RvLwO7KX8CNzewlv2wAvP0C4MFN6U/Bcmq9dWrYYPE5Y9V8hpih3WdEA6GL+C8M3Ul8Some01HWF6JEAdXXahU3TwEoGXlfYYWDBnM5ntaed0kMt921TmJsZ1RyAQU/lId2OYyTGQPq0tRhYwqcn5thwRf2+Ap2NQkPxRE6M8752yT7hlaLcalbRJ+2ZZM4nwYD2P3Uo6Tdmr4D1JXbEhlb69JfVW96rttRmVOPB6yz0a15pSMWBBHK7uQKACqD93n0XZy2z9S9aDACEk5GLWx9UIFXKwsB3BrlYQ7o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUYfhR+23n0IyOXu2ZASgr94CQhI0a/4TpndNQy8RdQ=;
 b=Fm/2HjLcR1+1DLZjKwzlxAqVjyrooj0NNnojW6TsF/7F0I48hrywb/ci3gGDoVKTZJfpLlF9PKfyrbesoXqRKs20o65zCH0RoMcihvPmKCb9Dt5MC3whaNkZwpPfswRpACVgFzecNj1xhW/C8TgHy5KIUoPpenENR9lMuenZkgCFlFZAQgbU47cnpFNqyK/8CpmBJf2/srrDsnuijGIFjdIyBNExeMV96UVVVNMbNm/Od2lH5K1UX8efZrDEZS7cxJQa9YJLz9+Ew7edojcr1ixMGqGefIpRSfjE6kNpXFnWRpMLPdsVbiH6cLP3hn4BYHJBEnV0SzXnkKWNZEY91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUYfhR+23n0IyOXu2ZASgr94CQhI0a/4TpndNQy8RdQ=;
 b=KSl81Ayd8BU6rlgv2t2h6jp1USOQKGelxutSXSGVbjzokijtruwp6PLQqP/8WmVEqqzP8DLjhGZ1x4rkeQZQudazulp5h0k69M2z9hX3VAavjCqFsF6YbqW1rkFXvwRweueWK2Fj98FTbtriz3we3+c1dMx7bzk+rqL1S4tNLU4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 16:00:12 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 16:00:12 +0000
Date:   Fri, 26 Feb 2021 11:00:08 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] (swiotlb) stable/for-linus-5.12
Message-ID: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SN4PR0201CA0004.namprd02.prod.outlook.com
 (2603:10b6:803:2b::14) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by SN4PR0201CA0004.namprd02.prod.outlook.com (2603:10b6:803:2b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 16:00:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0606f373-ff5d-415e-19e9-08d8da6f993d
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-Microsoft-Antispam-PRVS: <BYAPR10MB31607944E355D6E6F653075F899D9@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRAs++uvvmhvfm8X+6jIjtuOCryQA6dgj+CCy78NoxJlxeuI0H4QYVJXLTxNzbo6W2+L1/uc0hcSNqdeCXdAGEdt91kWje2y8BPyHYJfMjH0WGs7qEnne863VY2eITvH4Xr2Ct9GHG22N3gO62i9oFSnPBgCT93kuCKDkcqhf5+PrCodn0qvBKLbzk5/pHNfMAZlcGc0/HMiC6rZ/DRUo6MP+h8F040qCkykHRzAHl0dWnoGTE7Ws3a5H6N/m1N/MN1MRVkMe6W8xQBYVNzaWqlHfGTcwXgTeIku1VzeSSBUIigU2VHC40VxvyTI/yQIK+11mLp1eVWOeaRRjkX8smUHkPbd5jSdBG0sRy/1QiuwN9lY/ALBGB/mcshW9b2TvPb1QxvAwABKzwmoz78IZYfShq+OshNo+T3+Zfhk5FgB+hLGQVvojDa8ndJn+ZLfvkRh+GpLM26uMRCEXN4AJkpMlniAOSMyl5jOIjJACqS1b9VbSKtXVcSvNZabcCaWdHmXTURKNR5V61XOTqVsOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(39860400002)(136003)(52116002)(7696005)(6506007)(26005)(66476007)(8676002)(86362001)(316002)(6666004)(478600001)(186003)(55016002)(956004)(66946007)(9686003)(16526019)(83380400001)(8936002)(2906002)(66556008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rnl2XrUS77MDq+Ue11HRfWB2OLxBexns1S0bN38BdS3jQLCPshzuGaHhc9bi?=
 =?us-ascii?Q?Cr53rGiBdjJIqFyBaEngA1r8a7kvAb8zX+kVN3u0nRxlt2Is505zrbO3xchL?=
 =?us-ascii?Q?Y/OEym2GGDXPHyfuC1CxQTXQhy7Fv5gYFuAwhTfGXe/VKLZt1V1/3IpsJow6?=
 =?us-ascii?Q?FdELuCyrJDWuuFitc+E80EpfD09qLgMXThz0UJajZIe8TTfwg+bhNLEMt9dk?=
 =?us-ascii?Q?jSO8tyT8pvC1EKtwODNBwEhGcLnREMIALyC7rzCMt7uKzBja0ZJPSDZD7k3o?=
 =?us-ascii?Q?LEZ4+ra4UZVf5wyNgqR2vaMcVLATSV7n1u8XGIQOx6DHAfZrbtPraWvtWkLd?=
 =?us-ascii?Q?akgdIElUJPk6JUqwYusD7RYJ+0QKueuq+R5opMN9ZNO2Pc8lC0tRMYjXF0mY?=
 =?us-ascii?Q?agdPW3y+CfbSSje6xKaTloEse3QTQ8C+lOg0zpH8Sycj6KEY8JLMYHYLfmqi?=
 =?us-ascii?Q?HlqaqyxnIw48+vf1U5KUxA1hcbzWeDx3NFz6H+ahHvbc+lwakfqc/AFTabGV?=
 =?us-ascii?Q?sEhXrLwTXTF2n76qmXmLivNAf/DAScq5xCx4BSsBK5DNRSF+8Hn1pGUgkFab?=
 =?us-ascii?Q?6iCTHVo1mgMwXp1ZtnCYAezKWfpgcI26bfWeU3mHd0HwqiuIe/Pp4HEpAI88?=
 =?us-ascii?Q?HuJUXsTgOKITtcE26q5vetf+6CLVnaFdbuysPfFIi3az409R8EDc7lYpcpHQ?=
 =?us-ascii?Q?57NdEt+2+Vtu57P85CDN/Vr+x0b1blk333BQ6n1Pd8FSPATK9IIcx7Qx/IZ2?=
 =?us-ascii?Q?iIu5lzkf/Icd2FEi4dtDVKuh/UYp5RvqmCV0MJ/Nq5k6roDG9nfj7Ai7lCsR?=
 =?us-ascii?Q?wQPP5aSMwle5agmbuqd4Jt5un/cpu/0oVwbYywKxGQx8YnWKIji8ovBz1frC?=
 =?us-ascii?Q?ev8CaceNiFSk0/yK2sFrmdbBk8sQNAMzZUnmZqxoLyucJYwafjRJtk2tFVVU?=
 =?us-ascii?Q?5iTkcmh8Haz4A+gMjfjvElaw4UMybu1KV1UXLfSwlRnoMQjI1c4OgF7Z6Xms?=
 =?us-ascii?Q?pzrW9yKScMdHQz654yUq6dhLMSVwWSK/nO7zWuw5hqRYg75p/uZ+SdaKJDeL?=
 =?us-ascii?Q?DPiRhr2nM3VfBM/h32bXVXA490Ov7BsgROJ7X5YtJaGQYUwfUHrCkBfdEYVh?=
 =?us-ascii?Q?fMbSYl5CAGeRovhvdO1bWaPXh3haOJQGbgCBxd70taXTANp5InV/BZ0/MLrY?=
 =?us-ascii?Q?MU7rNG+GokPwLkAvWXYyQibV0aiuK5KFt6Toof8F8b+Y557XXF6Hb3qBf3ur?=
 =?us-ascii?Q?rCIxzYofURW37XN293hQZg+563tMeu+R+tNJnap8Me7Pb2mUtn0IT1vBCvVc?=
 =?us-ascii?Q?mXtTe7JZ0QifeFAsEWgpIGJZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0606f373-ff5d-415e-19e9-08d8da6f993d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 16:00:12.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxlzbY48OM16i7b0jwn52v4Ch58b1ZsR2PQDzVU72LLa/K3SUlZTHHiySRDNZg3G+uYhjCedTLm7BENfCPb1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260121
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Please git pull the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.12

which has two memory encryption related patches (SWIOTLB is enabled by
default for AMD-SEV):

 1) Adding support for alignment so that NVME can properly work,
 2) Keep track of requested DMA buffers length, as underlaying hardware devices
    can trip SWIOTLB to bounce too much and crash the kernel.

And a tiny fix to use proper APIs in drivers.

Please note you will see the tree a bit fresh - that is due to me squashing
in a fix earlier this week, which caused a conflict later, and me fixing up
the conflict caused the authorship to shift to me which I just fixed up now.

Argh!


 drivers/mmc/host/sdhci.c    |   9 +-
 drivers/nvme/host/pci.c     |   1 +
 include/linux/device.h      |   1 +
 include/linux/dma-mapping.h |  16 +++
 include/linux/swiotlb.h     |   1 +
 kernel/dma/swiotlb.c        | 310 +++++++++++++++++++++++++++-----------------
 6 files changed, 215 insertions(+), 123 deletions(-)


Christoph Hellwig (8):
      sdhci: stop poking into swiotlb internals
      swiotlb: add a IO_TLB_SIZE define
      swiotlb: factor out an io_tlb_offset helper
      swiotlb: factor out a nr_slots helper
      swiotlb: clean up swiotlb_tbl_unmap_single
      swiotlb: refactor swiotlb_tbl_map_single
      swiotlb: don't modify orig_addr in swiotlb_tbl_sync_single
      swiotlb: respect min_align_mask

Jianxiong Gao (2):
      driver core: add a min_align_mask field to struct device_dma_parameters
      nvme-pci: set min_align_mask

Martin Radev (1):
      swiotlb: Validate bounce size in the sync/unmap path

