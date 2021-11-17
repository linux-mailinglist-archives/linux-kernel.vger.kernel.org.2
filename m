Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C66454CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbhKQSEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:04:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:16465 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhKQSEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:04:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="214735448"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="214735448"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 10:01:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="604826640"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2021 10:01:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 17 Nov 2021 10:01:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 17 Nov 2021 10:01:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 17 Nov 2021 10:01:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHC10iumDAjRAUQQGuPKaz99QTNTcLWrNi/ARL8Lfjy/uytQziaB7waA15l1u8BpoQQG5mUs+n91A779T+zGqTeO0fdB5AoIV0bE1S5QvR2wOuvu8wvqVyG29L379ai5PjmsiynrbS28MMF7X0DMjK48v9m62N0nZvFZiffdExXFxpGxofJ5UoMziMSVfeALd+g+yMF8uLBhRjdLn7GBPFzELDh51+UKHongnVyZhIZQ7D3lPZUyNT+h2u7acQJyPN4xEKJvVpdgU5SYvl80/Dd3i6Lv0LVOiele9jJ1jUGflc/hJj4UWygpJqzjJluHUZzLyBZCznwLs4gSswoi5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNkWd9OXYfPoHLl8+ft+Tiu4rHX7SDSsBshtMyYxIPE=;
 b=YYpQMohwMuDbfsnHdzgNz0caf9fKgLk/WFIdLFnLMx0Sh6nF+nDgIZtJaj1A/e3MYhUnnAUdvZKANUfeMooK/Nv164OQiD/Iy1gKjOK2L7TscPJX0u+ZVYYo0Q6lyAAubM+qTgdABj46RdT+4aOgtgW7XLPzeqO2RQnIKVOnvNfez1W7CepGhvDrxWBRod5foAbpf2ug6xcdj0c1sW2cB7Jeev32W1jco1qI1jXRbwuYOn047meXjBav+S5MmCFpXndPSzkNrJiJYN5r4KkMKtEfQdom/ScuttT/cjVC4EsqiPQ2MoRh2CjvDj3P+Zo3HSU9b/+rpmjamymAakf1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNkWd9OXYfPoHLl8+ft+Tiu4rHX7SDSsBshtMyYxIPE=;
 b=FlK8j5kl+G0CZRzoCTYxkdpdkxiEfnYf9V3d6QiiG80E1edzfM8x8Lsh5lJc7s1btcZd2eYHbvZoTrIiZtW+BOKD3xFV7vVeCGTTA/W3+KJuLb35qJhhMRRiSqOxzGNvuVdsLNHNp+qQ54Ty0TskTvuisqX1dilLXll6jLxfGBE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA1PR11MB5921.namprd11.prod.outlook.com (2603:10b6:806:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 17 Nov
 2021 18:01:04 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::a039:c121:4dce:5def%9]) with mapi id 15.20.4669.022; Wed, 17 Nov 2021
 18:01:04 +0000
Subject: Re: [RFC PATCH 1/5] firmware: Create firmware upload framework
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <ardb@kernel.org>, <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <20211111011345.25049-2-russell.h.weight@intel.com>
 <YZUceupQe67KYJyf@kroah.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <c521bc07-0f10-e89e-a59c-b6e07fc35089@intel.com>
