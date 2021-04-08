Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7A9357C22
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhDHGIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:08:46 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:55519
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229506AbhDHGIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+JzHEoS4J0nr+4LzB21Hxza/Nclme5xmwr0fn80Q+Bc26FqLWHzbsYCxvUScuPKg4vDvRIu96rHzw+gXcMCHa1AGfntwXSLVnG3BXo+rv78vBv3UhzrhY8kp7h3o2v7OSBi0/TPGRsS1B5JIo3na1D8DghWYbOdomII0vh5TnHKIJcyscspSpOjLJ32elG/mDbz2gCg1LRDYWOS75jWMLJiIF5bm6y+uvUGu0F7RbuZuOupTsJxGQh2mv1rf5JtMO0EbRBDSFCOzmPSeehKV4ce6UoOiGdil/BBDTdesLnJn9Eilg8vH9FCo1cMlSmw9SSeNxWoY8hiuNnM5yK44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9POfFMd6vxs2KTMkla8WcMd2K6qRwdLDvsoaSWEna4=;
 b=ZGRxcZ7BID2gA5FIahIwBTQZXSUQOwFlt80vceAw9jvRGaaGNnsZRl1gPVwot5GdUUFfnylBkjD/OQgxP8yTOx8/VqfyOAKk8HMP0mrHQzXfbkn+DqkoigxULOaeH79ZLoXUUTJFaALXsBFdFkBmYi+PdbOTeWOnHb6D9aWFOD8Prkm6UV52Brtbc9RaT6LJuOfwLSMWJ3kA24Bno82I6CEN0iEPrAPz392scu9RG/p9bIZX8EJiIgYFVrCwLP4HjKlwKfb3pYfY2Klp8JxY3ggurq2VSBKJzmdpJdmO+7DTERkfleER3iJ6YdZwjyGL8psaj9oOwXVfv4/6Wc2gEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9POfFMd6vxs2KTMkla8WcMd2K6qRwdLDvsoaSWEna4=;
 b=GIC+rdTDqhNUCVduGdHJY2EFGFXDb0FOg6vDFAtoyofQD2pipu9OK9w+LS8TfmsykWbM2KE1pb1Kki9LAHTIOCjbyJ+L/ek45Cz0zZayW5209IrvtEo3/JN/tNV9ybS02reoSWI5nnDooZB8NruMHzDz3ny0nX4fjqkkZS12GkA=
