Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005223B7872
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhF2TSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 15:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhF2TSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:18:09 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD8C061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 12:15:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id r20so16967304qtp.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=hHxgr0mrPWLXjFG/R6cpZEYimEXFUGiQWGJT6Wj4ipU=;
        b=ZufjOGLeP345ZUv3Bo/2BAgLWQrfzZJ+FahDfsH2xIwD/n3YrwE3GSmK4xxEdFjEbe
         c/8xXMWnTuOzlrJCRAmBj4L70GYh33zm9pqnc564/2cxNWM2HCh0Pqj+ac0aPbNYDE4k
         yHAodOAU9rvOFS+dNnaSl0DPXOwIsN4HwTeXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=hHxgr0mrPWLXjFG/R6cpZEYimEXFUGiQWGJT6Wj4ipU=;
        b=juboG92B5xZdAeUzB5tNN7zwBCIzRDqq9z0a8K/Q+OKfcSXu72iSYLLp6/32bKnykz
         KIK3mx5TYhl4cu4Zuixx5TRaiI5SfooMcZgBbrJXAb2sFh+yhu+ujBp70JS4jC8QWlEL
         rjN62Q5c/1uKrTeTuPkcrAs+biPLJ0oWtTvum6sflrGv4jkdwrNO0dbg0oYDnda3rNGG
         Fi73xtPl2aB+oJLn6uSejBey1AL4MpDsdnRszozbaMQPlBMjUcM81uiUfO7/kVk9CiXt
         LxNPh/SnVSuVHeMjF58z7zvGz/ysk+f8hNw/JMszIf0nno66xWUUZDBAvuaBjxRQFFht
         0wgg==
X-Gm-Message-State: AOAM5331imJfZO5qfMqvLqG8oB1a+EHsbABeCt4J3PROvscGosicBrCT
        guhNfgchGJ/79xtF/uGDZVxDJzF7vpPNGQ==
X-Google-Smtp-Source: ABdhPJw6Y8UZvv3cOLyYnyz6fXVG6cKa78pxCIgUA6y7jJCDgbOA1LvPHSGxCIhn+cmZ7QKSFgVN/w==
X-Received: by 2002:ac8:584f:: with SMTP id h15mr28268174qth.362.1624994139783;
        Tue, 29 Jun 2021 12:15:39 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id m18sm4344625qtk.91.2021.06.29.12.15.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 12:15:39 -0700 (PDT)
Date:   Tue, 29 Jun 2021 15:15:37 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: linux.dev email accounts for kernel developers
Message-ID: <20210629191537.7kow6vupolahi5it@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all:

A few weeks ago we announced that we'll be providing linux.dev accounts for
kernel developers that need access to a mailbox that is well suited for
patch-based email workflows. During the beta stage, this service was only
available to people listed in MAINTAINERS (which was intentionally very
narrow, to make sure that we test the service before making it more widely
available), but we are now ready to extend it to a wider audience.

You are invited to apply if you fit the following criteria:

- you're a developer with an established history of contributions to the kernel
- your current mail situation is not well-suited for sending/reviewing patches

This is not intended to be a vanity address, so please do not apply if you do
not actually need it. Linux.dev mailboxes come with daily send/receive
limitations (read the doc linked below), so if you are able to use a free
service like gmail, then I assure you that you don't need a linux.dev account.

(Also, if you're paid to work on Linux by your employer, check their policy on
which email address you are allowed to use for DCO purposes before you apply.)

For the rest of the details and for information on how to apply, please see
the following document:

https://korg.docs.kernel.org/linuxdev.html

Best regards,
-K