Date:   Wed, 17 Nov 2021 10:00:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YZUceupQe67KYJyf@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR21CA0040.namprd21.prod.outlook.com
 (2603:10b6:300:129::26) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR21CA0040.namprd21.prod.outlook.com (2603:10b6:300:129::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.5 via Frontend Transport; Wed, 17 Nov 2021 18:01:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4ce4551-ac31-42d6-1707-08d9a9f4393a
X-MS-TrafficTypeDiagnostic: SA1PR11MB5921:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SA1PR11MB59213492E2495F2E16522729C59A9@SA1PR11MB5921.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSjhkSOwDBhVNr3ETHFVRm0p1A1VeMoP7LCqC7uU7oGn9rfGy7MYQ2ZxkR0sASzHDDF06aL3Qn56bQoz9p2EbpnO1dnWnwVPeXolw7WiDspX/97Y2rtdFnvWujW90Dtg2gSWOd7XOwtOtB2eIU/zFq8eyz7StUP8K4DMdz/aIBVqsFCEGa39uHQ2uriaEuwL5/IRbwNpj2TMmAs3zCsjyfOy/QL0XQDeLqVbnliYgdFTnCESA30R57xKdArUEfeXcf2zfW/+10iCMHmlwnViMtHRwrMPa7+DIwhnjwA1wJtOD8d9iUTK4R4mV9RgikWf2yQHoeBsM57Eo9AF4JT3wHToJsAzRSX5pRSJmFQYIKd+jugaetKpPHR1HVxBasyvcQ3+/UUtSnMPgI8XF9psnXuO3qBWhZxTi059XZyKNylgVAz+f7+DoYatpwE2/S4vaeXvjavrDPMPN/MFaVMZQBLm9+tNOocJTLaSHO2B0MrrDOdBfvGqzOBTTln+8XfR/cjnwRU/UlkqnIJByvAhhS7GKuCjSt/hAQIMFcv3g+d228sAeoJIWE2NY+Icf9XpQ9iKF5VaFPoMDILDQQvZmRPfOVx1tVRj1SXD51TNbsuZbzLV8tdfkfywLR2298lOxcwQr8mnUl7gmCp2jpNHpDvslfPRYGcbfZMehT5V/Y1P4d3OeK8BQZkIlkfRSPwiWC3O0rjubLuKtZIcIDPpWVSvMKa+WlCwV/7Xd9efiv6P4ZfisomCftXfqWOMCkb5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(8936002)(53546011)(6666004)(66946007)(66556008)(31696002)(2616005)(66476007)(83380400001)(8676002)(26005)(316002)(16576012)(6486002)(2906002)(82960400001)(186003)(36756003)(508600001)(956004)(6916009)(86362001)(5660300002)(107886003)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWJGVkdxR0R4ZG43a3VEcHlUVVEyQXR0WVJaOUk3WEhzRDZvUDV5YlIvQlVO?=
 =?utf-8?B?VjVONk1jWWNiQ1FGdk9UTzJ2UVNVcGFPbjlqemc3MWNUOEFBOVVQSC9NK2pl?=
 =?utf-8?B?TStxbFVaK1ZsbFE0bTZCZG1zTWNOa1BjWEY3WDNOVW4wYW5nRzA3bmJnVFJk?=
 =?utf-8?B?V0dEaTN0bitNMzN2R1FYVS90RlhuRHZVeHZEOTlUYllkb2E2M0NRZEpEdW1H?=
 =?utf-8?B?TDlRb3RBcUdUaUhLVlRWSU0xZGp2T0FMeGpvTUFZVVdiSWNSV1BkT3B6M2hj?=
 =?utf-8?B?V3hRNkFJMkRRZm5oOXhpM1oveWk4aVZ4Z3VKK3B1QU8rU2VXOHR3NzdNZEhF?=
 =?utf-8?B?eTZZcVM0Tm90bWRJalZScmxqMzFlY01RT3RreHk4VEIzM1pxbytaODIrcTkx?=
 =?utf-8?B?ckRaendWTWRhTEpEMDVhS2tIYXVZTGtsOHZ1T1J3OTV3QUI1UEszUXVZMEV0?=
 =?utf-8?B?bHlBdVdvVFBjMGljWGZzMkVCWFFDQ0E2YmZQWlBxYlo4bUVlVncxbFVMYWIw?=
 =?utf-8?B?M1VwOVVRdWdRMTJJb3BhdFRGWkRUaTVmWkJOOTUwdlVETHYxcmRSbEN2Si8v?=
 =?utf-8?B?OWpJTTFmTm5RRHFsZDJ2RFFhWGtEcXQ4SFRUV3M1eWlJMndnZU0xNXYzL1FJ?=
 =?utf-8?B?VHJuZWFOdlpObEpoekVRNCtmemliYmpoemI3dUEybFV4QUVmRkZVbFRuSHFa?=
 =?utf-8?B?Y3JqVDlnMmpUZjRRTm5MdVlkMmRRLzI4cFozenl6WnF4VENBU205d2szY1Rw?=
 =?utf-8?B?VjNETmJqckFjWjBHdG4zeklTOTJJdjJwMU9CT2h3WisxbU5ZYVowdVdvNzJO?=
 =?utf-8?B?M0t0Qm0vNUFkZnR2aG80NkZxYklmN0Rmd3BTMXpkVTg2Y3pJZkhYUzZBSWc1?=
 =?utf-8?B?V2kyZEV2MUt6WWsyOXBRV1l1amVpejV4Y3o2Y1RzTXAxNzdLSWo3L3JYaU9M?=
 =?utf-8?B?czAvN3JqQ1owOVdyR2NhWTZiaWVPaEpnbGFUaWVGTnJxbTh0bnZRcUg2ZVdX?=
 =?utf-8?B?YU5UWWNRa3NmTVdHWWNjK0labEJoVkZtNTkxTFl0R3RGcGFjcXYrSTNCS3hh?=
 =?utf-8?B?bGNqeEF6czVzM2JULzUxNXhqNU05enlTUm9ORUxKMTlmSkoyUU9uRUEyTk1m?=
 =?utf-8?B?NFl2bkJZSnhTVkwzSXJBME9QbURvaEVlakFjM1ZjbGZWWjlkc2pkUnNGdzR6?=
 =?utf-8?B?R1NPZjBKc1QvSmo3dXZKRzNiTUJmYzZMUGR5NkNxWE1BaVl5amthb0Qrckhu?=
 =?utf-8?B?UGVUSTdpZU03c1YvcWxGVFQ4d3JrNVZXTjUrUGFrbkRyT2o5cjcxTUNVblZq?=
 =?utf-8?B?U1NhR2dIbVlkSWxneExVM2ExcXZUOTkvOU8rZVE4czlCcS9jOUxSY0JraGpU?=
 =?utf-8?B?UUFjYlVONERCZVZ5UkFvUkFTaU50T25oWEZKZ1VJeGs5OEp0Vnd1QWtvRC9w?=
 =?utf-8?B?eW8rYmN2LzZjc3RqSGJYYU1pNkhxQiswTkVZRlBXRDgwZ0RBbFZCYUMxSVZY?=
 =?utf-8?B?MkhaYjJBZEU1TmtXNHRwSlhTSC9lbGFjVkhSVnVMK0lsTHQ1K1lpakJtL09m?=
 =?utf-8?B?a3RDZnZSQm53RDNuMlRzcUZPeWhTUDYrd1ZVZktDQnZBcXFmZEx3RjRtU2lP?=
 =?utf-8?B?SmZ2MFpGWkRDZisrWkI2UXVmL1A0MDQ5NHpSYnFTdUFTSWg0dXRDaEpUaURs?=
 =?utf-8?B?UXlielA4NjBPUlk5WUR5eXlkOTRqYkhPRmpCRm1BQzhSNU5pS1lIek1VOEdw?=
 =?utf-8?B?eFNaUVBZbERKdEQ2RGtuWkx5cnpnaHFDaitDcXVxZXJaYUZVdkM4b1FHL1A4?=
 =?utf-8?B?dVY0bDZDSzVES2J6ZjZnL0NQb3ZFd2RmdFp2Qm5rNm9OTS9udG9qOVg3enVU?=
 =?utf-8?B?U1hZRzRYdGtnZWVCcWZYVHB6UGpnSWVTRGlpOVRDa1RabHNJTzlMemk1N0R2?=
 =?utf-8?B?MHo2R2ZRQTVqenpnb284ZFVJQWNGM2Y0dzhUVU1Wdzd6ajYra1hlWExQVXRM?=
 =?utf-8?B?OUpZRFBHeTlOMXJLZlBoTDJpcUlFZGxFaSt6RGZQNHFwYnFrbmlZVG1Wc3Zr?=
 =?utf-8?B?U3JoM0dlbVlVZ3FhVVZXK0VheWZCRHVJVyszTjlYQ01PSktLY0tabmF4R3Bo?=
 =?utf-8?B?bjIzUTRrN01EN0VzODNUWW5YT0tXWW5ISldqb3JZaUtmU0Y5aElVN1VRVkFS?=
 =?utf-8?B?NFJjcWRLMWZNTnZKNzN1SnpjeVNsVmFUNlhQK3JxclVGTTNUM3pFc1lFRm8z?=
 =?utf-8?B?SGFpaGpQNWU3Y1F3UEIvUkFLSzhRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ce4551-ac31-42d6-1707-08d9a9f4393a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 18:01:04.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfqziDJ+hEYa6P85KpGX0P/ULnm2wUQb54+w+aoSa5XvQ7i2ioJbDtYVmSDo8+qQuN+6Bdk4Eg+SU8cXrQmrNcjZymub5DJaWkm8kXo4nHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5921
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/21 7:15 AM, Greg KH wrote:
> On Wed, Nov 10, 2021 at 05:13:41PM -0800, Russ Weight wrote:
>> The Firmware Upload class driver provides a common API for uploading
>> firmware files to devices.
> That is exactly what the existing firmware api in the kernel is supposed
> to be accomplishing.
>
> If it is not doing what you need it to do, then you need to document the
> heck out of why it is not, and why you need a different api for this.  I
> do not see that here in this changelog at all :(
This is part of the documentation included later in this patch. I can add
this to the changelog.

+Some devices load firmware from on-board FLASH when the card initializes.
+These cards do not require the request_firmware framework to load the
+firmware when the card boots, but they to require a utility to allow
+users to update the FLASH contents.

When you say "existing firmware api", I'm thinking request_firmware, which
requires that driver names be specified in the kernel config and wants to
load firmware automatically during device initialization.

Other support under driver/firmware is specific to certain vendors, devices.

If I add this information to the changelog, is that sufficient?

> thanks,
>
> greg k-h

