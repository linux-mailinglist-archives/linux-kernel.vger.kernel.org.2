Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7942D6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJNKE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:04:59 -0400
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:9953
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229468AbhJNKE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:04:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+0uQ5bnZnU0FaH8/lXUdtueRhtxtCwmCr645QkRjT6RvGK8Od5G9z6VwYa9GcvRsJO7K6TO/vNxLwq6tL5syEJH7sft5D1aYzPDH25NKloGpFeLtsWpCNkk+Y3pIL1lLnzK+r1wm+i9SReQmpwxG9gIeoI9/XL+VRzitkcCirfi2PL5bX36XFRGTVEYKaSPjBF9YV+8/CL0GmQQQ0aM25QBRbYf3aXvL6tEUv1gwv8U7kaJgtHi21ZK+rJwxb/JJPd65q+zs+e/NB4MoeW5+fiNr5/D5ms7Ktag1D2pan1gvBDgGarUdJyTN1cdmf6Xe8ugK5XIihaagXh6v0T0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlaHZBPmUlrZ5BMrHheAC4pN/eYTjKB2oQzXbTa0dEY=;
 b=cFia3o0BRk2q9DAyoVUjvqVaTSWR/Rfsh4vUiT4qfMrQ99huFJh/eArGHl8fNwBORDXkc0WceEryYiZ+8d3T8EPFRXB+r7MYZ+6ra9g1rHFi5RnGHTAy9J8jvn6XnEiaOFlaAPnk+LuGlGwYa4lv4bolonQ7p4XdpPF/GvJ6DJQG4s9zKtOyq9B1FWJMgG51kNcREVA76JUetOCoAIx4buUfpaGPUJ19XRlKvjpB9xVEul+WqAVaA2S/qXCf9XtKavoZ5fCqNzdl3CpV/Bf53PeChNSdbkgPIeQJctwwWZ4ERe+JgfChOW27kUyQfct9g5IqZ0L0hxW2Yfr375lSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlaHZBPmUlrZ5BMrHheAC4pN/eYTjKB2oQzXbTa0dEY=;
 b=f3xoyWeqINUBVwlCZ2YSV5pSrkMak65GNihaF6B/XswX0H5Hff8jyvguhOVA/MzdOYy78c++DyqY6kFxqwMrZca7Sj6n9iQIXA9CKZDLtlFusCRvx1EeQlroItzW+pCfRW7fwzJn/ZhK+N59zKRFNi+CBzilDXfaXgx7PTaTyzA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5114.eurprd08.prod.outlook.com (2603:10a6:10:e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 14 Oct
 2021 10:02:50 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::452b:e508:9c57:a6e3]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::452b:e508:9c57:a6e3%7]) with mapi id 15.20.4587.030; Thu, 14 Oct 2021
 10:02:50 +0000
