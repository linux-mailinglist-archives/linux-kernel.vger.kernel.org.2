Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE46636BE44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 06:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhD0EWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhD0EV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:21:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2259C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:21:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m7so55844243ljp.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 21:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WeYIezeq9LP89AlalP0LLaMFaw16N/VsQnjle/dgM24=;
        b=RVvMsIMyTg3VZ/Spz98Vb6H1Bzxh4h8UHy8RX/ce1/BfsSXWlHtlr0cIY2fyDzxvdK
         xwACmwxC+vrzM8yXLnXxSYoIeGUFCC0g9aR/wgaZsp7SG6wTbL31cRJ8I1in3aIEBmh6
         O91Wz9Iha+uvl/K6CS0YLgXBaHB/3SjGnhvJIwsyNW2ntBiLlCkAe9+i7MU54MaLOQjM
         82fC9y+0xWQNJ6bur57RwraDcnuyBi3usQA40s3xR2bk90pbfDOHMLE/U7mJK8MK7Osk
         jcL/szgljgzNdhb9UjlrJpAmCWOo7xi2BJFJF5ZXirI38qNq2bt+UKvV/61J8d+M/jIv
         Nzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WeYIezeq9LP89AlalP0LLaMFaw16N/VsQnjle/dgM24=;
        b=XWfCXAjo4lrMSK3ngERVH+gE9V0n2wld0kVeovwC4RNRmKJ3tau18XVSTjOKFeKf5H
         FBMMBP84FJoxns4Fc1P5Rs88MHCaJ7C/a5Smf5jFDvgxr1sMpiSPZ/Oxw6UpE0iPZE6+
         BwFn1p2gPNbBuf85/aLqtgYaZk0191CfYEXW9zYOi3bhtMOm5SwlhSVlwPecjomyyaUX
         lZFKia2gDNtrL4a1tYAkCPhqR9y88rKvzzn7DGWEQFjMhd+IMPhVLfEjQ/I+B6cSn3ob
         fNe4YUWY9vFKulYegb94KrEqHKWcDQC6aVEex3NIlSBunSj1BCtm8d8pf5A55WaUtVSm
         MJ+w==
X-Gm-Message-State: AOAM532vxEtd9M9Jheod7MyJAz27EIc4cgzUyPccif4b6XQfNIGhKxSB
        rYhEUzhVhRma3Q14z4hMfvALJJ3r5+kYyf5i5dc/KlnDH2o=
X-Google-Smtp-Source: ABdhPJxQ6oG1O/ph0ud3z/gr9xGMtffuQrrd6PnFnA7rlw22Ps/GY/SV2acOCfzvEWMv7mo0zzFfoNL4ovnHlcBXqjY=
X-Received: by 2002:a2e:720f:: with SMTP id n15mr15008611ljc.400.1619497275002;
 Mon, 26 Apr 2021 21:21:15 -0700 (PDT)
MIME-Version: 1.0
From:   sainath grandhi <saiallforums@gmail.com>
Date:   Mon, 26 Apr 2021 21:21:04 -0700
Message-ID: <CABqzqi41dV2J9V1k12r2RGt-wM8+3EZnWZsBhazQ1rosXRD4+A@mail.gmail.com>
Subject: Question on poll interface in Linux
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Looking for some guidance on using poll interfaces in Linux
We have a scenario where userspace has to wait on an interrupt from
the device. Inclined towards using poll interface on a file descriptor
in the userspace. When the device driver executes the interrupt
handler, it notifies the file descriptor and wakes up the Userspace
thread. Userspace thread reads the interrupt reason and handles the
reason.

I am afraid we have a scenario where we could lose notification from
kernel to Userspace thread if an interrupt happens during the time
window between 2 and 3 steps in the sequence below

1. Userspace thread is woken up
2. Userspace thread read the interrupt reason and handle the interrupt reason
3. Userspace thread goes back to blocked state again for next notification

Brief search on the Linux source code tells me that the kernel notify
function will wake up only a sleeping thread. So if the new interrupt
happens between steps 2 and 3, and the state of Userspace thread is
active, the kernel would not "notify" the Userspace thread and the
Userspace processing of new interrupt is missed.

In such scenarios, what is the best kernel-user notification interface
to use? Please advise
