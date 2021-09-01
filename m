Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E63FE490
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbhIAVKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:10:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38932 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245159AbhIAVKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:10:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181I4xxM004466;
        Wed, 1 Sep 2021 21:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ifvPz1rdMc+YZ+xR0/Zx10uCNTr81KT9P6CI9kNeKlM=;
 b=IrCXGhiAahFpCkp+g8lyKsw66PLEkIHaFLgQDnYTEYiVBrsarrBaqSYBpfLeJvNN6QLC
 obRya7B/v50udLcHZ5xyIBKfzOntc6maH1k3JlFiSLvg73Fm2798rC15lSJcg8z4jNvh
 e2UW6GCTlQB438/3S1G3kaeblhVkshNaRcNSt4yXvvSG1Q2YmE1g4sJg41y1EXTR4hg8
 fvLOmhQOQKisOMDynqDvUmmBzfPs5ctenHMm8oB/mDpzGnv1xtM8hw+fqsJ0YDofQEFk
 UI91IMfAVcZRhJ1zBJZbl44y9LIzEtlIb9kxpSQTZiNDTWvNIbw4PONC8TZokBkkkzUg ig== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=ifvPz1rdMc+YZ+xR0/Zx10uCNTr81KT9P6CI9kNeKlM=;
 b=EC9ms4Ui8qlNUSa0ux1HycLUSZnJB8FndgsXk/ykJrIPwJ6Fx90g56AV8w8euG2E1jHR
 8J9QYRGGiOe7ht+yjWcwCt6lAJQ7btZTfCqH/5AgiJizx2pC/j3/QB2Zg0xjFmroYa1Q
 NPpsr1NPwDdvgOAnvSH/FE3tLSuaI9qz/R2a5fS5xAGFQMK54/fE6fKuris9RjMQVEYg
 blM0hFYhFsEdxVJbuYfH4IGsfWi3GDKoUh3ePLSOgvnlECCGWg9yU72JEk9QdA/dEEaX
 dA4vfcE2boinPfWri8u8zsAOOeYNGlkU89CbytPJGvIorb3hMYg4yHD7qJkZb9vj35et tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw18k7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 21:09:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181L5f0r063689;
        Wed, 1 Sep 2021 21:09:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3atdyuge01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 21:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQFAJ8BMQbASe0n4CIJXAOQ1DWykzY4U4BrPOqMa66zs5Inux1iRq0fAgu8uSqMRC4A1L4r9fp0/BA49DpSJyBTnZNvC0UyfQ624aJzk55McakvruOW6MrtvwgMBcPYci68/+F1Nu3MaIcI2wpYeHzNW9EzHp/GWoBCijzOTXKTBkzuWdTLgkGBofWD8Gbmv0XKvTRK6jM+SpSZpzZyX6yLdivU8zsJCVflXLiYl9NGadObTAi2NQ1YKrY67iiGL9Nb3lCs7P4MmLd99zEVQukIjUZdp0Yijb4+q/YtMUVW5IYK4odaonvkXjKOy/hNiLtXA61eJkxMIWeZXOayXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifvPz1rdMc+YZ+xR0/Zx10uCNTr81KT9P6CI9kNeKlM=;
 b=BcWcKltCyMLVUY/QCHxPIKaJA9TgF7aCVUGi18nI+cHUIdOVZsfyxGzip3MGCjyTka4U4IjnRWwDFBOj47Ma4c8XTo27Jdx+ijLNEgZysYt2+iPRwcV538WiStj3MW+X99TGOtRBmUg5ig5ZO+ebB0pEYea1ZF3Z2UVC/GFumGhOAKNF7yvpgJvx2aV7E158LAuikQOH5aQHtSNy3q/RimoY+PP5wWqTJLx3D+QbCLbfc7lOpPz1f5SoyXQAJpHWCUhEm2ZFFPthnrOoxD6UHwge17NnFi9EoJgkUhOz7BSXA9LBs/zMpsx04JG2S1oQOn1y2xvQJzixuPKFqDtCWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifvPz1rdMc+YZ+xR0/Zx10uCNTr81KT9P6CI9kNeKlM=;
 b=SH5vwTrhofH/7P49zVJg21gpszW8M6H3H5XcCGWpH6A2nSIiqc/Y97T92WVgzaMVB0j6/0uhbGIUrYAXvkRWhpjnexqsn3TM4ESZWxZtkPZTJZH7cu44fndkYxYuaAxCFIiu7p7dMRcDcPxZgfQo888WOAQdIm96t2tCBqon/mE=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3160.namprd10.prod.outlook.com (2603:10b6:a03:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21; Wed, 1 Sep
 2021 21:08:57 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 21:08:57 +0000
Date:   Wed, 1 Sep 2021 17:08:53 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     tientzu@chromium.org, will@kernel.org, pasic@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] (swiotlb) stable/for-linus-5.15
Message-ID: <YS/r5eaf/ps5ekie@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MN2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:208:23e::16) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (130.44.160.152) by MN2PR14CA0011.namprd14.prod.outlook.com (2603:10b6:208:23e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 21:08:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb09bcea-5483-44b6-22fb-08d96d8cb675
X-MS-TrafficTypeDiagnostic: BYAPR10MB3160:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3160AEF6C411E53C49DEEAF989CD9@BYAPR10MB3160.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIeMD4AF4XpS8CSN8hG9bn/2ZSo+HtfeE9Td6TxUoVflz70q1JfGO5PPHdIzPf85reWj1u4j8V8SW2KL5yauoxYVM7tvIIFWwZGjK5qGob3RAWsUYOlcrd6vdw1Q4CRuuSoeUwi+T5cnsIwdJeGOBnMl96LHnKrAsuQBAXLXaLzrljwClcdm2BiJuJDpvwMWRNQ9Gl/8ArM3Ro1LTcp0eioSOLeQ9sy31zxq+VuA3SBLvvdni4Hq5K9uPicXOGf4GkZfclJ9XPJZK2GAxDfPxvITcln5lC0HMwY6dMXu4O194v5E+e34xRfNy3cx9Jn+9P9Gxs/3zsdrKrdK1XBVtI+nGhM2FBMV6VLzlPFWuNSa9tWpQ7QPGOgxn6ApLkVWlCuGAm2iIy8V+H9NgI/qdszneTxSZRFcSOXqnz4aRY1GjYmUCSr87126XpjUxmfaftRStvbNud8OKv/s9vYwxULsXqXNZSc/vhScy+5Tr95wDIhVLafDKxnzOSFUV5FoHqdieXLFSBdS1vCORj1LICXJOF99yWQdyAI37AVqSp0LY/DkEIfyTUpo9n8fy4S6B50fpoQYW9jO9ztV5khxzcMX6xl8+WFTxkkOMVl1B1/GMWAE7hQQAM1lgfqM0R7fzQqUa0wmB1Ruj9T9vHemgw7ZeLmxv9djHW+QXrptE4Mwe7V89BriasHSKwkqTm4voP0WIs1kFOBk2AsypPK8IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(52116002)(478600001)(6506007)(7696005)(66556008)(956004)(8676002)(66476007)(5660300002)(9686003)(6666004)(66946007)(83380400001)(316002)(186003)(38350700002)(26005)(6916009)(38100700002)(2906002)(86362001)(8936002)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZKKEqfHK+J1FYzlbdgtLtwDjh34i4LCOG7G3vmmK1fl0LFKOnd98OcOrU8oU?=
 =?us-ascii?Q?n4qpjSt5ZkN2ybpmArL49FxK+dWiwefAXcts6572Q6oOOoUHkFEXrl1+aTxd?=
 =?us-ascii?Q?LMDvekQrpKESAMNb2HtjDLo4O/+SnttRqzxbke915nnrWg1/CJnw2nJ0k2qT?=
 =?us-ascii?Q?6SbRiqFukJGJUNbG/Sey08zH6NoWmPPCl1+H2926tPLPQ6LS0FTEp11hZsKR?=
 =?us-ascii?Q?gkB8eQpsQRpHK/rRqT/IPKXa4z+nrVb9RAFtpk/el+lMPPSZgCgft7eAOCEE?=
 =?us-ascii?Q?oQ8//zudn2ebpaP2Uxk99O4Px4abfOCzi/HifnfskITsVjBm1Wc44yIsP+H4?=
 =?us-ascii?Q?7LPKrvuRQvsbeEJ3zAsKO6OGgOmQxNKPLYE1tciIWWaN5IRk1xREPeoSWznt?=
 =?us-ascii?Q?CgAQY6wMXarzjS9P1bxcx/2bjSutj3ktvIOg96f9K75CVta2Xpl7FEibyocU?=
 =?us-ascii?Q?O7vjfo+ccHBRD7A1ZfLPGk4+z9K2aZMtG0YRgffa7OGeHpy0vREWGva+SfW+?=
 =?us-ascii?Q?8RJc9qZxDy+Rx0nLJaOVev1VajMphJl00M4dMxeSrp6ZlUdmbQj1ksau9jwF?=
 =?us-ascii?Q?UklwpfuwLpMybtoXbN9iFesjh9Fnt7rbufxPzkfF1VVe59Md1b76gqVu0CAK?=
 =?us-ascii?Q?pC6/3dBKmHa8OFTISwCOL4+j9QjGgUw/a0weUbq6M/v3pATLMqvrnYXWXkB1?=
 =?us-ascii?Q?TToHy5yaXISUjoznazF5wSe14FeiVQaZHArTdeKmS6RRyomiM6XrguHkNMo/?=
 =?us-ascii?Q?wqJ76hP0KBjX3eO3Gv/Uady9a2yZA2EwYFao6ldXVKTTQoa6ViiIReMnQcaO?=
 =?us-ascii?Q?UGSfxSYvWgXqy0QAN8ZWn9X2BohDP0B3tfoK8NiRQYp344SCBv0a04ysMs1o?=
 =?us-ascii?Q?LGwOlYki3RDSJoOPuVXVbXExAhfM8qdbxjTXur9DhXnM9h/UQN36JYd53YMV?=
 =?us-ascii?Q?VgXRyko0cxho94/ZwMSxf/w0BSo6ygpa00/5wocix0pXD51vg/Auj4c2mlo/?=
 =?us-ascii?Q?xs7JpvsNR/lXtO4IsFv5VWtASZYL3KE6ueP+Q6uUjZv6hD/X6HLgzuvvelyi?=
 =?us-ascii?Q?cOr0Wa3Wwmq0MxcJ7Heu30Cr5qhxAN+DGi90EEquwkR37/uDk2BPDanA0qba?=
 =?us-ascii?Q?8qUqE3wOqouk0MctJI3baB6QAFvBzU/2ISr7m+IDuJSmSISNBvuQJ+uX9Rpr?=
 =?us-ascii?Q?BwDTpKr30Zsp3JVGK49jT3k9mNi6bpz9hv1WZOKI+dzOxBiypv1TDKrb5a1q?=
 =?us-ascii?Q?0OtczcOVw+/OuyCeQGADV4TTY7ugaDVwLw4yWCHEU7bOPwkvwdLgl4Fz+KUc?=
 =?us-ascii?Q?92KokqwZ3wel+1CaWpQmmFWx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb09bcea-5483-44b6-22fb-08d96d8cb675
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 21:08:57.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W79DNFL9tdV8EZEKJDqbFzP/+f38IsSTWMBoLIBu5je60xJVY8h10t0CT6inVqFh2sDMolP2IgEPTBP3THnSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3160
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010123
X-Proofpoint-GUID: muGHJaUafeg2ckBRqWIQa0OHQbNiseaQ
X-Proofpoint-ORIG-GUID: muGHJaUafeg2ckBRqWIQa0OHQbNiseaQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Please git pull the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.15

which has a new feature called restricted DMA pools. It allows SWIOTLB to utilize
per-device (or per-platform) allocated memory pools instead of using the global one.

The first big user of this is ARM Confidential Computing where the memory for DMA
operations can be set per platform.

Please pull:

 .../bindings/reserved-memory/reserved-memory.txt   |  36 ++-
 arch/powerpc/platforms/pseries/svm.c               |   6 +
 arch/s390/mm/init.c                                |   2 +-
 drivers/base/core.c                                |   4 +
 drivers/gpu/drm/i915/gem/i915_gem_internal.c       |   2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |   2 +-
 drivers/iommu/dma-iommu.c                          |  12 +-
 drivers/of/device.c                                |  40 +++
 drivers/pci/xen-pcifront.c                         |   2 +-
 drivers/xen/swiotlb-xen.c                          |   8 +-
 include/linux/device.h                             |   4 +
 include/linux/swiotlb.h                            |  57 +++-
 kernel/dma/Kconfig                                 |  13 +
 kernel/dma/direct.c                                |  59 +++-
 kernel/dma/direct.h                                |   8 +-
 kernel/dma/swiotlb.c                               | 352 +++++++++++++++------
 16 files changed, 469 insertions(+), 138 deletions(-)

Claire Chang (14):
      swiotlb: Refactor swiotlb init functions
      swiotlb: Refactor swiotlb_create_debugfs
      swiotlb: Set dev->dma_io_tlb_mem to the swiotlb pool used
      swiotlb: Update is_swiotlb_buffer to add a struct device argument
      swiotlb: Update is_swiotlb_active to add a struct device argument
      swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing
      swiotlb: Move alloc_size to swiotlb_find_slots
      swiotlb: Refactor swiotlb_tbl_unmap_single
      swiotlb: Add restricted DMA alloc/free support
      swiotlb: Add restricted DMA pool initialization
      dt-bindings: of: Add restricted DMA pool
      of: Add plumbing for restricted DMA pool
      swiotlb: fix implicit debugfs declarations
      swiotlb: use depends on for DMA_RESTRICTED_POOL

Dominique Martinet (1):
      swiotlb: add overflow checks to swiotlb_bounce

Halil Pasic (1):
      s390/pv: fix the forcing of the swiotlb

Will Deacon (7):
      of: Return success from of_dma_set_restricted_buffer() when !OF_ADDRESS
      swiotlb: Convert io_default_tlb_mem to static allocation
      swiotlb: Emit diagnostic in swiotlb_exit()
      swiotlb: Free tbl memory in swiotlb_exit()
      powerpc/svm: Don't issue ultracalls if !mem_encrypt_active()
      of: Move of_dma_set_restricted_buffer() into device.c
      of: restricted dma: Don't fail device probe on rmem init failure

