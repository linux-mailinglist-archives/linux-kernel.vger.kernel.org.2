Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB192428D73
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbhJKNBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:01:35 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:62336
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235237AbhJKNBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:01:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpJJjLIuALU2SMbn0IuiI2n3H0Gi5yCfrppnxLWogViZENRYgfJ1ZQBGxkm/tBP+SUTj5HIF0TAEtglDENdWOLDUyRSFOEi7ffOzAvuaY1kDCFwXvqvgi5whlVa7oNGw3PdPSuE7UliEhiLGhWLee4dZna9rw92oVKGIRUrrsiT709zwWdVZih8lLV9pperVwFjCfMj1EqH9MkqJtMhMnBFM8j/w0zGOcyhLuezO8J2TIZBLZ8GiuAuOPiBo5HDDTznh1VhukqXaEQX1GdFgJ2LuBm1XIU+zp+a1V039+Na7/oMZk17lmqpkJcVgNYaDCSuPvgY+C1/l0XYMIi+AXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZzUGDHrnNV4nsxVKS59gmKRy6rLEYYZ87i4nhBJlic=;
 b=OdD0Kbr1f8ULOtjavq0446dzCO5z2W1m8g0aTLePdt5L581a097qOloHqcRqZmYtalfdkq1aLdMGRMym57ptueRsjwi4OKi085UJhTU3vR/12kryIP8C+ebeN/oTtChycFB8ZWj8SnpS1ZOpx0DLAJ3DKg8ocMJRhW+Gyx5qhgBAG9WrfGYsUo/RXbPyawXCy869jMUQrPMSmsaGAxeh6zlSb3AhoIEzsaI9dSjg7jACKHF3FSaA8UJAFDizCIy4BSFZbfMwXzG9+wKizGFOXNx2SeQRWQbqQgGaFTbBUfbNBuy05b/6KAE06TXhgbjbd+Wg7d+mlwHno0edUzizvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZzUGDHrnNV4nsxVKS59gmKRy6rLEYYZ87i4nhBJlic=;
 b=pcJb7r5Sve4lj0dXCSIO0J42QtSGQpENNL/+kqe/Pn/bICH/9byVeTY37mneMmgfEaEJS8yodplhRCvsQ4TYg8G5QlkNTykJotUVH7wR9IuPo+DF63Eg/6sVxi4akXHVVr1aBdifGlbyvNZVooELYNQ+wROQckvViuMZEL6VLcs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Mon, 11 Oct
 2021 12:59:31 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::e967:9e04:2d3e:f5dd]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::e967:9e04:2d3e:f5dd%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 12:59:31 +0000
