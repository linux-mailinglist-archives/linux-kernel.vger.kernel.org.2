Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101CB3E2465
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbhHFHqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:46:15 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:17889
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230513AbhHFHqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:46:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdkCGpTk9y9548J3D8TcGbcC4GGvcI6IF75YMPQG2KRIn5dIns/0N35wcGY/leRPKSWwkD8cltU90hwyF1pfcUzH3QGtd0yWtThugRQYoWuEyWNzw6a9LXBT05TWdEbq3UE6zqxXkBKBAlfMWn8/19rDykQLUPnrkfcRAevyYNmiZp4YQ8CtLaxVMyUU+4iBfgInQmgXxwV/iN98rBYVSmIOfJkI9hz0AQNtprZ0JI+tlzh7XXspGg2Hiqc2IJLh5ibrO7Zs0hbzwtqEBl0RfO+M6eM/w23CzY5sd1CoRkNov4y2LfCuASV4wq7A22uaRPODK5y/vDh2WYVRXssk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4gLg9jiu1RSAKes6Vb5A/4cBZMnIox7mX6h6E38/3o=;
 b=HpA0go2cSaKNALDXEzchC5+IRuYH2oAccxsiq1KZPt2bY+b8OXx+l0ik7FpPDSTZd2dBXjNcpLikS4oVGphqJKy6KSWomCF7olEtX/VeuySEmk6vgm7oBCDLfSppOk6bMDvv90O9XRmvalF9T7Yyc2vr6OamjwpJ7GWNOM6WinOUVF3XxO3m5mF9vWR33BbpN7TbwJN/t18QbrRMIqz6fpa34z4f7/EW3iSH+oVA8Yj65QRn2OhwjdfPn/ckndQF6vcZagtJVRfcVDYeVWjDXozNbqrfJ+4dC1MZiBorC4/EIDMy9l3mXGa0Sz/QTCN4DnYXzCuSEwV/nKHcOCI/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4gLg9jiu1RSAKes6Vb5A/4cBZMnIox7mX6h6E38/3o=;
 b=V3SFwVHo7JOxXJ/mU9iR8EMytUCThmzvb4v+nc0mXuPvMSKsvBCOX7Ndn+kUP8cywWSd52KiSlLo8GutARuDyoLcOKjAsEIBMKuSGAMCcQ/OdXjAA7TAXeEuAJdLY6LbnpcvIDHRPAwDdc4XAARpCmULcgfqTjGiXrrDwoObCYM=
Received: from BN9PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:fb::22)
 by SN4PR0201MB3423.namprd02.prod.outlook.com (2603:10b6:803:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Fri, 6 Aug
 2021 07:45:56 +0000
Received: from BN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::73) by BN9PR03CA0047.outlook.office365.com
 (2603:10b6:408:fb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend
 Transport; Fri, 6 Aug 2021 07:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT017.mail.protection.outlook.com (10.13.2.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 07:45:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 00:45:55 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 6 Aug 2021 00:45:55 -0700
Envelope-to: linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org,
 yangyingliang@huawei.com
Received: from [172.30.17.109] (port=57800)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mBuYF-0000Qw-Bz; Fri, 06 Aug 2021 00:45:55 -0700
Subject: Re: [PATCH] pinctrl: zynqmp: Drop pinctrl_unregister for devm_
 registered device
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <michal.simek@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>
References: <20210729071905.3235953-1-yangyingliang@huawei.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <b3b4a3a7-17b1-4317-143c-925785b8c687@xilinx.com>
Date:   Fri, 6 Aug 2021 09:45:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729071905.3235953-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d6d07af-a58b-46b4-7791-08d958ae399b
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3423:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB342375D473924EFD039C0BEEC6F39@SN4PR0201MB3423.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP+DaLMYEZoNJQ7ak3DhHL0NW6DV6DrbFN+8Ss6LaO3D9vene9NirIvjuK2UbPvFI+gYqk94gcH6xZdot+g7F54GsjTKz2AhLgPBqPQTcB/vik/MTIm5sqNhf9Adja84fHPFy4xuRrIUakqj2L0VRlVWZ1kGbMdNzEjykUMewZ63ConGhxe9H+4wPf7dRUJdRnnlccGDM7gP0bHm4F9vVDuSZlITlhi9aGkYOBBwtFWmhEg5UKPw48bMwRXCNEZ+rB9AEFyr3olCOyD2+rhaCy7CSge2Y7qIgSD4cswnk4aQ9qCUJlLBbymgOTekM1EObaCAFO0Wb3Mwe9aRhKVotIh3howGJtGtxzeGqCG20oIwlJ3MJPX2bIAdA3vEFakr9zjCFB24KDfRoIDR3B8HdXIMJ4C4Ojh/1m7Hz8rViOjzE/6NVvwBsnjoyn/ELLG2JwgayDt3heq1h8cnlTzHtKtQltkTPTnKDmbt7k/SYh6Xdj3NT0XtwjxIYTMFmCtrXy+GB1pbm6/3x7qGZN9OnY82qvhVYGyAblMWex+QRhnlaF18hIW2oMDezwQUDtdqk1pdG8keUTtiKA3NDALlYJn67Qz54tTNmOgt/txy2wcEF+Le/0TXK+QezmJkoX4oZUcu5m+KCe8dduJuFjoEzX1Xk/BGMvPY0C/26n0O8S8CrL9FSC3mMMoO+iMl3nb4P/nBp6e1UiusE0c2HHOfdDgUGwWLgQy3FMg/ObTatQyTIEMuw37Kqdk6zRYl7RRADxiNZtOFpMAi42R39yD0Bg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(107886003)(82310400003)(4326008)(2616005)(186003)(47076005)(356005)(9786002)(36756003)(336012)(7636003)(2906002)(31696002)(82740400003)(54906003)(83380400001)(8676002)(31686004)(44832011)(70586007)(70206006)(8936002)(478600001)(53546011)(26005)(36860700001)(110136005)(426003)(316002)(36906005)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 07:45:56.2350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6d07af-a58b-46b4-7791-08d958ae399b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/21 9:19 AM, Yang Yingliang wrote:
> It's not necessary to unregister pin controller device registered
> with devm_pinctrl_register() and using pinctrl_unregister() leads
> to a double free.
> 
> Fixes: fa99e7013827 ("pinctrl: zynqmp: some code cleanups")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pinctrl/pinctrl-zynqmp.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
> index bbde676b7313..e14012209992 100644
> --- a/drivers/pinctrl/pinctrl-zynqmp.c
> +++ b/drivers/pinctrl/pinctrl-zynqmp.c
> @@ -866,15 +866,6 @@ static int zynqmp_pinctrl_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int zynqmp_pinctrl_remove(struct platform_device *pdev)
> -{
> -	struct zynqmp_pinctrl *pctrl = platform_get_drvdata(pdev);
> -
> -	pinctrl_unregister(pctrl->pctrl);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id zynqmp_pinctrl_of_match[] = {
>  	{ .compatible = "xlnx,zynqmp-pinctrl" },
>  	{ }
> @@ -887,7 +878,6 @@ static struct platform_driver zynqmp_pinctrl_driver = {
>  		.of_match_table = zynqmp_pinctrl_of_match,
>  	},
>  	.probe = zynqmp_pinctrl_probe,
> -	.remove = zynqmp_pinctrl_remove,
>  };
>  module_platform_driver(zynqmp_pinctrl_driver);
>  
>

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

