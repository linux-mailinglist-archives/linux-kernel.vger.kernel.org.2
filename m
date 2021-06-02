Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAF539924D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFBSRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:17:16 -0400
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:21302
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229467AbhFBSRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNspm5VZYynsbwYgmVDBf/LpoaC3V4R5nh+q9MRZ6AIiCXMk10QP5doLKj3Lm2d9vP2cHqZ5Zco5mWqhGwVNirwxeINPxT+AtrCdeDbDyUhs0EMRRGGzd013yYGMp3D7nGPaMOyuESiVuzA7Eo3WVr3leQR8qiveW2iAzmFaUl6S+8cQh3eQtaIthJHTWmaTjsi2PVn0FWrj4YDRqryqH+gROY6E52cUuV8JovbFtI36BtnALXbnvPpPZNEWsxg2s/E63dCiW42JhpK1vwRyjWUijLAG7cATN5br2imckaLbBtleHyC0EONBVCfbRAjHSFz2Bd9keAbgIdPrDMKqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEqoBuPvsLBs0TCXh3jqSFs5fR8nE1zOqsxwvrIm0FY=;
 b=Puv69muE5flyJ+5ixzPO9COVBzaiOEY4tftRPAPbMz8mRLl4sCM7EdGPmvHS4XuSfzVtLJWCh4ibrFLCB79onbHU6IFnMQI1kVdQhe6Fsgk1J6leqeTkOe4OmAjh7uvvlWbcqvB07yl4tBXb1XDj8OklPjn5dQmpocve33tRWdOlcqSqL7kr+qXLp5kjZensKeEMEYmICIK4CimBZGr9JwccX0n1V36/Xw1x2oNFSxgy9ZDKyGzbSrZ7wMGVDKBSYQbCk49ZYK1El4ZdJ0RQbDyMcbuJkSiGW913tWOth8blKWS1Yk8zdcWXTXiziFoV1+KHAcGfJURNEM2AWyOFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEqoBuPvsLBs0TCXh3jqSFs5fR8nE1zOqsxwvrIm0FY=;
 b=n/FBo6LcVqPr+xGsRuCUSN0AGXYenN8f5Z+4cicbCczbDw+Og9Bg+/H2xWX9UiTxvDQWUGj7AvQ67M+AH7uO3Qlow85fHWznn51tqHm+v425NwvygRv5chmmsSy1e6Mw95nl1G4f5My7NkbMgifuvrUdQpMvet5+YqoJy09K2K4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Wed, 2 Jun 2021 18:15:26 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::b914:4704:ad6f:aba9%12]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 18:15:26 +0000
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
To:     Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLe92NXx1jZPtPqB@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <3036a655-9d09-0f04-62a2-7a72ba9af5c7@amd.com>
Date:   Wed, 2 Jun 2021 13:15:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YLe92NXx1jZPtPqB@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN4PR0701CA0024.namprd07.prod.outlook.com
 (2603:10b6:803:28::34) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN4PR0701CA0024.namprd07.prod.outlook.com (2603:10b6:803:28::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Wed, 2 Jun 2021 18:15:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6dd957-8ce7-40dd-f1e7-08d925f2651d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:
X-Microsoft-Antispam-PRVS: <DM6PR12MB289236BC086D6A25EAB875D8EC3D9@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWr5A0ucHSjNDIK4PebGE5et5L1JdhaQ+6PXOFnMpViIeWADBRR+jCkf8BzwCKSo4STrBpjR+kQVbNaY/pwrFADndhjQpHuPcs8F68kGU0EZhnYQLbP9Y/FrT5II3KpJeICJ7D8H5NyzDgxgtA87aWVhEOGasKktpdLU4O9E9bpvReHhasLmkMl5rr9jHNveAwADHDzBXP3yoEntfIJytejisoTNhWX+3hYsWXdc9+s9VPwcVvT1VttsbEtuNqa+fxMXip16FUQqGmVMtHrZ8WSI6h++JpQOoE+QCobuhp8v7aN08aWdOXj8yzwftFJ74R0Oa6Kzt4SyxyLBH4taexw5HAsSMaOFIwZTEg3r3G7x/uqW3CMvJZgcfmuSc/PgMOH4FhuKnFZx0UdfZyHCmT5ZC6e0iRzn6tW8WMd9dlq4357sOnLm2NSy3+eZZhNGPx4cCDUVRZ/24Hy7nnns7vvsEsjIa5XBna5jvjQxR5clilWId2Sly1g0WMC0oOQ7ngl3bqIi2aOEdgeLXMwEr5cIH5IjGo+mXx2sbgNg4Jog4LBXj7Ypj/x+nI+8GxCNFTmrkM5Klk3G9E17vF/8JbuC5yHd1ywExDG8G+I06wS5zZnr6ZJPAFJ19tLB8B1tODDazchMuIT9dcp+klZU4hB7hrH2q/XxBw2d1rIRSpTJMoYWI85brJZHOHTyS/4rhNT3cpY1/VVwn5ie2P6Zew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(396003)(346002)(136003)(376002)(86362001)(110136005)(31686004)(186003)(6486002)(36756003)(54906003)(6506007)(38100700002)(16526019)(8676002)(7416002)(53546011)(956004)(66946007)(2616005)(6512007)(478600001)(66476007)(26005)(31696002)(316002)(8936002)(5660300002)(66556008)(2906002)(4326008)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkMrVzVqcmNzMVAvc3ZDOXRzR3BwclpyRlpqK1pUUmJKL3poZFBXei91T2xQ?=
 =?utf-8?B?RStLeGVuTkJFSGFidGQxSE1hN0ZpVkNrWk5XRnVzV3ZGQ1JHSURmMlBLakti?=
 =?utf-8?B?Q3cwaEd6N3NaQWpMeWg1TG4xUGE1QmhSbm13bjhqZVRkMVV0K1VEWnRNTGk5?=
 =?utf-8?B?ZG1iRDdZZTFBWklzSlcxa0RVa0dLaXM3U2N5emhwSEExbWtkVVlDb0Q4VzEv?=
 =?utf-8?B?cEQydWdab0VOcllDeFQ1QXdGbzRDeXJ6VmdnSzgvK08zS0NwUEJZNnlReVdj?=
 =?utf-8?B?aDRoTURNQVpnOUk1bkVvU201dlFHN3ZJUENsWGNSK0thaUQvSytjR3l3ZUZZ?=
 =?utf-8?B?bEs3ZmVKOW01bGZSRzgzSkNxNG9JWEQ4NWF2US9kaVd2ZW1tblRxQVFUb3pJ?=
 =?utf-8?B?WlA4WWZlQWpmdkc2NU9sblZlSTBGM2lhdnhBNHF5VHl2MFFyYmlFOW1tUjcy?=
 =?utf-8?B?K04wdTllbjZkRWhFR1NBa1pYT3BIOXhoUHgxdVpZRWRUenJROTRGNGdpR1BO?=
 =?utf-8?B?b1NXMGtPM2RVS3hBcWc0OWRzU1hYUElGL2dQeTRPZHFEUmdDYjZYVmlyWGky?=
 =?utf-8?B?dXdFRTNmNnpHdWNYdlpSY0s5blZXTDhocFI3YmV6MVhRdURmajllS085VStI?=
 =?utf-8?B?ZHdLdTFWN3Q4dE1OSlFlZUJmSzBiRzFGQU9QUFlFRkJ1NmpERXJxKzhWUlZQ?=
 =?utf-8?B?V1gwelRHdHdaS20rVGhsT3NSa25nZ2gybEVjUGpsMFB2OE9ycDJDS21oa1lo?=
 =?utf-8?B?SSthcysyZXRMc2p0aWlpRDdnaEN3WmRjcktsa05jTnZ0eVIxY3IzNnVVWmJP?=
 =?utf-8?B?YTk0UU4zNlRFZG1jKzcxVnVWb0xYbGR6L3Fxb0FpMmNoTm9pdlduTWptRXly?=
 =?utf-8?B?L2tKTW12WlduVFVFV1c1WG83SEs4MnJUTXo0Mkx2M01SYTEzeXRkQWJTMkM2?=
 =?utf-8?B?NGk4WmphMXovOE95NGRpaFAxR2k1MzNxdnBLcmtzbHBwSmNNQ1lqN3F4S0Qw?=
 =?utf-8?B?L1NrMUJjeUhjSXlnZnk3UStTZHFKYnVJeFlnall4WjZmeHRYWmQvUmVFWm1M?=
 =?utf-8?B?SFVDSWE1dXM1SHpBbEQrWnk3M0tSSFZZNnp6NXNVUHFIaUliV3lkc1N5U2JG?=
 =?utf-8?B?cmtZOE1NQmxtUWoxSGtvVnV2anRpVTB5ZExRdGs3bjVucVB0ZC9DR0NVaWRn?=
 =?utf-8?B?dHVzdWUyR1dzdTRrUVZ5VHNEcll1UmxHZ1l5YnN4WHpTZjI2V1FLaThmaGwr?=
 =?utf-8?B?Z0lRb1pWbFpUVmQzVHZTRHVULytwelNobVk3RzB1NHVwK3RVY1J0SGhTV3ZS?=
 =?utf-8?B?ZEl0cHBjTXk1ZjBYc3dSakVnajFMUnN2S2xTRVI4dDgxNVQydFFYNXJicjkv?=
 =?utf-8?B?bTU1bW1FN2ZXOVl3UExUWWFlTUtIQjJNYWd5dUF5MnR3WC9KUjJKNG4rR0hQ?=
 =?utf-8?B?QW5oNkdtZWhNaFoxVmU3RkVSOHdlODFxUVZsZmJJT1lKL1RzM2VaUmcvTE1O?=
 =?utf-8?B?bXRWR1krbmkvSXV5b1ArTE1XTHZsZnJFak5YUlYwZ2ViS2lpWEJUZGtOSTZl?=
 =?utf-8?B?eXlRV2ZQTThzZDBJbWkwcXlyZ1kwNkhMOUFxejBKcVhhM1JmZmlJUXAvaXBz?=
 =?utf-8?B?SEFpeFRhcmdPTXBZS2hYUm9mQmtWTlZQUzNJM05ZOW1ROXh0b0N2V05zMTZ0?=
 =?utf-8?B?YmFXdEtxcENyU3dkWXhFRjBYNStCWWVSN01HSDRWdlJkY3hxODd0K1Nlcjls?=
 =?utf-8?Q?Vw+49OL3evcDlboG9NFdmCdkL5tsr1gp3jNRlCG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6dd957-8ce7-40dd-f1e7-08d925f2651d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 18:15:26.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9lrtEiBbtw45x1/BAT/5dydceQz9jmRbllm5IYE3l+xubuYjF1xQlD/xaQiAwPcQCcDEdJHMvIyzFs0K10avQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 12:20 PM, Sean Christopherson wrote:
> On Tue, Jun 01, 2021, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
>> index 9c80c68d75b5..1492b0eb29d0 100644
>> --- a/arch/x86/include/asm/mem_encrypt.h
>> +++ b/arch/x86/include/asm/mem_encrypt.h
>> @@ -56,6 +56,8 @@ bool sev_es_active(void);
>>  
>>  #define __bss_decrypted __section(".bss..decrypted")
>>  
>> +bool amd_protected_guest_has(unsigned long flag);
> 
> 
> Why call one by the vendor (amd) and the other by the technology (tdx)?
> sev_protected_guest_has() seems like the more logical name, e.g. if AMD CPUs
> gain a new non-SEV technology then we'll have a mess.

The original suggestion from Boris, IIRC, was for protected_guest_has()
function (below) to be:

	if (intel)
		return intel_protected_guest_has();
	else if (amd)
		return amd_protected_guest_has();
	else
		return false;

And then you could check for TDX or SME/SEV in the respective functions.

> 
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index f0c1912837c8..cbfe7479f2a3 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -71,6 +71,8 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>>  u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
>>  		    struct tdx_hypercall_output *out);
>>  
>> +bool tdx_protected_guest_has(unsigned long flag);
> 
> ...
> 
>> +static inline bool protected_guest_has(unsigned long flag)
>> +{
>> +	if (is_tdx_guest())
>> +		return tdx_protected_guest_has(flag);
>> +	else if (mem_encrypt_active())
> 
> Shouldn't this be sev_active()?  mem_encrypt_active() will return true for SME,
> too.

I believe Boris was wanting to replace the areas where sme_active() was
specifically checked, too. And so protected_guest_has() can be confusing...

Maybe naming it protected_os_has() or protection_attr_active() might work.
This would then work SME or MKTME as well.

Thanks,
Tom

> 
>> +		return amd_protected_guest_has(flag);
>> +
>> +	return false;
>> +}
