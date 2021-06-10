Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30DE3A231C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 06:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhFJEMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 00:12:06 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:57614 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhFJEME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 00:12:04 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15A448rD007513;
        Thu, 10 Jun 2021 04:09:58 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0a-0064b401.pphosted.com with ESMTP id 3934d9r83q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Jun 2021 04:09:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R39g1uaX8Tgns2TgaMnGVpoyalLvgmfIY9L7yIgLCoEK82TCNOr9DLMF4v894t3ooY9uLKFiaU3qTd8O06K/HqCX8xwoRz2U2MVQFLK1BcoqJeNt2GnzkKcKZD3rxJkjaBFlCmOyvWmXuG3bpxz1P28Td0NZDeJW6OxDoMFu0WX1RWWBrK/mQabZZnmx3OltTn5FrA8h+Cz6aVjgGQnPzCAiJPXn0BnoUQMjKhx/QhXlC44iseBJ7DycOq4XeFWMF5GTOKLK/YH6Zg3XUuaZ416kpRXLKllPozSXSIeyU/ZU/mOTZCKWhWpWFDI4Aiy1H0n/8+7jufClnG0hcYlujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2BBo+ukxO2l/RhD629zE0XkpchQiuhkJwL5PKCQSH4=;
 b=NxlmrmO7MAqHvlCvs1TIoDzipVS0b5WRAIIRkivCHU78ktsvvz1bVdXzQuyilwBHhqe5LhHaWX1QoP9n6zNCL8ruoqQyLfJUOZqDkEmq25c8Gy6O2V+AzG9XvNmRh2m645J27+VINuQGfZpUzeOdoUoAFiNxpTs/dVs2mlqj10HJkNG7lVrEPD/cvohldrPZrrUJN2wzj4rNZumik21a7EIIVnf8SIw6sZHsfcGYnWS/HKiRHGDb2WfgHwWKepJNO+EmNPOebNJWenJhsTV/bTCoZh65q3KNhR/qPZS53upUJy2pG3c+6L2/OX91J/AAumcxySyqNFZ5A6Cv5FR3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2BBo+ukxO2l/RhD629zE0XkpchQiuhkJwL5PKCQSH4=;
 b=Fxop3wg7XRN0VFBV+358jcfZhBjykUAW1rRC1Cv0MEZjDLz5Ch6/Ut3z1KtCPRopPNC0V9YITKwkKvrkNwQYW2nqSlVJ+BTgRqQGLa0IVBTk3Ti0x7eGvSiLNUypFT0eKFwVEqpVaE0doUdnh21qeM/WPPwgYayBfSX35KC+zC8=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1333.namprd11.prod.outlook.com (2603:10b6:903:24::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 04:09:55 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::2175:30e7:d0fc:db4d]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::2175:30e7:d0fc:db4d%5]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 04:09:55 +0000
Subject: Re: [PATCH 25/31] arm64: zynqmp: Wire qspi on multiple boards
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1623239033.git.michal.simek@xilinx.com>
 <80671218c97ad2188df476cf1b49bcf6f64785df.1623239033.git.michal.simek@xilinx.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <71b6423c-ab14-424f-0018-fafece13150a@windriver.com>
