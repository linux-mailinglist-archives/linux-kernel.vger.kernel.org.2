Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9671840C327
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbhIOJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:59:24 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:16473
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237415AbhIOJ7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0WKdo1C3gAXO2LGsbcuIzNlAGHl7uEKSbLULl3sd+8cC6YI1uHwAprPK9K/aLABZvI31cW2HQZXd5uomxmM2el/bEH3HvAtYwEiSNdKjnd11iGt6IoOSao1RqayNTK/OYLeEtYHSKj+1diiKNngfRGPNrRW838fbByAWRLn6AFoP3of1Tb7NOAb+nJgFSLSwYxqTAyu+wbY7/hYccz8K+cSIkYYkfCSI6fP1s5MJo+iMWBxzYIZ1szNr/rw5jYrCHeJvNQrTDKmmq7iY3jy1AVt3MT2VkZQBIAZWbu6BJHSFGkKm1INsyqtjFsVm12vk4VT9BG7zRLvMxlsj9b0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xtZrNZu3zAxMKVNDmObH3xnggvA4o6BMDKiTQucHfYY=;
 b=dUVLeZgfrj884TKKS0wQ6DMHbtZZcVIcn+MTdvLGGUxPD8H8vHSYrWlGpYkklWyc7y3kKwbX4UdrDOlz23cEGdl1JqTvTzECpU/0f3Qhh1QdXjYXXPIAO30vIEhyi8WJeE15Qode3FhytwD3siJWDgERQC2swfiHT2g7v4OQDfEIi6J9OyTZ8HbW52GeTEMjPd/gYfEENdQkhth5YXrPa4g1IY9lvUKRF1dJRZpF4s5unaG1+TGCASTgNynSD/xHnJns8Hq4TPkJ7iqUXSBv3Ii0zWW5vGP4EX3tftKHHZNmUzVoAXXJzf/RisuqxPzA6ozDiKdQjPNu0Ss6ie05jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtZrNZu3zAxMKVNDmObH3xnggvA4o6BMDKiTQucHfYY=;
 b=CFep28SDCzfOamNsuxdKkY4jHxYIgSytvIcoVgsQCAZtyGqnzZal0y1paobPW/Z/Gtufsq4apeQJGHzDgYQ+AUF0Lo4OaIdB2kz2T9FmlIaF4zxpsHkC6Y4lW9DAAUgfa6bmIXrPF2CK2eHnlHf+w6GY/hWpOgumqT4qixLmdhM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com (2603:10a6:800:57::8)
 by VE1PR04MB6749.eurprd04.prod.outlook.com (2603:10a6:803:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Wed, 15 Sep
 2021 09:57:55 +0000
Received: from VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb]) by VI1PR0401MB2559.eurprd04.prod.outlook.com
 ([fe80::485a:4462:94c2:5edb%10]) with mapi id 15.20.4500.019; Wed, 15 Sep
 2021 09:57:55 +0000
