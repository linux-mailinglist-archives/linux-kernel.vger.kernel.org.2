Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44F144B3BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbhKIUJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:09:39 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:34318 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241827AbhKIUJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:09:38 -0500
Received: by mail-pl1-f176.google.com with SMTP id r5so639634pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qM0it/Joiu/Pg54IrxtysWeHDwiRHoa6OI2Dc7WUbkw=;
        b=h//hQJBsskUJOYiYg2xALpr/DiwAmft5ntAtOsS+0NLrmzbyq3ilCo09Gg6AC4B9MR
         GwPGLQOG1RpAfo6XPIuG8yFl2Z6rJQ/KUbafVH3/J2iV3Oh8jiQJIaJRAh/gJKHbeAIo
         j8sidMStw65mTRrdeg2o188UTeDctlwAJjec76MSc7L3li02gTJKDtZAM9dQDeKGWKRw
         5/rcAdvKQBOZKMfnAls5fm6ewEbZcyPBhNv67so7HzDlUB1UJg/Ot2MjVKSb7/Q8imx/
         0XAccFVByVUKklPV4uCHcU+Y6vl87ceGsaLfvsQSbkFOHddacxvDV3XgVxz9SxHmfLKW
         kfdg==
X-Gm-Message-State: AOAM530PlQMBb72nKerR3XqEAk/rK8ldMP1aWFZX2+xKeic7xaERST/T
        NHzupFmEBR281Jph3qdtkpo=
X-Google-Smtp-Source: ABdhPJwiXmwRwd6EcY2rhfLWuxqbUXwrvRK6Z4u75zd4PVZF1TX39gv4EIb+3Xc/8N/iDJ38AkrPlg==
X-Received: by 2002:a17:902:be0f:b0:13a:19b6:6870 with SMTP id r15-20020a170902be0f00b0013a19b66870mr10159496pls.64.1636488411967;
        Tue, 09 Nov 2021 12:06:51 -0800 (PST)
Received: from sultan-box.localdomain ([199.116.118.235])
        by smtp.gmail.com with ESMTPSA id j7sm6274538pfc.74.2021.11.09.12.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:06:51 -0800 (PST)
Date:   Tue, 9 Nov 2021 12:06:48 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Ben Segall <bsegall@google.com>,
        Colin Cross <ccross@android.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: printk deadlock due to double lock attempt on current CPU's runqueue
Message-ID: <YYrU2PdmdNkulWSM@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I encountered a printk deadlock on 5.13 which appears to still affect the latest
kernel. The deadlock occurs due to printk being used while having the current
CPU's runqueue locked, and the underlying framebuffer console attempting to lock
the same runqueue when printk tries to flush the log buffer.

