Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61673AEA8A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFUN5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:57:07 -0400
Received: from mail-mw2nam08on2058.outbound.protection.outlook.com ([40.107.101.58]:46624
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229747AbhFUN5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:57:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3YVnFsvPqzKxrahQHSo8hWjfbozGpp06TzNuFb5d2brvagPlSKOFbd5JWdBD38Z31YtSCyAFNEx4dQ54USFD22FsHLukmLhSar/PcP5CJcNc+v/BRgDgWwuxmreMk52rLxg04fkEsZUVcRgR/NUytEpiLkJjGgQpcC8wcsaTbamRQQzXVqBsDB//yrAUH3oP3hpXCA8bmu23xJ9VVU560wRiGrWm28ZHxoifRMJVtxyViI7J8cFcDe3Yk8vKtl96iIHsVm/j++0ORuI07q5UZMjUUCejg+aOvL+Rrt9jk5J6Fy6K+ig+ZbgUiLDFo7j4e4hKOlo3E6/Fl9kDGsjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+8O1Kao9EWf5Yr72Y8CAGWRvIEGZtu/JGIYfVbKy6E=;
 b=CTFsW/Rv2ToUE3urlM4Wioth9IpXXeobQ26JOoEuMKYZbHoKkbUcGpElokVU5N988feHD7TZ9qR3qs2fKyc6Adxnfq9x52hS3/DAtMJUMD34zxt4Gpw0v7S1+HbuOpCVUhLdnw/7xp44uoC6gPXXTbPFvLhEcGHMcodZ3maMCRJhWDWT69It8PcEkPWD42ZtXTqemnZDVR8tNYxw/IF7QUHRGd1cr2H9VSNQpIAozeR7gik/sEVUNFzzDPrb/pNBOlVlnKLcAJ5ZurgMkXQsK2NCKFdGadbUm6x4iD1P0dO6d0c/2DoI0iUnHnwoRbMgl3QPSaWJgbQGdLFauyjxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+8O1Kao9EWf5Yr72Y8CAGWRvIEGZtu/JGIYfVbKy6E=;
 b=L0fkeKk94oSX8sZ6hiKYsc229FE8n1gE7FChn2vD3gnUGgef4SMriJWR63U08pUuT5Oqyz/nxB3EBZuNdxmQC5JqhcXOhIoauyDM8f7P9YUW8LuliYhD0+Js9hXIt97DFFDQr+neOkakaYzFGtiXZk3w+BvoWX7pNxFIwANIVbg=
Received: from SN7PR04CA0057.namprd04.prod.outlook.com (2603:10b6:806:120::32)
 by BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 21 Jun
 2021 13:54:50 +0000
Received: from SN1NAM02FT0026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:120:cafe::a2) by SN7PR04CA0057.outlook.office365.com
 (2603:10b6:806:120::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Mon, 21 Jun 2021 13:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0026.mail.protection.outlook.com (10.97.5.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 13:54:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 06:54:48 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 06:54:48 -0700
Envelope-to: git@xilinx.com,
 linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 sboyd@kernel.org,
 quanyang.wang@windriver.com,
 punit1.agrawal@toshiba.co.jp,
 mturquette@baylibre.com,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 arnd@arndb.de
Received: from [172.30.17.109] (port=32800)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvKNz-0000bO-3w; Mon, 21 Jun 2021 06:54:47 -0700
Subject: Re: [PATCH v2] clk: zynqmp: fix compile testing without
 ZYNQMP_FIRMWARE
To:     Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <fdee3a286defb103aa07b5493b805d1987885165.1624281224.git.michal.simek@xilinx.com>
 <CAK8P3a1twOhC8DFxpLxpk8bcy0+JfGZUSE9bX4tdMetVLGTcSQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6ef72766-74c3-8356-555b-818e887518a6@xilinx.com>
Date:   Mon, 21 Jun 2021 15:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1twOhC8DFxpLxpk8bcy0+JfGZUSE9bX4tdMetVLGTcSQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ada2405c-56e9-4fe7-3fbf-08d934bc239c
X-MS-TrafficTypeDiagnostic: BYAPR02MB5016:
X-Microsoft-Antispam-PRVS: <BYAPR02MB50161A0B194EE2389A1AB490C60A9@BYAPR02MB5016.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/Q2Dg7QuINkDdUNlP7gI9oIx4PMVKVnTWRX5jDKSKoHpU3p5Rkd4PaQ9rCDfl/S+z1f+Jqq6MxGIloD6IPJAyEpF06qYC7bZbkZHWBkm45UJCosnEqgo3kV6DZ+C6LMeptfpIZ4mrWyPeXlrNlhuWt7GgDvtarmMfHRF1OnoOwB/fAGAAF7GEJ1fac4MnH6u2kwTNwNs73/TGExh7TP6489dyHiXyQTlnOSnHDzqJgkiERpLdOnMPKkd2Zg6vHhifl74lBpDSZg7kVwro7jOzdSC7z0aX1wLLzsVUPTGVULT3E2Twg7DS9ONComM2vHHhmUG10iDRmCwFrraXjIuduoTzQEOL4fwg6O7qmh5J7RSmSfOjIp6zhBYPMh0YWqMf6pyG0F7P8lb1Cr4z69dIlCK65sKZpOaAWRKtu9c3u98doSCJJfyfIyeK8rA+WHhe+joupqqV8ifDiV/60S50lZF0FHNMjKzGPr+tmnkhsRMZHuDJKYb7OT7vHLX9kHUMh9clUsJ7emxKoRatJIYuhfuItbkDv2F69rYhSPzBGQVAE4nWAwWVwArpZlf4YelTZ7nRVVR+PYXt+1qMSRLA+Pe28JFshn54iUD93ia4ZPEgYeoQN90elgOI9CkIyA8ayTKmpDY89piJ0BiO0ZGONM8d8gp+fR5GO23B5ZohlLdFOFAjExbarlJhI4h/uM2sgt7nV3SvJ2Xatli/UEl1phRTZusNwGAw6F3AflHOX/nmAg2R8oqCiOZZb4ys9o+fxoEgVF8Va+WKsicXSOTVC3aEKNFxumxQoI2Ghkr2fWEqkwbFq255hgM1cz6HsM0oA1Ax3rY7kcyiuExQKTGQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(36840700001)(46966006)(2906002)(966005)(36860700001)(36906005)(186003)(26005)(53546011)(336012)(83380400001)(4326008)(316002)(8936002)(8676002)(31686004)(82740400003)(356005)(7636003)(54906003)(44832011)(110136005)(82310400003)(426003)(47076005)(478600001)(6666004)(36756003)(70206006)(5660300002)(2616005)(9786002)(31696002)(70586007)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 13:54:50.4764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada2405c-56e9-4fe7-3fbf-08d934bc239c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/21 3:51 PM, Arnd Bergmann wrote:
> On Mon, Jun 21, 2021 at 3:14 PM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> When the firmware code is disabled, the incomplete error handling
>> in the clk driver causes compile-time warnings:
>>
>> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
>> drivers/clk/zynqmp/pll.c:147:29: error: 'fbdiv' is used uninitialized [-Werror=uninitialized]
>>   147 |         rate =  parent_rate * fbdiv;
>>       |                 ~~~~~~~~~~~~^~~~~~~
>> In function 'zynqmp_pll_get_mode',
>>     inlined from 'zynqmp_pll_recalc_rate' at drivers/clk/zynqmp/pll.c:148:6:
>> drivers/clk/zynqmp/pll.c:61:27: error: 'ret_payload' is used uninitialized [-Werror=uninitialized]
>>    61 |         return ret_payload[1];
>>       |                ~~~~~~~~~~~^~~
>> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
>> drivers/clk/zynqmp/pll.c:53:13: note: 'ret_payload' declared here
>>    53 |         u32 ret_payload[PAYLOAD_ARG_CNT];
>>       |             ^~~~~~~~~~~
>> drivers/clk/zynqmp/clk-mux-zynqmp.c: In function 'zynqmp_clk_mux_get_parent':
>> drivers/clk/zynqmp/clk-mux-zynqmp.c:57:16: error: 'val' is used uninitialized [-Werror=uninitialized]
>>    57 |         return val;
>>       |                ^~~
>>
>> As it was apparently intentional to support this for compile testing
>> purposes, change the code to have just enough error handling for the
>> compiler to not notice the remaining bugs.
>>
>> Fixes: 21f237534661 ("clk: zynqmp: Drop dependency on ARCH_ZYNQMP")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> Based on discussion here
>> Link: https://lore.kernel.org/r/20210421134844.3297838-1-arnd@kernel.org
>> I have updated error return value which I got from clock core based on
>> error cases.
>>
>> zynqmp_clk_mux_get_parent() should return num_parents() as error defined in
>> clk_core_get_parent_by_index() where num_parents is incorrect index.
>>
>> Extend zynqmp_pll_get_mode() with PLL_MODE_ERROR to handle error case.
>>
>> zynqmp_pll_recalc_rate() returns 0 because __clk_core_init() consider 0 as
>> default rate. But maybe -1ul which was used by Arnd is also good option.
> 
> Looks good to me. You changed more than I did now, so it might be better
> to change my authorship to Co-developed-by, probably not worth respinning
> for that.

Let's see what Stephen said about these changes.

Thanks,
Michal