Date:   Wed, 15 Sep 2021 12:57:53 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/8] imx: clk: Rework all the wrappers
Message-ID: <YUHDoeg2S/vnkl/b@ryzen>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
X-ClientProxiedBy: VI1PR0601CA0019.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::29) To VI1PR0401MB2559.eurprd04.prod.outlook.com
 (2603:10a6:800:57::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ryzen (188.25.164.198) by VI1PR0601CA0019.eurprd06.prod.outlook.com (2603:10a6:800:1e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 15 Sep 2021 09:57:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18adec3a-ff56-461d-f739-08d9782f4a39
X-MS-TrafficTypeDiagnostic: VE1PR04MB6749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB67495D082594DA5275354454F6DB9@VE1PR04MB6749.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4ULEoMyUCQ5HDH0NYz3sdEYxaRvN3/5dgQ3U3jIp0gEiHBfPuXfZ/P1IJlQsLODn23kbyqyYND32ioKLSGv1XiyS0lv5QNrf1ZqWiKQWRoAPWLueepsgfUGY+kIx+hj51lP1S+AFRgtze8Oa88Bkb+e9PVtWpO18rihPjiMbudmaIacAS9K/OGlMbmKadU7a8+vw0fr6bsrs8VhUN5XWxZdp3+CQ42ZcE8ghzKcS4w5hSFv3AUAmCym5F7tdEpfnEG/NRREaTVVH+YGwwxAfFa2Yo4Zhx5+iQ6mFdEAGlGuPF5iyTBGd68u6HuQPwtjua/0gG3bMA3HAPe6WrH5PspLNMCzY01kQ6K+HH/tpeNFvKnkJO5sqa0QAYlhfMYIK0x81z5Yri5sKtNqwovEsJGbsWdofSIlIAE2G8/rF7Zgu4yN0cx8yhG9taZnKVEweMgaSLV3lk+ZV5n4sjtTkmLVnAuWXvJUFAzZjDcRLNZkpHrRlATaS5awntydrm+xWk995DjVN5iMeAs9lJmzgaIQek9Hs1PWp43/vrnaeIUBOufW6l1vT6D835+5XEkX7uhG/XhLNrJgVrpvGtEwMJRQKVIIDs/uqS5eiszniKA2UInf0IHVJmEi/KPshCXjSDDPHp8AAXpsatwgX9GDBjxmer2FX72wUz7vRDcGn+0C03r0GTjKFqdBrYhe1fsuSy6s8zQ0QZ+Sz8AqfArDfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2559.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(66476007)(33716001)(316002)(478600001)(83380400001)(66556008)(55016002)(186003)(5660300002)(6496006)(8936002)(26005)(6916009)(86362001)(9686003)(44832011)(8676002)(38350700002)(4744005)(52116002)(53546011)(38100700002)(66946007)(4326008)(956004)(54906003)(9576002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I63snICcra/q+TnqXr6BVP2IBGLv4il2MTjLNAYnvOc55j6XhmLCuFd42AQv?=
 =?us-ascii?Q?CpJdLYdV8abPTNRUJfP7tvcDwaglyDC8sQu/6d5LDDSW4B3eyo7+np55d57K?=
 =?us-ascii?Q?k3kYUCOSa9sWpa53fYso3gxtkaC9IrnbosVj8lnh8yio3kRcvIoLoGY06CIM?=
 =?us-ascii?Q?0gzBJTxkibFNS2HTOWl3//R8iZwlH59VwgO2CKArGUpgdYkSbXoMZhJKLOa/?=
 =?us-ascii?Q?TjYbO5I4W8grG9gZ+m36M50Zu5sHHFUBetFrTRG+ZilgZ5fhuM+473BShg/Q?=
 =?us-ascii?Q?5gZnwNCBx7T6ZXbXPHkvkTs6AbFnj49e6clQs8WtEZBbQZ9t5QpSelg7ceeq?=
 =?us-ascii?Q?6/ilkmPun7E5LnocXbOzSdkzY/EKoRTCUYhESRxhPxJMtYMYpwOmRLtBJkYn?=
 =?us-ascii?Q?gUVXWXBFvL+EC9oILLeF6Sq2Tz2y/XRBLWxjuP0XchcdRWxVBnQBtkVrqSOM?=
 =?us-ascii?Q?4OZPL2cq/OxXF+iCOeYdNasj5IJeQqHtzkrQDM+BFi/oO12TAyJ/Wdg/Hs3H?=
 =?us-ascii?Q?fL+vMepoo7DneRkKL3saQoeqG1qcq/XQtx93RCvu1D2ko1eg/vNFnCViQi1u?=
 =?us-ascii?Q?gVegCw5so7k8or5hFvzOqJTF7MOPiRlZwZ/Bn3I1Cgx3STr0vXj8IiGI7w74?=
 =?us-ascii?Q?fLhkEAmLQMuyuDj7JqiczrDfO4f6Tk6ARdiOfG+w23x0TR6a5LkmpMEH1pIb?=
 =?us-ascii?Q?mb45TgratQSpHZ5lQfnlJzGJdK6X2jU2kK6Gji4v+nR6kb9IqTtWdX3x7yKx?=
 =?us-ascii?Q?UTHNYcON2Xydq+ZI2wh7vxj84y/77Jmukdc7Q87r/i+0Zd7Bg7Qq/i3Q1Ut7?=
 =?us-ascii?Q?ON6LAMy4TPUVHlO/68VQOZ7s+1wZ93yvEuKQqP/orCAgB9dlwFPpbn1qyN6n?=
 =?us-ascii?Q?QviHKQ7/uNI9aZSFJCdPVMWMnryFBgYvCnWtFqQTYufaAZjRnnZGQ/nALDxv?=
 =?us-ascii?Q?EXy18VjleBuwFrQRHeP+Gyk4tgP+8Bz2NTceSu8EymP992Imz77PeHst3ltG?=
 =?us-ascii?Q?ox138yZHO57g5KE1WJ+NuUpGnGcBK/0BRDUEguMT8oZJyqHJGhy6dnpBCL/e?=
 =?us-ascii?Q?gIplddzmHWcPzWWujPEfSWFMn25XvjxWMa7bawKnVDMGcsEQNzqzRB3RVfLI?=
 =?us-ascii?Q?f0kLkwZqAhU47W9qS/SdDp8/NosMrfSkBgOUd5It7IZhmFlT67k1VDzRdYrM?=
 =?us-ascii?Q?UcfWYUHY0wVEp0HjuC7uMTZTobfT/LsGA6/FQhgaljlBRaoe7axJYm8LIAqp?=
 =?us-ascii?Q?hk3wfuERT2/QzrhrX2uFEBcfnH4Loo3jM8TTshlQih0ixefV2JW38zKB0Zc0?=
 =?us-ascii?Q?01x1eNrh4N/+0d+g1dDFYCzO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18adec3a-ff56-461d-f739-08d9782f4a39
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2559.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 09:57:55.6293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vKcJ7FCuzqzgnQXeDulp/M2jVeIcI26oieIMi0WWywkHeHuG6C22h9N4rHZkjeM10HRNyMUwRX5xotWOdEuLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6749
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-13 11:24:42, Abel Vesa wrote:
> Remove the unused wrapper and rework the rest in order to prepare
> for removing the non clk_hw based ones.
> 

Applied the entire patchset with Stephen's R-b tags.

> Abel Vesa (8):
>   clk: imx: Remove unused helpers
>   clk: imx: Make mux/mux2 clk based helpers use clk_hw based ones
>   clk: imx: Rework all clk_hw_register_gate wrappers
>   clk: imx: Rework all clk_hw_register_gate2 wrappers
>   clk: imx: Rework all clk_hw_register_mux wrappers
>   clk: imx: Rework all clk_hw_register_divider wrappers
>   clk: imx: Rework all imx_clk_hw_composite wrappers
>   clk: imx: Rework imx_clk_hw_pll14xx wrapper
> 
>  drivers/clk/imx/clk-composite-8m.c |   4 +-
>  drivers/clk/imx/clk.h              | 431 ++++++++---------------------
>  2 files changed, 122 insertions(+), 313 deletions(-)
> 
> -- 
> 2.31.1
> 
