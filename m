Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE63D2CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 21:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhGVSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 14:52:44 -0400
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:64032
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229556AbhGVSwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 14:52:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8KelM/+wHY8Yrns/jSVPOumybrF3bt+/PnMbhR64EENUaLEVEePecviv3eTfvq+2At3+4Inq5jT6uH8sOGkq3dimQn0CXSYaUaMAYv83IvJlmpOyfEkwIjdtcjBKza9T5GhOcW41DD7iX7xTyK+t3L6L0g75zkbeHekDjDFbxYgzerHJ/472V3DgC9YsBApaORMFTvHelPi7cqUR9ddDu5h5BnefqMmyf0eMmpGcEz01ZyzMNio1RKw9MBwR0R/tB3S3/SkIYQw4Xy5SyiIN9nWfTWTiSGnPb4bYh1fBprmd5TpQfV6SvMw7o7w4Q9yRFrW4Jx6Uz8tmkf/k6wJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEKHsDmaAoXz99eM54imzVmaSNnSkCON5akqflnbJc8=;
 b=FMoHjO8yECatA7MJZTcKx3nSgeJ6kc8qxLhstV3L9fpWcMLkkR8VufUvrE79qIRZqeOcvYgPDE55dXTbYJ2FuHlAD3iILVm2ikcX+M9No0xyQDaFUTqJYENpeM9uBpSMK9q0UMD/35dYwo4XlaRkM7N1pYkskaTJW6IgzKiut7u3snU5XTDJRJhBDYjthiGnkMH+VLOVjz6cK/0GB5cJPfkoQgagCKFSD+sysmGV5jPU/NVEMhYSMsKEY/XQ3BymhgEGkhsT46916XLsJcuehwcwUPxFLcPbgMwWLmVrMj4kHqBLV7257AA8JWXBMwZeAgEjkwAblQE8i7u/6UC18w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEKHsDmaAoXz99eM54imzVmaSNnSkCON5akqflnbJc8=;
 b=Q0RnvGbMxPkP//coz9QQV54bXSBKurmHmiY329M8KzC/8K+fgno6yuzPfy9FE6ZHU04TCtwYKPJf9dwZ0lTLJAwlhPhzYloe7u1Xcmd+rz6jJPUApLgSD9mI/NlsiVwZobagsM5MQLuGmOIcJvdmC47+QGKx+NVZcte1dchrbiI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.24; Thu, 22 Jul 2021 19:33:14 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b098:ccab:f79:9461%5]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 19:33:14 +0000
