Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2EE3AE9DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhFUNST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:18:19 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:61152
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229640AbhFUNSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:18:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSLlVM93ET6+IFNeYWARaK8r0ZrXcj0RxXYFCuepXjnKlYSrBbmSDtNJSe36sXaRJR5tIT4BuX9cf/EwHODtozhOHUOeyLa+OBtBumMi5RQ8h/LWSeWIEJfPAfM9slJUlvndaR4B6Sf58pHRca7QWEg1Yyp07lqoRFRKyZhusiGQJwTmMWRXhJZvv8EQs6WMVR3h9JZOVupwJ7fb7dvn767bcCrctpkP4/GU5c2Ty3LO04tsP2AfrGEALiNjdEJBZywI3kg37mZHCtRNo7QNDqNEbzhYKVg95aiVVXLdjvLDCQKXsttXgrD0Yl8bJbemJSIzZUnlHl81nRD6V+22ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR2ekNAj/OT5JCNYejVxANNlGNGqvkx2BGYLDYzBfBA=;
 b=nQwnHFOCpKZwpQOVquEC5l/YVmpQvmDATvO14dJnBnMBD9BnzjVfWRaZ4RBPxnNm6cUtdJirgW9jl2uQVMTYBREPs6LbVlJKEcVOK6sSvr+2wDN95RJfBTV2xXHJMw93iLeZjU9MBaNVTeyRxi6FqPZ35HJLQEz8yGVXvEzvJ4CqBDizNRcUc+G2cYB6qLc/CbuvN4W+D2rAxETUXheakp1PWTv8MqPk+cOzxLE0Qj6NXKo+t7w6KI1knAmy9fJK6hbO5VNVEv7DQ4yYDGoh9I40gLd3g4kmZlyEty0MEWJ+/beFK0iai/BPvwJCc5lUO0r4gz0pNbjANWihQIrP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR2ekNAj/OT5JCNYejVxANNlGNGqvkx2BGYLDYzBfBA=;
 b=lHj4eh7fc9hrcfNf7CSljnHWK3YATFtdzGa7ZxZKatdZL6K7utJ/NmGKhFz+4fYc55HGDgOOnyBn3LWNrokdrfPW7wQHAMKUehtP+uGYol8tiKsOzwH4By46UNOmG7ftoH42q5vWU1cm0yxnuelKlnccTgDzZwLp4s0TC2ZerXs=
