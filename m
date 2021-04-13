Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D1735E09F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344374AbhDMNwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:52:35 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:8640
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229570AbhDMNwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:52:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCib8TeefJ+2wXoeX8XmYDh2tK2pTahraEL2o+5rLPQfp4XxJNEHD9H4QsVVCJutfij9D9Ajb+XbPCMg/TFHotgziGKpgUMB6yKOBSW/J3wU8UHnuOaIsn3rG8xufBx/McZzsj3qzGw18IbkBThZxH5k+qvWN+Ifhd1uEvJKZ+x4ZB8Z0wc2Kjl4fNSdAANcIeR9k9Tq7CxxCTFmMK0XxO+iMzHac4JdAPq4Lb9Gtna69pdilI4WgJ1DB+nPzDkF1OO69nfR4UF2YeCJMWA1Fm5vHhcP8dg07D1WIhmSd/ggJyM+sG71icmcM6zu2fxrFHJiU4F7cM+RTe5NQdcw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3oFWaVMnfEkZo/UfG6m6HYDXy/H42ps8KgYRGF1YTs=;
 b=c/HNfzCXqcXYBAYcnMAayOqpRfeFo2W+hLgC85Xn2h0wQfKvlsjztOCr+2xCxXCN45Nonf0OFFbR/0j/J3IbJjQSrL6QInzIPGrqqIcvsjx7Lgx7NlFbm3FOihBadrlWcGkFnUQ4bda1knKW5pQIULVJaoERSfdcddtJsnJoDDkgq4eCTHXJ/Pv2TXZcZHHOHAPzMXi9rODon9zKIUYS2VA14fCWj00RC5oY5w/TwxaF0SeTZrhEtdkXYuqtiATIwgkJhJIEk+3rEMGFnmYdY6+yH0vC2zPqttncJeD1Ws9vmJL71B0MSvZhCAaAABIfOehvMVdPhKaJ8dUg4FJ7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3oFWaVMnfEkZo/UfG6m6HYDXy/H42ps8KgYRGF1YTs=;
 b=A4c0kWyRN0JqP+Xio7tcha3Brb434RUt9KVFEEBQoNz4gf0DDC4/una2/vvEmuXvi2+umUe908E5CyKMExSvcJUebCliRLthphKcoa/tWm0OTl+zsgdbvOarW5Qe71JKBwP8jEW/yzfdnmtBfyKtl9Wt5CgnlD/EOPCJ2BW9Q8A=
Authentication-Results: bugs.launchpad.net; dkim=none (message not signed)
 header.d=none;bugs.launchpad.net; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 13:52:08 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 13:52:08 +0000
Subject: Re: [PATCH 2/2] iommu/amd: Remove performance counter
 pre-initialization test
To:     David Coe <david.coe@live.co.uk>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Tj <ml.linux@elloe.vision>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Alex Hung <1917203@bugs.launchpad.net>
References: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
 <20210409085848.3908-3-suravee.suthikulpanit@amd.com>
 <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <add9d575-191e-d7a6-e3e1-dfc7ea7f35c8@amd.com>
