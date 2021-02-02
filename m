Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2530BBA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBBKAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:00:19 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:43091 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230129AbhBBJ7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612259906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hK8uf99asdr/NvFpyOabOBY7USx3GtWHkI2i3eHv5Y4=;
        b=Ss6kOwz+hSJkYDdZs8JXRy7g2A3w/izfvm/GWJCsmgdMwcht5OZ1p6DqOi6pJGK8iDA4bG
        jVu9jPlId6PNnH6XEVv3U5NJ9Y81de3rxcZx1q50xmsOOv8ul4Rqv4EHxzWTASXs9ADzW7
        NyV3kvSNlLUn/BLXDux55LQ2na1OcsQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-fa78D1ETPkemocAAankmZQ-1; Tue, 02 Feb 2021 10:57:52 +0100
X-MC-Unique: fa78D1ETPkemocAAankmZQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flsOVfa6AeIaX9Czs1FaVfM3fnXv7Sy8l2qTN/WuG7qp/ZVMyCQRe7B8rY+pbPjGG+XCv3NnCx/07IF1WVEU+1YbodNkvSi1Rf88P43MQy26/ajvj8hA2DMLt/Oh+IAY5SUO5PoLHr3zhxw0MfPLcAhX4Tw/EQPaqt+G+GYEYjTNZcX+pmzOozo7OvVJzVVS4wwPuWG34+K/PPfueWnUKJYI6137BLnkHVopnhDyN+FdduNWgPQLHrG/KYl5iQINTdJtqOou0p4k3099LTvEBWFd3lHwSDPggv7HH3OT/IJ66ditcfyl4JALSqBC3IjJiNTaI5poRpSzCtYf24Q3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK8uf99asdr/NvFpyOabOBY7USx3GtWHkI2i3eHv5Y4=;
 b=oIhLPulx21/kU4gfXRNJ+kdZ4qOt4hGrPeOXgIyLpgzAoiSIMUNN/HrU7EyW05x0ah3NOpyGOBnNx1ICam95xgqFrF9X3XpgXB0joCtTR/5KJexaQ66oOBnjUpa1UBLz3caaHuv5D4cLjPQLSNk1OkQSm05ZZHzKHTrzjgNFcqv/xVVJnsD9W0j91cLdPn42QChp9j6DnNwqg5bFNRpg60W2+f/LS5YwehGTsIGhmm5KGuRc+/o4U8ki0h94qh4eWdlrx3KyTaiG0ZJJra2TDApdwgKzqWWtajPgsp196qA3cxYOWzPFVJVOYy+UZBsoFFpzNRWJAGp1ZgyiEIiRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=suse.com;
Received: from AM9PR04MB7571.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::18)
 by AM0PR0402MB3571.eurprd04.prod.outlook.com (2603:10a6:208:18::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 09:57:50 +0000
Received: from AM9PR04MB7571.eurprd04.prod.outlook.com
 ([fe80::42f:77ab:ab6a:e1dd]) by AM9PR04MB7571.eurprd04.prod.outlook.com
 ([fe80::42f:77ab:ab6a:e1dd%7]) with mapi id 15.20.3805.025; Tue, 2 Feb 2021
 09:57:50 +0000
Date:   Tue, 2 Feb 2021 17:57:37 +0800
From:   Firo Yang <firo.yang@suse.com>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/3] VMCI: Stop log spew when qp allocation isn't
 possible
