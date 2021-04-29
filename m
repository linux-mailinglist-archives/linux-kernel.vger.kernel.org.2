Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48C736E450
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 06:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbhD2EsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 00:48:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57501 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2Er5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:47:57 -0400
Received: from mail-oo1-f70.google.com ([209.85.161.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chris.chiu@canonical.com>)
        id 1lbyZy-0007St-9O
        for linux-kernel@vger.kernel.org; Thu, 29 Apr 2021 04:47:10 +0000
Received: by mail-oo1-f70.google.com with SMTP id 126-20020a4a17840000b02901e5e0ccc28aso18750073ooe.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rRim53UzJWgVMkdOW0b/+ZBSUNTOdVPMyNPZwfBxAPo=;
        b=L77psbNKlebF71VUA10x50QBC9g+X4kzucjQtrAZuZ50r7MCpLEBlQ1g7/u27gmH0A
         Ibu2Kg8nmvBIqm294NrDmn12+c/dOTs0lBle3DxHB88w2ipgpHk67mVdwdcgEVSKGcLB
         agYz6owCrai94qPNGvzbRXMWVe118uygZ3vpZNY/4TjP8/8a2a+mgpjfoqtroCM6oBD3
         meYyeZGHMcawKeSmKWB5P12wY/379XQQoj27R3poSPmURUGl0HHZcQq62AcQ3PhH8eIR
         l4ukQpAGHyFGiCDFjZ/wYNL8dewZN4iO56m3veNx8Swh97/Ynuz6WGRJyow2v5JVrDu2
         MlLg==
X-Gm-Message-State: AOAM530cbs2/Ok5IHfdvQVjbHMajZESPWGfNlup9RQO4+j0nNM8pYacI
        h5SbPo/J6f4a5iAtSIvW77wiyRoZQgceOGrUc67bIv2tj4b071unrTXebj+GE+TCkvcEgiXjYsg
        mKLrvR4S+Iw5UNewjIv+jfC+mJ+/10S9wjFu503xwKPvO0dq4pnIsHonsLQ==
X-Received: by 2002:aca:3d86:: with SMTP id k128mr5603683oia.86.1619671629101;
        Wed, 28 Apr 2021 21:47:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqdMpxb8MWKz1tOE3sKrkJg5plm8nWbqA9fYdsOBpP6o5Ws798cfd23tiJN70JL2O/48OnzYTMqiwUxSqj8FI=
X-Received: by 2002:aca:3d86:: with SMTP id k128mr5603660oia.86.1619671628872;
 Wed, 28 Apr 2021 21:47:08 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chiu <chris.chiu@canonical.com>
Date:   Thu, 29 Apr 2021 12:46:58 +0800
Message-ID: <CABTNMG1TRbAW+ULs9Ss27owvxppf-dA=F7M0vGp1EtHwDcK51w@mail.gmail.com>
Subject: TGL: : No video output on external monitor after unplug and re-plug
 the cable
To:     imre.deak@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found another bug after the fix of
https://gitlab.freedesktop.org/drm/intel/-/issues/2538. The external
monitor is also connected via WD19's HDMI/DisplayPort just as #2538.
However, the display monitor can only be detected and show output at
the very first time we power on the WD19 dock. If we unplug the cable
and replug again, the monitor seems to be detected but there's no
video output.

When we power on the WD19 dock with cable connected to the monitor,
the drm kernel log shows as follows

 i915 0000:00:02.0: [drm:intel_get_hpd_pins.isra.0 [i915]] hotplug
event received, stat 0x00010000, dig 0x0088888a, pins 0x00000200, long
0x00000200
 i915 0000:00:02.0: [drm:intel_hpd_irq_handler [i915]] digital hpd on
[ENCODER:292:DDI D] - long
 i915 0000:00:02.0: [drm:intel_hpd_irq_handler [i915]] Received HPD
interrupt on PIN 9 - cnt: 10
 i915 0000:00:02.0: [drm:intel_dp_hpd_pulse [i915]] got hpd irq on
[ENCODER:292:DDI D] - long
 i915 0000:00:02.0: [drm:i915_hotplug_work_func [i915]] running
encoder hotplug functions
 i915 0000:00:02.0: [drm:i915_hotplug_work_func [i915]] Connector DP-1
(pin 9) received hotplug event. (retry 0)
 i915 0000:00:02.0: [drm:intel_dp_detect [i915]] [CONNECTOR:293:DP-1]
 i915 0000:00:02.0: [drm:intel_power_well_enable [i915]] enabling TC cold off
 i915 0000:00:02.0: [drm:tgl_tc_cold_request [i915]] TC cold block succeeded
 i915 0000:00:02.0: [drm:__intel_tc_port_lock [i915]] Port D/TC#1: TC
port mode reset (tbt-alt -> dp-alt)
 i915 0000:00:02.0: [drm:intel_power_well_enable [i915]] enabling AUX D TC1
 i915 0000:00:02.0: [drm:drm_dp_dpcd_read [drm_kms_helper]] AUX D/port
D: 0xf0000 AUX -> (ret=  8) 14 1e 40 55 02 00 00 00
 i915 0000:00:02.0: [drm:intel_dp_lttpr_init [i915]] LTTPR common
capabilities: 14 1e 40 55 02 00 00 00

Then I replug the cable, the intel_power_well_enable() in
intel_dp_aux_xfer() shows "enabling DC off" power domain instead of
enabling AUX D TC1. After that, the flooded i915 0000:00:02.0:
[drm:intel_dp_aux_xfer [i915]] AUX D/port D: timeout (status
0x7d4003ff) keeps show up and no video output.

I filed a bug on
https://gitlab.freedesktop.org/drm/intel/-/issues/3407 and also
uploaded the journal log  with kernel boot parameter
"drm.debug=0x10e".

Can anyone suggest what happens at the replug? What can we do to
identify the cause? Thanks

Chris
