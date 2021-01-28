Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF610307C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhA1RRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhA1ROu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:14:50 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63239C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:13:03 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f2so7232665ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EZNHjz8BRDjIZRvQ8bDoVm/1cEKA7sfe9XrZ0bLjwzU=;
        b=KNW4Bm6HriRYnRBhh2r6vDKKyCWzIKFSFZs1fMEGaQBkS4IBW1XWh2DmSpc0DJ/h4S
         U5Z8VlFuOW/QYpCIR0v4It4iim3qBlIsgjAH8J6Nh64cGjUekR3NyofEsybWVvFJxSmw
         etzbvo7gJ0hcGleycUaD5hLZzstTMHD4mmnJ2OV4HLuTHJFgwuxTSbuk8i7tK38sB6Nk
         ch0jtMV8S5zbBUdmYzBoHUKmGMhw2kgGFmTKn+1F6uyqAfyaxg2Nai3yO28IpWLufVJ/
         URO5Ycrp0Y9wmpqpuRXrwhatSB7kO2O0G7POF8rMlwdAcuwYqjCuV0RYUMFg6lkpANBF
         iX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EZNHjz8BRDjIZRvQ8bDoVm/1cEKA7sfe9XrZ0bLjwzU=;
        b=XkO+endVS9kRA7Ndt+yU25xSAno43QUzqjr2j6dir/SsRjvGcLsxxeRCAmBnwPH4N9
         XPUqlTFy2yPAyTbdX+OOKfVeuUg44RWWIXiKGFH5uwJjdiy9HVsKQd3rWPMfhobJvNMm
         3JrPpn7iEMIJGicamLLO+Jq01r3UbzBsY+OIOj9sDFJY2t0barYS0oj2LR5TWM5XUw7t
         fP24BY98XwLzgSUoZZgSSE/CHajxyDMtwmT0u8w4kNZ4u2QqnGERtPKuEo3VbP/xmESt
         oiNhm67jPxGbvNa5cW6FvYkCIIL2eL7HFJUSNJ1P+BN5uGiVZ36qad7u2lVro+SfdNna
         IOoA==
X-Gm-Message-State: AOAM532vzw/ETI0y7cClA8bvxZj31co3EbJb71CqNxmnwKcVP7v2CtMg
        pmJAJm4OQZoluShgal50o5IixFk40Xn8fwwWIT42tsLsOmOOYA==
X-Google-Smtp-Source: ABdhPJzZTY3tFxj0a16af7jp4ahLY90Ogdgl/bpir6/qjDgwPz21mzGnUXLqZ1Adh/fv/Z+pfJ6A0UAVF9JPVWuzBqU=
X-Received: by 2002:a2e:87cb:: with SMTP id v11mr153843ljj.218.1611853981630;
 Thu, 28 Jan 2021 09:13:01 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 28 Jan 2021 11:12:50 -0600
Message-ID: <CAH2r5mu+yZv2W26dhqE2mL1JZfTuK+=8hgLZTv6TVYLwmF8aqA@mail.gmail.com>
Subject: regression in drm_blank.c?
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the last month my logs have been flooded many times a second with:

"nouveau 0000:01:00.0: [drm] *ERROR* crtc 50: Can't calculate
constants, dotclock = 0!"

(see line 641 of drm_vblank.c) which is distracting for debugging all
other kernel problems (since dmesg entries on this system are 99+%
this message).

Am running current kernel ie 5.11-rc5 (although it also was very very
noisty in 5.10), Ubuntu mainline kernel builds, Lenovo P52 Thinkpad
laptop.  Could it be due to one of the more recent changes to
drivers/gpu/drm/drm_vblank.c?

Ideas how to workaround this?

-- 
Thanks,

Steve
