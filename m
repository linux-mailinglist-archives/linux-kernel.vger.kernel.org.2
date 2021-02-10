Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741EA3172BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhBJV6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:58:43 -0500
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com ([40.107.93.84]:60716
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231642AbhBJV6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:58:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJu/CdNYkPMGerQ8Iq7LB2bK9Cn6f8EtpVKIh1K9nuNNNcdtD+xtUBCg5KkXw22VoBP7ieHBeNwRGhG5sB0z/SgnULgAcPDQgL/uibyXgMZr5juH+//ymLTKmNyINSsWitK6O8qtxdbTZTkmhvngIs6KGBX3o3XWWwhN04JY5CJeT5MI+/Lg3gM3HwDwnl9j9u503RydRXjvjxtguCEiZa+QFf9Y9P44Ij/2WrP/6XOQtilYhW90gu3zCTP5lBohc+j1aBMSh0fq5Y7EFjH3po6jI5INSiHcYm2QoGI06cTqtYZ2X7E6L/VN5yNCu76OH23H4LfgL37foIxCFcN3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRx3oBjFV1Rkjgw0f2XY6jO1BW+rM9+J8Hpcunu96XA=;
 b=FbBpDMN1gViFPsXE5YdnwblCj62n3vvWqUmMml4f6DVRM0mBsGxk6M+osd+wkSeF9MWvyC/dm9WwANTOHvjq/A0MwHljeIkI0BNhMy9vcU4452AM7k+gy8UMZxpDXIKXV+83u4CDE9XqvtX6WTXK4iIqnqRK879ifmCpOoYln5GTO2kloUNEa5I8h3+wNaoNoM8z6MAhWvSk5Cha4ZBS9oG3wgXOTyCtGlT6NG8gpmdlmcim9dUePrgBG8QdbyiQsETDsPmXJ/kFzEEE0xqFM8secbiE97VdFJmnFsZcx7e+IZw3Vyg+CE2HO7AEqEgMYATIuOE5lac7PZGPLBEuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRx3oBjFV1Rkjgw0f2XY6jO1BW+rM9+J8Hpcunu96XA=;
 b=PbqmyYLDhRIAMp3eYyyO//fADEV3RY8jdwD6vBIWE7u3jfd5DyxGvUJX7tSNn/wfv2zXmfRes3XhFTjkj2oD11eoWZt0YE5OjUPWRzgefSpWGo2jA8vpUQ7yoA13CrWMg9DbHIJLwjXJJagiB3jHDm+4E0638jCQuvu6lbGkx/M=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB3514.namprd11.prod.outlook.com (2603:10b6:5:61::26) by
 DM6PR11MB3867.namprd11.prod.outlook.com (2603:10b6:5:4::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.30; Wed, 10 Feb 2021 21:57:48 +0000
Received: from DM6PR11MB3514.namprd11.prod.outlook.com
 ([fe80::8d65:1cea:7dc:dbea]) by DM6PR11MB3514.namprd11.prod.outlook.com
 ([fe80::8d65:1cea:7dc:dbea%3]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 21:57:48 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kgdb-bugreport@liss.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
References: <20210210142525.2876648-1-daniel.thompson@linaro.org>
From:   Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH] kgdb: Remove kgdb_schedule_breakpoint()
Message-ID: <12577be2-ac19-bce5-ede4-a7e6756cb138@windriver.com>
Date:   Wed, 10 Feb 2021 15:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210210142525.2876648-1-daniel.thompson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [73.74.120.8]
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To DM6PR11MB3514.namprd11.prod.outlook.com
 (2603:10b6:5:61::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.15] (73.74.120.8) by SJ0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:a03:333::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 21:57:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f84566e-14ab-4f05-8e77-08d8ce0ee772
X-MS-TrafficTypeDiagnostic: DM6PR11MB3867:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3867CD5D306C9F015F68116D978D9@DM6PR11MB3867.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJo1M6NzkPE+lTg/siV3Gcsb2E93cg1W04YUg3Ai7aRU1cowxrs5baKz6X67Jlg7ebAbOE9dauwZr+jBGZIFTIxuFRgXQfSpU55UTN7c3igQYdZeHaimjJBnWssjnbwHr1dt03AFLUCLFQDQCKDNImemNZ7w+mrb87fSLCLib//NK92nNFnUsUlgKzFM5Nw6qbsgd8ZxIWND0acE+N1Yos5OPPNlj0Jv7UHPgR+Yd/hudoJAGAxzQeKqC4sEMNJQP+s4Sm3sB8b8eDGhGbOommgeFWQ6c1g4KFCrnzNCYTp+2wBSZTXR0nFTl9cHMnPwxXud6vLcGZqIDdw9oX0iJ09aPNlECE3Q/njiG08RLxV/lBwtUf8lJa9MQfE/f+u/d6cUgL5QLgRYDnKROOL54VYlTUliCSaHCUpmPqawNvlUQaanh9YZ8Sug0jD17mk5qQokyUYyL5N1bjeH3BkjJ1QbRAEbzDOtiej301M6eN4W/f5xNG6ZCV06tdRHIci5C02/kwCY5LOdBkT5/VdKD64I2lgPD1luXKthQcOWc7sojD7XYAZ34/NzHxVIvWKhupCoGdxPjmBRVrXDYzXy/vNER7D/3tSjIoZG4CB4eXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39850400004)(346002)(376002)(396003)(44832011)(26005)(16576012)(316002)(53546011)(8936002)(956004)(2616005)(16526019)(186003)(8676002)(4326008)(6486002)(54906003)(2906002)(5660300002)(110136005)(478600001)(52116002)(66476007)(66556008)(66946007)(86362001)(36756003)(31686004)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZVpSZWlOVStQa2FLZkZTZ25YcGs5QW9aT3NlL21pMWpyczZCS05RNkh4VTVz?=
 =?utf-8?B?MVlWTC80bktmMkhZSnloV1phNVhBYm44ZnBRa1FsY1RSbUY0NVM2dWV2R0wv?=
 =?utf-8?B?cVhDczloNHh2UUY5eFIxZnJ4MXU0Sm9OYTlWTElwZEVmN3VLM29Qak1tRlZH?=
 =?utf-8?B?RlhLN2tnVUJSbG4xTCtXdWg4a0xhWWdaMkh3VmlFeTFVaVRqa001ZGFud0xL?=
 =?utf-8?B?bkxmUTExZXA0T24vMkJNMk9udnBTTmt5emszb25JbkdRQ1Bic1ZPWUl4dnZW?=
 =?utf-8?B?WjNNcllKQWVSQnNLSjZTNy9rN3FTV1p5cmNVcUhEOGVXSE1HajdNc25OME9x?=
 =?utf-8?B?bHZ1VUlUblRXMjFaVmUweXZNUmtUangrS3ZxMG4yTFdaTzU4SVVIVlcyZEha?=
 =?utf-8?B?NTJ2VXBHa2VDTVNSSDVSNTN1amU4L0RlZHFJUmo0ck9JWkZEb2xPTFpJRkpm?=
 =?utf-8?B?SXJMTFdaVjV4M1c3VkVVak1pL2IrZU1EWUhiM3NFQUtReS9UeUI0T05CUlM3?=
 =?utf-8?B?ZDFlbW9ud1YzZWxjaHMwVXRsOW80QklkREZoRjM4TWcxNTBmWElZQVI2SlIx?=
 =?utf-8?B?M0RIcDdIcDdLajRndWg5d3hPbk43SmFETnZ5U1ZJMi83a1Zvcm1MMzZpQ3Av?=
 =?utf-8?B?NDAxRTA4cE9yZDE1cVB6VjdOSitHY0UwS2t0Q1FiYjZad0Zlb01WeUFtdS9L?=
 =?utf-8?B?V2RVbmVLZHVTNkRrOEd5Y3R2Y2RVZVhCVzBnZy9JM3c2RVI3VEswMGxSU1VR?=
 =?utf-8?B?QXM2TytHNXJycmVKZllqRDRkbkR2MVZCSXZFTis4TDVYR1pLbWtiNmRmQS9s?=
 =?utf-8?B?cjRxYXN0QkgvTjlFR1M0VGRMaXY2ZjNxU3oySEhlWjdJNVRydnoyMkdYUUhM?=
 =?utf-8?B?NHJvang5ZVhPR1JXUkNrLzFXUE42YTRoK1llUXFLU3VWbVBwK2taZndzUVJR?=
 =?utf-8?B?NWUxSVloN01nMnhvTm8xUG1rQnJiTUtWc1dDTDNLdDQweXM1ejVySzdRb1lG?=
 =?utf-8?B?Y0dvcGMxWk9pRXlqcWcyWEhHK2NsYVZ6RFZGVVh3SVpXMzFUTWVlS1hQbUMy?=
 =?utf-8?B?aUowcEU1L3BZOHJJTjE1YW9pOGJDZG5Zai9UcGVyT2lhdEdqOVpDZzVjN0Mr?=
 =?utf-8?B?eEtBcnJ4QisvS0wyQVNYWnh5ZlhpVmpCdTNyYkYxaEE4dGlBQ3YrVWZoU0o2?=
 =?utf-8?B?TzA4SzNiL3ZGelNzQUZjSnJPa01hLzhvdjFrYURuSVNkRmFPUFdKTVBhc3Zz?=
 =?utf-8?B?MXRMMkhyY2tXVlRmb2FMNS9taU1MY2IwdCtYSkh6Z1Avdi9HZE1WZkF3VU1v?=
 =?utf-8?B?QzVnUkpBS1oxa0Q2b0s1a3dGTGlLVFpnRHBlaFRUMUQ1SzNrM2NxS3kwL1Bn?=
 =?utf-8?B?TU1HeDM3Z0lROGtLNVV1YXZGL0JsY2tqekdTbUVUWjhCdHJjNW14aFhVNzZn?=
 =?utf-8?B?NnVSbmpSTG9hdnBURHRMVWFuQ1BEOFBkejRyU0pnTVh3c0F0MllTUmdldU85?=
 =?utf-8?B?V1JxN0NUU1IxazB2ZnJyRWFibXhZTERDbEliQmRlUytaUG9HVklJcktZa1Vt?=
 =?utf-8?B?Q1lYRHBjSEJQdENyRnd6bjhZd0pjN1ppOHl3MU1GSm13QndjSjJQTFVFcEIz?=
 =?utf-8?B?OVhKZy96bktvT09BcVAzaHFMUWFObmtTY3VsVS9ieHF2MU56MjlvRFpHQy91?=
 =?utf-8?B?SE9oZDJRdEFzK1I3eEduWmtxWjFqNUVtQTNsdW5FaEdGaE5kdG1sUjZiei9k?=
 =?utf-8?Q?Nfl4q+pXKW9M3A4a3fl/Faypglaj98v/ZlSRhUy?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f84566e-14ab-4f05-8e77-08d8ce0ee772
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 21:57:48.2032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //l5Zid1Wnx6gGM+A0WEPWAFSXPsi4og6h7YfQa0kcyHMABy7FyySSY3tAgQ/vLgdKsZrjl9PTewry5LhpnGJnJ5EMK+fXrRwO+QBmXkgP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3867
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/10/21 8:25 AM, Daniel Thompson wrote:
> To the very best of my knowledge there has never been any in-tree
> code that calls this function. It exists largely to support an
> out-of-tree driver that provides kgdb-over-ethernet using the
> netpoll API.


There was another out of tree user of this, but I don't know if
this is still applicable today.  The scenario is around the
ability to use a character sequence when kgdboc is active
on the console such as <control-c>, to cause a break point, vs
using a hardware break over a tty (because not all hardware supported this).

I could send the original patch that implements this along, but
I question if it is needed given the devices out there.  The reason
the original patch existed at all was to deal with some pick serial
hardware.

---- original out of tree patch header ----

Subject: [PATCH] kgdboc, tty: Add the rx polling call back capability

The idea is to allow kgdboc to intercept a <contorol-c> or any other
character of preference to cause breakpoint interrupt which will start
the kgdb interface running on the controlling terminal where the
character was typed.

The default behavior of kgdboc changes such that the control-c will
always generate an entry to kgdb unless the "n" option is used in the
kgdb configuration line. IE: kgdboc=ttyS0,n,115200

In order to make use of the new API, a low level serial driver must
check to see if it should execute the callback function for each
character that it processes.  This is similar to the approach used
with the NET_POLL API's rx_hook.

The only changes to the tty layer introduced by this patch are:
   * Add poll_rx_cb() call back for the low level driver
   * Move the poll_init() into kgdboc and out of tty_find_polling_driv()
   * change poll_init() to accept the rx callback parameter
---
  Documentation/DocBook/kgdb.tmpl  |   46 ++++++++++++++++++++++---
  drivers/tty/serial/kgdboc.c      |   70 ++++++++++++++++++++++++++++++++++++++-
  drivers/tty/serial/serial_core.c |   23 ++++++++++++
  drivers/tty/tty_io.c             |    9 +----
  include/linux/serial_core.h      |    3 +
  include/linux/tty_driver.h       |    3 +
  6 files changed, 139 insertions(+), 15 deletions(-)


-------------------------------------------



> 
> kgdboe has been out-of-tree for more than 10 years and I don't
> recall any serious attempt to upstream it at any point in the last
> five. At this stage it looks better to stop carrying this code in
> the kernel and integrate the code into the out-of-tree driver
> instead.

Because it has no in tree users, it absolutely makes the most
sense to purge this function.

Acked-by: Jason Wessel <jason.wessel@windriver.com>

> 
> The long term trajectory for the kernel looks likely to include
> effort to remove or reduce the use of tasklets (something that has
> also been true for the last 10 years). Thus the main real reason
> for this patch is to make explicit that the in-tree kgdb features
> do not require tasklets.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> 
> Notes:
>      During this cycle two developers have proposed tidying up the
>      DECLARE_TASKLET_OLD() in the debug core. Both threads ended with a
>      suggestion to remove kgdb_schedule_breakpoint() but I don't recall
>      seeing a follow up patch for either thread... so I wrote it myself.
> 
>   include/linux/kgdb.h      |  1 -
>   kernel/debug/debug_core.c | 26 --------------------------
>   2 files changed, 27 deletions(-)
> 
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 0d6cf64c8bb12..0444b44bd156d 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -325,7 +325,6 @@ extern char *kgdb_mem2hex(char *mem, char *buf, int count);
>   extern int kgdb_hex2mem(char *buf, char *mem, int count);
> 
>   extern int kgdb_isremovedbreak(unsigned long addr);
> -extern void kgdb_schedule_breakpoint(void);
>   extern int kgdb_has_hit_break(unsigned long addr);
> 
>   extern int
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 7f22c1c0ffe80..b636d517c02c4 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -119,7 +119,6 @@ static DEFINE_RAW_SPINLOCK(dbg_slave_lock);
>    */
>   static atomic_t			masters_in_kgdb;
>   static atomic_t			slaves_in_kgdb;
> -static atomic_t			kgdb_break_tasklet_var;
>   atomic_t			kgdb_setting_breakpoint;
> 
>   struct task_struct		*kgdb_usethread;
> @@ -1084,31 +1083,6 @@ static void kgdb_unregister_callbacks(void)
>   	}
>   }
> 
> -/*
> - * There are times a tasklet needs to be used vs a compiled in
> - * break point so as to cause an exception outside a kgdb I/O module,
> - * such as is the case with kgdboe, where calling a breakpoint in the
> - * I/O driver itself would be fatal.
> - */
> -static void kgdb_tasklet_bpt(unsigned long ing)
> -{
> -	kgdb_breakpoint();
> -	atomic_set(&kgdb_break_tasklet_var, 0);
> -}
> -
> -static DECLARE_TASKLET_OLD(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
> -
> -void kgdb_schedule_breakpoint(void)
> -{
> -	if (atomic_read(&kgdb_break_tasklet_var) ||
> -		atomic_read(&kgdb_active) != -1 ||
> -		atomic_read(&kgdb_setting_breakpoint))
> -		return;
> -	atomic_inc(&kgdb_break_tasklet_var);
> -	tasklet_schedule(&kgdb_tasklet_breakpoint);
> -}
> -EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
> -
>   /**
>    *	kgdb_register_io_module - register KGDB IO module
>    *	@new_dbg_io_ops: the io ops vector
> 
> base-commit: 19c329f6808995b142b3966301f217c831e7cf31
> prerequisite-patch-id: 6d9085a2ef51882c80a4f13264cd12a14dcceb54
> prerequisite-patch-id: c0a2cb664281d00a6e32867896374a617aafb358
> prerequisite-patch-id: 6bbcef7ce98747090ecb13fd3eda74a241e47249
> prerequisite-patch-id: 8bf7c51993c06ff88809d49ed59cbace3d94604e
> --
> 2.29.2
> 