Message-ID: <20210202095737.shlt4sjsdriq2qc3@suse.com>
References: <1611160340-30158-1-git-send-email-jhansen@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1611160340-30158-1-git-send-email-jhansen@vmware.com>
X-Originating-IP: [175.170.255.99]
X-ClientProxiedBy: HK2PR02CA0150.apcprd02.prod.outlook.com
 (2603:1096:202:16::34) To AM9PR04MB7571.eurprd04.prod.outlook.com
 (2603:10a6:20b:2dd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from suse.com (175.170.255.99) by HK2PR02CA0150.apcprd02.prod.outlook.com (2603:1096:202:16::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 09:57:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 773e79f7-1375-4599-53f4-08d8c761004d
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3571:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3571D6E076CF63FC212BA09788B59@AM0PR0402MB3571.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXhrT2FvT3h6ZTk0dDhuVW9lNUxqU1Vka0hPZVZRa0hKYzBxMnc4NTROcHpW?=
 =?utf-8?B?Mmk5N0JPemhxYXY3NlMwZFN6Ni85QVBLTDFiREhCVHhtYVNkSm1Ja3ovdWF3?=
 =?utf-8?B?MGU2SGNvUTVadk5tWEFMTitneC9JSk1kZzk2SzByWWxNTkN1VC9tbUJDVDNu?=
 =?utf-8?B?Unoxa01KUjR3OXlsWFlQZVdnbENvRWVXNmowbkhIR3plcGM4RFd3eDQvTm1z?=
 =?utf-8?B?dUxOZWkvLzBPMFZ6UktibDdxNWdMNy8wZzZmNWFQMjI1MUxPTlh1K3BGQVVw?=
 =?utf-8?B?SXppTjZNTHpJZUhqKzk4RzBlbk1seDU4bG8zRUhTWHpPaXJJREVCVlFubXRp?=
 =?utf-8?B?UGJXdHFGOWlvZDB0Z2U2b1ZTdHRCeHlLNnhLWlBMTFpsRVZrdk1DV3ZHNmtP?=
 =?utf-8?B?ODE0Qko0eXQ0N3Q2RVlnMEc5enJCYTc2UDNPWXNmdUVJODZtT0pLN1VKNmZJ?=
 =?utf-8?B?azJnN3JXNTl4bGEwMmlHN1BEZm1TTWMrb2hEM2pFRmI1UkM2S08waG5OanpS?=
 =?utf-8?B?L2NGNXh1L3RCR3BPVkc1SUxiMXBraVYyRU8zT21hNEFIKzRKdXA3OHUvVlhF?=
 =?utf-8?B?aGVnbk5aaHdoY1lDRitBZkVOZksyQjhKR3daQ0dCWGpyRGdhcWtKbUh5KzNi?=
 =?utf-8?B?QnFTZFNlWEFlQm1XdkNyWG9oYVlLcTNPV3A5eVpqVlRpWk9Gb0xDRERYbTFa?=
 =?utf-8?B?dTFIYm02MUtINEFubEpKZEdGNFVWbzdZY013UmgrVE1yVW1xZmJmdVF0eEhS?=
 =?utf-8?B?YUpXQ3RwT1RwQmNBY3kzRm1mSzFBSGJwQml5Z0FVNi9LdWJkZCtaL1QyazVr?=
 =?utf-8?B?WmkvUVNERFBPRGpIWEVrUzVVbU9mWWFVbFJKbmZ2ejV1N1J0NDVUNDZjWDJa?=
 =?utf-8?B?TVlFa2tsVW1oL1FRY0VZUThDb25jOTA1TnUwQ2lXLzliMWFGYkFwWWFMckNw?=
 =?utf-8?B?elFBdzA4TURHSHRpZG9jWUEyeDEveUl0ZzZSZld1eHlOeU5iNzFEWGhhUHFE?=
 =?utf-8?B?MzBwY25QRW1jWmFNc1k0UzNCcWdCZ1FSTEZVcklGTDloQWZtYi9TUEY2c3dD?=
 =?utf-8?B?bUZ1WmVNSGFNL0hFcG9BYmV1cExxSnFGUm0xdy9pOGJXbTdMcWNwdnhHcWFJ?=
 =?utf-8?B?bjcxaWh0SHIwYUNyUzcwOGVxNmYvNklkNWtncVpjbldUSlU4elJnYTQ2Mm5q?=
 =?utf-8?B?eThoa05oMkpHeGJhRVNmQ1JIYnk1NFJ3R1JURUtPaHhqL0VPNGJrZk5hanli?=
 =?utf-8?B?QUhyd28vY1QraW93TVVYSU5LZ1V1T0Z2d0VJZW9ob1NWcEdyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:AM9PR04MB7571.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(376002)(136003)(346002)(396003)(39860400002)(366004)(2616005)(55016002)(66476007)(8886007)(316002)(66946007)(86362001)(66556008)(4326008)(6666004)(83380400001)(8676002)(8936002)(36756003)(6916009)(5660300002)(186003)(7696005)(478600001)(966005)(44832011)(16526019)(52116002)(956004)(1076003)(26005)(2906002)(1490200006);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3hwWjdQc0pTTzFRZnFaM0lrYWM1MXNPSkZoaHlmNi9FTm1tc1FSemVhNnBk?=
 =?utf-8?B?cmVRUy9jQk16ZjF5amdzK3R2U3VVaDBJelh5TktqTmRYOUFLdWlMTkpSYnUy?=
 =?utf-8?B?eEdxMlNySmowTmVHV3RCNXo1NmhHTWZHQWRTeUdJQk5WRUI3WS9ENkl3eUdL?=
 =?utf-8?B?WWlXUTBmTFVnaEZnVXBJd1BmdExiTlE0Y09TM1YrbWxteWp3Rm8xV0g0SUh0?=
 =?utf-8?B?a2R5ZXFRaW9LWWFpVmdLOXZxUmVFeGpIVUVBclRwdzZROWkxdVhTNzFmbWVl?=
 =?utf-8?B?WFpmOWNsT25CcnJPN3ZYak1uUDdmcjY2ZzVOYkdKRWxnVDh4d2ZCaDhFYk81?=
 =?utf-8?B?R2w5MTBjVmxnRjdaOUFYMnNYUlNGbnZxN1VOMkdnTk5NbTlqVU4xankzNzdQ?=
 =?utf-8?B?RnlFc3E1UGRRNndIUXRtbGJPNlMwSzgvcnlUdmRjWkRpU1VjbGlMUkRTdGZu?=
 =?utf-8?B?WXVVT1QwRXp4MUpHNThycjQwblZPYThxaVB4aU1vSUNVVkFTMDVuOFhMMkRh?=
 =?utf-8?B?dm8vSWU2L09CeEV1MkpkU3dDR2JCZDhZTG93ZmlYbG5NWTFCakJVWElyWnVD?=
 =?utf-8?B?eldmMW5Fc0NxRFdaY2V4ejJyY1lhcjhKUm9rT011aVA1eWRRZlZ3cEJhZXVI?=
 =?utf-8?B?NWdpYVlCTDJvMzdyMEphdmYvMWNmSWg1aURHQjNWZGtMUTJRYzhPVkwvQmZ3?=
 =?utf-8?B?UkV3S01PMnhreFlGTTdaK2kyNlhZa0wyM2tzbGVLM2VMRG96RjVRUWFKVnN3?=
 =?utf-8?B?RUoxWmNmZ3A5ejZRZFVDdmxRb2kzbkNvZmgxR0g0ZTJNMTk2YWhFbzZWWktI?=
 =?utf-8?B?b3pqMjRHd3QrU2ZmcTBZc3p6Zk5wTGxGK0FKVWxWTzZCdXBRRGlEai9pK21v?=
 =?utf-8?B?bGJvd0N5QjU1dEFGZGcreEFpT0ZJRzVBZ0xqV1VkbUNKK3k5cWxYSEtGVVFJ?=
 =?utf-8?B?c0U4cnluNCsvNzV1dENUTDA5SnBLcGVxV3EwUWNrTUZRY0lHUTJRNGVJYjJ5?=
 =?utf-8?B?VnR2TlF0ajMwN0JNaE1sQzZEZmoxQ2t4dkt0dWJLWmRmb0p2M240eFFZRTVY?=
 =?utf-8?B?ZWxXZUlpTkg2Tjl0VjZOWnhYdjNreStMOXI2K1NzL1ZlZFFNMTYveTRPc0lp?=
 =?utf-8?B?cEV4bVRtRjlNallaQkFKQnByN1Zma202TjFPVVpvSFhLMExKTWJ2c3pxTzlm?=
 =?utf-8?B?SkpDU1VSMlVNcXFTWUIyY0xCWXFxS0ZZR1AwY2l6NXBLeGVRaDBnTnNreTJO?=
 =?utf-8?B?RlQ0c1R0Y3ZRUXRWQXpxQzY3dWZRUzdTQloxT2ZJckttQVRsS1BOamNzazR3?=
 =?utf-8?B?bWdYankzSGxVdTh0cDFFL1BQc1NXMXVkaEw1MmlnQmpaSHZRVGtuQ0JuRldl?=
 =?utf-8?B?ZW5nM2d3czRYS1FTcE1CVlNrOUo3cTFsWHdhdHNjNURHVzA3WVJhSUg0UnUy?=
 =?utf-8?Q?EsGIHSL2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773e79f7-1375-4599-53f4-08d8c761004d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7571.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 09:57:50.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz7NqG+GODiChCcf9QVlQcY1KireEaZE+e4dSD5nh5EKGwqjAKnukz4DhxL05ndkpBTU5G5EaF1FL7nvSec6Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3571
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 01/20/2021 08:32, Jorgen Hansen wrote:
> VMCI queue pair allocation is disabled, if a VM is in FT mode. In
> these cases, VMware Tools may still once in a while attempt to
> create a vSocket stream connection, resulting in multiple
> warnings in the kernel logs. Therefore downgrade the error log to
> a debug log.
> 
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index c490658..a3691c1 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -1207,7 +1207,7 @@ static int qp_alloc_guest_work(struct vmci_handle *handle,
>  	} else {
>  		result = qp_alloc_hypercall(queue_pair_entry);
>  		if (result < VMCI_SUCCESS) {
> -			pr_warn("qp_alloc_hypercall result = %d\n", result);
> +			pr_devel("qp_alloc_hypercall result = %d\n", result);

Hi Jorgen, recently, our customer reported that their dmesg was also
swamped by the following message along with the message above. 

  "Could not attach to queue pair with -20"

This message was printed by vmci_transport_queue_pair_alloc(). Could
we also eliminate it?

Thanks,
Firo


>  			goto error;
>  		}
>  	}
> -- 
> 2.6.2
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

