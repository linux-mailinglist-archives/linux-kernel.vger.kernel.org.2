Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE892311193
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhBESNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:13:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233381AbhBESMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612554807;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GBqis/XImlxAXRai9BNdloDkDFvNDVn4n6xKv4Vk5U=;
        b=C4VyOP/PjN8XORBcn9EWCoHWY/WVYavsxGi5WuSi19N98Jnp4IxDDgGJN6J0rGhXJcRRUc
        ZDbwemssTIHz0aSPbMa13USKW+XgMUu0k7+t5m9j0eTc5bRizSPaQHhrSOP55j82E0Dgw/
        M8bryqaKB489NVyMGVSm542XcDQ3bWk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-8zAkCSBiO1i8GEbHOciVAw-1; Fri, 05 Feb 2021 14:53:25 -0500
X-MC-Unique: 8zAkCSBiO1i8GEbHOciVAw-1
Received: by mail-qt1-f199.google.com with SMTP id m21so6072429qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 11:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=+GBqis/XImlxAXRai9BNdloDkDFvNDVn4n6xKv4Vk5U=;
        b=RgiWcXIEOoCgiVjMGCdgdrZKVR5z1KJfHiFbhnmH7ZE5mV6k3gNjlpViyPQ4ijK1TN
         7JwVW68SVY+qegJi1yrVd4PxnFMtOqQnP9Cy8X1MDp3A3oB2C75Rk1CCsu1YR3sgSsos
         g55mgsOh9U035mgQN+5WA1Zmdt3k8k1NssoK3lyogUvIXMxDuTfWWXVxLgpcIGMiYQDE
         WdVcymspDN59YR70lv0VZJ3SaeFF/nqMKqeSh3gkVPLPLmt1Sp7lmUCp9ZwqNwcRBhHG
         WbAw+GdiEjkEYaklw78t7Td7X4DNh03QaZNG2AXJheLUkBXTZN4Jf74fJJHRm1Mf93zZ
         zy/A==
X-Gm-Message-State: AOAM531J/tawYjrti9wD5ZmSC4XFkxiq33u86JylD12Ooj6HV9sc38g8
        V3pBJ/3NpwG10Bs1HC8ML4rHjx0er5VkZOmgNq2YOUibkxu34ntbyTCDtKBVs8JEeJGBsyVtPzT
        Ncs8K9dwXtvx180RZu2aSnaYP
X-Received: by 2002:a37:bcd:: with SMTP id 196mr6100273qkl.494.1612554803259;
        Fri, 05 Feb 2021 11:53:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwVBQtDA9v20k1GVE2BtsR1ZHj/9Q/MIA6TfA63zf4i9dHBzKwaWnDMqaZJas0bOcLnDdMq8w==
X-Received: by 2002:a37:bcd:: with SMTP id 196mr6099825qkl.494.1612554794450;
        Fri, 05 Feb 2021 11:53:14 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id p75sm10524063qke.82.2021.02.05.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 11:53:13 -0800 (PST)
Message-ID: <b94a605ba4a44e7b45f1ce3d6071dcc7a449e7ac.camel@redhat.com>
Subject: Re: [drm/i915/dp]  4a8d79901d:
 WARNING:at_drivers/gpu/drm/i915/display/intel_display_power.c:#assert_can_disable_lcpll[i915]
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, rui.zhang@intel.com,
        yu.c.chen@intel.com
Date:   Fri, 05 Feb 2021 14:53:11 -0500
In-Reply-To: <20210204090229.GH17757@xsang-OptiPlex-9020>
References: <20210204090229.GH17757@xsang-OptiPlex-9020>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am I right in assuming this is likely a very delayed test result from before:

