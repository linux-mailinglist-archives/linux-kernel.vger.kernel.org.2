Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D26362116
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244001AbhDPNdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhDPNdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:33:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEC3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:32:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so2115950wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding;
        bh=hrzLya89eEvpFLZLKBl1cD6X0iqxPFh++vX1H4RxaPM=;
        b=KxsQ4CAq0MNzNH+pcQeLYmwQIhyKFLbE9/bbDboSLCN8yc3a3UHmYbYXnSL0PBPseb
         YXxTBITODTzMm8AsFRaxzNXxiQD8LrvI6TIpfnYn+4QcMVXfBLUAy4eYaQslh3TZxmHz
         XsBYQmbpf5VGRlgKTQmKm1adZhCBiks8c4TB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding;
        bh=hrzLya89eEvpFLZLKBl1cD6X0iqxPFh++vX1H4RxaPM=;
        b=eZTWvTdwnL/YWEnRXm0mAUbfONvFqsEy0nYOkRXost1rY45iCs9z6Kr0OOo5D73J3N
         zyhiGhhqd/8/hQNE0nca9lF36vx6prIe8MXuAugjBdyu7TqnaOmhFc5KrRhQN7kRm0Ll
         hJnkBmOPB8UXUzjFH1rWRKcO2qNX1PN9oY60fF72xufUADJU6oOgyntU8A2Zx/a3ZneZ
         wASWFyBLdfOnUN6AotQ8nBGTWKLnXks7iDi1vE2v6T+FJnuGRjeXLrYh4Ya16afmbwUV
         zmPY6D95OKh1P3o/5hsfO1Tk9qq73pgTHkpdfopIvg0QFyn0S31UACsBcXi9tajQ4wkG
         WmQw==
X-Gm-Message-State: AOAM533VM3YJLzEqRZmCwWb1EYM5XY82Tuiok3w2R2q9ZzQW4N2THDAA
        tuJfwEqkWUXZ0fjp6TdLlspoSV5H4UJuaQ==
X-Google-Smtp-Source: ABdhPJwmzzbCUBU42t6ZBV0CVhcp6jfBS0ZYqehStSJBSnQg1xKNnuutuMaagDY5rRm58GclqpHK4A==
X-Received: by 2002:a05:600c:b4b:: with SMTP id k11mr8349064wmr.180.1618579967707;
        Fri, 16 Apr 2021 06:32:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u4sm9967392wml.0.2021.04.16.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 06:32:47 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:32:40 +0200
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PULL] drm-fixes
Message-ID: <YHmR+Gyh/s2sHT2D@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I pinged the usual suspects, only intel fixes pending. drm-next also looks
ready, minus the big pull request summary Dave will have to type next
week.

Cheers, Daniel

drm-fixes-2021-04-16:
drm/i915 fixes

Cheers, Daniel

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-04-16

for you to fetch changes up to 4d2e1288372ccc5ac60290bc10cace49c9bfa6d0:

  Merge tag 'drm-intel-fixes-2021-04-15' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2021-04-15 15:24:17 +0200)

----------------------------------------------------------------
drm/i915 fixes

----------------------------------------------------------------
Daniel Vetter (1):
      Merge tag 'drm-intel-fixes-2021-04-15' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Hans de Goede (1):
      drm/i915/display/vlv_dsi: Do not skip panel_pwr_cycle_delay when disabling the panel

Lyude Paul (1):
      drm/i915/dpcd_bl: Don't try vesa interface unless specified by VBT

Ville Syrjälä (1):
      drm/i915: Don't zero out the Y plane's watermarks

 drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 1 -
 drivers/gpu/drm/i915/display/vlv_dsi.c                | 4 ++--
 drivers/gpu/drm/i915/intel_pm.c                       | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
