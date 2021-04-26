Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4936B79D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhDZRLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234794AbhDZRLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619457034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LhQebeVb23SzF4/ud2ZKbP179wUrgXncKyn7ZiDLbaE=;
        b=F9lDzO/QCXnV4WN/LsSfdQfZTOGASBxz7ZbVUYHS1SEcTdoaKR1dFJZnM45VCI/ra+yK+T
        sL28Nc5aOuzSaQYi8HVp5n/3yLlkRyDQpjQO8zd/cFrNkzAlh3Erg57a0pxSvWuplq1iHc
        3mZLtuDVQDS6xYAlw1n+cA9w9HL9Znw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-Ld3YN1x3MlSnkzXqr-lx3w-1; Mon, 26 Apr 2021 13:10:30 -0400
X-MC-Unique: Ld3YN1x3MlSnkzXqr-lx3w-1
Received: by mail-qv1-f72.google.com with SMTP id r18-20020a0ccc120000b02901a21aadacfcso21888579qvk.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 10:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=LhQebeVb23SzF4/ud2ZKbP179wUrgXncKyn7ZiDLbaE=;
        b=BqgI99eAknrod/94EeRtR4IbMhv1x64o1wCSUI6zY/akqPeXU2URA39A/Vykp5QmZu
         ISic6tzr1aUEQJ2wWW90rnKgzVm5K2A1n/dlWz0VCQsfpq8IwTJBNWXlhgll7yHuUQ89
         IOC2+QBoGTLmXP1v1ax4s/LQUP6gld8ODxG7ij4Gsa5k0d/4S8CXWQ2rjQ4WAngC/++W
         YKQo/K2yN7a8uLMpLfXGlfRtQnZoP4eACHkUUOUKEkH11t3ynMczCSMOq/XkvdlRUW8R
         J0fxC24zgehU9ejlDfxhVYK2fBtO8rQqDxjae5UszwjH1CgODxwI2vJlwxAwcFJFFOtN
         hasw==
X-Gm-Message-State: AOAM530bEEtG4gR2zEdaM20c8MoICOJxvyD7oYZcgMkw711aCxtdxDYG
        Nsh0zeiLIcTtcSIcMCBd64aYYk5VFw4p7hAGmiiqUlL/tgP/P0ks4/3ZZ4x708ykXBu7t48jw8r
        F3aYSGWR3KWd+yBPsg7GQsu/s
X-Received: by 2002:a05:6214:7e6:: with SMTP id bp6mr18803849qvb.37.1619457030030;
        Mon, 26 Apr 2021 10:10:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/Y87o+qIB8Q2h8dGaccxFuM8RTk/CnrPlsWsSEMfhPVr3ikxYschzkxuOhVJgd3ppsgnzEA==
X-Received: by 2002:a05:6214:7e6:: with SMTP id bp6mr18803828qvb.37.1619457029795;
        Mon, 26 Apr 2021 10:10:29 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 198sm587906qkf.20.2021.04.26.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 10:10:28 -0700 (PDT)
Message-ID: <bd123d91c6323fa7f63140b71df613f40adc4c09.camel@redhat.com>
Subject: Re: [drm/i915/dp]  4a8d79901d:
 WARNING:at_drivers/gpu/drm/i915/display/intel_display_power.c:#assert_can_disable_lcpll[i915]
From:   Lyude Paul <lyude@redhat.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, rui.zhang@intel.com,
        yu.c.chen@intel.com
Date:   Mon, 26 Apr 2021 13:10:27 -0400
In-Reply-To: <20210425005610.GA5251@xsang-OptiPlex-9020>
References: <20210204090229.GH17757@xsang-OptiPlex-9020>
         <b94a605ba4a44e7b45f1ce3d6071dcc7a449e7ac.camel@redhat.com>
         <20210318021320.GA10304@xsang-OptiPlex-9020>
         <90e58cf788299c76b80ec72735ebfd33eef7fffd.camel@redhat.com>
         <e0d2addfb1042baf9cc34b35b1a563656147353f.camel@redhat.com>
         <20210325135342.GA17080@xsang-OptiPlex-9020>
         <3f97d13aab87ca8023f6607b419e3c0f3249871a.camel@redhat.com>
         <20210425005610.GA5251@xsang-OptiPlex-9020>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

glad to hear it, thanks for the update!