fe7d52bccab6 ("drm/i915/dp: Don't use DPCD backlights that need PWM
enable/disable")

Made it into the kernel? I see that there's a PWM being left on, which was the
same issue we were seeing on fi-bdw-samus

On Thu, 2021-02-04 at 17:02 +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 4a8d79901d5bed0812d272c372aa40282937b50f ("drm/i915/dp: Enable Intel's
> HDR backlight interface (only SDR for now)")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 
> in testcase: suspend-stress
> version: 
> with following parameters:
> 
>         mode: freeze
>         iterations: 10
> 
> 
> 
> on test machine: 4 threads Broadwell-Y with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> kern  :warn  : [   21.137894] ------------[ cut here ]------------
> kern  :warn  : [   21.137897] CPU PWM1 enabled
> kern  :warn  : [   21.137930] WARNING: CPU: 3 PID: 575 at
> drivers/gpu/drm/i915/display/intel_display_power.c:4902
> assert_can_disable_lcpll+0x335/0x3c0 [i915]
> kern  :warn  : [   21.138084] Modules linked in: sd_mod t10_pi sg
> x86_pkg_temp_thermal intel_powerclamp i915 hid_rmi rmi_core hid_multitouch
> coretemp intel_ra
> pl_msr crct10dif_pclmul wmi_bmof crc32_pclmul intel_gtt crc32c_intel
> ghash_clmulni_intel rapl drm_kms_helper intel_cstate ahci libahci serio_raw
> mei_me proces
> sor_thermal_device intel_uncore processor_thermal_rfim syscopyarea sysfillrect
> intel_soc_dts_iosf sysimgblt intel_pch_thermal hid_sensor_custom fb_sys_fops
> li
> bata bcma processor_thermal_mbox joydev mei drm processor_thermal_rapl
> intel_rapl_common int340x_thermal_zone i2c_hid ideapad_laptop sparse_keymap
> wmi rfkill
> video int3400_thermal acpi_thermal_rel i2c_designware_platform dw_dmac
> i2c_designware_core acpi_pad ip_tables
> kern  :warn  : [   21.138148] CPU: 3 PID: 575 Comm: kworker/u8:6 Tainted:
> G        W I       5.11.0-rc2-00745-g4a8d79901d5b #1
> kern  :warn  : [   21.138153] Hardware name: LENOVO 80HE/VIUU4, BIOS A6CN38WW
> 09/30/2014
> kern  :warn  : [   21.138155] Workqueue: events_unbound async_run_entry_fn
> kern  :warn  : [   21.138161] RIP: 0010:assert_can_disable_lcpll+0x335/0x3c0
> [i915]
> kern  :info  : [   21.138263] ahci 0000:00:1f.2: pci_pm_suspend_late+0x0/0x40
> returned 0 after 0 usecs
> kern  :warn  : [   21.138296] Code: c0 75 22 e8 8d 61 cb ff e9 f3 fd ff ff e8
> fd bc 6a c1 0f 0b e9 0c fd ff ff e8 f1 bc 6a c1 0f 0b e9 05 fe ff ff e8 e5 bc
> 6a c1 <0f> 0b e9 cf fd ff ff e8 d9 bc 6a c1 0f 0b e9 a2 fd ff ff e8 cd bc
> kern  :warn  : [   21.138300] RSP: 0018:ffffc900006f3d58 EFLAGS: 00010282
> kern  :warn  : [   21.138304] RAX: 0000000000000000 RBX: ffff8881451002e8 RCX:
> 0000000000000027
> kern  :warn  : [   21.138307] RDX: 0000000000000027 RSI: 0000000000000002 RDI:
> ffff888249397cf8
> kern  :warn  : [   21.138310] RBP: ffff888145100000 R08: ffff888249397cf0 R09:
> ffffc900006f3cf0
> kern  :warn  : [   21.138313] R10: 0000000000000001 R11: 3030302035313969 R12:
> ffff8881451007f0
> kern  :warn  : [   21.138316] R13: ffff888145106c60 R14: 0000000000000002 R15:
> 0000000000000000
> kern  :warn  : [   21.138319] FS:  0000000000000000(0000)
> GS:ffff888249380000(0000) knlGS:0000000000000000
> kern  :warn  : [   21.138322] CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> kern  :warn  : [   21.138325] CR2: 0000557c22ec68a0 CR3: 0000000004c0a003 CR4:
> 00000000003706e0
> kern  :warn  : [   21.138329] Call Trace:
> kern  :warn  : [   21.138334]  hsw_disable_lcpll+0x22/0x280 [i915]
> kern  :warn  : [   21.138479]  i915_drm_suspend_late+0x5e/0x100 [i915]
> kern  :warn  : [   21.138578]  ? pci_pm_poweroff_late+0x40/0x40
> kern  :warn  : [   21.138582]  dpm_run_callback+0x4c/0x140
> kern  :warn  : [   21.138590]  __device_suspend_late+0x98/0x1a0
> kern  :warn  : [   21.138596]  async_suspend_late+0x1b/0xa0
> kern  :warn  : [   21.138602]  async_run_entry_fn+0x39/0x160
> kern  :warn  : [   21.138608]  process_one_work+0x1ed/0x3c0
> kern  :warn  : [   21.138612]  worker_thread+0x50/0x3c0
> kern  :warn  : [   21.138617]  ? process_one_work+0x3c0/0x3c0
> kern  :warn  : [   21.138620]  kthread+0x116/0x160
> kern  :warn  : [   21.138626]  ? kthread_park+0xa0/0xa0
> kern  :warn  : [   21.138631]  ret_from_fork+0x22/0x30
> kern  :warn  : [   21.138640] ---[ end trace a93fe4d40a5a37bb ]---
> 
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 
> 
> Thanks,
> Oliver Sang
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

