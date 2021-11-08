Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8A447C98
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhKHJQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:16:36 -0500
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:28064
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229570AbhKHJQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:16:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXtuUnQH3hWs2yWs5hDux/KqLe2fSXORtarnzZcuZc4YgoL9H4SltVKQhuNMynRL+xG9c/4b4gPbpMFluOSiIOjPETaHQFlUkARP0hJAT2kUxg+zpEXCB0SlNoFz4tuRwjyGfbtkUK0ZpCo7uiN6RZ3+5mLjJsVOjIFzo15j70d+y0cRKFrgYZg5D8QuW4e1ZCi7hM/RXhbi3dxPwUFQoP6e8Hglq4warVmk6Ti8c2D8gfFLmcNtOxYyr+ra9QzWWZ/2KZRKTXfEbAhwVaYRxMzUshTHgnIYjPjMc9obwm6IWk92nV7le8qfVF0ToIMS583Uez4b0wU8E3BzEkxvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMNXGbtyg0eBesrUGh797v23VUWr0tWcQ3TnsSizyAM=;
 b=OcliwO4gNmgKKqDoqADkQsmr87VbwPXKdNHlDU/bCjx8nPVnMWzSF2VuEp6fPD10m/mitOJtpLVK0NIhLVGUVI2AVG1sp6Mpg+5QUUgpwi1zLTQK/EwE8UaMFbQ+kDtGFMV+GaPT8XcPPsF+2m+ZxIiWphPwKOWgtLy33vAbMAWlWUeicPYjExYkp6JE93J4q7lBNffnDKFMGO1gu/UT3FMKRX7RmJfwcQT7vD+7tqUmSOAiuTs4mlRX/p3UU0VGI4RvWw7ESxNHrZUe4P0h4AHs2A5k8JF9FX5wvOO5HcOs1mPd4yJw8ji3YZ21oXyCfdnwRXsBkmOohgLW1k7GuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMNXGbtyg0eBesrUGh797v23VUWr0tWcQ3TnsSizyAM=;
 b=BIqnw/0USyok8i2asBTtgO2bkhmUpT1GCe0kb5zjIXUqSZk0NPXMxuk7O2f4L24q6rF7M8n9g9YmmnatExaIKLQectE69UJyuOsX0otARsmdpEDa4yXOCoCniZjhLN8RR4YWLk7umdP/K7fL37ULPKQrBtSJ0Jb9UwMPGN26vMs=