Received: from BN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:e6::24)
 by SN1PR02MB3648.namprd02.prod.outlook.com (2603:10b6:802:2c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 21 Jun
 2021 13:16:00 +0000
Received: from BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::6c) by BN0PR03CA0019.outlook.office365.com
 (2603:10b6:408:e6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Mon, 21 Jun 2021 13:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT053.mail.protection.outlook.com (10.13.2.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 13:16:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 06:15:59 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 06:15:59 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org,
 quanyang.wang@windriver.com,
 gregkh@linuxfoundation.org,
 arnd@arndb.de,
 mturquette@baylibre.com,
 arnd@kernel.org,
 punit1.agrawal@toshiba.co.jp,
 sboyd@kernel.org
Received: from [172.30.17.109] (port=57666)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvJmR-0005ZX-7O; Mon, 21 Jun 2021 06:15:59 -0700
Subject: Re: [PATCH] clk: zynqmp: fix compile testing without ZYNQMP_FIRMWARE
To:     Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210421134844.3297838-1-arnd@kernel.org>
 <871rb2swd9.fsf@kokedama.swc.toshiba.co.jp>
 <01e78b64-8ad1-dfc8-9fc0-6afff4841492@xilinx.com>
 <87v98dqzfe.fsf@kokedama.swc.toshiba.co.jp>
 <161974903429.177949.6659170601321970979@swboyd.mtv.corp.google.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <8cc5409f-a8e4-87f9-87f8-79c5467b1faa@xilinx.com>
Date:   Mon, 21 Jun 2021 15:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <161974903429.177949.6659170601321970979@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab146f9-8156-4e46-e98a-08d934b6b69c
X-MS-TrafficTypeDiagnostic: SN1PR02MB3648:
X-Microsoft-Antispam-PRVS: <SN1PR02MB3648784D9E8AF330A17FA1BBC60A9@SN1PR02MB3648.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQt6rlaU3YusQuNihGN9GqBA7IQY8UTo+lSYPTVlZAzVOHLq8gxtM7yJL+kLlqaHhWpxn2wgRCijhZBwJgWR9m5ELUGHsO0Li3dqUd+9q9QmAwKFp5Km1e/yoHMWWMeXz/KkuL7RqdgAfgKjzAJdhQVLf99qsscE/jxt2afNJ4VGst/PrUBpmVeM+1K8QLzk/f0G23Az78oF5ujz8OiJHCG9fZjcoLcWbgdm7XjKUnJl0XS4YQABsCYuCfOOlOguonGY0xvuKd+5MrE0cyv607lshTc2djeymKZ6XWXpzmoHdQ0afyeHXkupyIwYkZS/JXfwKeN74ZWorYdtJzShB49BuELB1tGHmtbkhAsIrLLsUWulJNf8P9N1nt1YmkQfyDfS6D53gu1nUTWMFuMvS7Oc05OddtrEnOHRmLMpwCSCqJNkjgpV+j1qetiQT6PfaofyFFcr4oyKqITGl0EIyJeBeN8OilxA2q2NUOiPiOgKFZy1wtB0+5ZOv8SwcIQBZD+8wb/QXAqOX0FJxcZYYKXXWfNuDRfdEvtf1vz5I3Mb78XesM2dVrGxmFYCD1xsuZ27z9s3yadCnBb5x/0SSgred1LvV0sQSH86UnZBElKBQQTEQr0kQrAZiS9ZN18r6FINE3e3h2i/SHLKxntmhcyMqYC6KvheIIydAWVWwnAdoNv6eiarD7xE7e9BJ0eMrH3m4qN6ptj6RhB8FLY6FGa/r/+Z4QNu/CnSnmqxBpvUlJa4gDs6CBMP1JZFcFbrphPmRCpfCjILV0p78zs9p46UDC02q/pKcuC5uW1pU1qNoaUMEld0tEhrX080tN/nqZrHqMLoYBoBQFXj2+YD7Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(7636003)(53546011)(31696002)(478600001)(8936002)(82310400003)(186003)(6666004)(70206006)(8676002)(70586007)(966005)(26005)(36906005)(336012)(83380400001)(2906002)(4326008)(82740400003)(2616005)(7416002)(47076005)(54906003)(36756003)(5660300002)(316002)(44832011)(426003)(31686004)(110136005)(9786002)(36860700001)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 13:16:00.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab146f9-8156-4e46-e98a-08d934b6b69c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3648
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/21 4:17 AM, Stephen Boyd wrote:
> Quoting Punit Agrawal (2021-04-22 23:37:25)
>> Michal Simek <michal.simek@xilinx.com> writes:
>>>
>>>
>>>>>  
>>>>>     rate =  parent_rate * fbdiv;
>>>>>     if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
>>>>
>>>> The changes make sense in that the functions error out sensibly when the
>>>> zynqmp firmware driver is not enabled.
>>>>
>>>> Acked-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>>>
>>> I think code should be checked that these error values are handled how
>>> they should be handled.
>>
>> I only looked at it from the point of view of getting rid of the
>> warnings - based on the commit log, Arnd's patch is only taking care of
>> the compiler warnings when the driver is built with
>> CONFIG_COMPILE_TEST=y and likely CONFIG_ZYNQMP_FIRMWARE=n.
> 
> The subject line basically says this.
> 
>>
>> In practice, the code should not be hit at runtime due to the dependency
>> on the firmware driver. Even then, a better fix would indeed be taking
>> the returned values at call sites into account.
> 
> Still needs to be fixed. If a better patch is sent I would apply it, but
> if that isn't going to happen I'll apply this one.

I have sent v2 version based on what I have found how that error values
should look like. Please take a look at v2.
https://lore.kernel.org/linux-clk/fdee3a286defb103aa07b5493b805d1987885165.1624281224.git.michal.simek@xilinx.com/

Thanks,
Michal