Received: from SN4PR0201CA0070.namprd02.prod.outlook.com
 (2603:10b6:803:20::32) by BN7PR02MB5170.namprd02.prod.outlook.com
 (2603:10b6:408:23::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 06:08:31 +0000
Received: from SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::69) by SN4PR0201CA0070.outlook.office365.com
 (2603:10b6:803:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 06:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT004.mail.protection.outlook.com (10.152.72.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 06:08:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 23:08:15 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Wed, 7 Apr 2021 23:08:15 -0700
Envelope-to: git@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org,
 p.zabel@pengutronix.de,
 balbi@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux@roeck-us.net
Received: from [172.30.17.109] (port=40116)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lUNpu-0007ab-9U; Wed, 07 Apr 2021 23:08:14 -0700
Subject: Re: [PATCH v4 2/2] usb: dwc3: Add driver for Xilinx platforms
To:     Guenter Roeck <linux@roeck-us.net>,
        Manish Narani <manish.narani@xilinx.com>
CC:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <balbi@kernel.org>,
        <p.zabel@pengutronix.de>, <git@xilinx.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1615963949-75320-1-git-send-email-manish.narani@xilinx.com>
 <1615963949-75320-3-git-send-email-manish.narani@xilinx.com>
 <20210407214811.GA260719@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <ee280235-736d-1689-d324-b090c21106c9@xilinx.com>
Date:   Thu, 8 Apr 2021 08:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210407214811.GA260719@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38f260fc-4475-494f-a904-08d8fa54bc33
X-MS-TrafficTypeDiagnostic: BN7PR02MB5170:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5170A307615AEEE2442650BCC6749@BN7PR02MB5170.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5Wexh7UqNAbVei3RKABhcvLbJx4ThMA40sF3iNR7MtfYvKnKjtr+aGB0yEzjpctaAgCpPx2CXasN+AeCFpN3dmgvzhzE2kQaoHNRbjDJIJIOhX2ksgNDzuhcBHPEqokJjOYHbmTgisvStFa8N81gLpLHemDmiycW28TmPLWsQNs76sTwXH8j275Vc7BL8oYJlWbvuJXJWE9mXumVRXNhxuwVPY9UOGxoLMzft+K+NrKrIQqe4jNaqoxtsi0BZLOKnzLW502XIQMkf5dZG119fgdciwO4H3bPavhdpaOhNv0sYG9InKI47NI9Bn+60xY7aOJ1qU86mZtKfq6v9cI9ZNGoBTBoeVdrQhI3mOZ3q7rDapbNt6k139FDko6vfVoVywI7/4pGyqXxq+xe4svHALZngD/3IEUEYgHkDhxv2hDTwP3UOPDTups7sQZ+eeCqstXZ9wrWUp9leBQQ92755o3NIecYVNZPSnxd5yzrNCxE+tzLhTRgHNak0yrVcmydGP3ySV6lrRnx87aJsXemDCfrb1QcArObeZ8qXHrkzpt1XNfJ5NABvIhVhdYAhPiKZ5ku3lc1a++Sco4qbnHTc4EIAjfO0mdpjnBjRC42pWWTebwI4NrBSeI+fwvlUXomCsSWKDxBmPWksAY7JL9rSQu+iU/iqYAZDkCbGhyGDcT7GWWNBrtFX2V+EPvOT0nAlrYHFDGmfmMUz4ZqhOXUA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(2906002)(356005)(82740400003)(70586007)(53546011)(83380400001)(26005)(5660300002)(8676002)(8936002)(7636003)(70206006)(478600001)(426003)(6666004)(336012)(31686004)(45080400002)(2616005)(36756003)(316002)(110136005)(36860700001)(31696002)(82310400003)(9786002)(47076005)(4326008)(36906005)(186003)(54906003)(44832011)(6636002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 06:08:31.3814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f260fc-4475-494f-a904-08d8fa54bc33
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5170
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 4/7/21 11:48 PM, Guenter Roeck wrote:
> On Wed, Mar 17, 2021 at 12:22:29PM +0530, Manish Narani wrote:
>> Add a new driver for supporting Xilinx platforms. This driver is used
>> for some sequence of operations required for Xilinx USB controllers.
>> This driver is also used to choose between PIPE clock coming from SerDes
>> and the Suspend Clock. Before the controller is out of reset, the clock
>> selection should be changed to PIPE clock in order to make the USB
>> controller work. There is a register added in Xilinx USB controller
>> register space for the same.
>>
>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> 
> Trying this driver with qemu (v6.0.0-rc2) results in:
> 
> [   15.184242] dwc3-xilinx ff9d0000.usb: error -ENODEV: failed to assert Reset
> [   15.185754] Unable to handle kernel paging request at virtual address 006b6b6b6b6b6b9b
> [   15.185994] Mem abort info:
> [   15.186065]   ESR = 0x96000004
> [   15.186317]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   15.186414]   SET = 0, FnV = 0
> [   15.186498]   EA = 0, S1PTW = 0
> [   15.186579] Data abort info:
> [   15.186666]   ISV = 0, ISS = 0x00000004
> [   15.186756]   CM = 0, WnR = 0
> [   15.186887] [006b6b6b6b6b6b9b] address between user and kernel address ranges
> [   15.187436] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [   15.187777] Modules linked in:
> [   15.188060] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc6-next-20210406-00006-g05407f068fc9-dirty #1
> [   15.188265] Hardware name: Xilinx Versal Virtual development board (DT)
> [   15.188495] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> [   15.188614] pc : __clk_put+0x24/0x138
> [   15.188716] lr : __clk_put+0x24/0x138
> [   15.188791] sp : ffff80001326bac0
> [   15.188853] x29: ffff80001326bac0 x28: ffff00000644ed00
> [   15.188982] x27: ffff00000421ecd0 x26: ffff00000421e810
> [   15.189076] x25: ffff00000644f100 x24: 0000000000000000
> [   15.189170] x23: ffff8000126a2570 x22: 0000000000000005
> [   15.189271] x21: ffff00000644ed00 x20: ffff000006449970
> [   15.189367] x19: 6b6b6b6b6b6b6b6b x18: 0000000000000010
> [   15.189456] x17: 0000000000000001 x16: 0000000000000000
> [   15.189546] x15: ffff000003af0490 x14: 00000000000001b7
> [   15.189642] x13: ffff000003af0490 x12: 00000000ffffffea
> [   15.189729] x11: ffff8000123b6460 x10: 0000000000000080
> [   15.189815] x9 : 00000000676993c6 x8 : 00000000676993c6
> [   15.189941] x7 : 000000007d152ab3 x6 : ffff800012768480
> [   15.190047] x5 : 0000000000000000 x4 : 000000007f97631e
> [   15.190139] x3 : 00000000d5bdf2c2 x2 : 000000000000000b
> [   15.190233] x1 : ffff000003af0040 x0 : 0000000000000001
> [   15.190432] Call trace:
> [   15.190506]  __clk_put+0x24/0x138
> [   15.190588]  clk_put+0x10/0x20
> [   15.190653]  clk_bulk_put+0x3c/0x60
> [   15.190724]  devm_clk_bulk_release+0x1c/0x28
> [   15.190806]  release_nodes+0x1c0/0x2b0
> [   15.190887]  devres_release_all+0x38/0x60
> [   15.190963]  really_probe+0x1e4/0x3a8
> [   15.191042]  driver_probe_device+0x64/0xc8
> ...
> 
> because of ...
> 
>> +
>> +	ret = devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
>> +	if (ret < 0)
>> +		return ret;
>> +
> ...
>> +
>> +err_clk_put:
>> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
>> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> 
> clk_bulk_put_all() is not necessary because of devm_clk_bulk_get_all(),
> and results in a double free.
> 
>> +static int dwc3_xlnx_remove(struct platform_device *pdev)
>> +{
>> +	struct dwc3_xlnx	*priv_data = platform_get_drvdata(pdev);
>> +	struct device		*dev = &pdev->dev;
>> +
>> +	of_platform_depopulate(dev);
>> +
>> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
>> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> 
> Same here. This will likely crash the driver on unload.
It looks like that you directly created the patch. Isn't it better to
send it yourself? Or do you want Manish to create it based on guidance
above?

Manish: Can you please take a look at this?

Thanks,
Michal