Date:   Thu, 10 Jun 2021 12:08:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <80671218c97ad2188df476cf1b49bcf6f64785df.1623239033.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK2PR04CA0070.apcprd04.prod.outlook.com (2603:1096:202:15::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 04:09:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30ddc7c-3489-4e77-33cd-08d92bc59a60
X-MS-TrafficTypeDiagnostic: CY4PR11MB1333:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1333856E43F8CAF45D728CC0F0359@CY4PR11MB1333.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XHcMURXg/n0i5soz4XZtvU5RjxW8cj8iH2uOKwSuc1ZUJStah6B1JX0jkRnlchtNsa9QowImgBLQnHv3JGMaYAar4w7qxZEJmkT0HZnIp2rb3hoDjyZBzWrPqzAtC8pi8QRME9hEeZo463X5iPSSy10lSfFe44mUodIXE7Qs09FZ1l9HFWhXcUsF0Z+VVt4bU1/5XgDk8IqOQ8qTSG/uP6i+nGnvYlGSAURZmVksNk9xFllBQPkKZJURxjpB+RrSM+RRw6sFRKPkM01wQrwETi2WBlddmMP6VoUvlGL1bd6WUMhdbUvTEbDVyKv0jeOsKYePfFk9w1R2h/x0ruG6Cyi/YAqL2iS74UwjTFdP+zmk/I7v6Lu5m5XlpuopIG9BdfbbptePuo92UjnXDScaI6L4jXogGO6IgDx7KAEYVCgxaEFqZFkUbwmWgw/aDtTq1BsY0Mrt8wCcAgK8j8zW9VpYRmqBWE8tiiMlb/XJCDqB3szOcN1eAQbnHO8kEUEKTANPg6s1S2qfGqcVKH8fzBPdXvom5kcDlvsH6QVTITVAV9KRfQwK+8hLV+mr7QUs7x2aMlppdfNk3bMN8XbT9/99JWyfp5MLpp5ocuVgWLjZUaw79QwI8lYgiHvxNlqXrOsXC7uUqC5s1042G5nMJJed8pq/mojFj6c/EeniM+kjGm4EeaSJlvxMKQpG0v8RHSWe8nP+t39UD24pClhjZ31Lm4c7di3gFaTI1GWiZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39850400004)(36756003)(110136005)(2616005)(6486002)(66946007)(956004)(52116002)(38350700002)(54906003)(31686004)(8676002)(66556008)(66476007)(86362001)(478600001)(4326008)(6666004)(7416002)(31696002)(53546011)(83380400001)(2906002)(6706004)(316002)(26005)(5660300002)(16526019)(8936002)(186003)(38100700002)(16576012)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXlMU05vdTNxcE5nbFgzUGltWWsyenNLaVFndGNBYldjMTV3NlBCVHd6REZP?=
 =?utf-8?B?a0hRcjZuN0g4OXlWbEo0L3cvTlI1U0ZOenFyYXVRMVBMTWxFeHRsdUZ4eU0z?=
 =?utf-8?B?WFpOVGMrTHVKTlhxVTJZeVRiU0pLUm5EU3Q0K21xWDV5TDBOaWV2ajVvRzd5?=
 =?utf-8?B?eVhxSzY3OGJHdEpsT0pZWTJHK21GMTZRK25va1RGOXk1cFd0UjY0a0kwbkFW?=
 =?utf-8?B?U1c0V1ZIU3ZRWGZONjhWVEhRTmZxRnl1dFpTTDRUbzl5MmZOellEc3RKNmpD?=
 =?utf-8?B?TDVlU1FuL1BuVURRU2FmTHNvMG9qRjZ4bDhyMitISU1XNzdKQkkxc0pURytv?=
 =?utf-8?B?bnVuQUpuRWNGUThPQ1hRdmtNeWpCL3o3UldIUHFrcTlsbjRHWGZnTi9EbW84?=
 =?utf-8?B?bHpsWTZNOEhmSFhNWWRzQzNCMEZmK3RRMlJGbGdUODRydk9Tcy95WC9FMFhZ?=
 =?utf-8?B?ckJYUTl2S0RNdEdHVEZuU3Rnd0JvNEtxRk9vUWhiM3JUaUtuUWVMdU9VOXBl?=
 =?utf-8?B?Ynk3ZTRnTnYwY0FTZ0VEeTlTR1N4aERjenE2TFdveXp3NUNxYlRWV0FEZmxG?=
 =?utf-8?B?cnEyVWt4ZFMxc1FGUmFvMjEyYy9DWkxvWnp0cS9ueHZsZVNkUVQ2eXBvN3g3?=
 =?utf-8?B?dGlwQ2ZqNHpIenMyNDAwMUtTSkJPeVZFTDlkNzdFck5oWm1TbDhXQ0dzeElx?=
 =?utf-8?B?ZE44cVlrK0UwUHZpZ0xhcXNVM1IweU1PTlNQUVV4WmFZS2plYVdZZnhuakoy?=
 =?utf-8?B?VVcxbDY4dTNjVmFZN0hnZjFGZzFPNUpIV2k5UW5ZTHZPTUUySS9zSnZSZEc0?=
 =?utf-8?B?cnJIeENZdWxGMTRHRDYvTTFQR2pBaWo3ZDVVTFZGdC9VMUM4V3JGRWRTejJY?=
 =?utf-8?B?SzJWbEZXM2Z6VnYzTjg1aFJJNjFQazVhNzFWREEvaHB4cE5ya3lOTzBBbnJu?=
 =?utf-8?B?MVhHSmIxck1CZmdFZkRRYTBJWEpjNDlvcXNOR3QyazJ3cXlMcXg0WnEwZjFK?=
 =?utf-8?B?UGJWdllCTG1aNHNqcEZvRlRyUExZWS9XRWFDcEtMNCswb3preTArR2x4MWov?=
 =?utf-8?B?TlFUODc3UDg4VDFGakszZkVyNk4xVG5WdkNzVEUybzN3eXV2RUV0YWlXTmpU?=
 =?utf-8?B?NVY1MXZTbGwwS3JFdG12MVF1US9YVTZYWHlDZndkVWxNNkk4RkpEM0k0Mnc4?=
 =?utf-8?B?dHgvYnlDSTFiZ1R5b0N3c3U0d0VoV1pVbEVSTFQzdXkzRGsxMHpldklkbEI2?=
 =?utf-8?B?R1lxLzZyNWlBTEJKOFVudHovU0tXL0xjRnpEVW5Ucnp4cVlwVkRrMnNKMUVo?=
 =?utf-8?B?dEQrNXVRbEJsMWV6QWVRY0xMK2srQmlEbDhuY2x6Tmp1Q3VYOC96TC8zTVpx?=
 =?utf-8?B?dmRtcnduL3NLcXlDMGdCZXVhQjhhSlZocFRPa05Mb3pEdUp0ZTNXZXhOdXRG?=
 =?utf-8?B?VUhhYXVuN3dDOFJMLzFkQlUzMDFVc3JjVG1lWDlCL2FTTUttOHpGbTRhdytz?=
 =?utf-8?B?MldxUm5hbDJaSXROUTZORFpXS2NGNnEyNFdGVEF6NDRKcXk4SFVVTVVsbDdX?=
 =?utf-8?B?dTdlQ0E2Zm9WZXAvMGRZd2R2MkY5dlNMUFlIRjdOU09Jc3hqemhaYnNGclN3?=
 =?utf-8?B?QmJrMyt6QXJTaVJITDRWaEl4Ymp2Z0FTY0U5RXpmTFF3eTBjSGpVZFpwdEV6?=
 =?utf-8?B?aEhjaWxXL2o3OVZjL0w5N2FrNmpkaDRYUlMvb1daNnZQSGF0Sm4xV0o2Z2x6?=
 =?utf-8?Q?wK59Bz/x9evpGZw6mZpmYomhSWkZaSkO9cqu7Y6?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30ddc7c-3489-4e77-33cd-08d92bc59a60
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 04:09:54.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpt4ELFuKdJxVVUQX1BfM7WSsDlJm6rMsnGeTJyrHUEEO3eKqWnhFX7gRpbWPxXL619He5CfiboUUBl+pIydTQlxs8DotJ47+zue47iTBGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1333
X-Proofpoint-GUID: E_CJg3EnV_b5vfgIUDB7DsacA6JtMKmM
X-Proofpoint-ORIG-GUID: E_CJg3EnV_b5vfgIUDB7DsacA6JtMKmM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-10_03:2021-06-10,2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 6/9/21 7:45 PM, Michal Simek wrote:
> Couple of boards have qspi on the board that's why enable controller and
> describe them.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>   .../arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts | 16 +++++++++++++++-
>   .../arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts | 16 +++++++++++++++-
>   .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts  | 14 ++++++++++++++
>   .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts  | 14 ++++++++++++++
>   .../arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 15 +++++++++++++++
>   .../arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 14 ++++++++++++++
>   .../arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts |  4 ++++
>   .../arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 15 +++++++++++++++
>   .../arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 15 +++++++++++++++
>   9 files changed, 121 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> index 2e05fa416955..f1598527e5ec 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
> @@ -2,7 +2,7 @@
>   /*
>    * dts file for Xilinx ZynqMP ZC1232
>    *
> - * (C) Copyright 2017 - 2019, Xilinx, Inc.
> + * (C) Copyright 2017 - 2021, Xilinx, Inc.
>    *
>    * Michal Simek <michal.simek@xilinx.com>
>    */
> @@ -19,6 +19,7 @@ / {
>   	aliases {
>   		serial0 = &uart0;
>   		serial1 = &dcc;
> +		spi0 = &qspi;
>   	};
>   
>   	chosen {
> @@ -36,6 +37,19 @@ &dcc {
>   	status = "okay";
>   };
>   
> +&qspi {
> +	status = "okay";
> +	flash@0 {
> +		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <108000000>; /* Based on DC1 spec */
> +	};
> +};
> +
>   &sata {
>   	status = "okay";
>   	/* SATA OOB timing settings */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> index 3d0aaa02f184..04efa1683eaa 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
> @@ -2,7 +2,7 @@
>   /*
>    * dts file for Xilinx ZynqMP ZC1254
>    *
> - * (C) Copyright 2015 - 2019, Xilinx, Inc.
> + * (C) Copyright 2015 - 2021, Xilinx, Inc.
>    *
>    * Michal Simek <michal.simek@xilinx.com>
>    * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
> @@ -20,6 +20,7 @@ / {
>   	aliases {
>   		serial0 = &uart0;
>   		serial1 = &dcc;
> +		spi0 = &qspi;
>   	};
>   
>   	chosen {
> @@ -37,6 +38,19 @@ &dcc {
>   	status = "okay";
>   };
>   
> +&qspi {
> +	status = "okay";
> +	flash@0 {
> +		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
> +		spi-max-frequency = <108000000>; /* Based on DC1 spec */
> +	};
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index cd406947ec34..9f176307b62a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -26,6 +26,7 @@ aliases {
>   		mmc1 = &sdhci1;
>   		rtc0 = &rtc;
>   		serial0 = &uart0;
> +		spi0 = &qspi;
>   	};
>   
>   	chosen {
> @@ -339,6 +340,19 @@ conf {
>   	};
>   };
>   
> +&qspi {
> +	status = "okay";
> +	flash@0 {
> +		compatible = "m25p80", "jedec,spi-nor"; /* Micron MT25QU512ABB8ESF */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <108000000>; /* Based on DC1 spec */
> +	};
> +};
> +
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> index 8046f0df0f35..05a2b79738af 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
> @@ -26,6 +26,7 @@ aliases {
>   		rtc0 = &rtc;
>   		serial0 = &uart0;
>   		serial1 = &uart1;
> +		spi0 = &qspi;
>   	};
>   
>   	chosen {
> @@ -161,6 +162,19 @@ &i2c1 {
>   	status = "okay";
>   };
>   
> +&qspi {
> +	status = "okay";
> +	flash@0 {
> +		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>; /* also DUAL configuration possible */
> +		spi-max-frequency = <108000000>; /* Based on DC1 spec */
> +	};
> +};
> +
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 3cbc51b4587d..becfc23a5610 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -30,6 +30,7 @@ aliases {
>   		serial0 = &uart0;
>   		serial1 = &uart1;
>   		serial2 = &dcc;
> +		spi0 = &qspi;
>   	};
>   
>   	chosen {
> @@ -934,6 +935,20 @@ &psgtr {
>   	clock-names = "ref0", "ref1", "ref2", "ref3";
>   };
>   
> +&qspi {
> +	status = "okay";
> +	is-dual = <1>;
> +	flash@0 {
> +		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
Maybe here should be "64MB" not "32MB".
There are 2 mt25qu512a flashes at zcu102 board, and each of them is 
64MB. Since "is-dual" mode is not enabled, so we can only observe 64MB
size from boot log:

spi-nor spi0.0: found mt25qu512a, expected m25p80
spi-nor spi0.0: mt25qu512a (65536 Kbytes)

And I only verify the flash size in zcu102 board and not sure if the 
flash size comments are correct for other boards in this patch.

Thanks,
Quanyang
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
> +		spi-max-frequency = <108000000>; /* Based on DC1 spec */
> +	};
> +};
> +
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 4c328569c3ac..84c4a9003e2e 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -28,6 +28,7 @@ aliases {
>   		serial0 = &uart0;
>   		serial1 = &uart1;
>   		serial2 = &dcc;
> +		spi0 = &qspi;
>   	};
>   
>   	chosen {
> @@ -427,6 +428,19 @@ &psgtr {
>   	clock-names = "ref1", "ref2", "ref3";
>   };
>   
> +&qspi {
> +	status = "okay";
> +	flash@0 {
> +		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <108000000>; /* Based on DC1 spec */
> +	};
> +};
> +
>   &sata {
>   	status = "okay";
>   	/* SATA OOB timing settings */
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 99d172867f6a..fb8d76b5c27f 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -28,6 +28,7 @@ aliases {
>   		serial0 = &uart0;
>   		serial1 = &uart1;
>   		serial2 = &dcc;
> +		spi0 = &qspi;
>   	};
>   
>   	chosen {
> @@ -435,6 +436,9 @@ flash@0 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <108000000>; /* Based on DC1 spec */
>   	};
>   };
>   
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 464a76a13c24..d2219373580a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -30,6 +30,7 @@ aliases {
>   		serial0 = &uart0;
>   		serial1 = &uart1;
>   		serial2 = &dcc;
> +		spi0 = &qspi;
>   	};
>   
>   	chosen {
> @@ -928,6 +929,20 @@ &psgtr {
>   	clock-names = "ref1", "ref2", "ref3";
>   };
>   
> +&qspi {
> +	status = "okay";
> +	is-dual = <1>;
> +	flash@0 {
> +		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
> +		spi-max-frequency = <108000000>; /* Based on DC1 spec */
> +	};
> +};
> +
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index c9d41d16c3f0..4dc315ee91b7 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -29,6 +29,7 @@ aliases {
>   		rtc0 = &rtc;
>   		serial0 = &uart0;
>   		serial1 = &dcc;
> +		spi0 = &qspi;
>   	};
>   
>   	chosen {
> @@ -772,6 +773,20 @@ &psgtr {
>   	clock-names = "ref1", "ref2", "ref3";
>   };
>   
> +&qspi {
> +	status = "okay";
> +	is-dual = <1>;
> +	flash@0 {
> +		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>; /* FIXME also DUAL configuration possible */
> +		spi-max-frequency = <108000000>; /* Based on DC1 spec */
> +	};
> +};
> +
>   &rtc {
>   	status = "okay";
>   };
> 
