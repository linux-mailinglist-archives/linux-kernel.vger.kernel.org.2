Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD53DDE4F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhHBRRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhHBRRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:17:15 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6E1C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 10:17:04 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u10so24895621oiw.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XNmEhCYcavH8lUjF07r3laSZ11ZJHK1QVVxu5abkP1M=;
        b=TAL5Vdu+3qZZCRpP6g1+EmXLtetQl+wHhdkwpxsT+/fxPP6sJMH1Op+C3Ogsp5Jvwe
         qo5HznHDkKYo/uMBDKRWYsMV2JEx/PER4p3xMmU7pgvErWbBbRcBsi0B0OcI+piKnJAG
         KXs4zksTeKoQX3tFmDMRfPh4eaIMSiC2Vh5KXBo9cqFWkENxcpUnMUEH92byjofJsHtB
         yPe+FUW3C5CJiUhH3t7QmNGFUtvGOLroKgr5aabx1se/421I9qvEo5rUC7FP1QsgyoUB
         1DUNWij1xA4AbusIobhtWbBZXITS4zLM1f1SbUZ6PeOu+0zI0M6PKsRPbuaqtj+Gqzc1
         4roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XNmEhCYcavH8lUjF07r3laSZ11ZJHK1QVVxu5abkP1M=;
        b=JaqMUu0cWBrE9kyF7FubRv032en/6APqx06hTV6vdLy4+KB/FMRVbyPg4A/dxP8WL8
         bOPGfcaZ8TDkgSvCc7n3RW5XcY+oHmqh09PAHkBQ3n0EGCV3WrLZH/9bfQ7wRYacGgfd
         BT6OlQHQUFVzVwtIeqfw++kwREjd5K3v8mjS259LqFD6f8636fVM4T4nSGraQEfV0TCz
         1/dy0+NZ7A7LyANsZ3UUffB5rTFJikSGhm4hbiWk53GbQ4/dwQ+rUXBGd+iesMGMb0bz
         lZAhmYHiRlNVpPzKBZa/K+nBmS0q4Vs9/ywTLFW3zXMtFC2XCQ9CkaoL0vzFB1VdVD9d
         OMBw==
X-Gm-Message-State: AOAM5312YSWHqJ4twlhdXY05uDl995sDEQuniQNHnIRn4rX4ovIINzwm
        IgvDMvVwk7YjVSjqJNMK1jaePgJrVoNnrxQkH3CyX2gHonSoeA==
X-Google-Smtp-Source: ABdhPJz0ojc6DeWSvEDLNdpEWqUoNSiP9Bq90/S4qeCahoGj+1KUQMcRa6S+Ji4G5PJDkMs0LeWCBpPJw/xdRUnR3Lc=
X-Received: by 2002:a05:6808:1304:: with SMTP id y4mr11638385oiv.40.1627924623710;
 Mon, 02 Aug 2021 10:17:03 -0700 (PDT)
MIME-Version: 1.0
From:   Mikael Pettersson <mikpelinux@gmail.com>
Date:   Mon, 2 Aug 2021 19:16:52 +0200
Message-ID: <CAM43=SNDAcS952MZpsiD2Z-WU9Bd0EPv=7Z86i7FGdvDtsSXdQ@mail.gmail.com>
Subject: [BISECTED] 5.14.0-rc4 broke drm/ttm when !CONFIG_DEBUG_FS
To:     Linux Kernel list <linux-kernel@vger.kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting 5.14.0-rc4 on my box with Radeon graphics breaks with

[drm:radeon_ttm_init [radeon]] *ERROR* failed initializing buffer
object driver(-19).
radeon 0000:01:00.0: Fatal error during GPU init

after which the screen goes black for the rest of kernel boot and
early user-space init.
Once the console login shows up the screen is in some legacy low-res
mode and Xorg can't be started.

A git bisect between v5.14-rc3 (good) and v5.14-rc4 (bad) identified

# first bad commit: [69de4421bb4c103ef42a32bafc596e23918c106f]
drm/ttm: Initialize debugfs from ttm_global_init()

Reverting that from 5.14.0-rc4 gives me a working kernel again.

Note that I have
# CONFIG_DEBUG_FS is not set

/Mikael