On Sun, 2021-04-25 at 08:56 +0800, Oliver Sang wrote:
> hi, Lyude Paul,
> 
> On Fri, Apr 09, 2021 at 04:30:55PM -0400, Lyude Paul wrote:
> > Could you retest this against the latest drm-tip? I pushed something that
> > I
> > think might fix this
> 
> sorry for late.
> we tested on the tip for drm-tip several days ago, confirmed the issue was
> gone.
> 
> the test commit is:
> commit 0d733c1e940857595e3f647dd59bf98c126806c4
> Author:     Ville Syrj<C3><A4>l<C3><A4> <ville.syrjala@linux.intel.com>
> AuthorDate: Wed Apr 21 02:02:02 2021 +0300
> Commit:     Ville Syrj<C3><A4>l<C3><A4> <ville.syrjala@linux.intel.com>
> CommitDate: Wed Apr 21 02:02:02 2021 +0300
> 
>     drm-tip: 2021y-04m-20d-23h-01m-26s UTC integration manifest
> 
> on repo:
> git://anongit.freedesktop.org/drm/drm-tip
> branch: drm-tip
> 
> > 
> > On Thu, 2021-03-25 at 21:53 +0800, Oliver Sang wrote:
> > > Hi, Lyude,
> > > 
> > > On Tue, Mar 23, 2021 at 01:27:29PM -0400, Lyude Paul wrote:
> > > > BTW Oliver - I'm still happy to look at this issue, I just need the
> > > > extra
> > > > logs I
> > > > mentioned below in order to figure out what's going on here
> > > 
> > > I enabled "drm.debug=0x16 log_buf_len=5M" and got attached kmsg.xz for
> > > 4a8d79901d.
> > > hope it's useful.
> > > 
> > > > 
> > > > On Thu, 2021-03-18 at 13:16 -0400, Lyude Paul wrote:
> > > > > Well this is surprising, because I had been pretty sure we had asked
> > > > > someone
> > > > > at
> > > > > Intel to test that this patch worked on samus and they had said that
> > > > > it
> > > > > did. 
> > > > > 
> > > > > Is there any way you can get me the kernel messages from this
> > > > > failure with
> > > > > drm.debug=0x16 log_buf_len=5M added to the kernel commandline? It's
> > > > > hard
> > > > > to
> > > > > see
> > > > > what's actually going on here that's causing this issue to still
> > > > > reoccur.
> > > > > 
> > > > > Also adding Tomi P Sarvela onto this thread, since they were the
> > > > > ones who
> > > > > originally tested this
> > > > > 
> > > > > On Thu, 2021-03-18 at 10:13 +0800, Oliver Sang wrote:
> > > > > > Hi Lyude, sorry for later.
> > > > > > 
> > > > > > before we send out the report, we also tested fe7d52bccab6, the
> > > > > > issue
> > > > > > still
> > > > > > exists on it.
> > > > > > attached one kmsg-fe7d52bccab6.xz FYI.
> > > > > > 
> > > > > > we also tested on latest v5.12-rc3, also exists.
> > > > > > attached kmsg-v5.12-rc3.xz FYI.
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > On Fri, Feb 05, 2021 at 02:53:11PM -0500, Lyude Paul wrote:
> > > > > > > Am I right in assuming this is likely a very delayed test result
> > > > > > > from
> > > > > > > before:
> > > > > > > 
> > > > > > > fe7d52bccab6 ("drm/i915/dp: Don't use DPCD backlights that need
> > > > > > > PWM
> > > > > > > enable/disable")
> > > > > > > 
> > > > > > > Made it into the kernel? I see that there's a PWM being left on,
> > > > > > > which
> > > > > > > was
> > > > > > > the
> > > > > > > same issue we were seeing on fi-bdw-samus
> > > > > > > 
> > > > > > > On Thu, 2021-02-04 at 17:02 +0800, kernel test robot wrote:
> > > > > > > > 
> > > > > > > > Greeting,
> > > > > > > > 
> > > > > > > > FYI, we noticed the following commit (built with gcc-9):
> > > > > > > > 
> > > > > > > > commit: 4a8d79901d5bed0812d272c372aa40282937b50f
> > > > > > > > ("drm/i915/dp:
> > > > > > > > Enable
> > > > > > > > Intel's
> > > > > > > > HDR backlight interface (only SDR for now)")
> > > > > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
> > > > > > > >  mas
> > > > > > > > ter
> > > > > > > > 
> > > > > > > > 
> > > > > > > > in testcase: suspend-stress
> > > > > > > > version: 
> > > > > > > > with following parameters:
> > > > > > > > 
> > > > > > > >         mode: freeze
> > > > > > > >         iterations: 10
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > on test machine: 4 threads Broadwell-Y with 8G memory
> > > > > > > > 
> > > > > > > > caused below changes (please refer to attached dmesg/kmsg for
> > > > > > > > entire
> > > > > > > > log/backtrace):
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > If you fix the issue, kindly add following tag
> > > > > > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > > > > 
> > > > > > > > 
> > > > > > > > kern  :warn  : [   21.137894] ------------[ cut here ]--------
> > > > > > > > ----
> > > > > > > > kern  :warn  : [   21.137897] CPU PWM1 enabled
> > > > > > > > kern  :warn  : [   21.137930] WARNING: CPU: 3 PID: 575 at
> > > > > > > > drivers/gpu/drm/i915/display/intel_display_power.c:4902
> > > > > > > > assert_can_disable_lcpll+0x335/0x3c0 [i915]
> > > > > > > > kern  :warn  : [   21.138084] Modules linked in: sd_mod t10_pi
> > > > > > > > sg
> > > > > > > > x86_pkg_temp_thermal intel_powerclamp i915 hid_rmi rmi_core
> > > > > > > > hid_multitouch
> > > > > > > > coretemp intel_ra
> > > > > > > > pl_msr crct10dif_pclmul wmi_bmof crc32_pclmul intel_gtt
> > > > > > > > crc32c_intel
> > > > > > > > ghash_clmulni_intel rapl drm_kms_helper intel_cstate ahci
> > > > > > > > libahci
> > > > > > > > serio_raw
> > > > > > > > mei_me proces
> > > > > > > > sor_thermal_device intel_uncore processor_thermal_rfim
> > > > > > > > syscopyarea
> > > > > > > > sysfillrect
> > > > > > > > intel_soc_dts_iosf sysimgblt intel_pch_thermal
> > > > > > > > hid_sensor_custom
> > > > > > > > fb_sys_fops
> > > > > > > > li
> > > > > > > > bata bcma processor_thermal_mbox joydev mei drm
> > > > > > > > processor_thermal_rapl
> > > > > > > > intel_rapl_common int340x_thermal_zone i2c_hid ideapad_laptop
> > > > > > > > sparse_keymap
> > > > > > > > wmi rfkill
> > > > > > > > video int3400_thermal acpi_thermal_rel i2c_designware_platform
> > > > > > > > dw_dmac
> > > > > > > > i2c_designware_core acpi_pad ip_tables
> > > > > > > > kern  :warn  : [   21.138148] CPU: 3 PID: 575 Comm:
> > > > > > > > kworker/u8:6
> > > > > > > > Tainted:
> > > > > > > > G        W I       5.11.0-rc2-00745-g4a8d79901d5b #1
> > > > > > > > kern  :warn  : [   21.138153] Hardware name: LENOVO
> > > > > > > > 80HE/VIUU4, BIOS
> > > > > > > > A6CN38WW
> > > > > > > > 09/30/2014
> > > > > > > > kern  :warn  : [   21.138155] Workqueue: events_unbound
> > > > > > > > async_run_entry_fn
> > > > > > > > kern  :warn  : [   21.138161] RIP:
> > > > > > > > 0010:assert_can_disable_lcpll+0x335/0x3c0
> > > > > > > > [i915]
> > > > > > > > kern  :info  : [   21.138263] ahci 0000:00:1f.2:
> > > > > > > > pci_pm_suspend_late+0x0/0x40
> > > > > > > > returned 0 after 0 usecs
> > > > > > > > kern  :warn  : [   21.138296] Code: c0 75 22 e8 8d 61 cb ff e9
> > > > > > > > f3 fd
> > > > > > > > ff
> > > > > > > > ff
> > > > > > > > e8
> > > > > > > > fd bc 6a c1 0f 0b e9 0c fd ff ff e8 f1 bc 6a c1 0f 0b e9 05 fe
> > > > > > > > ff ff
> > > > > > > > e8
> > > > > > > > e5
> > > > > > > > bc
> > > > > > > > 6a c1 <0f> 0b e9 cf fd ff ff e8 d9 bc 6a c1 0f 0b e9 a2 fd ff
> > > > > > > > ff e8
> > > > > > > > cd
> > > > > > > > bc
> > > > > > > > kern  :warn  : [   21.138300] RSP: 0018:ffffc900006f3d58
> > > > > > > > EFLAGS:
> > > > > > > > 00010282
> > > > > > > > kern  :warn  : [   21.138304] RAX: 0000000000000000 RBX:
> > > > > > > > ffff8881451002e8
> > > > > > > > RCX:
> > > > > > > > 0000000000000027
> > > > > > > > kern  :warn  : [   21.138307] RDX: 0000000000000027 RSI:
> > > > > > > > 0000000000000002
> > > > > > > > RDI:
> > > > > > > > ffff888249397cf8
> > > > > > > > kern  :warn  : [   21.138310] RBP: ffff888145100000 R08:
> > > > > > > > ffff888249397cf0
> > > > > > > > R09:
> > > > > > > > ffffc900006f3cf0
> > > > > > > > kern  :warn  : [   21.138313] R10: 0000000000000001 R11:
> > > > > > > > 3030302035313969
> > > > > > > > R12:
> > > > > > > > ffff8881451007f0
> > > > > > > > kern  :warn  : [   21.138316] R13: ffff888145106c60 R14:
> > > > > > > > 0000000000000002
> > > > > > > > R15:
> > > > > > > > 0000000000000000
> > > > > > > > kern  :warn  : [   21.138319] FS:  0000000000000000(0000)
> > > > > > > > GS:ffff888249380000(0000) knlGS:0000000000000000
> > > > > > > > kern  :warn  : [   21.138322] CS:  0010 DS: 0000 ES: 0000 CR0:
> > > > > > > > 0000000080050033
> > > > > > > > kern  :warn  : [   21.138325] CR2: 0000557c22ec68a0 CR3:
> > > > > > > > 0000000004c0a003
> > > > > > > > CR4:
> > > > > > > > 00000000003706e0
> > > > > > > > kern  :warn  : [   21.138329] Call Trace:
> > > > > > > > kern  :warn  : [   21.138334]  hsw_disable_lcpll+0x22/0x280
> > > > > > > > [i915]
> > > > > > > > kern  :warn  : [   21.138479] 
> > > > > > > > i915_drm_suspend_late+0x5e/0x100
> > > > > > > > [i915]
> > > > > > > > kern  :warn  : [   21.138578]  ?
> > > > > > > > pci_pm_poweroff_late+0x40/0x40
> > > > > > > > kern  :warn  : [   21.138582]  dpm_run_callback+0x4c/0x140
> > > > > > > > kern  :warn  : [   21.138590] 
> > > > > > > > __device_suspend_late+0x98/0x1a0
> > > > > > > > kern  :warn  : [   21.138596]  async_suspend_late+0x1b/0xa0
> > > > > > > > kern  :warn  : [   21.138602]  async_run_entry_fn+0x39/0x160
> > > > > > > > kern  :warn  : [   21.138608]  process_one_work+0x1ed/0x3c0
> > > > > > > > kern  :warn  : [   21.138612]  worker_thread+0x50/0x3c0
> > > > > > > > kern  :warn  : [   21.138617]  ? process_one_work+0x3c0/0x3c0
> > > > > > > > kern  :warn  : [   21.138620]  kthread+0x116/0x160
> > > > > > > > kern  :warn  : [   21.138626]  ? kthread_park+0xa0/0xa0
> > > > > > > > kern  :warn  : [   21.138631]  ret_from_fork+0x22/0x30
> > > > > > > > kern  :warn  : [   21.138640] ---[ end trace a93fe4d40a5a37bb
> > > > > > > > ]---
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > To reproduce:
> > > > > > > > 
> > > > > > > >         git clone https://github.com/intel/lkp-tests.git
> > > > > > > >         cd lkp-tests
> > > > > > > >         bin/lkp install job.yaml  # job file is attached in
> > > > > > > > this
> > > > > > > > email
> > > > > > > >         bin/lkp run     job.yaml
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Thanks,
> > > > > > > > Oliver Sang
> > > > > > > > 
> > > > > > > 
> > > > > > > -- 
> > > > > > > Sincerely,
> > > > > > >    Lyude Paul (she/her)
> > > > > > >    Software Engineer at Red Hat
> > > > > > >    
> > > > > > > Note: I deal with a lot of emails and have a lot of bugs on my
> > > > > > > plate.
> > > > > > > If
> > > > > > > you've
> > > > > > > asked me a question, are waiting for a review/merge on a patch,
> > > > > > > etc.
> > > > > > > and I
> > > > > > > haven't responded in a while, please feel free to send me
> > > > > > > another
> > > > > > > email to
> > > > > > > check
> > > > > > > on my status. I don't bite!
> > > > > > > 
> > > > > 
> > > > 
> > > > -- 
> > > > Sincerely,
> > > >    Lyude Paul (she/her)
> > > >    Software Engineer at Red Hat
> > > >    
> > > > Note: I deal with a lot of emails and have a lot of bugs on my plate.
> > > > If
> > > > you've
> > > > asked me a question, are waiting for a review/merge on a patch, etc.
> > > > and I
> > > > haven't responded in a while, please feel free to send me another
> > > > email to
> > > > check
> > > > on my status. I don't bite!
> > > > 
> > 
> > -- 
> > Sincerely,
> >    Lyude Paul (she/her)
> >    Software Engineer at Red Hat
> >    
> > Note: I deal with a lot of emails and have a lot of bugs on my plate. If
> > you've
> > asked me a question, are waiting for a review/merge on a patch, etc. and I
> > haven't responded in a while, please feel free to send me another email to
> > check
> > on my status. I don't bite!
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