Date:   Tue, 13 Apr 2021 20:51:56 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <VI1PR09MB26380EED406F2F08ACB6B5BBC7729@VI1PR09MB2638.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::26) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.73.101] (165.204.80.7) by KL1PR01CA0062.apcprd01.prod.exchangelabs.com (2603:1096:820:5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 13:52:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 398bc6b8-2a37-4b9d-f513-08d8fe83547f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4001:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB400104CE8B51C828F58E9413F34F9@BY5PR12MB4001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOdQpA4Iedbj+yiJCsYmTG0Jls9M+1qH4iJqUgbF3O0h8cP4CSvJrhLYW23Qw20qhLD6PYPJ07BCkL9Pc7KD+ngB6J2meX1ur2hu1T2SZPp2VpGIi2qG29P8PE7iJSEwuiGwZ41HB8E8OLUI8ma8PrWxqu/AKNTSgMDWX/PrMG+cgWAODOUkbK/2EgwyQMiZ+nF3Z1pZ6mJuJQACtyi9xrLeon6Lq2ukYAeJqypZ/NRE2jxnBavtccoynia/EU8x9yVcm4KG/nWZjbgB2C6J2l+UuRlbKgkab0P1q1UIJjr3zUZ0TfBX7Zlpnr+EFlHi/yw8IwqD4q6G6dMpbXTQ1obgv79xcG1A/c4bLRDWIdUL2wfsRrZRCNwN/iv95vyRMwNanRznQHzh3JKcJRkiOBFX7Ycjjbgihpiqiphl3xov4Ry8Lqn3ZInWclpSAoMuvcvHhqHPob8MYAwwfIot3TcheqLGE3xdcHKkJ7iTGUWXrC0zU8YgfcGhntkeQugtZLv9fIhtHy/+VP+ryJow+hY1y5bOdJYmRUbfKhVcfHs24MiuDxWyx0K1SVaQhLKJ5qbX80n9uq4qk+KSM4OVfIGQ2sPHL9zZ18qKMrU3uI+md5lldmD+HLFiURLeM+v/EAWG3+Hj9PP9OO6ywXRK18xS/qQ4eJ/mSU+CRpHOCz0swjG/RIxWryTwN1xaYGdjsAG24fRjcXQCUhiKDZvUbd30w09hB8oaOcgeUUt0c+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(34580700001)(26005)(16526019)(186003)(66946007)(31686004)(2906002)(54906003)(956004)(52116002)(66476007)(53546011)(478600001)(6486002)(36756003)(16576012)(4326008)(38100700002)(38350700002)(7416002)(31696002)(8676002)(83380400001)(86362001)(6666004)(316002)(66556008)(8936002)(2616005)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZzIyTDlOQ25MN1NlSEtYaTJpTjcxOG56Zk50cnl3dysyOVA1TElXOVkyMS9P?=
 =?utf-8?B?UDhCQWVpcGk4b2x2bGFWVUpTMUJBNVRkcmhpalNXNTBRSG5IL3BWQ24xcTdr?=
 =?utf-8?B?Zno3WlQvOXd2ZlNBTXRSQ2xuaDdQdHFkMng1MGl4Mjk0TCtXTnBwTVc3bEgx?=
 =?utf-8?B?dXFxeTBVTG41WDVqQW4xU2FrMzRLN2VIYk9LK2VHb3VJVXc3cUw4WkQrVUlL?=
 =?utf-8?B?YmxTVE9acXMzQ0xNWGg2dS9PdDFpSTdXSWNlQm9lRGs1SUhYbWdrVEU2VVNU?=
 =?utf-8?B?Y3dsa0gzWUdMcWdiQm9YYTlzSWFlajNQK29TdGhLUDQvcHZMSkd1dGJsQnZY?=
 =?utf-8?B?YkdDV0NueW5YSHJ6dzNTUTAvVEhWcVRmRm9BYkZHUDZadVJWY1RHMllYcjdT?=
 =?utf-8?B?ekIxTUJmZGNJSmFGb2o2QWJRN2t3T3UwNTdEWXl5SG1WSVhRdEdnVkw0RktL?=
 =?utf-8?B?T0I2SjBCMnR3MTR0bkdKb2FQLytEaG4rbzFjL2dpSVNrZWtkOXNwOUhvdzQw?=
 =?utf-8?B?d0FSWVZsSXR6U0UxU1lPOWZycHZsQXY0aFZPVlhxRHo2NExJTGV6TzNFUXl5?=
 =?utf-8?B?Kzhrc05maVZVdUR1QURkVTl2TFJwSDJRWDZIT0ROemN6Yk5NV2ZuODMva215?=
 =?utf-8?B?aENlNHFqR2pIckxOU201V2lPZ2pvZ1BvOXdXak94em1CQUV6dmdFUDJxVXR5?=
 =?utf-8?B?YkRXV244T2JOUVRsUG9QbVg5VVorSXJNWVNaRVdDRVZKNy9YakptVUdVbzRI?=
 =?utf-8?B?THVPMnJ2MTVXc2RldGlHc0R5aTNDWEkrVzRCdEY5TWZkajhBL05wMXE1bC9W?=
 =?utf-8?B?aW5zWlVCWGgrdzNTa1NsUWJKR2ljMTMwc2VqcjJQZkpicE1RNkpaRTNIcDZh?=
 =?utf-8?B?bVcxdHBGR2F5UlFKbnBFU0VvMXA4eVViZUlxYm1BY0ZQbXoyM25WUStJekpK?=
 =?utf-8?B?dHdpQlhaWmNjQk9kZWNwbDduS0toeGJCREt2SmpsbFFsNHRPTHlTUUo0dU0y?=
 =?utf-8?B?U3lkNDIza0tIWTBSZVE2U0swRjQ1N0luL1crZjNTZWQxZDhyYnAva3hoRGlV?=
 =?utf-8?B?NzRwanlIa1N5SXF3OFJ5eXR4MnAzM2xrd2hnY0JDODl6T3FqUzdQQ1hmK0xG?=
 =?utf-8?B?b0xSb01XM0lNeEppUTN2ZzFEMzZKNGZnOUpSYVNIcUYyTWJLbm4yU2RrZit2?=
 =?utf-8?B?UUJIM29ZdE5MMXZ1YTdOOXFQdFlLV0hOMEV1NlpiM0toS1k3ZkhPVkRwaUx5?=
 =?utf-8?B?OUVyNTdrSzhVVjZlVHplcmRoUlRoaHdOUC9FWEo5OFRQd2dDOUJ6V0xzRkNz?=
 =?utf-8?B?Y1VUamRhMTBUQzU1K2FaK2YycUplQzNsR1ppYWpHMWVpQ09tcis2NEs3clZX?=
 =?utf-8?B?L0hTbDVqV3lXeHN6ZERPNlQyTkFpVXE0TWFJRU44aUxBOTZGdWhyYm5hK3VW?=
 =?utf-8?B?UWp5NmpiZXUvcUh0VS9VaFc2b3UrRnVYRENYSysrN3JFY3ozb0czOWMrQi9R?=
 =?utf-8?B?MGtjUkdiS29TMXFnL1dEaVZjRWxLeFN6eFF4RmxyVnNnajE1ekl1U1RXUTR1?=
 =?utf-8?B?VDVYeHpqZm1JUG1hWGZHT1h5Tis4bUpXTFlRclNpRjFZNHFDRlFRQXFxQncw?=
 =?utf-8?B?U2JhdFZoUE5XbU9aTWFGV1BxL05WNEdXR241ZW9XMUgrSmM1VEc1dlhIRElO?=
 =?utf-8?B?akNtVU9VdGlocnI4NFB5Zm5aSlpIeEJ4V1lJVVA4NnhwdFpjeFRnYmlpallB?=
 =?utf-8?Q?JEhyY+4f+7YQDPuwxObkcTCm4Myek88AulLIBAU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398bc6b8-2a37-4b9d-f513-08d8fe83547f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 13:52:08.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVSJ05nMzkQrbhgIinW7JxjJE0ZbVLTmyDNaIZnqzgK28GupHXrdqIqKkaoqghSqiKpvCaXeGWCyE3ieognmbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2021 5:03 PM, David Coe wrote:
> Results for AMD Ryzen 4700U running Ubuntu 21.04β kernel 5.11.0-13
> 
> $ sudo dmesg | grep IOMMU
> [    0.490352] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
> [    0.491985] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [    0.493732] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
> [    0.793259] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> 
> ....
> 
> $ sudo perf stat -e 'amd_iommu_0/cmd_processed/, amd_iommu_0/cmd_processed_inv/, amd_iommu_0/ign_rd_wr_mmio_1ff8h/, amd_iommu_0/int_dte_hit/, amd_iommu_0/int_dte_mis/, amd_iommu_0/mem_dte_hit/, amd_iommu_0/mem_dte_mis/, amd_iommu_0/mem_iommu_tlb_pde_hit/, amd_iommu_0/mem_iommu_tlb_pde_mis/, amd_iommu_0/mem_iommu_tlb_pte_hit/, amd_iommu_0/mem_iommu_tlb_pte_mis/, amd_iommu_0/mem_pass_excl/, amd_iommu_0/mem_pass_pretrans/, amd_iommu_0/mem_pass_untrans/, amd_iommu_0/mem_target_abort/, 
> amd_iommu_0/mem_trans_total/, amd_iommu_0/page_tbl_read_gst/, amd_iommu_0/page_tbl_read_nst/, amd_iommu_0/page_tbl_read_tot/, amd_iommu_0/smi_blk/, amd_iommu_0/smi_recv/, amd_iommu_0/tlb_inv/, amd_iommu_0/vapic_int_guest/, amd_iommu_0/vapic_int_non_guest/' sleep 10
> 
> Performance counter stats for 'system wide':
> 
>                 12      amd_iommu_0/cmd_processed/             (33.28%)
>                  6       amd_iommu_0/cmd_processed_inv/        (33.32%)
>                  0       amd_iommu_0/ign_rd_wr_mmio_1ff8h/     (33.36%)
>                290       amd_iommu_0/int_dte_hit/              (33.40%)
>                 20       amd_iommu_0/int_dte_mis/              (33.46%)
>                391       amd_iommu_0/mem_dte_hit/              (33.49%)
>              3,720       amd_iommu_0/mem_dte_mis/              (33.49%)
>                 44       amd_iommu_0/mem_iommu_tlb_pde_hit/    (33.46%)
>                810       amd_iommu_0/mem_iommu_tlb_pde_mis/    (33.45%)
>                 35       amd_iommu_0/mem_iommu_tlb_pte_hit/    (33.41%)
>                746       amd_iommu_0/mem_iommu_tlb_pte_mis/    (33.37%)
>                  0       amd_iommu_0/mem_pass_excl/            (33.32%)
>                  0       amd_iommu_0/mem_pass_pretrans/        (33.28%)
>                  0       amd_iommu_0/mem_pass_untrans/         (33.28%)
>                  0       amd_iommu_0/mem_target_abort/         (33.27%)
>                715       amd_iommu_0/mem_trans_total/          (33.27%)
>                  0       amd_iommu_0/page_tbl_read_gst/        (33.28%)
>                 36       amd_iommu_0/page_tbl_read_nst/        (33.27%)
>                 36       amd_iommu_0/page_tbl_read_tot/        (33.27%)
>                  0       amd_iommu_0/smi_blk/                  (33.28%)
>                  0       amd_iommu_0/smi_recv/                 (33.26%)
>                  0       amd_iommu_0/tlb_inv/                  (33.23%)
>                  0       amd_iommu_0/vapic_int_guest/          (33.24%)
>                366       amd_iommu_0/vapic_int_non_guest/      (33.27%)
> 
> The immediately obvious difference is the with the enormous count seen on mem_dte_mis on the older Ryzen 2400G. Will do some RTFM but anyone with comments and insight?
> 
> 841,689,151,202,939       amd_iommu_0/mem_dte_mis/              (33.44%)
> 
> Otherwise, all seems to running smoothly (especially for a distribution still in β). Bravo and many thanks all!
> 
That doesn't look correct. Lemme do some more investigation also.

Thanks,
Suravee
