Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68F7446042
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 08:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKEHyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 03:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKEHyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:54:13 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31FC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 00:51:34 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id az37so15571458uab.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=keith-pro.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ql/whxklNbpeT/TF1sL/HqiOGPe6lSTe12O+OSuI+eI=;
        b=ZC+fTHcif2qCPUKFmZfEGF45V0CERSr/dNF+jA7xD0MJifdzBearf+WaW7RH/sQrPo
         fHCd34S+AORFj+Dkgt6zwKqMfMC8erNmIarURCJUcvTpiSkq/ZGOb/nnAXeZ6+50fcCD
         qEEOmZlKo6a7H5sDAPnkabN15gExrJj6vGEnXru04dCBBstCq2zKDx284bbM91OeplUc
         zYUB/8WziFrQoSGp2ZO53RjqmeQQerhgYy8slHZfZ2vDL8jGutD1UoEmq2x65WhX5eRg
         bX1h7PiHLGbNkHCKM7JNDrCvnKubdq6XaXaMsf5ZlCIdFc+WIt6SiAEb3JaGtWA5llZv
         svyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ql/whxklNbpeT/TF1sL/HqiOGPe6lSTe12O+OSuI+eI=;
        b=TD2A781YbnuV2mO/kjBETBC7DCrl2llTaRXrZXt7yU385g0w0tUy+Vy9uIrmVNkj+y
         +vlslepo059yLyXmEmbNEFDb1lNAw6yCIkafO0PEe0Cos5t6rWh/5e4ppR5hWvw1tFCy
         AeQYCcJDJHY9pAb+WUQXB7YREGu/ulVxwkk++zCx5vPH9Z7cXQ4JkUrX0uD3yX+Hd8x2
         ri7mgqICwo/bxthxCBNh3H9hwK1VsrpCUqFSP3cqtsvABYDuiEuwY5yLn7Wemu3+Fv13
         ZYfhEtuHPM4JF1sS8FOVi2kzBZu6fYpNWzprOGH47mLbAO+dBidgnzDOe0zBs4Z03Bv6
         d1og==
X-Gm-Message-State: AOAM533L6ethlMEUzfcmBGOO1SI4YvJ+6Sn3bLk0K2DG8Uy1F6FjWJ4J
        YcBU1eK2hLfGim3pcouMzq60JMBNryqjnH83oRss/N3eXB3hmQ==
X-Google-Smtp-Source: ABdhPJxg6AhFdjliiGvkzCVekgPWhfXHTnAFZSe/aJnTiB+7xNILGvWWg6RoZi00ESyKrQ2mNX38rkXAjDmrgHfXJfA=
X-Received: by 2002:a05:6102:370f:: with SMTP id s15mr10421320vst.5.1636098693561;
 Fri, 05 Nov 2021 00:51:33 -0700 (PDT)
MIME-Version: 1.0
From:   Keith Cancel <admin@keith.pro>
Date:   Fri, 5 Nov 2021 07:51:04 +0000
Message-ID: <CALGQo4Yw7Ptm5faXjyAewW9Xe5=QKC_m9=QMy4Rb0N2p-a3VuQ@mail.gmail.com>
Subject: Intel Alder Lake Question (Scheduler)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

So Alder lake was supposed to have AVX-512 disabled/fused off. So it
looks like that was not the case. For example see this news article:
https://www.anandtech.com/show/17047/the-intel-12th-gen-core-i912900k-review-hybrid-performance-brings-hybrid-complexity/2

This issue I noticed it seems to be the possibility that a bios could
allow someone to enable both AVX-512 and and E-Cores (efficiency
cores). How on earth would the scheduler handle this? I could imagine
the scheduler switching a process/thread using AVX-512 to an
efficiency core. Now suddenly the core the thread/process is running
no longer has AVX-512 instructions... This sounds like a headache.

I suppose the kernel could handle the trap and then from on only
schedule such a process on performance cores. This issue I see here
though is userland process could then intentionally trigger such a
trap to then only be scheduled on a performance core. Even if it does
not use AVX-512 otherwise.

Thanks,
Keith Cancel
