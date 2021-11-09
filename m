Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BB44AF59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 15:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhKIOYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 09:24:02 -0500
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:53121
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237614AbhKIOX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:23:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeZQ0C2yjs2B28ES0SXh0erJ8LrR+orkv+N2PK4vn0xAW6qWtOz0VQERte5cqs+vstFJl+gVggl4hXHzS6kTa1IMZzmE4bUnLfaWDOZXfwghtkMZPVNsph3BjLkqsHrrtsBwDH/Ng0+jDj1BeceRZQSfeVJL9s1LFvz3cy6nI67edcCpIICHFKXH3+wcD5pT6CSaN/1k4t1WE20i4CwTmq9SJq8JPFz5VNB1haxSrK2o+mBVpCMXP9VhtsFWwgjTZAnaaVEx9PrSUh4qwyr53vndJ+JiBxa7tDXELk9vUsbWf8dPeD/Z7WTaC6e2fpdbtCfXaNg1HUfVuUAPbIuvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KDNUqsJep7EM/AKz79nil1W2qfv3mHTRtUxuS0BBNc=;
 b=fhdntazazum26mjfOzCPQPbWY0zZL/FtWGHMBDRMrCWPtmVTLBzFzSPGHmsNXO87xzmF88lED+yqgOjrBYqWg+OkoSE0oyRlF+jAKkZCOJgnPpY3jqbyYQxeoCFTNuX26pcfl6F51Bz78AWkHlZ/WnUKxbVrZTF1iuWtjTo2TcV1dAZino+NN1zPsfnvSorM62L7P6h5R2k2djzFJuSy7gacUB6fmK75uCadqwJHbe3LHAevbJebt5fRayRJAyCGche4dggGhqIIhyDSjep/mSSlLbpjGHNCmv+/kul4umiuXuwMrtQTSECqmS0AOoCGElfe3AFPebTIqiI8i0ngJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KDNUqsJep7EM/AKz79nil1W2qfv3mHTRtUxuS0BBNc=;
 b=ZpnN14TbbnuBY0cSaxb/0hHml1q6Pm31W/IbeMuU3AbIYDM3H9n8BvXvrs4/EM5OEL1HnNlfbHrVx4nyeev/vvNAGGs5vRaHv66tcucsne73uugSeqbbSCJtZ7E0UtE1HbAVVkg60k9rcfzUFO9k6qQGhhgIf4hbhCCa60aNxvc=
Authentication-Results: insiberia.net; dkim=none (message not signed)
 header.d=none;insiberia.net; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 14:20:41 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 14:20:41 +0000
