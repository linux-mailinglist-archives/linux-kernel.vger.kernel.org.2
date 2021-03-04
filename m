Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5413032D82C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbhCDQzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:55:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:50044 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238718AbhCDQzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:55:19 -0500
IronPort-SDR: pWZAOHngWH25nAyoyu2X8UVxUH7wSgPIDH0aTmdwUQv/5/JbKp1hlr1Abgb/Foy37NjfLS4vP5
 tiTb5WTNe01A==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="166712476"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="166712476"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 08:53:41 -0800
IronPort-SDR: s5Z30VFK8gVq0YQkVUQ23+yR46psCJF5tzIAwYnqhkLBFxXV9GCNtNfKpRnDgkjmPdcyklVPWT
 chPGT95/3bwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="445795887"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga001.jf.intel.com with SMTP; 04 Mar 2021 08:53:38 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 04 Mar 2021 18:53:37 +0200
Date:   Thu, 4 Mar 2021 18:53:37 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Intel-gfx] [WARNING] v5.12-rc1 in intel_pipe_disable tracepoint
Message-ID: <YEEQkT0DZWyZgvAL@intel.com>
References: <20210301115946.295279c1@gandalf.local.home>
 <YD0ie6qcKBgGgcNW@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YD0ie6qcKBgGgcNW@intel.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 07:20:59PM +0200, Ville Syrjälä wrote:
> On Mon, Mar 01, 2021 at 11:59:46AM -0500, Steven Rostedt wrote:
> > 
> > On my test box with latest v5.12-rc1, running with all trace events
> > enabled, I consistently trigger this warning.
> > 
> > It appears to get triggered by the trace_intel_pipe_disable() code.
> > 
> > -- Steve
> > 
> >  ------------[ cut here ]------------
> >  i915 0000:00:02.0: drm_WARN_ON_ONCE(drm_drv_uses_atomic_modeset(dev))
> >  WARNING: CPU: 7 PID: 1258 at drivers/gpu/drm/drm_vblank.c:728 drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x319/0x330 [drm]
> >  Modules linked in: ebtable_filter ebtables bridge stp llc vsock vmw_vmci ipt_REJECT nf_reject_ipv4 iptable_filter ip6t_REJECT nf_reject_ipv6 xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables snd_hda_codec_hdmi snd_h
> > ek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_hda_codec joydev snd_hwdep intel_rapl_msr snd_hda_core hp_wmi i915 iTCO_wdt snd_seq intel_rapl_common iTCO_vendor_support wmi_bmof sparse_keymap snd_seq_device rfkill snd_pcm x86_pkg_t
> > d_timer i2c_algo_bit drm_kms_helper mei_me intel_powerclamp snd mei soundcore i2c_i801 drm coretemp lpc_ich e1000e kvm_intel i2c_smbus kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel serio_raw ghash_clmulni_intel video tpm_infineon wmi ip_tables
> >  CPU: 7 PID: 1258 Comm: Xorg Tainted: G        W         5.12.0-rc1-test+ #12
> >  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
> >  RIP: 0010:drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x319/0x330 [drm]
> >  Code: 4c 8b 6f 50 4d 85 ed 75 03 4c 8b 2f e8 60 92 45 c2 48 c7 c1 28 a5 3c c0 4c 89 ea 48 c7 c7 15 5a 3c c0 48 89 c6 e8 1f e7 7b c2 <0f> 0b e9 e2 fe ff ff e8 fb 6c 81 c2 66 66 2e 0f 1f 84 00 00 00 00
> >  RSP: 0018:ffffb77580ea7920 EFLAGS: 00010082
> >  RAX: 0000000000000000 RBX: ffff8afe500c0000 RCX: 0000000000000000
> >  RDX: 0000000000000004 RSI: ffffffff833c86b8 RDI: 0000000000000001
> >  RBP: ffffb77580ea7990 R08: 000000700c782173 R09: 0000000000000000
> >  R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
> >  R13: ffff8afe41c7eff0 R14: ffffffffc05e0410 R15: ffff8afe456a2bf8
> >  FS:  00007f8f91869f00(0000) GS:ffff8afe5aa00000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007f9523a6cad0 CR3: 0000000001b78002 CR4: 00000000001706e0
> >  Call Trace:
> >   drm_get_last_vbltimestamp+0xaa/0xc0 [drm]
> >   drm_update_vblank_count+0x90/0x2d0 [drm]
> >   drm_crtc_accurate_vblank_count+0x3e/0xc0 [drm]
> >   intel_crtc_get_vblank_counter+0x43/0x50 [i915]
> >   trace_event_raw_event_intel_pipe_disable+0x87/0x110 [i915]
> >   intel_disable_pipe+0x1a8/0x210 [i915]
> 
> Hmm. Yeah we do vblank_off() before pipe_disable() which wants
> to still grab the frame counter in the tracepoint. I think we
> could reorder those two without causing any problems. Either
> that or we put the tracepoint before vblank_off().
> 
> >   ilk_crtc_disable+0x85/0x390 [i915]
> 
> But this part is confusing me. intel_crtc_get_vblank_counter() is
> only supposed to do drm_crtc_accurate_vblank_count() fallback when
> the hardware lacks a working frame counter, and that should only
> be the case for ancient gen2 or semi-ancient i965gm TV output,
> ilk_crtc_disable() is not the function we should be calling in
> either of those cases.

OK, figured this out. It can happen on any platform due to
never initializing .max_vblank_count for pipes that were
disabled at boot. Also spotted some other issues in this
code that needs fixing. I'll mail out some patches...

-- 
Ville Syrjälä
Intel
