Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FC1329DD3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444097AbhCBCja convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Mar 2021 21:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242570AbhCATyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 14:54:04 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0AFF65368;
        Mon,  1 Mar 2021 17:54:14 +0000 (UTC)
Date:   Mon, 1 Mar 2021 12:54:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [WARNING] v5.12-rc1 in intel_pipe_disable tracepoint
Message-ID: <20210301125413.70c5a424@gandalf.local.home>
In-Reply-To: <YD0ie6qcKBgGgcNW@intel.com>
References: <20210301115946.295279c1@gandalf.local.home>
        <YD0ie6qcKBgGgcNW@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 19:20:59 +0200
Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:


> >   ilk_crtc_disable+0x85/0x390 [i915]  
> 
> But this part is confusing me. intel_crtc_get_vblank_counter() is
> only supposed to do drm_crtc_accurate_vblank_count() fallback when
> the hardware lacks a working frame counter, and that should only
> be the case for ancient gen2 or semi-ancient i965gm TV output,
> ilk_crtc_disable() is not the function we should be calling in
> either of those cases.
> 
> What hardware do you have?
> 

According to "lspci -vvv"

00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v2/3rd Gen Core processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
        DeviceName:  Onboard VGA
        Subsystem: Hewlett-Packard Company Device 339a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=4M]
        Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
        Region 4: I/O ports at f000 [size=64]
        Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee20004  Data: 0022
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a4] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: i915
        Kernel modules: i915

Note, this is a dev box that is only connected to a KVM and I haven't
connected to it outside of ssh in years.

-- Steve
