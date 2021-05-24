Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921AF38E118
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 08:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhEXGmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:42:13 -0400
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:39495
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232120AbhEXGmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:42:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1wISudJrtUVKZPX2AIO7Z+glkxpY8mRsIY+wtup7FLvpsUokrDd3Hv/bHJSqfabP6v8wrN0cRqTV2ndlH39uEnGJfHzrjNTwJlhBG9mCzANB061MIKW2qs+7VEhO/0gWhw6wtwKVrMSK/apOwIks4Mdp1lOb3LiXceWmn7ZMhAQya6YKjUFQyTGvivIUlqzbQVcY7yuM4TbUa+b9LPxOyXd0OjjF6S5r4pBhzE5Fk6AwiAIVq4P5pC77LUpfIdQI4IGLvJtcH4pUHB6GLhWXJ1bZcCS1YIW6LA0LfUv6riXrwz/1iKuvtcnutv6JANZ9Xk3ExxFjFoUUicKyV4WTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHL6h2owE7x03SmmTXD+ACp5oHnHEKET4bmBchK4gi4=;
 b=QzYxYjpBuiidsnRLUYsk06cNUoUn77h4zsLzhgQQh0NUJamXfMQlI9YJ12nSvoPaWBl4gDPxlUnVNzpWN6GAoMKGGrn4rcWOYcpzk6fr9Sb85CbVznRcWHXOJ29q+Pujv0wjUkBWbozYff2lKVYGP8lF9moKrpvN91XLoiu/rWipV4sVODDRaHcjDtViWtRVU+WMJ5j3NXYzAjcZ1j1u7XPzyqy4jd4dv2j7WdV40EIDlrNTDV8hnIuJcU1Ka742Dw9ZNSsmV9bDoGui+b61ZigM43M1THLoooCHoy7eQLc7/HmbKfrW4CH6XsFLO6UVe2KZyWhpVzVB3hIvn0z8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHL6h2owE7x03SmmTXD+ACp5oHnHEKET4bmBchK4gi4=;
 b=rkA61Gx/D4xeWcrZpTomx3bhPcfJAAXNG5J+5m2DXrrHRJRN0l5naE/qICmVxKNM27+gHR3T+UYjH7BAobQ5ZuJaXmMwPi+sZfLC79OIlrSgi90p//tfG1Wbt5YFQAsGfo0VAd3n9rDhvKWNT3bQMEMIScSQ+2/onGZWxjtFFPE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB8PR03MB5546.eurprd03.prod.outlook.com (2603:10a6:10:106::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Mon, 24 May
 2021 06:40:41 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239%5]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 06:40:41 +0000