Authentication-Results: insiberia.net; dkim=none (message not signed)
 header.d=none;insiberia.net; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1782.namprd12.prod.outlook.com
 (2603:10b6:903:123::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Mon, 8 Nov
 2021 09:13:48 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 09:13:48 +0000
Date:   Mon, 8 Nov 2021 17:13:25 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Stefano Picascia <stefano.picascia@insiberia.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow selecting amd-pstate without CPU_SUP_INTEL
Message-ID: <YYjqNaND8hLGsoXg@hr-amd>
References: <9932762ef184fe132acf176081f8893800c83800.camel@insiberia.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9932762ef184fe132acf176081f8893800c83800.camel@insiberia.net>
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by SG2PR02CA0004.apcprd02.prod.outlook.com (2603:1096:3:17::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 09:13:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 551d3782-2619-4493-7238-08d9a2981292
X-MS-TrafficTypeDiagnostic: CY4PR12MB1782:
X-Microsoft-Antispam-PRVS: <CY4PR12MB178202993C0D851989FDBE0AEC919@CY4PR12MB1782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuKIWwuCis3fCWRWs0gLgeXo9u70fx8iS0Udi/5EWMTOEFPmgF5eiECwK/np2uIgEB1UMjoz3bFL5PjFv8U19YbVqAGOLo3Dh/TcMylrde31alDhOwUIGKvUDQCTwFTh9+0DNBy1+fDnVqwVar7/Oj8Ub67t0CAG3mDlHsTsfIdO/hQF7dztGvrRhy+WL2RrNwh8erqMfCz58pysZMW/i9RQhMVb8vJ/M4qS0r/W5mO9/d0SwvhcvKR6sJvXGCrVx+UDv+49wcYMIDDTHZu/M8lwnpRHQSfnG9Fuzf9CSJGJMFI9c2VKGiC6s3JbvpHJlWwFwBhCy6N8Yt2LH+HJ6uA2zSy3cr6S09xAJVzShjlJ2CjB5gARO1lGLpoKZbOG1IbELJkC4RDUWUn+wltU6WKj9/Opbd1TfmvlY2IGksT5alqUmPYYfkG4A4eq+d5z1VGXVsCPeLDMyIhkfJtZIpzHTOZi4o5/pTwaLJNvPdDx2jXDxK5koeAA7rIHNPRKJnHIFwrf+W/vh7lyRluHKhUqNQTwWsXh5Gh9EU2abAQLTIjJHEhsPS2oVojjSH3TjqfRFPP1GRmSYRJxqj5/l85w/1aPB/Wf9kPepZ0154AKOqs4Vi2KtE//bbg9XmNTGcg65D0Zrh/BPgTmoFPFiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6666004)(5660300002)(6496006)(4744005)(9686003)(38100700002)(33716001)(8676002)(4001150100001)(26005)(956004)(55016002)(4326008)(508600001)(86362001)(66556008)(66946007)(6916009)(316002)(186003)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VV2o3tQU4Ori0M8SCIsBoqDiuizBIesAiAO0Iubn7yrSOn854EUHViNssyp1?=
 =?us-ascii?Q?ToV0llI9T/TbZX5tkpaeYo0CbezdLkeI5JQIv4+OI34dRQChOW63TDmWtGX7?=
 =?us-ascii?Q?l5Z5sEqbYdwja5k6Ln1IvPnEv2OkJ1qEgDjnXEH4sKy8qQQuZy0EvZGNXgW+?=
 =?us-ascii?Q?MHmgeteQYGEijKJPvrdPk9bjj2kz5FQ5SxxuTbVGuwSADNCPrutprdCnpuPU?=
 =?us-ascii?Q?NBXetML/xcpcB7kCJ6DeFSMFdkyI26YXU/rur6NnoFDHMKK0vOzA0LNI4jpu?=
 =?us-ascii?Q?XLIlyWaM+nNHIv/+OH4xqCY0yJebr3nMhAA1AF6/ZcmLGjm6EPIkrw2fOOkM?=
 =?us-ascii?Q?KzUDG/1xbrVF2a/n39HqyvLpn/qT3Vf6dKPvZZeTPZKBj3c+YzSiCU9iZJn6?=
 =?us-ascii?Q?VppRECZybSOhe1HXx8WRP1GBsyt22mmkUAdgiJMyYGmLFWjEEKVyqZ3M6w4A?=
 =?us-ascii?Q?a/TIYp2dZkSiOXtKNt/7Lahy3k/oH8lyO5dDVqEpV8x1a72/xcq/BV4hUM87?=
 =?us-ascii?Q?jvyA+p86xBICHAtwcpNlxdqbddpjDngoPGJebSB0D9NdGmViOFgB2e/YzvfL?=
 =?us-ascii?Q?uH9keqadvPXe10KTiVKZIDlRWFOIk4xDQD1doKru15OoX/E8uvJWdwNNkkII?=
 =?us-ascii?Q?XgVneXY7k+eOwAc4im/mWw2NKMg2Vb/7J+f1vZ41aGixrquPjERQdoFwOlP6?=
 =?us-ascii?Q?o5FhGX0H4jgCX/GaU1DcxG4ebkVU9WjL6rDKTaG8iZmwufS02oGA+rFPwAHY?=
 =?us-ascii?Q?Gsad2wVJO85k2LWCuZ1X+fWGQFK0WCMXTcob0DmJ76TJuo+lubJweRc30Mo9?=
 =?us-ascii?Q?B8t6irQ/2/YjTFBAovBXBNsirBWtXrNN/cEq5APlBJuoIwHjwr9jGXWgtXhh?=
 =?us-ascii?Q?TJOo2kkd0owtA31antnPyqh/HzqlOaxehNb9aX4tNdqRa8FEDQsMa5TO8S4c?=
 =?us-ascii?Q?pzvV0O4cuvGF4O1d7vZ+nWpZvSdSgVjNFiWAuRD55RnFqLWAKvDpASE1xMXq?=
 =?us-ascii?Q?JjWz2naph0i4IpdZCUrzeIzmQDzi8rUnKeGKf3hyUC6hg1j5lfsb+2OMo21t?=
 =?us-ascii?Q?l1uXUset/pMMznp+4INOu4y1GmjcKK2CIDLJcssEVFhHE4k5F/oyVSJ3ivtP?=
 =?us-ascii?Q?YU6qXvT1kR5G0AP+RN5RMD+SoipUnzZJv1dyv+A8fvQBiAM9F2R4rHy6BjX/?=
 =?us-ascii?Q?qDBhzhXtwCPmlvCTRKRA5ETHPvaKSN2OMQIzTrAt3qkqw4ic4OZjokAeuADF?=
 =?us-ascii?Q?RiZXBCa1xfUR2lKRFtAccy1cGWteSRWb1apTn71KK+VbLSDDJVJeCkQO/S7r?=
 =?us-ascii?Q?Arez86kOz64ZygVAWrHTU96kMFlQSTwjdiLdz8L3fRch++zYXfMLLgFiAi1f?=
 =?us-ascii?Q?tITEtqW14StGvPlEyhq5hnNExh0Lxy2DYezY1VQZWjG9+o8nMq9uwtDp50BE?=
 =?us-ascii?Q?S7hOcmzcaK6a7/0DMfZNXDoyZBHxPHHlOAYObCHubY2pXTtia43MX/3uVV4t?=
 =?us-ascii?Q?A6i9QVSy/rFymRU+QeoUCoZlflMhTTx/uOR0mmeTLmCSkoGsNEtJR/BZOhn8?=
 =?us-ascii?Q?HJ6qH9cET4E7ftu3lgKII4byIejQqlc7ohukgLYBgU07uW97Qm7dPlHcI/Ht?=
 =?us-ascii?Q?DTqt7Kaku2B1UECuP0KW28o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551d3782-2619-4493-7238-08d9a2981292
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 09:13:48.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzcnXqdffHSOib4epjkYqTMgcbF/DDcjplRSYgfFnLdEtIdxd/dIPRKr43aIMhQfJ2DNQOpNe/A0K8jq+3IMiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1782
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2021 at 07:55:29PM +0800, Stefano Picascia wrote:
> Currently, even if selected, amd-pstate is not enabled unless
> CPU_SUP_INTEL is also selected, due to ACPI_CPPC_LIB depending on
> SCHED_MC_PRIO, which in turn depens on CPU_SUP_INTEL

Actually, amd-pstate driver doesn't depend on SCHED_MC_PRIO. I will clean
it up in my V3. Thanks.

Best Regards,
Ray

> 
> The small patch below fixes it.
> 
> 
> --- a/arch/x86/Kconfig	2021-10-31 20:53:10.000000000 +0000
> +++ b/arch/x86/Kconfig	2021-11-06 09:22:46.736533394 +0000
> @@ -1015,8 +1015,7 @@
>  
>  config SCHED_MC_PRIO
>  	bool "CPU core priorities scheduler support"
> -	depends on SCHED_MC && CPU_SUP_INTEL
> -	select X86_INTEL_PSTATE
> +	depends on SCHED_MC && (CPU_SUP_INTEL || CPU_SUP_AMD)
>  	select CPU_FREQ
>  	default y
>  	help
> 
> 
