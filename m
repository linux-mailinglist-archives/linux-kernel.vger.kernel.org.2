Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6A397E70
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFBCIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:08:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2942 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhFBCIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:08:37 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvslH3gBHz68xw;
        Wed,  2 Jun 2021 10:03:55 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 10:06:53 +0800
Received: from [10.174.178.95] (10.174.178.95) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 10:06:52 +0800
Subject: Re: [PATCH -next] soc: imx: gpc: add check for of_match_device in
 imx_gpc_old_dt_init
To:     Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>
References: <20210601100256.70030-1-tongtiangen@huawei.com>
 <DBBPR04MB7930A304416458880D69E1C7873E9@DBBPR04MB7930.eurprd04.prod.outlook.com>
 <CAOMZO5CKW5n4P9X5tTHGcS-MkN=gmCkyS1+bkwn98kaK2vL3-w@mail.gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   tongtiangen <tongtiangen@huawei.com>
Message-ID: <3b50ca69-5482-a6a0-cf29-6898dbd61b26@huawei.com>
Date:   Wed, 2 Jun 2021 10:06:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5CKW5n4P9X5tTHGcS-MkN=gmCkyS1+bkwn98kaK2vL3-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.95]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/1 22:04, Fabio Estevam wrote:
> On Tue, Jun 1, 2021 at 7:11 AM Jacky Bai <ping.bai@nxp.com> wrote:
>
>> I think there is no chance to pass 'invalid of_id' and 'of_id_data' to the probe function.
>> Such check seems not really necessary.
> I agree. The only way this driver can probe is via device tree.
> .
ok,  there is no problem in practical use.   thanks all.
>

