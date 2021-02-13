Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D977C31A8E7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 01:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhBMAoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 19:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhBMAoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 19:44:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1A6C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:43:57 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m6so567143pfk.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 16:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dbhUzwqGfG1hKMLbbUj/LjjWuHYf51AvOfJj5/4HJUU=;
        b=lOvDyZuCcqdlGpIpZqJwhKAdJ8v2iA4ozRlURXedM0oL6iIOUvFhraAQSlkyBpqhx5
         httUjscQ3/UM95/G0oBLqe5j5qxsxAJApYykpS3o/b+aNux4jCsg0Hhp4w4X68CAvGZo
         bhaXfGbLFlH+TqiuefsFSxAj9iMMm5ygvA6eyuulXQVvqpYVU0I8a/dkZ3e2T8e66Kem
         fPqXAX9NoXq1dac6LINFPFB5pxtnJV+H58P2Hqe5nxVSSiiQgIfjjNqDeoZPaR2vg04a
         1uJPv+KC0h9T2OjiE0PLBt5DcSFIGdvNuAP3ZUMWEEk/WTSzkAuixeEmTzmvmvUeifz+
         pL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dbhUzwqGfG1hKMLbbUj/LjjWuHYf51AvOfJj5/4HJUU=;
        b=ngxP2QVpRckjvUd3yixqOG1C2caErIyC1GOXujiI5sl7lABT0bT/5VKFy9klfWwf9r
         Z+hDyU/090a6KWRF3Jf1kh79jfg4lpi2bZuzoJZ3AM/n4/noIoN08VOh1AuKh+QujUUo
         HwGSurf3376rlRdSYR8V2/cYylMr1so2KX3dldMXRsrN4adXteBSJJ966rMb3u40TnWq
         aksBNxWfS6nG9BBVUZtgNvMD4hs3u9HgF41rKr8Cw+N0zCULtOi8W/J4Q5Ab4sZ1jHXB
         8ZOW7SFe3tUs9oEilxoDqTmhWf4C5ZvM50iJj2dEDlzb4TJyEWlIv+7mv16bzKOpmFx8
         Gedg==
X-Gm-Message-State: AOAM531295gDvwA406/zPMw4JaI+1k6fU4b+Pj9OvM0Ok91VGjVgkLUS
        qCvyOA0sWRAlQ4+A5ZINZqqMcw==
X-Google-Smtp-Source: ABdhPJzdBhGkqACtkkAi9SNbmD9Ucwde/9QRGP1PUg2zL/AcBwjgqor8b5sJsMl3wBwUtpZjEeQ8Kw==
X-Received: by 2002:a63:1826:: with SMTP id y38mr5577270pgl.252.1613177036325;
        Fri, 12 Feb 2021 16:43:56 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n12sm9230574pff.29.2021.02.12.16.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 16:43:55 -0800 (PST)
Date:   Fri, 12 Feb 2021 16:43:55 -0800 (PST)
X-Google-Original-Date: Fri, 12 Feb 2021 16:43:50 PST (-0800)
Subject:     Re: [PATCH] Revert "dts: phy: add GPIO number and active state used for phy reset"
In-Reply-To: <877dngjdi1.fsf@igel.home>
CC:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        anup@brainfault.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, yash.shah@sifive.com, robh+dt@kernel.org,
        sagar.kadam@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-60c8c9ad-1184-4c41-b2c4-1cf5fe057473@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 04:47:34 PST (-0800), schwab@linux-m68k.org wrote:
> On Feb 04 2021, Palmer Dabbelt wrote:
>
>> From: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> VSC8541 phys need a special reset sequence, which the driver doesn't
>> currentlny support.  As a result enabling the reset via GPIO essentially
>> guarnteees that the device won't work correctly.
>>
>> This reverts commit a0fa9d727043da2238432471e85de0bdb8a8df65.
>>
>> Fixes: a0fa9d727043 ("dts: phy: add GPIO number and active state used for phy reset")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> This fixes ethernet on the HiFive Unleashed with 5.10.12.

Thanks for testing.  Looks like I forgot to reply, but it's in Linus' tree and 
should end up in stable.