Here's the backtrace corresponding to the deadlock, with some notes I've added:
-----------------------8<-----------------------
  PID: 0      TASK: ffff888100d832c0  CPU: 11  COMMAND: "swapper/11"
      [exception RIP: native_halt+22]
      RIP: ffffffff8320eb97  RSP: ffffc900005b8540  RFLAGS: 00000002
      RAX: 0000000000000001  RBX: ffff88821c534280  RCX: ffffed10438a6850
      RDX: 0000000000000000  RSI: 0000000000000003  RDI: ffff88821c534280
      RBP: 0000000000000003   R8: 0000000000000001   R9: ffffffff81302973
      R10: ffff88821c534280  R11: ffffed10438a6850  R12: ffff88821c535080
      R13: ffff88825c0b32c0  R14: 0000000000000000  R15: ffff88821c534280
      CS: 0010  SS: 0018
   #0 [ffffc900005b8540] kvm_wait at ffffffff81125cc1
   #1 [ffffc900005b8558] pv_wait_head_or_lock at ffffffff8130294a
   #2 [ffffc900005b8580] __pv_queued_spin_lock_slowpath at ffffffff81302d2e
   #3 [ffffc900005b8600] do_raw_spin_lock at ffffffff81303a33
   #4 [ffffc900005b8668] _raw_spin_lock at ffffffff8320f118     <-- ***DEADLOCK***
   #5 [ffffc900005b8680] ttwu_queue at ffffffff8125cff9         <-- tries to lock this CPU's runqueue again...
   #6 [ffffc900005b86f8] try_to_wake_up at ffffffff8125d778
   #7 [ffffc900005b8780] wake_up_process at ffffffff8125d924
   #8 [ffffc900005b8788] wake_up_worker at ffffffff8121268b
   #9 [ffffc900005b8798] insert_work at ffffffff812199aa
  #10 [ffffc900005b87d0] __queue_work at ffffffff8121dcde
  #11 [ffffc900005b8810] queue_work_on at ffffffff8121e1ca
  #12 [ffffc900005b8838] drm_fb_helper_damage at ffffffffc079b0a0 [drm_kms_helper]
  #13 [ffffc900005b8878] drm_fb_helper_sys_imageblit at ffffffffc079b613 [drm_kms_helper]
  #14 [ffffc900005b88a8] drm_fbdev_fb_imageblit at ffffffffc079b9e1 [drm_kms_helper]
  #15 [ffffc900005b88c0] soft_cursor at ffffffff8236ffc9
  #16 [ffffc900005b8928] bit_cursor at ffffffff8236f207
  #17 [ffffc900005b8a50] fbcon_cursor at ffffffff82362c0f
  #18 [ffffc900005b8a88] hide_cursor at ffffffff8253be1c
  #19 [ffffc900005b8aa0] vt_console_print at ffffffff82543094
  #20 [ffffc900005b8af0] call_console_drivers at ffffffff81319b32
  #21 [ffffc900005b8b30] console_unlock at ffffffff8131bd50
  #22 [ffffc900005b8c68] vprintk_emit at ffffffff8131e0f5
  #23 [ffffc900005b8ca8] vprintk_default at ffffffff8131e4ff
  #24 [ffffc900005b8cb0] vprintk at ffffffff8131eee6
  #25 [ffffc900005b8cd0] printk at ffffffff81318ce0
  #26 [ffffc900005b8d78] __warn_printk at ffffffff811c7b9d
  #27 [ffffc900005b8e28] enqueue_task_fair at ffffffff8129774a  <-- SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
  #28 [ffffc900005b8ec0] activate_task at ffffffff8125625d
  #29 [ffffc900005b8ef0] ttwu_do_activate at ffffffff81257943
  #30 [ffffc900005b8f28] sched_ttwu_pending at ffffffff8125c71f <-- locks this CPU's runqueue
  #31 [ffffc900005b8fa0] flush_smp_call_function_queue at ffffffff813c6833
  #32 [ffffc900005b8fd8] generic_smp_call_function_single_interrupt at ffffffff813c7f58
  #33 [ffffc900005b8fe0] __sysvec_call_function_single at ffffffff810f1456
  #34 [ffffc900005b8ff0] sysvec_call_function_single at ffffffff831ec1bc
  --- <IRQ stack> ---
  #35 [ffffc9000019fda8] sysvec_call_function_single at ffffffff831ec1bc
      RIP: ffffffff831ed06e  RSP: ffffed10438a6a49  RFLAGS: 00000001
      RAX: ffff888100d832c0  RBX: 0000000000000000  RCX: 1ffff92000033fd7
      RDX: 0000000000000000  RSI: ffff888100d832c0  RDI: ffffed10438a6a49
      RBP: ffffffff831ec166   R8: dffffc0000000000   R9: 0000000000000000
      R10: ffffffff83400e22  R11: 0000000000000000  R12: ffffffff831ed83e
      R13: 0000000000000000  R14: ffffc9000019fde8  R15: ffffffff814d4d9d
      ORIG_RAX: ffff88821c53524b  CS: 0001  SS: ef073a2
  WARNING: possibly bogus exception frame
----------------------->8-----------------------

The catalyst is that CONFIG_SCHED_DEBUG is enabled and the tmp_alone_branch
assertion fails (Peter, is this bad?). The current CPU's runqueue is locked when
the warning is printed, and then drm_fb_helper_damage() triggers the deadlock
when it tries to schedule a worker and thus attempts to re-lock the runqueue.

I'm not sure what the *correct* solution is here (don't use printk while having
a runqueue locked? don't use schedule_work() from the fbcon path? tell printk
to use one of its lock-less backends?), so I've cc'd all the relevant folks.

Thanks,
Sultan
