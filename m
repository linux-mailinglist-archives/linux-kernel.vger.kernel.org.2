Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEBD307E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhA1Sy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:54:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:5650 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232596AbhA1SwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:52:17 -0500
IronPort-SDR: JEPUnOtOPZVwglaFeN9jY1RTw/TrIjKbQYejRklWPeEBCvnrUaUCMsX9dQv9V4woMf57hbvYtp
 GbOZngsE4Y2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="159464520"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="159464520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 10:50:05 -0800
IronPort-SDR: ZDYtK5zINq59RqmmhpdHKlSKybeGQ3sXCDCl261ndYRPxzt4QmZBKhMF0yTaDPwKM+6SXmMvHH
 HRWX6yLZlO8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="357541050"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga006.jf.intel.com with SMTP; 28 Jan 2021 10:50:03 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 28 Jan 2021 20:50:02 +0200
Date:   Thu, 28 Jan 2021 20:50:02 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: regression in drm_blank.c?
Message-ID: <YBMHWg9Bx0UEthe3@intel.com>
References: <CAH2r5mu+yZv2W26dhqE2mL1JZfTuK+=8hgLZTv6TVYLwmF8aqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mu+yZv2W26dhqE2mL1JZfTuK+=8hgLZTv6TVYLwmF8aqA@mail.gmail.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:12:50AM -0600, Steve French wrote:
> For the last month my logs have been flooded many times a second with:
> 
> "nouveau 0000:01:00.0: [drm] *ERROR* crtc 50: Can't calculate
> constants, dotclock = 0!"

Would indicate someone has a bogus adjusted_mode in their state struct.
Assuming this is one of those atomic nouveaus of course. No idea what
goes on with any of the older(?) stuff.

Sadly it's an error and not a WARN so we don't get a backtrace to
see who is calling it.

The only related changes around the atomic helpers I remember were
commit 441959ebc905 ("drm/atomic-helper: Remove the timestamping constant update from drm_atomic_helper_update_legacy_modeset_state()")
commit 4b31a9c77bf8 ("drm/atomic-helper: Extract drm_atomic_helper_calc_timestamping_constants()")
but those should be a nop for nouveau.

So no idea really. I'd suggest changing it to a WARN to see where it's
coming from and then adding more debugs to figure out why the mode
is garbage.

> 
> (see line 641 of drm_vblank.c) which is distracting for debugging all
> other kernel problems (since dmesg entries on this system are 99+%
> this message).
> 
> Am running current kernel ie 5.11-rc5 (although it also was very very
> noisty in 5.10), Ubuntu mainline kernel builds, Lenovo P52 Thinkpad
> laptop.  Could it be due to one of the more recent changes to
> drivers/gpu/drm/drm_vblank.c?
> 
> Ideas how to workaround this?
> 
> -- 
> Thanks,
> 
> Steve

-- 
Ville Syrjälä
Intel
