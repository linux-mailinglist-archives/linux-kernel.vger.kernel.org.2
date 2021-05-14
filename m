Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB63809A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhENMfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhENMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:35:49 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5B5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 05:34:37 -0700 (PDT)
Received: from localhost (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 388E6A7F2E9;
        Fri, 14 May 2021 14:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1620995672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4vwJiGTh6ElCKYC/wP6uUt98bvM4B8L74svpei6Ju4s=;
        b=k4P0PRaU0pOt6NoAaXdArjthun1X5Z3xm0J1NP99QO/kCvs7gH1yjGmb+kD3/UPVsnEPt0
        i524R6BXymUAbd3WqekM3GGLRvv1td6RiAvViZTPemp6ph4IkukuqsnjhA+G5TSxVEcWmM
        uBtPbYE483kRT7/HYynefUDrEIeOnvE=
Date:   Fri, 14 May 2021 14:34:31 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Thomas Stein <himbeere@meine-oma.de>
Cc:     linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: thinkpad x1 carbon display flickering after update to 5.12. good
 on 5.11.x (i915)
Message-ID: <20210514123431.fqvaa437zlw7rq7j@spock.localdomain>
References: <1a6cf0a3dc8a2c6364265ad7249b76b1@meine-oma.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a6cf0a3dc8a2c6364265ad7249b76b1@meine-oma.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Fri, May 14, 2021 at 10:24:26AM +0200, Thomas Stein wrote:
> After upgrading to linux 5.12 the display on my X1 Carbon Gen 2 starts to
> flicker. Well actually it seems to turn off and on again and again. Here a
> link to a video a person posted who has the same issue as me obviousely. https://linuxove.com/thinkpad-x1-carbon-gen-3-display-flickering-on-linux-kernel-5-12/
> 
> This happens without having Xorg running too. So it can't be related to
> Xorg. The kernel boots and after a few seconds, the kernel messages scoll
> through, the flickering starts. Nothing special in dmesg.
> 
> dmesg:
> 
> himbeere@rather ~ $ dmesg | grep i915
> [    0.713595] i915 0000:00:02.0: vgaarb: deactivate vga console
> [    0.720280] i915 0000:00:02.0: vgaarb: changed VGA decodes:
> olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    0.741494] i915 0000:00:02.0: [drm] Panel advertises DPCD backlight
> support, but VBT disagrees. If your backlight controls don't work try
> booting with i915.enable_dpcd_backlight=1. If your machine needs this,
> please file a _new_ bug report on drm/i915, see
> https://gitlab.freedesktop.org/drm/intel/-/wikis/How-to-file-i915-bugs for
> details.
> [    1.864837] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on
> minor 0
> [    1.875907] fbcon: i915drmfb (fb0) is primary device
> [    3.158255] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> himbeere@rather ~ $
> 
> Downgrading to 5.11 solves the issue for me. Any ideas?

Does [1] fix your issue?

[1] https://cgit.freedesktop.org/drm-tip/patch/?id=acca7762eb71bc05a8f28d29320d193150051f79

-- 
  Oleksandr Natalenko (post-factum)
