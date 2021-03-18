Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B2C340978
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhCRP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:59:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:55330 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231726AbhCRP7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:59:47 -0400
IronPort-SDR: ur8YZ1z2EdF3WXwdSMXPVteqBWki5Ui2jcqGpBoN29M7E0sdiB//QdwZtLC5uLIx4blLPjnZJk
 XfrmI2ZPPJ6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169634314"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="169634314"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 08:59:45 -0700
IronPort-SDR: twXGXCDyrFuWJMDyNKaRrG8z9VPKKXx07Vr7J+bExRSsvd3MxnEMjI2xdasK5+v9nQ1BVeHO/b
 OGU4Gjw/lIcg==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="413137430"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.142.35]) ([10.249.142.35])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 08:59:44 -0700
Subject: Re: [PATCH][RESEND] Revert "PM: ACPI: reboot: Use S5 for reboot"
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <b8db79e6857c41dab4ef08bdf826ea7c47e3bafc.1615947283.git.josef@toxicpanda.com>
 <CAAd53p5Vh_+tUeEQx3xf_aLiCiKP1u5Y3VgYCUzZ82Kgtr-iYw@mail.gmail.com>
 <bebcaffc-d485-912d-0c42-c0781f9c7603@toxicpanda.com>
 <CAAd53p7eJk9EtMTLjB5i7RdoKA3WS1W4TRjQs08adi7iAux_jQ@mail.gmail.com>
 <78dfcd55-442d-dcc0-c37f-5576f65f91b5@toxicpanda.com>
 <CAAd53p6Lp8+S0yjWi=MikQJ_zywiWamUS5p19oKoqB6uYW8jzg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <03dba78e-4271-ac60-3d7f-a07924735049@intel.com>
Date:   Thu, 18 Mar 2021 16:59:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAd53p6Lp8+S0yjWi=MikQJ_zywiWamUS5p19oKoqB6uYW8jzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/2021 6:42 AM, Kai-Heng Feng wrote:
> On Thu, Mar 18, 2021 at 1:25 AM Josef Bacik <josef@toxicpanda.com> wrote:
> [snipped]
>> "shutdown now" works fine with and without your patch.  Thanks,
> Rafael,
> Please revert the patch while we are working on it.

Done, thanks!


> Josef,
> Can you please test the following patch:
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index eb1b15850761..263444a3fb38 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -233,6 +233,15 @@ void migrate_to_reboot_cpu(void)
>          set_cpus_allowed_ptr(current, cpumask_of(cpu));
>   }
>
> +static void kernel_shutdown_prepare(enum system_states state)
> +{
> +       blocking_notifier_call_chain(&reboot_notifier_list,
> +               (state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
> +       system_state = state;
> +       usermodehelper_disable();
> +       device_shutdown();
> +}
> +
>   /**
>    *     kernel_restart - reboot the system
>    *     @cmd: pointer to buffer containing command to execute for restart
> @@ -243,7 +252,7 @@ void migrate_to_reboot_cpu(void)
>    */
>   void kernel_restart(char *cmd)
>   {
> -       kernel_restart_prepare(cmd);
> +       kernel_shutdown_prepare(SYSTEM_POWER_OFF);
>          if (pm_power_off_prepare)
>                  pm_power_off_prepare();
>          migrate_to_reboot_cpu();
> @@ -257,14 +266,6 @@ void kernel_restart(char *cmd)
>   }
>   EXPORT_SYMBOL_GPL(kernel_restart);
>
> -static void kernel_shutdown_prepare(enum system_states state)
> -{
> -       blocking_notifier_call_chain(&reboot_notifier_list,
> -               (state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
> -       system_state = state;
> -       usermodehelper_disable();
> -       device_shutdown();
> -}
>   /**
>    *     kernel_halt - halt the system
>    *
>
>> Josef


