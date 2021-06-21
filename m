Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646B13AE889
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFUMAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:00:31 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:53313
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229610AbhFUMA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:00:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epaeKgq4mKP1fTZuNTXA3dEB4Yysu8Jwu1mGEnD4pXps3a8oWwe+gZn+EYaMz0bMNtFSHujkYBJtYO1xZ2BNZUrIzah1qkPL8XFnLcGEbvAh8vlFniLCAPLBx4yL5n9lJpC6KlqHdqjdFdooLqtuXN1wNUuhBCfKufTgk/GVHT5fTiuwc0rPBzPby6jFuF6FffPDW5Y6Dzml71uGqBztLojeXD73WemAugb7eBTGv+eEF3HxUQ3vYbkhsf/STH7hgIyBWgUXlz5v5/3JdNSaYozL5SIckwHfs1ltLJIQBggDtTmQubQCpCbwMFj2tBc4fj1jXgyP7/LngZTdGSaqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiUqEDaR+bqnRqtdocNVXn09q92nEPasPhkMu2f+ZyA=;
 b=MqEmfUrUkv1DgbuflNge+vZS9qR+d1MD7EpnbwyPJ3x4Ple/nQ0Lsruv3gqQ5rV16eFm+IYKabOFqU84eXBnpLKjZ5jWEjZQYlt03B7EM4KfHRL9mw35iaHmgEzvB5fSzT5fpgLwM52FcRq/dw1eErXRkAVIIlzrvcs0UAGmSdny/zoR4B2B3+Dji8pEciJ1D3mlTu98GzRUPoaq6809jwM8wDt0AWFTwlsN/bLAvuKzwhP7obUhDKBIpsK8QKjsLU0iQf+IKZEK8D71fvmdEfMJq7J5KAareng4zWUNjDV0A/MCc8IFHYdLEO+WiWRAYqxT9idPj3PWS0EWL64gnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiUqEDaR+bqnRqtdocNVXn09q92nEPasPhkMu2f+ZyA=;
 b=PnvKcRF8sDOv6WLBlrNbISOmc7yqest5v8oPwOowFD8G3xo1FUrQWW0P461/8hGZ6ll27fBbEyWw5k0pZj8Ylfe5cKcchu4d8dGpPNznNKEXxaYKRFLfctD5aRoJQXgHsJ0TgU3lY2bvmO+oO/Nyy/MhO8SLsvNgRsRDNzVY3sQ=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by CY4PR02MB3175.namprd02.prod.outlook.com (2603:10b6:910:7f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 11:58:14 +0000
Received: from SN1NAM02FT0005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::91) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Mon, 21 Jun 2021 11:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0005.mail.protection.outlook.com (10.97.4.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 11:58:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 04:58:10 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 04:58:10 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=50572)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvIZ8-0007RZ-9v; Mon, 21 Jun 2021 04:58:10 -0700
Subject: Re: [PATCH 5/6] firmware: xilinx: instantiate xilinx event manager
 driver
To:     Michal Simek <michal.simek@xilinx.com>,
        Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1622217566-1856-1-git-send-email-abhyuday.godhasara@xilinx.com>
 <1622217566-1856-6-git-send-email-abhyuday.godhasara@xilinx.com>
 <1155e79d-7c66-d772-d5ce-7d346ee8d8a0@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <4e43bd3f-26ae-e85d-7d32-2bebe5c09a5c@xilinx.com>
