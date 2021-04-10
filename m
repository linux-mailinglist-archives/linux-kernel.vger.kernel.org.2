Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66935AC99
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhDJJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhDJJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:57:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894D6C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:57:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sd23so3731272ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=sender:from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=7S9q0YHwnnTroMuG465VKDIH1I2S+LS70kyJQrdJvBE=;
        b=C255EywfRLks3GdA5bzqxhfR5GanjHOyPPzzpU7W/waJY52tweAlxgftLa06eKkrhv
         ltkkfrH8w/NHIM8iUpf9qOiG0vNux9HobdS2/QOxQj+d7/SJI1fEUIpNq6s81FWi3hV8
         qsrfHygwYMi9TXInlEDThkCi3DoeYezs2uG90iCnQPSNpzR7R76VkFKKp1hy5TJnTLuC
         R8PMD669KyuC/JmIyLmOlz16CV3CcxIDb3SuLGgVr01gUYEHgPId1H8wffS9v+2hER/r
         MsOlU3Hpmt0DOj/82vngQtfkNaYSYUGGKt032DNXmoKAYKtBhbRTjghDbc82InsMqAEg
         GusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=7S9q0YHwnnTroMuG465VKDIH1I2S+LS70kyJQrdJvBE=;
        b=KHzdNqQbMCRHw1HGaVbdkCfY1FJ4W3Ofd7pXOkWhgh5Sf66DsgI66KeWMcsAqvw7Dk
         7TWmpzALOwfb3OHloI5TAe1h+M15cfc9g6YOCVGgqXSwgSEv/mz3Id7BK+DjYXGphlO8
         Rg4ufpwe+nnBncNqhsnjbKFAR0djrQ4rxe+HMb6gec4eQrGzHU0GVxW5ZzgChsgu6gYe
         OPvv6LCgi4Si7tEsnb+H1BVd6QW/vCsKGDulbQMC3wkx0UaA0n3uChb5MFX2XzfuKTwO
         UGeMeQe6nrAfcYAGCHENSs01VjpQ6UIwTgg8g/F+MVk8lmR4CP0tWmb77xLG8284Nydi
         el3w==
X-Gm-Message-State: AOAM531skandT7kR6NvpNkXKIHt/FzTcUX76YthNxobFa0MJhGqTxxjP
        Q4czi+8s4nfarmHKfpGI9x77+ADmflmBlw==
X-Google-Smtp-Source: ABdhPJyYWO6QO81O2S3Cwy+wjZGvdGMD2VKuByTj1gFiMNbUqayvetBQ1hNQ0d8XaODyJvlCk7tzDQ==
X-Received: by 2002:a17:907:3c08:: with SMTP id gh8mr5943546ejc.439.1618048635459;
        Sat, 10 Apr 2021 02:57:15 -0700 (PDT)
Received: from ?IPv6:2001:16b8:20ac:ce11:c250:6a0c:6a8:28a1? (200116b820acce11c2506a0c06a828a1.dip.versatel-1u1.de. [2001:16b8:20ac:ce11:c250:6a0c:6a8:28a1])
        by smtp.gmail.com with ESMTPSA id gt26sm1632328ejb.31.2021.04.10.02.57.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 02:57:15 -0700 (PDT)
Sender: Malte Deiseroth <mdeiseroth88@googlemail.com>
From:   Malte Deiseroth <msdeiseroth@gmx.net>
X-Google-Original-From: Malte Deiseroth <mdeiseroth88@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Cant resume from sleep on 5.12-rcx regression?
Message-ID: <5af07598-6baf-1228-b4d5-f9e87cabb43d@gmail.com>
Date:   Sat, 10 Apr 2021 11:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys.

I think, maybe I found a regression in 5.12.

TLDK: Screen stays black after resume from sleep on kernel 5.12-rcx but 
not on 5.11.12


I compiler a 5.11.12 and a 5.12-rc6 Kernel on my  Ubuntu 20.10 T480 
Laptop. With the 5.11.12 kernel I can safely boot and put the laptop 
into sleep by closing its lid. Up on opening, everything works fine. 
However with the 5.12-rc6 (I also tested on rc2 and r4) I can not do 
this. After sleeping, the laptop wakes up, but the screen stays black. I 
can still ssh into the machine and it works, but I also cant open any 
ttys. I tried to gather some logs or any kind of information, but I 
don't really know what I'm searching for.

My setup might be slightly out of the ordinary, as I have an dm-crypt 
encrypted filesystem with an encrypted swap partition.

I hope I'm not wasting anyone's time here, but from what I understand 
about kernel development this should not happen.


All the best

Malte Deiseroth