Subject: Re: [PATCH] usb: xhci: Enable runtime-pm by default on AMD Yellow
 Carp platform
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
References: <20210920154100.3195683-1-Nehal-Bakulchandra.shah@amd.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <dce6c013-c2aa-aec6-a2c5-370e6c774e6f@amd.com>
Date:   Mon, 11 Oct 2021 18:29:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210920154100.3195683-1-Nehal-Bakulchandra.shah@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::23) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
Received: from [10.252.254.83] (165.204.158.249) by PN1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 12:59:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ff8ad0-ed9b-4707-5d76-08d98cb6f6ee
X-MS-TrafficTypeDiagnostic: BN9PR12MB5193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5193A7199DB9C9F8D41AB42DA0B59@BN9PR12MB5193.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zBZ6M/nEpljSaFFaBOycKXOngqoI6xby5rCDimCzAdu2X51SxK+bgNkV8uwPDeKA5E+6c8mTIYN/uRX1U7ykQHvbKeJshG+L6xNHHhP0fNG9BwFzAixNjfBz2jbjyNgNFaxDDpm0HcJmn9J3LrKoU+531CGEsn1scWFTbJHyR+GSWHbNMUEEAc6sWLPHEmmUMmmR91YRk3pn4fOrQ3vmwhiRzn1lY5/0ysr+3moOzymo1WlZ0EdOLSHRjvtb6A0rYN6ZJG4kkvwIXvuYn3Y1SP6qkenQqubSirzo+DUUxivam6QKMlZltSQSDplfHPb49ByzTyd0zvrDQFA7eMar1+N4f4VHI3xHHdMsW+/h0Drc04aaDnnCNqRz59rrgSl0aTBePhgRCijRpG051MyQjfYIKk4aEV1aCuNw66k/hR0O8ZDEJsz6TsFowTbQu6s8brIN4S8JyGdpJWpkHdkvvQ20CtXVyCmVPnhdsKIQ+cUY5EW49IDEv1wdmOnRUX6DMZ378gNu+UO6t5rsaREbyuABw1lm8fPkQ2i7Z8fSQCuwjtt6nT5uhKHuIfFHJvQSQxDsBWInPxGQeWKsJImBh8JXZ4LAPBBpYBRi6vL/0LvXZlGTCVFArWFZAL+9turK3PHIqofM2ly9WG+Y5UHjE9649ruhQrbZNdUCJxJ0PhVbtXe3AW+hV/oWLXoZPh1bg/NNCe2fyjJzDATgEWUv4sXVOtBwTP4IXeJ19dQvEwztWeQAPk1WGtqwW6qOHGz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6666004)(53546011)(6486002)(36756003)(508600001)(26005)(186003)(4326008)(8936002)(66946007)(66476007)(66556008)(956004)(2616005)(5660300002)(31696002)(316002)(54906003)(16576012)(86362001)(38100700002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmU0UVVVdHBVTnByZ3JWajg5a2p3amg5MXhZZGVncHovaGxJOU9GZDlqYU9h?=
 =?utf-8?B?Um5KZzBpT0ZvUGR3S1JCdHpPaWRTR21qSHZNU3p1MEc4WGgxR0pCQjJQT1FU?=
 =?utf-8?B?UHdtK0NrTzF3YVh5Z1ExWmdnaWd4WDBHS2JxWnl0UE1SL0owTExoWHJqb3B3?=
 =?utf-8?B?L0RJSGorNUJPSEtXUzNVNTU2NlgraW5sM3I4YnVsN3BUcHhKUzRkbWpPRGla?=
 =?utf-8?B?TFEzQ3hHdEZyRkVHSS9QTDdxTU1iWDN4VWRQYnB4TENCOW4zUE9iWEFFQ2J6?=
 =?utf-8?B?RllDUldEOWNDVkFObFdkWTQ3VTFWa1RXTEgraVZ6SFpsQzB5blJXaDF4b3FF?=
 =?utf-8?B?WjVyL2xpR2pBMjZtMXRJZ3pQVGNKa1FEMG5LUG1lWnNPVG9ZYVU4c01HNGdk?=
 =?utf-8?B?T2M4dm5UYjMwVFNrWGNmMHd4YnBGSVVqTVMyTlk0WW9HbFZsaTJIejNnT2cx?=
 =?utf-8?B?aXNCZmEydDNQYkxHUVplc2lMODhTWElpQlJqcy93MWxWdzBVTjBqUndLV2Iv?=
 =?utf-8?B?eTNHMnovMVh4R2RHUlEvd0JWTWVzdHpYT3hZdkxTUU43NSt2SFVCa1YzbXBq?=
 =?utf-8?B?dy9vTExIcTM0ZnAzT1pFNWlhN0szczFxSkZERmxod1h6ZXR6cGlrQWtBbXZq?=
 =?utf-8?B?S0pyeVFYVTlDRXFwUFZQVDRndERqajdua3p1VHYvMTY4b1dCc21LY20rckNi?=
 =?utf-8?B?SFdGR3ZrLzdzamNURU1MWnNlNVpLMWY2VUpQYVpjaFYxUy9zWncrK2NIYTM4?=
 =?utf-8?B?L05nTmxmNnkzRnd2c0FXYnhmK0hSNy9DeFJRT093bW1iVEhvcnlTOE9JS1dV?=
 =?utf-8?B?UVN2dVpGZlpqSkkwZGhwd2NOKzJSUlVQSTEzOXFyTjFwdjJCVU0vUkVwdVAv?=
 =?utf-8?B?MWN3S3pEOXFCRU5NZ2xRUmtWNzlJN3BLWjZuRllGcGxDZnZGRHY3NVJ6bU01?=
 =?utf-8?B?RENCM2dPMGZNblgxK2MyMUxjcmdHeXlkZVpwVUpKaDZkZ3RwTzhIdVdQVzFB?=
 =?utf-8?B?S2xLTXp3N1BtR1UzTFo2ZmppNmhzZmZXN0ovdHZMckhMR1hnUC9HMFRZbWhi?=
 =?utf-8?B?blFWalQ5MVowQjFKMmxuem1maUx5MDYxemRZMVh0VHdsSUJ1UlAxSTUzdjgz?=
 =?utf-8?B?ZitveG92emhNVFhFb2xISTg0MVRWam9EeFZGUW5ZdGNVdzdUSmhMWFM4aEU1?=
 =?utf-8?B?djJHN1dJM3lqV0pUS3g5czJiV3hKY0ZKYkwrS09UNXc3aHVvMyttMEpQVysw?=
 =?utf-8?B?cHhBRlZCMTMyamJmNUFKbUhKZys2OU5EZXBEZnQ3empudytjL1lxQWF0NS85?=
 =?utf-8?B?aU9KQzhxNjVmTjdTN3N5Zm9FMWpCNFN0VXczeDJDcmhmSWhQM3IrMXNNcVZE?=
 =?utf-8?B?cTFrSHNycTNlc0M4bVl4ZVRjQ3FHeW56OWVLSlhLOVRpV3IzSVVTQXlINDVN?=
 =?utf-8?B?RGZZcExycmt1dEpySXZ6SVcyZzl1N1dOUE5IMGRxYmdOMXhseGN6YTVmZ3Ft?=
 =?utf-8?B?VU55VGhzZGN5MjBlbm9rWlFpTzF0MjM1NVVWU1k2MWxCeWFxUTZQTVlKSG1h?=
 =?utf-8?B?SHVVc0pYVGozZXJWYVJtcEhoVUxpbVNrcVRwY0tGU0ZzMmx0YTZNTXdOS1A3?=
 =?utf-8?B?aHhrZUJYaWNaSEdZQ3VFaGRVUG5QSjlUYUxOOVh5SEFGcmI4eUFnSVlPVTRE?=
 =?utf-8?B?NjM3d2QybHF1TTFLWWRQbkNuWFdBZDJOQTluNE9NM1d1aTNndWJ3YVhzb2ZH?=
 =?utf-8?Q?CqJufx09olcG5Z8hcnrRnZyjbdwB2LofBTrUvym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ff8ad0-ed9b-4707-5d76-08d98cb6f6ee
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:59:30.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnycwRFppi6hKPBYu5+Nzj5hjRfN0hbLdeEv00lKesByq/0yMp/6Jb/EMLP1amPz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 9/20/2021 9:11 PM, Nehal Bakulchandra Shah wrote:
> AMD's Yellow Carp platform supports runtime power management for
> XHCI Controllers, so enable the same by default for all XHCI Controllers.
> 
> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>   drivers/usb/host/xhci-pci.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 2c9f25ca8edd..0e571d6af2ab 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -69,6 +69,12 @@
>   #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
>   #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
>   #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1	0x161a
> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2	0x161b
> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3	0x161d
> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4	0x161e
> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5	0x15d6
> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6	0x15d7
>   
>   static const char hcd_name[] = "xhci_hcd";
>   
> @@ -313,6 +319,15 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>   	     pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
>   		xhci->quirks |= XHCI_NO_SOFT_RETRY;
>   
> +	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
> +	    (pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1 ||
> +	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2 ||
> +	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
> +	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
> +	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
> +	    pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6))
> +		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> +
>   	if (xhci->quirks & XHCI_RESET_ON_RESUME)
>   		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
>   				"QUIRK: Resetting on resume");
> 

ping

Thanks
Nehal