Subject: Re: [PATCH] iommu/amd: Convert from atomic_t to refcount_t on
 device_state->count
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
References: <1626674437-56007-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <bdb2f68a-fea9-ac69-d807-123e445b6465@amd.com>
Date:   Thu, 22 Jul 2021 14:33:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <1626674437-56007-1-git-send-email-xiyuyang19@fudan.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:806:6e::28) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.117] (165.204.77.1) by SA9PR11CA0023.namprd11.prod.outlook.com (2603:10b6:806:6e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 19:33:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3371fcc7-7818-4b35-c5fc-08d94d478c3b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:
X-Microsoft-Antispam-PRVS: <DM4PR12MB50889DB8DE2A95293D44C4F8F3E49@DM4PR12MB5088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUOzbamfCjRd3a6W+w+fybbc5C/mJ79zv8kB1Wjq4hLhpNygNfp8eYgZZvKf83/Wceiqc//m0CskcWSsaoL38FaICF31MMr+hoUtDv1+w0uh37vlNxzCBhPImM8CorUZZTPBgYxxZvlLY0H1YNsQducXaqEPUSMYr4KxfdnDFy6kq/3qedw9jQo5ZoDeOky5St+bvpFkI3d9hJ/aYOXiKDpBBvrvwhuZsAmrcOuJJWznAuyx3oeITlD0ug69NoSh3NNiWuioH0cEnpfQXvOBRir3AQggl/kcA+ca0GRW829JsyNdNpS68qvDL7wxg89xobOrSrRBhWSVpDAQKq/TpBD1uTWIn5YD7/NzcxzPotojTTx0qQaGK/Q1vOoNLSuYHdiME5v4OchXCiIsC8GqroVmiWWcE5jXcyS0223Lo6dLojX1bKpZt2hPkh3eWLhxjysUpAjy7+FtRkWC+Gd+bnXEXqTgMBiTtECL1hp7h5CI5tLUjHlUdhtZ7u1tJKvjnN+i41LO2srvna97nUUKlmUDKO6x4H8R6665RZwcyZaDQsSHHc4TUwuiKBSktQZZTI0HKAXFT3pIkbpQZ4KnQ73kBN/Z8EidrCA85NNekAwp+KyjI8FebD7vikXA0Ee6rDZkQIz72N0xn2zNQoCQZaZGCrGMSUgc/VLXnljxfhGQ+eWIXPcxxJkEtDM0gfHYUrwGs6vSfXbDR0Em0EZf8yKpaE2C291bVu87Cx3or0DStj3MabTtJ5hTnEtLRFSpm7Dk1Os/x6Vbq9NKqGerlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(2616005)(38350700002)(4744005)(956004)(16576012)(110136005)(83380400001)(186003)(31686004)(8676002)(478600001)(316002)(38100700002)(52116002)(8936002)(36756003)(6486002)(4326008)(5660300002)(31696002)(2906002)(66476007)(66946007)(86362001)(66556008)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUkyNDJPTENybWptVHBJNEhQYlRzQUhvRjA3ZnY4bzc2aEFGbi9ERTNaNnF4?=
 =?utf-8?B?bFI5L0FpSXA3aENwRDJkTUxJMURkaDJYdHVGRjdpaWxJL3RUSDZoS3Y3VEd4?=
 =?utf-8?B?d0Y5M01Wa2tZT2VLRVJQOEhGaW03S3pRWHBGb3MwQTFHQWJyV0EwMVlQR1ho?=
 =?utf-8?B?Vmt6TDVDb2NWYk9TL21DYzNmZ0RRMTBkNG5acTBFZEhsTS9OL0dmbE01Q3lF?=
 =?utf-8?B?NW90cVhtWUZJa2szTUVoc3J1VjlmUy9hTVV6L0dWRFpmc28vbDJwMmFqSVl3?=
 =?utf-8?B?RmFDMzZsRnd4VzV4MFE1Z1NhN1M5TW96Njg4ZFVRUy9jRWhkSlhLK3NqcVZx?=
 =?utf-8?B?bEVkVGY2M2gvVEpzWkxGMUQ3LzVKUThXS0ZMdEY5WklKUFJpUlZrSmorOXdF?=
 =?utf-8?B?VEduVWQ1dWRnZExsZlVlQmlsaDZHQ00ySVgvQnFoblRpclpCb0VkZ1pqblpD?=
 =?utf-8?B?VkJZT1R5VGpQOFJubFpBZmVsd29RMStBVVdUL0tob0ZtMkRWZVhyN1pjV2Mz?=
 =?utf-8?B?blNJcmUwd1RMRlBZY1NnSlVmaW56N1ZCbld6TXF4bEhsZVNzSUE1cDA3MFlX?=
 =?utf-8?B?TWFyK1Q5QkQwSTZMS3M3bk1TQTdycGwzc0pDam9oVnNBU2xqUEYxRytNUWdB?=
 =?utf-8?B?aEFBZmlMYUFvc05TaWR1emxaalFCeTlybGVBOURTc1k1dGpQZW5jRkxaWDNI?=
 =?utf-8?B?VUFJbjI3Y1NYcFRrSFRzQWllc3hIVFA3R2hZTVBiVmdZaDhRelgydFBoajMy?=
 =?utf-8?B?ZG5kNUhCRWREU3l3V1JMSlJ6c3VwTXlvMnBkS3NDMzB2Z3JGZWkzZnlrTEl3?=
 =?utf-8?B?RC9ySG9FZ2xrWm15NWUxWFlXTU1DN0dDa2xPZEw1YTdQcUUwbWNTUkZsRUsx?=
 =?utf-8?B?cHVLbWYvOWlaa1VXR0xOUGpRTnFwUDN5b1d5MTNqNlIybzRoaEJKeFovR0hl?=
 =?utf-8?B?V0JSZVBScThjTXRnVWQ5djNlSXNBZEFlVVc4eGZGcXdRNDJVak5IMktlUVg1?=
 =?utf-8?B?aUQyckxLc1RkN0pDS0d2TnArdFZMZGNseXJGTXE3MnRHTHF0VHducWFNbm5T?=
 =?utf-8?B?amFkRTkvY3B2NFhhdW8zZUY5YnNEcVVVMDNEYW1NZHowd0hIWk8yYVBBN1hk?=
 =?utf-8?B?L1dqcENkclFKUmxnaWlxM3Rza0VUZ3ZpZ0xkQnBNTm5xNmQ3dzlEUmVkV2ho?=
 =?utf-8?B?dDNlVVNqN0grWXNBYVp3azErUmtyYkJYb2lHbVNWcDRnTURvZmJmVVJRZ2Rw?=
 =?utf-8?B?VGQ5TCtWOEp0R2dzMGlFUTYvQlVGdytvdUg3UWsvRUJjb1p2TklRRUczQTVw?=
 =?utf-8?B?WjhQR29zc1FOeU41R0RTdkp6US9OOEU0eVBNOGt5aGxlc0lQVnJsMHNyUmpK?=
 =?utf-8?B?eHozY1NocnNvMll2cG5tTHQ1NHRhdUNqb0xvZm42MUZKM2hHRzkweUExSWlt?=
 =?utf-8?B?NXh0K0tCaEtDM1JJc3ZTUkl0bncwUktrNW1pU2x5cFZuR0cveUIzTTUvY3hL?=
 =?utf-8?B?OStidlludUgvQWxPdjdmcVMyUko4RjhIVllBM0lzc1pzZFVQeGcwN2Z2NDFx?=
 =?utf-8?B?dlkzU1VTT2I0UTl3dGpreElzNFp4WFV4alY3MlVpUEFsVitoQ1VqQzJBcFBy?=
 =?utf-8?B?Slh3RG5UaEtFQUFzU1lDbDVRMHBMQm1uRG01Y3UyVFl0Q0FyM0YrTElkZGxX?=
 =?utf-8?B?bFVSMmRqdHRzVHU0dkorM1VWemhXSkJFQ1BqUDhNdmNDTlU5VUpVMzEzcXkr?=
 =?utf-8?Q?LBypsTmPlvGTLstNVyMvIAHJHFaDp56cGQx3BZb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3371fcc7-7818-4b35-c5fc-08d94d478c3b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 19:33:14.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydgt9Ac5KsBtuvRadAmOSuoEMsCh22xPSTL7GV13t6Pdar0ghm03zv5FZRGwOG08dzB44Ax+9lJkmA0M/X7ktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2021 1:00 AM, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>   drivers/iommu/amd/iommu_v2.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Thanks,

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