Subject: Re: [PATCH v5 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <e4dc31d5-d897-50fa-34e7-f5c033d5f5db@linux.intel.com>
 <20210524060221.519093-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <4295dab3-7675-9146-ac6e-244704ecfcca@nextfour.com>
Date:   Mon, 24 May 2021 09:40:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210524060221.519093-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [91.145.109.188]
X-ClientProxiedBy: HE1PR08CA0052.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::23) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1PR08CA0052.eurprd08.prod.outlook.com (2603:10a6:7:2a::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27 via Frontend Transport; Mon, 24 May 2021 06:40:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a67a86a-73d4-4d9b-206b-08d91e7ed93a
X-MS-TrafficTypeDiagnostic: DB8PR03MB5546:
X-Microsoft-Antispam-PRVS: <DB8PR03MB5546047F3095F4E2A680D3F683269@DB8PR03MB5546.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HioLGBYl45DBLPWK1Qd/x+ptYSuJ+7ZmKMblkDZj4wwQuBoaCpxZYWRAKmyhk+cKs9QM/e2faCaXHBu6meC4RYgJs7Fz/flTdjnI8Vz4x3F7nFh5U5pOwYAH/F7mUyzkh+RJE2bMQ/0KApeSjo7Dq1I3Ec/M2oUw8JPXJXHlmCK55WDbxpl8joJLLPAigIP9f9aw07pSYlVrx7T/CvaxRHcefo7wgJptBoeczMTEcq2JIj9oY2StVNZM5sAZ+4/IcoplZNddJ6Lg9ipU0YT2zosNMvzjMtkROoYMzBLoraeqaRXAaK4XPHmyY9n57/HoKgi9ZqZBFPINnVgexU8jTW08WeZUoEp+RIQyKOD69irFu0i5flDaqGfVOWXiEBTTGRFMEAsWlapug37y7X/hk968kNDU3N6kwmWQ6pSu7TYUg2njXA8IEGu4o3IqUn8gBw3xfog1AIoCjO76C9epITGbyxMkPNCkrtEaMPytD8+AiHPs5TrWbLIKbo/V/XpwoEGq4iftLpv+Sbxse7YziWT5zZtcsOW19YwdJSweoGUEdx9c8kgKv+w/zi9vu5jVV9cI1Wm94lUVn6urhbX8AuC7rsaw0qvjDEHZ2W154gGHoDTRghJbEKZ0TdC6l1MmpfwHWwzMYcDREH06d+wSmHY7AlXXBTbicq/ZPqqfkagT4mnq7Pxfyu+pdnuss8aLDMgLiUVjZIwyJccpixQ9mux9M+9JnTBQNJdCqyQBvPY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39830400003)(136003)(2906002)(5660300002)(6486002)(86362001)(66476007)(31696002)(54906003)(110136005)(66556008)(7416002)(16576012)(4326008)(8936002)(186003)(31686004)(478600001)(316002)(8676002)(83380400001)(38350700002)(38100700002)(36756003)(52116002)(16526019)(956004)(2616005)(66946007)(26005)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cUxPSHBScmxSa1AreDh1WjA2Y1lWL0wwTnBsT0lKTkd4K1p3ZTNmekdrU29q?=
 =?utf-8?B?WFNDaDRKWTF0bk1hREhqVG9sOFRWcmY4cDBKVlJCTlU5R213cHNHRXdTR0kw?=
 =?utf-8?B?aUtzRGFyeS9FcWZ2bWRLVW5WTitzWmhIS2oxSVlSbTMrcVFhanczTFVZMXJZ?=
 =?utf-8?B?U2FPenlpTkp3L05tZnFUbjd1ZVI5bHF5QVZmVzc2OU5nTmNkVW9zb3l5Y3RU?=
 =?utf-8?B?UFlBbFlybnJtTEtqU3hSSkdyV3NYVnZxRlM3Kys4ZnJoaXpWZzZ6eHNjRXg4?=
 =?utf-8?B?MVNJak1oMG9mVDluR2ZyWWY3ZnUvUTFOR25LbDVvMisyM2pCbVRtMUVpZVc1?=
 =?utf-8?B?eDRUVUZPdlFLUEJUNDUwQU9Od2NKajZBSTRlOUlTVW1TUjVuWlJxdEFGUUpy?=
 =?utf-8?B?MVVBRGx5clZCUFVldHNrM1VVdlE3VkkrMzUybGRpenJxRlU0OEdPSlFPdEdI?=
 =?utf-8?B?bjh5QmloTGFlVUxMdzdnVzZTUlFXWGpUdFNGa3hjdjRnYmN3c0NHK0R0dlVF?=
 =?utf-8?B?a2pvTXZoemhyc3FWN3RCS00yQXo5a2Qyc3RSamc1YWk4UkVxTVZhckJkb0JS?=
 =?utf-8?B?WnNQRHVvempvUGpnUThlTG5aaUp3NXZZd2xiZ1RJNmxVYnJ6T1YxdFNJOGdy?=
 =?utf-8?B?Ynd5NWo5RnRlbnlTQ0Z1RUZaSGx2U2VNYkMyaWwxVnpiT2szOHJZT3dCMUNV?=
 =?utf-8?B?Ni9oUm1vSEVrUlU4VmRyRFRJS2puZjg5UW00NTZDZTlpZzVGdDJiTEZpSmhU?=
 =?utf-8?B?aFk4bTBQZU5hdDVpcHRDOFRsVkErdWJVTTg3NlRlZ1h0Y3JZaXlNZUl4RE9h?=
 =?utf-8?B?SzlZT0ROc2ZkVm04NHlwcXpvZ2ZXZEE1RjYzR1QrK3dtVUlzSXoyV0NsYVV1?=
 =?utf-8?B?VFRMVjc2TW5zSCtEdzdiYnRUelRtZTUyWFNmRElIdlNEWWJ1VDdjMmJTbXJH?=
 =?utf-8?B?ckI1Z1RvRWNZcURja0QwS1VVZGxXdW1lS3VrQlNDNnBnSVNhRENnOEUrU2pa?=
 =?utf-8?B?bWgrUU1XaUdkaXZTa1BGeDhnSzY1MGVyQUV5dkNxQmxGZTJRR3pCQ0pNY2lS?=
 =?utf-8?B?a3owTlJra0tlYkFwQWdoblF4cTZSYUhUd2sxYUM1aTFWSGtPUFJLWHZWZUVV?=
 =?utf-8?B?Tkl1aGdudTZ0L1kzWUpxKzJ1VDQ0TFEwTTAwNHdtMmUxb2IrUVVUcWJ6citF?=
 =?utf-8?B?akRUeUZvcmxMeG9VYnNjM1lhZGJhL2pnT0FBS2RRbGlnNFRZZTRXT3ZjVzFr?=
 =?utf-8?B?dTdOSm1SVEgvc3ZTZm81QTZTRWdzemVYWTdKVUxVYlNKanprTTJWdEZQRDV1?=
 =?utf-8?B?dHZmSTFYaG1uRnRnL2srWjBRV0dVcjdPV0c4djhrd0twVFIrK0hMVmZBYXY4?=
 =?utf-8?B?QU1MZ1k0K1RsQUJEbmNkcmpFS04vZjhZUmIxZjYrQWx0aEJITmNaNUJZbmp6?=
 =?utf-8?B?THROUEtLaEZ0MDR6T1Z2Zm10VUF2UmJlTlFmZG5tcHFmbGVqZFdRRU1ZdmpE?=
 =?utf-8?B?L3YwRE8zNWFienRtaUdUa3BIVCtCcHdUYlVWeXhKdnYxaXJxcG1RUnArNEcz?=
 =?utf-8?B?dWFrS3h1ZklKWmM1TW4yOUgvdVN3Q0VTaHNwNThnMlI5MnBaWHUwWGxVYmZI?=
 =?utf-8?B?YzVJWHIwODZoZGVoeHpIdzhwSjZzK3J3aGtFeWFzbE9IbVRXVGNtTXozWHA0?=
 =?utf-8?B?VnNEaGQ5Ry9WNmYzeUxhckRQOVEvTUh3V3BZRXNKUkprYnpDQlIzT3dGNVBR?=
 =?utf-8?Q?PT+fU868/MyoExIA4+t7V2tFryc2pVCYYBsTbtJ?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a67a86a-73d4-4d9b-206b-08d91e7ed93a
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 06:40:41.1621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E27MdDJdkE0BytmOKSlpcljJ1RelJ8KWqlgEXHvxcUPjx+/MF22DRBPFe34j3m7suAU4+NREVct7Dr9GopbGVLJ4cNbaCkDQdcuMJ1AKN1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5546
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.5.2021 9.02, Kuppuswamy Sathyanarayanan wrote:
> As per ACPI specification r6.4, sec 5.2.12.19, a new sub
> structure – multiprocessor wake-up structure - is added to the
> ACPI Multiple APIC Description Table (MADT) to describe the
> information of the mailbox. If a platform firmware produces the
> multiprocessor wake-up structure, then OS may use this new
> mailbox-based mechanism to wake up the APs.
>
> Add ACPI MADT wake table parsing support for x86 platform and if
> MADT wake table is present, update apic->wakeup_secondary_cpu with
> new API which uses MADT wake mailbox to wake-up CPU.
>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>
> Changes since v4:
>   * Used smp_store_release() in place of WRITE_ONCE().
>   * Addressed some checkpatch warnings.
>
> Changes since v3:
>   * Removed acpi_mp_wake_mailbox_init() and moved init code to
>     acpi_wakeup_cpu().
>   * Removed redundant NULL pointer check for acpi_mp_wake_mailbox.
>   * Added comments/debug prints as per Rafael's suggestion.
>   * Removed MADT/SVKL ACPI patches from this patchset. It will be
>     merged via ACPICA submission.
>
>   arch/x86/include/asm/apic.h |  3 ++
>   arch/x86/kernel/acpi/boot.c | 96 +++++++++++++++++++++++++++++++++++++
>   arch/x86/kernel/apic/apic.c |  8 ++++
>   3 files changed, 107 insertions(+)
>
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 412b51e059c8..3e94e1f402ea 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -487,6 +487,9 @@ static inline unsigned int read_apic_id(void)
>   	return apic->get_apic_id(reg);
>   }
>   
> +typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
> +extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
> +
>   extern int default_apic_id_valid(u32 apicid);
>   extern int default_acpi_madt_oem_check(char *, char *);
>   extern void default_setup_apic_routing(void);
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 14cd3186dc77..c51134eb55d0 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -65,6 +65,10 @@ int acpi_fix_pin2_polarity __initdata;
>   static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
>   #endif
>   
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +static u64 acpi_mp_wake_mailbox_paddr;
> +static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
> +
>   #ifdef CONFIG_X86_IO_APIC
>   /*
>    * Locks related to IOAPIC hotplug
> @@ -329,6 +333,68 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
>   	return 0;
>   }
>   

So this isn't supporting suspend/resume if AP cannot started again?


> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> +{
> +	u8 timeout = 0xFF;
> +
> +	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
> +	if (physids_empty(apic_id_wakemap)) {
> +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> +						sizeof(*acpi_mp_wake_mailbox),
> +						MEMREMAP_WB);
> +	}
> +
> +	/*
> +	 * According to the ACPI specification r6.4, sec 5.2.12.19, the
> +	 * mailbox-based wakeup mechanism cannot be used more than once
> +	 * for the same CPU, so skip sending wake commands to already
> +	 * awake CPU.
> +	 */
> +	if (physid_isset(apicid, apic_id_wakemap)) {
> +		pr_err("CPU already awake (APIC ID %x), skipping wakeup\n",
> +		       apicid);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Mailbox memory is shared between firmware and OS. Firmware will
> +	 * listen on mailbox command address, and once it receives the wakeup
> +	 * command, CPU associated with the given apicid will be booted. So,
> +	 * the value of apic_id and wakeup_vector has to be set before updating
> +	 * the wakeup command. So use smp_store_release to let the compiler know
> +	 * about it and preserve the order of writes.
> +	 */
> +	smp_store_release(&acpi_mp_wake_mailbox->apic_id, apicid);
> +	smp_store_release(&acpi_mp_wake_mailbox->wakeup_vector, start_ip);
> +	smp_store_release(&acpi_mp_wake_mailbox->command,
> +			  ACPI_MP_WAKE_COMMAND_WAKEUP);
> +
> +	/*
> +	 * After writing wakeup command, wait for maximum timeout of 0xFF
> +	 * for firmware to reset the command address back zero to indicate
> +	 * the successful reception of command.
> +	 * NOTE: 255 as timeout value is decided based on our experiments.
> +	 *
> +	 * XXX: Change the timeout once ACPI specification comes up with
> +	 *      standard maximum timeout value.
> +	 */
> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
> +		cpu_relax();
> +
> +	if (timeout) {
> +		/*
> +		 * If the CPU wakeup process is successful, store the
> +		 * status in apic_id_wakemap to prevent re-wakeup
> +		 * requests.
> +		 */
> +		physid_set(apicid, apic_id_wakemap);
> +		return 0;
> +	}
> +
> +	/* If timed out (timeout == 0), return error */
> +	return -EIO;
> +}
> +
>   #endif				/*CONFIG_X86_LOCAL_APIC */
>   
>   #ifdef CONFIG_X86_IO_APIC
> @@ -1086,6 +1152,30 @@ static int __init acpi_parse_madt_lapic_entries(void)
>   	}
>   	return 0;
>   }
> +
> +static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +				      const unsigned long end)
> +{
> +	struct acpi_madt_multiproc_wakeup *mp_wake;
> +
> +	if (acpi_mp_wake_mailbox)
> +		return -EINVAL;
> +
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		return -ENODEV;
> +
> +	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> +	if (BAD_MADT_ENTRY(mp_wake, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(&header->common);
> +
> +	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> +
> +	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
> +
> +	return 0;
> +}
>   #endif				/* CONFIG_X86_LOCAL_APIC */
>   
>   #ifdef	CONFIG_X86_IO_APIC
> @@ -1284,6 +1374,12 @@ static void __init acpi_process_madt(void)
>   
>   				smp_found_config = 1;
>   			}
> +
> +			/*
> +			 * Parse MADT MP Wake entry.
> +			 */
> +			acpi_table_parse_madt(ACPI_MADT_TYPE_MULTIPROC_WAKEUP,
> +					      acpi_parse_mp_wake, 1);
>   		}
>   		if (error == -EINVAL) {
>   			/*
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 4f26700f314d..f1b90a4b89e8 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2554,6 +2554,14 @@ u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid)
>   }
>   EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
>   
> +void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
> +{
> +	struct apic **drv;
> +
> +	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
> +		(*drv)->wakeup_secondary_cpu = handler;
> +}
> +
>   /*
>    * Override the generic EOI implementation with an optimized version.
>    * Only called during early boot when only one CPU is active and with

