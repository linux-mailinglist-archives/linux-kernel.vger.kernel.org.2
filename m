Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED20C367F15
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhDVKyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:54:45 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:60864
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230270AbhDVKyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:54:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7evencpmfqoNk83AghGnmMK6DlVazQRxZ4psQacykEZRc86sHO4vdDAoNwZhqnKoBHlGQaKVA+dvzU4TrVHEyoVsvMabp1zy2XJROAishZDHJtX3f5d9je0hKXyYYEi3Hk86CMlXLoT4Vxeunnrm5RyvbzYxp9Fw0ZGvLyAWpO/aODAHKFVOM3kCt9CSEB1NKIfUnonpcN9eWf5cDN7ctt1O+zElU0+KkovdaTxFc3TeabH+KC3QIqAfcN77/vOQKL5miGQ71GHMVLSltc4k7tfqzAWICk1T4YMXnAPqWU1C6kwsiOivUMgg+pAZ2YWE6ob6a4O/4KN2ABthyCRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLJNUsZ8OnvtImQX91Xe0XW+0p5PnxULzrGtqTkMsf4=;
 b=iZE3+EEekjHClqzjtGW7fdb9gC9urMlFAf4bc25WEB55KPZYX4DF+SbAR+6o7B48l3+wBmFUcilK4hhhpHyWAvxyp0Po7on8aSOkUWs2soA8sDcAncDFC6iTziu7abUZLXXHHrJAAL4HM+iWnmpduADt41kFR1CdhV9HihYIApT1XCQovDO10VA6v8qZBlrUGZuhpd2SV8Jb863CeBH810bIIvi8dUMkddHZUbucREfpMLC1mp4YvAvSJswWgflv8eNOXdS2AkP/cxXcc7LTtD1DbaKFkCDgwdU+dse6KK3H6mx5VL0DyYTsinhr+70BohgvgLSCQIM65SPx5TGMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLJNUsZ8OnvtImQX91Xe0XW+0p5PnxULzrGtqTkMsf4=;
 b=A2cw60pNXTN3tLW/QkWoAbeyIR2OYGgWYs5ubYWLG1HJ70KeKAswpL/dKTaYRGg5WTMNO85alUgkIjQWJtnzw614j/7dYNjBHDwEEzNzPne8lSs0dudPzm0dAZo9lXBqAOI6jh5NSz/vZIhL93jIKbTGYrQ4XsZe72jwMm1RoBY=
