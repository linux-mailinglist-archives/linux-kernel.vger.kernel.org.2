Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1D34B3BA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 03:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhC0CTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 22:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhC0CSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 22:18:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD41C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 19:18:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s11so5484pfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 19:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=OXIpHAYAomHcQCpYYm35sv6RjEQLcSDixenL0TOMv+I=;
        b=CM4VwHHkgkadZxlCw5EznSyplK4473qNZIF3gAAogfM5v1SYeKvFv7+NboTHeECHHU
         q+tex5YEc+sGopa4tu9cSFQDsQsyGLs+Rr75Kwh44cewlIHNWJtypr2Xuc+6IPS4u6zD
         FuyyfumS/FufPjJJyyFQBv0E0dQM0Lw1PtQbyLmo0zZcpTYsA1rbGVKiv5Tv+1x0/q/7
         jZUSV0rbPQUFkmxyy4yLQe8hbtvYP8aM9435H8fZEtsrrjgoWx8+CURWur/zLnh9yDic
         OqUJGYJPSwfW1JYtUPzkoacjWlAJShBXQloFS3Hs9v2JTI4uRjA3j48dFb3ogVKhnwsQ
         HkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=OXIpHAYAomHcQCpYYm35sv6RjEQLcSDixenL0TOMv+I=;
        b=R/Cx7VA+7P0uaYQoI/oZ3ruHMczf8vZkU8pgI8BbL1hRdq8dfh+xpqJPke6X1ey9cj
         IQafgvc0bMVV5LVqjai+THmJLZVTaTLRnz4hTWLNubqyDkzN6jF06BoaiZXZI8uch8St
         XQjpUsr9fpo1gQ4nB3CvkibCVDAxqw6+tdLGnTnH+Oh+bSVhduwZhF6SnKXgbpohRzhA
         RaHErfiS62EmGPqqGYoqeg/cOmUve6it3l5c0uiaMzYtb4puQWankopGQ8Q90xL2ztIY
         AaBstL8Cf4AmfFcIVXbW3tKrTrwD2pr5XrcVOmDJzEExJTtWhphISEsKZhS+6ZKkb268
         0r2Q==
X-Gm-Message-State: AOAM532fL5aYKg8IpUGcr7i8tUoLFn3uZbCyrGNaBXlziormfpgK7wWM
        rXowY8sEnqf730U/nQqhC2JUGRFXQXqUsg==
X-Google-Smtp-Source: ABdhPJw8AOPnwMpS6MxJBgAET8TFZ3xF7nl6QwZmWKyLpaJL21DpNqK3R1Wpz8VbVrcPjDWeTRYMmQ==
X-Received: by 2002:aa7:91d1:0:b029:1fe:2a02:73b9 with SMTP id z17-20020aa791d10000b02901fe2a0273b9mr15594497pfa.2.1616811529683;
        Fri, 26 Mar 2021 19:18:49 -0700 (PDT)
Received: from ?IPv6:2601:648:c100:2aa0:a0f4:2914:dbfc:d1e3? ([2601:648:c100:2aa0:a0f4:2914:dbfc:d1e3])
        by smtp.gmail.com with ESMTPSA id y8sm10180557pge.56.2021.03.26.19.18.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 19:18:49 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Logan Devine <bbhclinux@gmail.com>
Subject: arch/x86/kvm/hyperv.c failing to compile: frame size of 1048 bytes is
 larger than 1024 bytes
Message-ID: <5932e10b-b890-c48a-3ab6-abe93ef97721@gmail.com>
Date:   Fri, 26 Mar 2021 19:18:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling the kernel for the second time, and now kvm/hyperv.c is 
failing to build:


   AR      kernel/built-in.a
   CC [M]  arch/x86/kvm/ioapic.o
   CC [M]  arch/x86/kvm/irq_comm.o
   CC [M]  arch/x86/kvm/cpuid.o
   CC [M]  arch/x86/kvm/pmu.o
   CC [M]  arch/x86/kvm/mtrr.o
   CC [M]  arch/x86/kvm/hyperv.o
   CC [M]  arch/x86/kvm/debugfs.o
   CC [M]  arch/x86/kvm/mmu/mmu.o
   CC [M]  arch/x86/kvm/mmu/page_track.o
arch/x86/kvm/hyperv.c: In function ‘kvm_hv_send_ipi.isra’:
arch/x86/kvm/hyperv.c:1799:1: error: the frame size of 1048 bytes is 
larger than 1024 bytes [-Werror=frame-larger-than=]
  1799 | }
       | ^
   CC [M]  arch/x86/kvm/mmu/spte.o
   CC [M]  arch/x86/kvm/mmu/tdp_iter.o
   CC [M]  arch/x86/kvm/mmu/tdp_mmu.o
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:271: arch/x86/kvm/hyperv.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [scripts/Makefile.build:514: arch/x86/kvm] Error 2
make: *** [Makefile:1851: arch/x86] Error 2
   CC [M]  kernel/kheaders.o


(Sorry if I did this wrong, it's my first time on the list.)


I'm on gregkh/staging branch staging-testing.