To:     pgwipeout@gmail.com
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org
References: <20210812204116.2303617-8-pgwipeout@gmail.com>
Subject: Re: [PATCH v2 7/8] arm64: dts: rockchip: add usb2 nodes to rk3568
 device tree
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
Message-ID: <fecdda76-6eaf-9cf7-09d3-e2025ad1297b@wolfvision.net>
Date:   Thu, 14 Oct 2021 12:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210812204116.2303617-8-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0601CA0017.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::27) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
Received: from [192.168.100.125] (91.118.163.37) by VI1PR0601CA0017.eurprd06.prod.outlook.com (2603:10a6:800:1e::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 10:02:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5f1a8b-d446-437c-fb68-08d98ef9c822
X-MS-TrafficTypeDiagnostic: DB8PR08MB5114:
X-Microsoft-Antispam-PRVS: <DB8PR08MB5114A2F319818FFE5B4D85F8F2B89@DB8PR08MB5114.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: im4K7LkLALXv+AIrsh9+r0u4c9pAT2veEcwL1CEwRAA5wBK7mVVC01yBZztU9OrQMSETTYFbDUj06ITKMCkLuDGAwFbrhj3qlxPOKiYHGYyUywXIoKOjUNdJO0oxnKYn2aOL2uJg8N2Rn9dcMGeY6XSKxEOh/sG38I+4iaZN2glUKxqokdiiPvR5p8wYBZFPzi5Uc3v1NACx3Q3FwUBPCyXaYvT1bESFlE6zmeiZpzVcga9KjtHQDAaY0XGYK6BspbEbYJA+D+ZtCbNr7Kx/GE8AX3juAk0huRkxF6+HEdi9cOjd030anqLgoCfvhV/C6WZNGQZIDP2g1G8dhmKPaY2DIlKO98v8ULb1LfQzMCtuccRIoJZW1uPqj+7NigXnwZPBsgZOtRVi+No9AiVWC07XZC2FzoePC/VuuQRHEdi5gzA8IvyAMVZiLD+atryNMb+7yPlV5tSSiKJMzSuh67k6LYuh927YwfsfazMVx5nA4vkT2fWSb3e1jYafwOU+dwUTX/pPOceeBo/fXanYso70v5+4Ym+zDVYnLmIh7D9G5phonwQw1XlbzqeNyy24EPeLTNirrV0KxkOlzl8XiSHU2vcpVolOGwjsgB871MIsSG0yv8IkA2myqDV+Qabe8R9M5LBSEqRC8L1cYK1fYghjv+Ly/OL8LcLT6D8CbXhU4e2SvxDn9P7e2N+l3QH11xxqw9LlbNcnAJDNwOhOMWPp00sa4IO8SOYei99AIfPYCAs+L5OAcwJ/s8PdP5ITQDY8BIJNW795ZjwLITd9Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(396003)(136003)(346002)(86362001)(2616005)(26005)(5660300002)(83380400001)(2906002)(956004)(508600001)(38350700002)(36756003)(38100700002)(186003)(31686004)(4326008)(66476007)(8676002)(31696002)(66556008)(44832011)(8936002)(36916002)(52116002)(6486002)(66946007)(16576012)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmNvOGdzay9jQUptU0Y3YzlZSFErU2tOWW9JRnY2bkNRZ21Say9jZ2RkNzZT?=
 =?utf-8?B?czY3c1NZYVhoazVLYU45cU5BU3pSNFhiM21xdlo2YkhjdE5WQ0xjZkpSSFFw?=
 =?utf-8?B?RGNTTjMwV2xpbldyRzZlUllSRXBnTlJMZDFPcjV1YWtkZ1VMWEhjNDlrR284?=
 =?utf-8?B?ajdGU0NaZkh6dHVIeU1vL0ROcXE5clQzb203UEw3Q1BxdDJ4OGdsa2tNYmhU?=
 =?utf-8?B?NzhXN2xibWhTN3RheGxOd2lGTzNHK3RLcUQwR3dTWHNGZFE4S1RGMXpDcXBJ?=
 =?utf-8?B?NVYrMWFwR01SSWlsSzZJcHdyaGtJL3hlRmpicnNSSmliMFBxR1pPdDZ2eDRZ?=
 =?utf-8?B?UlFpM3ZuTFI3SlRvMFNmYWRadjdFWUJnMUJHNnhHSm1MdUFCMy9KWG9OMFY2?=
 =?utf-8?B?UnhqZnNna05HMG5Yd3RBaU5tS3RlUk16dTFmT0xReWx5UWc0L3J1MU9pU2xl?=
 =?utf-8?B?TDQyVXU2MDBGQlA5NGZHM2FEWXJvclQ4VVhCS2luYzRGZXFuNWZxUnBqaWNy?=
 =?utf-8?B?RUdZYk1HWWRjUWtlWUxMMVFOV242dko5MUU5cndOa01nSzhpbkhwYy85eWgz?=
 =?utf-8?B?Zkw3aituU3ZtVEROeE55UkxyeEVvUC96K2pOSE5Kck81NVVjb1VMbFFoY2Iy?=
 =?utf-8?B?UDUwTG9Ka0RnQkxpWkRwZTNZQndodU1uSU1nMXhQeWdXbE9Ba2gxMXJpNzlG?=
 =?utf-8?B?Qk52K0F6VWo1dElMNzZBUm5tUGFWcVZVVExCQWtuOWF2ckx4VmVVODhtRmdp?=
 =?utf-8?B?TkRrUldUWVAxRHV4SmtVcGgvci8rT3hHTXRHVlhTeUQ3WFMrRkRESGE4VzRp?=
 =?utf-8?B?KzNUMENkU1FuREVGSHBjUGZqaCszWHA3b3E2RHFWVFQ5ZmdCQXpmSjBmOFNk?=
 =?utf-8?B?Zy8xS0FEdFVmMW9jVXZxQ21tbGxsV3lKNHd1ZGJMcXBWUkliUHc2Q29rNU5z?=
 =?utf-8?B?dW1TZ3NXeWw3SkcxNFZUOHcwQWlZV2thcmlxMkQyWDZ6cU4wRERrM3liamd4?=
 =?utf-8?B?cU1qV21LSzZXbjkwVHpvRFJuZGJ0T3ZtZFdqRUk2a2g5NXlLakJsdnQ2eXpK?=
 =?utf-8?B?SHhGaGFqQjVqRXcxRWtDbUloL2V3c0JHK2grdklTUXR1S1ovYmNZWmxSTi9l?=
 =?utf-8?B?ZnB4cHAyV0hoeVltTStITC8yZjliYUpxdHJIZm1qR3FPdUtSaHlpaklVbFdU?=
 =?utf-8?B?dWN6a0p6ZkpvRkhrNCtHbndZRWdaM05BdVFjcDlQT2E4Y3pnZlVnOUUzUGJZ?=
 =?utf-8?B?ZjBsK2hCWHhVVTBCZjRscWVMUlN4ZnF4MENiWVRKRTJ4bTNOSWFSUmY5eU5J?=
 =?utf-8?B?aEFIRUJ5TEVES1dpQy90NTdNQlYxL2F1c3RYZ2lmSWtKTkxiNG1GQkIxM2x4?=
 =?utf-8?B?VmRQa1c5YkE3MmtaNHNuYWJ2YzU0NmR6d0d5SHpOOXhtUkJCQzQ3MCtEVTcv?=
 =?utf-8?B?WVhtRjJzS2xrNEQ0ZnNudm1SOFh6QjI4RUVZTlcrdmIyRG5BcUFlNDJhMzQy?=
 =?utf-8?B?M0dxT29iajdpK0JoNWg2WmxLUFV2TjI4TzZIQjVUS3czZGtNZURPeVNUWXpJ?=
 =?utf-8?B?SGF5dnhlUHZIdEVxck9NQW52Q0QvUVdhdGhGWmdpaDkveTdSZFluTmNQMEZu?=
 =?utf-8?B?OFB2VVcyWnBFN3N3ZjJLcE8wMHRNbDA1azIrS2JPTjVvNXc1WlN2WXFuL3Zw?=
 =?utf-8?B?NFJHcmp1cXpVaXJMUEl1Q2ExcHZyTFFTaGZoVCthcy9IVlYxM2p2djZFeHdI?=
 =?utf-8?Q?QAIrL5Qgs2UDNQLPkxrrTDjOaPq09Oq87oYJIUq?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5f1a8b-d446-437c-fb68-08d98ef9c822
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 10:02:50.7671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXhYDuzbRswkUk1zjfy8ThnhRYVQsAYHDUzQ1joJnLHiQSiAWXspZ+urXIxSAkrwN8sSBa0bvKYJGsimJlOaxHF4ZomawQ2y4+8H7CAS9D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

One cosmetic issue/question:

> [...]
> @@ -738,6 +792,50 @@ saradc: saradc@fe720000 {
>  		status = "disabled";
>  	};
>  
> +	usb2phy0: usb2-phy@fe8a0000 {
> +		compatible = "rockchip,rk3568-usb2phy";
> +		reg = <0x0 0xfe8a0000 0x0 0x10000>;
> +		clocks = <&pmucru CLK_USBPHY0_REF>;
> +		clock-names = "phyclk";
> +		clock-output-names = "clk_usbphy0_480m";
> +		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
> +		rockchip,usbgrf = <&usb2phy0_grf>;
> +		#clock-cells = <0>;
> +		status = "disabled";
> +
> +		u2phy0_host: host-port {
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		u2phy0_otg: otg-port {
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};

Would it make sense to name those usb2phy0_{host,otg}? This would clean
up the sorting in the dts files a bit. Otherwise, u2phy... and
usb2phy... would have to be separated by e.g. uart nodes.

> +	};
> +
> +	usb2phy1: usb2-phy@fe8b0000 {
> +		compatible = "rockchip,rk3568-usb2phy";
> +		reg = <0x0 0xfe8b0000 0x0 0x10000>;
> +		clocks = <&pmucru CLK_USBPHY1_REF>;
> +		clock-names = "phyclk";
> +		clock-output-names = "clk_usbphy1_480m";
> +		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
> +		rockchip,usbgrf = <&usb2phy1_grf>;
> +		#clock-cells = <0>;
> +		status = "disabled";
> +
> +		u2phy1_host: host-port {
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		u2phy1_otg: otg-port {
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};

Same here, of course.

> +	};
> +
> [...]

Best regards,
Michael