Date:   Mon, 21 Jun 2021 13:58:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1155e79d-7c66-d772-d5ce-7d346ee8d8a0@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2359749-514d-41fe-b293-08d934abd951
X-MS-TrafficTypeDiagnostic: CY4PR02MB3175:
X-Microsoft-Antispam-PRVS: <CY4PR02MB3175AEEBD7DE97148B7CE7E3C60A9@CY4PR02MB3175.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lEjeiwTOkwtH9719ydvecdwy50vLeoaLF1VWsDFEsVf0gtG5karHLlXTZXVvHRSjXPDnsf1Qb5rnOJwXqxZItfRZFnWikkcJB1gRaAiS9VJNyBkznbv9TIod8RI6bUJm4f3USSYNjuwly+uXcsPkdnjzuZohQSuhifSdr/AV84eDOKqLCqQ+u0E2pRZHkuvhbGmBT7hUffKs7OHojM65XZs3jPm/VTd5UD5g4lvGfCDjEWB8OmApz0d+UehNnNTyN33o42psZZIE3YX6eJ88gth7Q/x0EySpXvsX42V70sTZiY7M47L98BVLLcSJ47YdLNR6LmNonrqLcFXgRhVO7DuQgRHTsiSevqOMNTUVg0yB8FqRWXNNNsYk5wdiyOnHHFbkedZOvNZL8B67bGPS8lsCEHzPRQbIvGQmw1wLumDlvYe4QfM56tUXxg6SgEh7+3f3wiwAlhljxoYYpPC/fhMpCnnkc6g+trFtM4Yob3aAvfkOzV55jravYFyrEHbTxhaaXGYLXGNdLryPNkJbAZL/VGmfAprIPxJQnjIzvertMf6MLvQB3drRrOuyLDXkiP+h1YK7F8/iTRoqzWzwBCCT76yJyP4aNzjOoXEj1MEmr9uMzr/Y0telIl4XuGsUWy+oXdzRpCfiID5XUtvIInwq8abGB+MIsCzpXuNNUhxnFP+3M2WzumIZ4aDV8L2Zz19zAStyKi+PYylTI+qMQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(9786002)(70586007)(36860700001)(110136005)(31686004)(5660300002)(8676002)(36906005)(47076005)(8936002)(478600001)(83380400001)(316002)(70206006)(2906002)(36756003)(31696002)(4326008)(6636002)(356005)(26005)(6666004)(7636003)(82740400003)(426003)(82310400003)(53546011)(2616005)(186003)(54906003)(336012)(44832011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 11:58:13.8878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2359749-514d-41fe-b293-08d934abd951
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3175
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/21 1:48 PM, Michal Simek wrote:
> 
> 
> On 5/28/21 5:59 PM, Abhyuday Godhasara wrote:
>> Register simple platform device to instantiate Xilinx event
>> manager driver.
>>
>> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
>> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
>> ---
>>  drivers/firmware/xilinx/zynqmp.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
>> index ce16a72..31f7857 100644
>> --- a/drivers/firmware/xilinx/zynqmp.c
>> +++ b/drivers/firmware/xilinx/zynqmp.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/hashtable.h>
>>  
>>  #include <linux/firmware/xlnx-zynqmp.h>
>> +#include <linux/firmware/xlnx-event-manager.h>
>>  #include "zynqmp-debug.h"
>>  
>>  /* Max HashMap Order for PM API feature check (1<<7 = 128) */
>> @@ -31,6 +32,8 @@
>>  static bool feature_check_enabled;
>>  static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
>>  
>> +static struct platform_device *em_dev;
>> +
>>  /**
>>   * struct pm_api_feature_data - PM API Feature data
>>   * @pm_api_id:		PM API Id, used as key to index into hashmap
>> @@ -1412,6 +1415,15 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>>  
>>  	zynqmp_pm_api_debugfs_init();
>>  
>> +	np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
>> +	if (np) {
>> +		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
>> +						       -1, NULL, 0);
>> +		if (IS_ERR(em_dev))
>> +			dev_err_probe(&pdev->dev, PTR_ERR(pdev), "EM register fail with error\n");

Above you have IS_ERR(em_dev) and here PTR_ERR(pdev) this should be
PTR_ERR(em_dev).


>> +	}
>> +	of_node_put(np);
>> +
>>  	return of_platform_populate(dev->of_node, NULL, NULL, dev);
>>  }
>>  
>> @@ -1429,6 +1441,8 @@ static int zynqmp_firmware_remove(struct platform_device *pdev)
>>  		kfree(feature_data);
>>  	}
>>  
>> +	platform_device_unregister(em_dev);
>> +
>>  	return 0;
>>  }
>>  
>>
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>

With above fixed please add this line.

Thanks,
Michal