Received: from SN7PR04CA0117.namprd04.prod.outlook.com (2603:10b6:806:122::32)
 by BY5PR02MB6948.namprd02.prod.outlook.com (2603:10b6:a03:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 10:54:07 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:122:cafe::a1) by SN7PR04CA0117.outlook.office365.com
 (2603:10b6:806:122::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Thu, 22 Apr 2021 10:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 10:54:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 03:54:04 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 22 Apr 2021 03:54:04 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org,
 quanyang.wang@windriver.com,
 gregkh@linuxfoundation.org,
 arnd@arndb.de,
 sboyd@kernel.org,
 mturquette@baylibre.com,
 arnd@kernel.org,
 punit1.agrawal@toshiba.co.jp
Received: from [172.30.17.109] (port=41894)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lZWyC-0005IL-8u; Thu, 22 Apr 2021 03:54:04 -0700
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
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
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] clk: zynqmp: fix compile testing without ZYNQMP_FIRMWARE
Message-ID: <01e78b64-8ad1-dfc8-9fc0-6afff4841492@xilinx.com>
Date:   Thu, 22 Apr 2021 12:54:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <871rb2swd9.fsf@kokedama.swc.toshiba.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dda0f80-2446-4dbc-7fe7-08d9057cf3b3
X-MS-TrafficTypeDiagnostic: BY5PR02MB6948:
X-Microsoft-Antispam-PRVS: <BY5PR02MB694811B5944B0808EF6A6E26C6469@BY5PR02MB6948.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cm+JC5TxfsCvu3HVHq9XOxT0fYzxxXWqLFbOEpBU9BNusLhJxYqq+Z/o9Bde4DTC++B1TwQCt/j30+aNGWALu+ZMKG/IWK7Ii4QBWz0AkCqluRahU+FvuBtdvn6H4FNyRecbrUhV3ueX/8SPEmexVa6vekAywreqeS41gHuANwBvLUo6kgBzH6Hphvy4TATF7txr/OMCyS7DBUWoKr5Zxtx4g7xqG8owR1POI+qrPXm5I3HXmebXpSx5vm5oaGN90EioJxwjVIRtztF90AB0JZiwyoQVek9PpsubnK4D3k5i8D+bdPTWkBm8g1ExemeDCQz6TRZiLOXogV64owAQfdyv7qw4uYzLpoeY5nnBi95bnWHv90w4kiBSEcB6Jc0faEAiX8SuHM4FaPvnRLBAuiQ9JTTXq2+WgS/EP4d488peblKXpWIDwsCf3jtOmzqoaZkhhWoOSrEgzcbThduCiVmJ/IrTX9xgZgjL5z6jtm6JK+0gGXsgxZNiI6I27lgEm3JreEoXRiiiM9SA2iMYxMFIf0rEkK2fLmRJEJ+ngp1VsCeBZ4MB2lSLH23xbctks0DDHN2f3Y4El2rXlf8ONyAU5k2fA2E8hlmjEUZo+XeS2K5NUoYBjWUdKBxW9e7J4vLNTGh3GdlJvdHFk6bhgxXTrY2uY24IG+vsLgcjBe+3It3smX7wpr+LoqaW5eD+/HTdnjVSULOks8pgzwSu4g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(36860700001)(70206006)(2906002)(70586007)(82740400003)(31686004)(82310400003)(44832011)(6666004)(7636003)(8676002)(47076005)(110136005)(83380400001)(36756003)(4326008)(9786002)(186003)(53546011)(426003)(8936002)(5660300002)(36906005)(31696002)(356005)(2616005)(54906003)(336012)(26005)(7416002)(478600001)(316002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 10:54:07.1546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dda0f80-2446-4dbc-7fe7-08d9057cf3b3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6948
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/22/21 7:48 AM, Punit Agrawal wrote:
> Hi Arnd,
> 
> Thanks for the fix.
> 
> Arnd Bergmann <arnd@kernel.org> writes:
> 
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
> 
> 
> Not sure what I am missing but I couldn't reproduce these warnings. I
> tried a few different ways to toggle CONFIG_ZYNQMP_FIRMWARE.
> 
> Regardless...

Me too. Can you share your .config file?

> 
>> As it was apparently intentional to support this for compile testing
>> purposes, change the code to have just enough error handling for the
>> compiler to not notice the remaining bugs.
>>
>> Fixes: 21f237534661 ("clk: zynqmp: Drop dependency on ARCH_ZYNQMP")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/clk/zynqmp/clk-mux-zynqmp.c | 4 +++-
>>  drivers/clk/zynqmp/pll.c            | 8 ++++++--
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
>> index 06194149be83..2afded3c7c11 100644
>> --- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
>> +++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
>> @@ -50,9 +50,11 @@ static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
>>  
>>  	ret = zynqmp_pm_clock_getparent(clk_id, &val);
>>  
>> -	if (ret)
>> +	if (ret) {
>>  		pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
>>  			     __func__, clk_name, ret);
>> +		return ret;

return should be u8 and this can be negative value. That's why I think
this should be fixed differently and all users should be checked that it
is handled like that.


>> +	}
>>  
>>  	return val;
>>  }
>> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
>> index abe6afbf3407..67d2a2d260c1 100644
>> --- a/drivers/clk/zynqmp/pll.c
>> +++ b/drivers/clk/zynqmp/pll.c
>> @@ -54,9 +54,11 @@ static inline enum pll_mode zynqmp_pll_get_mode(struct clk_hw *hw)
>>  	int ret;
>>  
>>  	ret = zynqmp_pm_get_pll_frac_mode(clk_id, ret_payload);
>> -	if (ret)
>> +	if (ret) {
>>  		pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
>>  			     __func__, clk_name, ret);
>> +		return ret;
>> +	}

Return should be enum pll_mode which is 0 or 1 which is likely not done
here.

>>  
>>  	return ret_payload[1];
>>  }
>> @@ -140,9 +142,11 @@ static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
>>  	int ret;
>>  
>>  	ret = zynqmp_pm_clock_getdivider(clk_id, &fbdiv);
>> -	if (ret)
>> +	if (ret) {
>>  		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
>>  			     __func__, clk_name, ret);
>> +		return -1ul;
>> +	}

Same here.


>>  
>>  	rate =  parent_rate * fbdiv;
>>  	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
> 
> The changes make sense in that the functions error out sensibly when the
> zynqmp firmware driver is not enabled.
> 
> Acked-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

I think code should be checked that these error values are handled how
they should be handled.

Thanks,
Michal

