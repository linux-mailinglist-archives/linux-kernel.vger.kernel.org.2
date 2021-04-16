Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F373E362691
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbhDPRUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbhDPRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:20:23 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A89C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:19:58 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b17so23726170ilh.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6e7t6TfWiGQDRdCZmECAbPZ2los9v9aMlAKupjzwxUM=;
        b=jJL1VCySU07RkNPU/y7sIq1rho8Kbaay+P8s2sUhLxdHcIHxy4hegDdJ3Au33EalQD
         7XVEmdaQh8GHpSEMKYC3uk6jfgaA94ASQW+asyqDOjR8Cbz0ErKd3GRSVLHwyCGq5T95
         1nfa3LC/xcASYISfB66rJrEkl75mcmPDelxscE88RcI00x3N0GrzHsZ9KeZppXOBHP/L
         oenwCVWdc3LCBkzisMq6gB+N5O/1zw4Vb1L3yVpFu8mTrlz5X5qc2baXgBtqACDPqGBg
         hSgIskrXAb/hBa6hFCesV5Xq2ZG5LAZ+LJpsVFRzV5bP3GuZzAQ8L//bVVFz0INfPiw9
         xcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6e7t6TfWiGQDRdCZmECAbPZ2los9v9aMlAKupjzwxUM=;
        b=g7xGDX0zM3UTSLP8A/HeKqcSHMpRUSvN0OTE1ekD0UA2vAxMjGHagkhyRe1d6sI2fX
         aXRDuGLFzdH/vva/XxtRICYTZjXgn7olXOYnYcnfPjLPZ89yXN49QUCEx2Hpebw/XVSJ
         zjN6D6Jt2DflSGEdZ77R3HUWDxQgMiia3lCtB+46O08R2IBCy9WbeH8iQfKM+CFkft/t
         HOXrrAe8vpbKjJib382Y7CTUnsaZDpyLUjXcqMAP0dweibPPnn3ccDP3hQAqybGhrRuy
         FzpkrMZWavpcb0nOP7HijMpg6Bi7GnfDNXjvIvGqzlyk3CxDPOg0cQulhbHKG5nImQBK
         0Mhw==
X-Gm-Message-State: AOAM533K7gPUY0D01+bwxf/sRQYY4nb3Hs9s5Zetx4Rz5/3XdRx16H0f
        MeFVL3OIPAsjZd/N8cHtytWu6s+ak17FgI/p+G6oLT9TdfKVRg==
X-Google-Smtp-Source: ABdhPJyM0roxIn+nCrjOTRzI36tQfRmnapRL8yJe9hKwTQO2YCgJ6KCOwAiJYPxf2dTjs7l4oMa/3N7fIYaJAVE9t0k=
X-Received: by 2002:a92:de4e:: with SMTP id e14mr1898299ilr.129.1618593598010;
 Fri, 16 Apr 2021 10:19:58 -0700 (PDT)
MIME-Version: 1.0
From:   Drew Abbott <abbotta4@gmail.com>
Date:   Fri, 16 Apr 2021 13:20:28 -0400
Message-ID: <CALY-g84i=WPVT7OKwKa1xJaORPwMUyjdX0ewqqoVsC2ihbpvtg@mail.gmail.com>
Subject: Page BUGs
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been troubleshooting problems with the vanilla and lts linux kernels
for a couple of weeks now and saw this mailing list in MAINTAINERS for
problems with mm.h; apologies if this is the wrong place to ask. I have
been experiencing many freezes and panics with this hardware:
https://pcpartpicker.com/user/Abbott/saved/#view=wXdgt6
Originally[0], many of the traces referred to cpu idling funcs that seem to
be addressed already[1][2], but now all of the traces refer to problems
with paging[3][4][5][6]. I normally mount a mergerfs filesystem at boot
that I thought was causing the panics[7], but I have since removed that
entry from fstab and can still see paging bugs without that fs (or any
other FUSE fs) mounted[7].
What can I do to keep my computer from freezing and panicking?

Thank you,
Drew Abbott

[0] https://bbs.archlinux.org/viewtopic.php?id=259571
[1] https://bugzilla.kernel.org/show_bug.cgi?id=212087
[2] https://bugzilla.kernel.org/show_bug.cgi?id=212543
[3] https://imgur.com/HT4F7p7
[4] https://imgur.com/pTb4Miu
[5] https://imgur.com/pTb4Miu
[6] https://imgur.com/JVueE3m
[7] http://0x0.st/-ATM.log
