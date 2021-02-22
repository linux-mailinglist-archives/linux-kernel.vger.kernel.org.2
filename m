Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CAB32133C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhBVJib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhBVJiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:38:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF52C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:37:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u14so18320454wri.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=wMCik8OMhKRvlGn7Bn8d2Q4kMtrUNEeYNGZWFYz3tEM=;
        b=HSPHghvo9TAtYjbkPJrhU0lNbF3S3PxaEgT4aSX5mASOSNmB/ez6PG9Na4va9rVe+C
         Mzv0z0Kv8UgGn+wg+3B7x/ZNUYRInSpU62g8vANa+cmtIdj5pJIoYEFcPwULZiw707d7
         y0t6vUXET1NvZeTbS32ipJaZU/UAjLIvK+20U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=wMCik8OMhKRvlGn7Bn8d2Q4kMtrUNEeYNGZWFYz3tEM=;
        b=ILbGqSfXf+1TEBa6RDBlsJtaf9hjxlTZwqZSgsCcqYeKDqE4WmU5ExC8v7AAL0iig1
         o8I4WBzjtanxLT55GW+yFAx749ONIgjJj1AoDsKf23F7xReCnrkNysIc87fj72P2I2wZ
         Ml4owJLE6RgBQvk1eXuaW25R73wCsHW39kQS6pzyhmQTks/Kufk4R9ynHsSJt2KfE+A6
         nlFcQpeegOCEIEn+gkG1GsGJMo37kTJK+fFui7B0jKGk/anPRQ+Gc8XVgLQGEiSy+TjG
         9mIsWd4sdfpLjEVOAZ8F1xguXn3dDeUnu9zuMRlwMCM0M9bFk4Av6Neh1JoTxwvCnE88
         dtiA==
X-Gm-Message-State: AOAM532SEIwmImGa240J+/Is6McoMu1JTIQmFKzD5Di1JmFSAFo7Z6Of
        YsB7MiDMkNOa/ltIaNwr6CTm7A==
X-Google-Smtp-Source: ABdhPJxf4EpB2oHzM6hdAxC1zUf2GYli1mGy4hf8Jirrzeu9oFK9WYMdIUkvVW3QSaWT/7gGPl0dQA==
X-Received: by 2002:a5d:6808:: with SMTP id w8mr18158234wru.290.1613986656449;
        Mon, 22 Feb 2021 01:37:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u8sm25466wmb.36.2021.02.22.01.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 01:37:36 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:37:27 +0100
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PULL] topic/kcmp-kconfig
Message-ID: <YDNrq+mpwta0f0vt@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One patch pull request for you to ponder in the hopefully less stressful
2nd week of the merge window :-)

It's also marked cc: stable so people can stop building kernels that don't
work so well.

topic/kcmp-kconfig-2021-02-22:
kconfig for kcmp syscall

drm userspaces uses this, systemd uses this, makes sense to pull it
out from the checkpoint-restore bundle. Kees reviewed this from
security pov and is happy with the final version.

LWN coverage: https://lwn.net/Articles/845448/

Cheers, Daniel

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/topic/kcmp-kconfig-2021-02-22

for you to fetch changes up to bfe3911a91047557eb0e620f95a370aee6a248c7:

  kcmp: Support selection of SYS_kcmp without CHECKPOINT_RESTORE (2021-02-16 09:59:41 +0100)

----------------------------------------------------------------
kconfig for kcmp syscall

drm userspaces uses this, systemd uses this, makes sense to pull it
out from the checkpoint-restore bundle. Kees reviewed this from
security pov and is happy with the final version.

LWN coverage: https://lwn.net/Articles/845448/

----------------------------------------------------------------
Chris Wilson (1):
      kcmp: Support selection of SYS_kcmp without CHECKPOINT_RESTORE

 drivers/gpu/drm/Kconfig                       |  3 +++
 fs/eventpoll.c                                |  4 ++--
 include/linux/eventpoll.h                     |  2 +-
 init/Kconfig                                  | 11 +++++++++++
 kernel/Makefile                               |  2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c |  2 +-
 6 files changed, 19 insertions(+), 5 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