Date:   Tue, 9 Nov 2021 22:19:49 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Stefano Picascia <stefano.picascia@insiberia.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow selecting amd-pstate without CPU_SUP_INTEL
Message-ID: <YYqDhaXDIqJyjGjg@hr-amd>
References: <9932762ef184fe132acf176081f8893800c83800.camel@insiberia.net>
 <YYjqNaND8hLGsoXg@hr-amd>
 <6b30aaf57cec5b6a72cff1f32d4fe24e47e9754b.camel@insiberia.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b30aaf57cec5b6a72cff1f32d4fe24e47e9754b.camel@insiberia.net>
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR03CA0044.apcprd03.prod.outlook.com (2603:1096:202:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend Transport; Tue, 9 Nov 2021 14:20:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccdb8fe1-deaf-4eff-3f73-08d9a38c1bda
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2471:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24714133C1D7A06A68E048FEEC929@CY4PR1201MB2471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVnq8oODZgSWaWvGdQ55kKIYd3QrjFKtd2Hkc/ueMKbSINviQk6hjGVPyix0CtxOSJtK8dzUvfH2L+eX8j7QMstM634kVX4NVlqvEql+ukkHfDI10xq84ZYbf57fiQQf3d52pJ3Sbhdjb2Fv1rZfKBBF6zANC6zsyUPGXnRfvHaOeglnNt9xdN9hAQzql5OU0gclUII6Q7iG1gAa1xTazl7sPkeOskji9e0eXHpvDKjgEhATAl8eBNq2wOZ2YT2XiFFw/3e3dhzZ/AsgFx7TcnyhPxnF7IqEqgt9ziduL15ofo1aotnkM7TVrdQ8LZhhwbCDjSRwPxnQSzOay3kJCNORrOBN8fy6eftBxiCSXYXySgJjf8TQQAd/IL4mW4E/csG1zA/PxVNj/FJHkwUIIaoWanhaMbq0ahPV069X8QBlW5/Nl1wM4f+mG1V89/OF+5LhSqZ37wNw/4Vm7jOxcshbJx663btGtU0+DVbA8wy7a5c4Io+wWvYLx4K9iiZVbuGO0eipo9pNtzxsB1DcN16+j1RKs2FdSMCuRnh4JXgp8HqpdecYKShMo0wB0WALktK/A4SFKnJKLrw5hhcuC+QQl34eo3fNF0OxgfSzEUxR0bjW8CHPJjzCDkKFP0BjWOJp1UdaT3JKsRVVqvOgyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(316002)(83380400001)(55016002)(33716001)(66476007)(4326008)(66946007)(6496006)(8936002)(38100700002)(508600001)(8676002)(9686003)(66556008)(956004)(86362001)(2906002)(26005)(186003)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?h4E2n2Nx0MptqPmV5VkE7R1gOp0rWQgOHLvFQW0XGp7csx3ivFpDNLbJYB?=
 =?iso-8859-1?Q?cDUAs1iutJwbyrC8zSe9Y8GiyVLtqgmQzG/ps31iRbY3dk9xekNY5Hrvra?=
 =?iso-8859-1?Q?UVq+pZauBBZR24KfrEueBdHi06AtSfFJ+TLbPLbOCdP6Cqld/ES+lcC4C2?=
 =?iso-8859-1?Q?Dxavynq2/r0Jz1TXYEkttw/W1qLAlIcr4jdk06ECLfxRcaO71FFUPHFAwd?=
 =?iso-8859-1?Q?7BxD53a8J4KtLJW5D0ZLWj3tJRIXIv44HcZQKYjprF23stLsh2q2jvAgdo?=
 =?iso-8859-1?Q?AygDZNz9gkkC/tDUeGyHjlZVwbfeFBTV5boxUQu5YR8L42p9VPnVkpJWmf?=
 =?iso-8859-1?Q?RFyIFtp4bXOLTzETXsotL4RHw9ZZ/gNl/tAXxh7h2oNsdZbQzXGoeNe6dS?=
 =?iso-8859-1?Q?9Ou3CNaqlUW9d9GW16jdKNeiVrUEkw3DblJX/qI18vBzwhCK0HSbx3pMjG?=
 =?iso-8859-1?Q?tCna3GaJquG4unvca5TISHuFv6hAk7yzdwz1ULQoO+gMMFFlYqsUARX2qJ?=
 =?iso-8859-1?Q?cK7hKxNnX+EMdG9GeE0iYT4PYz3LBpr87WSXFEzUpeOAGilszQoz40j3dP?=
 =?iso-8859-1?Q?TdsBrsJ/9XesAark66P5pPMenUM6E1NNdWF+uoTDSNkCxab/UUPAiNqgBp?=
 =?iso-8859-1?Q?CsoHxYS4PAXs8PIB5r/bglwaY2JmPO23BvvItl5BwyuNWe1lXUKqKJsA9k?=
 =?iso-8859-1?Q?RHzEM6wx0zeSdO33XUBNCeBHlTH4/e2GyOxMiB+/4JvGQ3XrnIRN3XD/Cv?=
 =?iso-8859-1?Q?/Xgw0jOuUOqAFaliAil92Z3F6TME+PLoGzBR9MDkzEudvxBIcPnipkT4OF?=
 =?iso-8859-1?Q?/KsT4chpPYWwQjY01SEyENsGWmHrU849Mr+VWYK2lt7vpK35JhNPG0TSwc?=
 =?iso-8859-1?Q?zh9+IH4ctWW2wNol+k1LBNBuKeQW90PJctUxNUj9P3aqmqOcO7/lMl+wrg?=
 =?iso-8859-1?Q?lfV8UFKoF7uHfRbYQujzFdcCR9XdNSpOE9eEodM2fkqZAM5L9ND8A7TcgI?=
 =?iso-8859-1?Q?LK8R1dLBqfH45HJvgd0FtVatMDZoY+posUpKchQlaN6p5F14t3+tmoX0VZ?=
 =?iso-8859-1?Q?0gLiReK6uhzCWtqlDs+OIbZq9YcTTvGboOdBcIx80DcpCCt3Fa24LwGR1q?=
 =?iso-8859-1?Q?jwYvYA4gLcEd8YTAwdERrmrEDHCAJt/n9+UrJ65zgSCHfdff2MOmFhstlv?=
 =?iso-8859-1?Q?Yn98q4PLAOKOrfmInl005j00/e7yEjcExky9CcAaRflkwjgbAV46XZa3Q6?=
 =?iso-8859-1?Q?4H8j5KrfWmA5N3k/cNsox95Rc2mUhwF0CDN35uQRUNQHWblThAmXE/t+a1?=
 =?iso-8859-1?Q?eUXH0YMHDJh+hkmYuZ1gbeWxLDNQ5FW9G2jvLeEyYomyV+oH8rA6xTm9nR?=
 =?iso-8859-1?Q?JcvX67IFnkqFnN5bEsKfZU8hOhldVIE63uO7Mn1LuzLhnlRWG9sCDpSFFU?=
 =?iso-8859-1?Q?3F3fF2R7rZilgTw7JAuQTfNSPUbvtwSNnFRFSLKyOMEKw/WZ1JdknIid9p?=
 =?iso-8859-1?Q?gOP4B0OTQr5XNEVQi8nce9PY1p0cXIaZwao8b+9pJ8LZk1H65eB4fcyTje?=
 =?iso-8859-1?Q?6Jz3OHovWoE7YXyPNdt3P1AvjfdHeT7EZ2rLfblPHmeJluuZa031OnfRg+?=
 =?iso-8859-1?Q?Im6kPWbAe5XLZ/d9Pw4a4NztsIGr96HHHYestH+0waDd/xSuObIX7XswCX?=
 =?iso-8859-1?Q?unf22SriDd2nNzuklGo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdb8fe1-deaf-4eff-3f73-08d9a38c1bda
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 14:20:40.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt6NiwNmIvwnIv0lPOTP1Z7dCp/ovfDWAWvHsBt6V+9buk3acEJ2IP1/hMorNcWmHfauhx3UMZrbzRETzpuAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O Mon, Nov 08, 2021 at 06:01:51PM +0800, Stefano Picascia wrote:
> On Mon, 2021-11-08 at 17:13 +0800, Huang Rui wrote:
> > On Sat, Nov 06, 2021 at 07:55:29PM +0800, Stefano Picascia wrote:
> > > Currently, even if selected, amd-pstate is not enabled unless
> > > CPU_SUP_INTEL is also selected, due to ACPI_CPPC_LIB depending on
> > > SCHED_MC_PRIO, which in turn depends on CPU_SUP_INTEL
> > 
> > Actually, amd-pstate driver doesn't depend on SCHED_MC_PRIO. 
> 
> amd-pstate doesn't depend on SCHED_MC_PRIO, but ACPI_CPPC_LIB is only
> selected when SCHED_MC_PRIO is selected. I guess the issue can be fixed
> in a better way, but currently if one compiles the kernel with
> CPU_SUP_AMD, but without CPU_SUP_INTEL, ends up with a non functional
> amd-pstate. 
> 
> Not a problem for distro kernels I guess, but I was puzzled as I wasn't
> getting amd-pstate even with a supported processor.
> 

If I modify the Kconfig of amd-pstate like below:

config X86_AMD_PSTATE
        bool "AMD Processor P-State driver"
        depends on X86
        select ACPI_PROCESSOR if ACPI
        select ACPI_CPPC_LIB if X86_64 && ACPI
        select CPU_FREQ_GOV_SCHEDUTIL if SMP

Then ACPI_CPPC_LIB can be selected by X86_AMD_PSTATE as well:

Symbol: ACPI_CPPC_LIB [=y]
Type  : bool

Defined at drivers/acpi/Kconfig:268
  Depends on: ACPI [=y] && ACPI_PROCESSOR [=y]
Selects: MAILBOX [=y] && PCC [=y]
Selected by [y]:
  - X86_AMD_PSTATE [=y] && CPU_FREQ [=y] && X86 [=y] && X86_64 [=y] && ACPI [=y]
Selected by [n]:
  - X86_INTEL_PSTATE [=n] && CPU_FREQ [=y] && X86 [=y] && X86_64 [=y] && ACPI [=y] && SCHED_MC_PRIO [=n]
  - ACPI_CPPC_CPUFREQ [=n] && CPU_FREQ [=y] && (ARM || ARM64) && ACPI_PROCESSOR [=y]

Did I miss anything?

Thanks,
Ray
