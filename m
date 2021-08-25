Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC66D3F6E86
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhHYEmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 00:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHYEmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:42:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF832C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:41:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso3298061wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Hkj0iEzvJVmpDDmw2s6nIXy6t9+ke4R1JhjfvVlmw3s=;
        b=ZxqnNHLpa/sGtKdMmPnddKko86HWgvFF8N3ksfiJesSp+zhpQdSlzn647Fhu9k1Qyi
         9oFOgkksZFEG86wSzKIBLlrCsdvj3O5skDw1TORjL9y1YE9tPrqfZ3i9lpEhi/D/H+gN
         L3imMKNHQm12y1Z4cwI8CbYOEhM0lASmXjKggrAFkCk2G6Mb2OE4P/+tW57S9edvw3bA
         ZjRxBGTkZd8R7o87jhRmdTl6KUIzkDOIRNqHskO1S0iIauJbQG+XkfTUcd7pOKI8ABzj
         1dAXAUCs4c4Mwd8TTnTuyMc8fSEN3JqU4V2x95+zVjbNjqiyLjKv9xLqg1E5Y9JO1uN5
         669w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=Hkj0iEzvJVmpDDmw2s6nIXy6t9+ke4R1JhjfvVlmw3s=;
        b=Gx0uMgMcYCmPUK2VlVaxzPVdyigR1efVcQCAZT1kP8mDcW/0I7IMV1hdrO7d3JIHBB
         UG0zNn9OAegC3B4KeVj1/N0vTSf8fDUZ18uIDoO/waufnH/Q09IwbA8kzlv9rzEweD/f
         KbI9Pxxkj9cXu8JXOBBT/uyzrvKhyJrjexr6YZL3mDxiDwd2fco4NDQVjEgozk5d1q40
         80HoGvRAJaYuKgsaM7I6r26T+R/G3N2cUC7Yf8TLZh0Ds3w+0dV/QUI6CVOUkTrCoZPI
         wgf7tJ5dvwIjMCPpngPW94oXXFJCGm7jJgdIvpm6ro5tbm7N2g2XMa1fA2DL+sR1AP74
         ExTw==
X-Gm-Message-State: AOAM531AbC53S6eArKmnrb2WWjnz8IBtEUhDmKnpBLur3Mgen9JAn6HZ
        1k0xWL+Cs5U7SfeHKQ7XDX0=
X-Google-Smtp-Source: ABdhPJxh30lNNdUfu+vVzYnZbkqMkVv5232q0YegIYvfvIeKcmGhZ442KtU7zuimx0VnK+xt641xXA==
X-Received: by 2002:a1c:7702:: with SMTP id t2mr880571wmi.121.1629866496533;
        Tue, 24 Aug 2021 21:41:36 -0700 (PDT)
Received: from localhost.localdomain ([92.206.20.83])
        by smtp.gmail.com with ESMTPSA id f18sm4124638wmc.6.2021.08.24.21.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 21:41:36 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Fix 'make allmodconfig' build
Date:   Wed, 25 Aug 2021 06:41:30 +0200
Message-Id: <20210825044130.14795-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <8784.1629857764@turing-police>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 24 Aug 2021 22:16:04 -0400 "Valdis Klētnieks" <valdis.kletnieks@vt.edu> wrote:

> On Tue, 24 Aug 2021 09:14:30 -0000, SeongJae Park said:
> 
> > > > ERROR: modpost: "cpu_scale" [drivers/cpufreq/qcom-cpufreq-hw.ko] undefined!
> > >
> > > That's a different patch, am working on fixing that one now..
> >
> > I didn't take a deep look here, so I unsure if this is an appropriate fix, but
> > I was able to work-around this issue for my use case with below change.
> >
> 
> >  DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> > +EXPORT_PER_CPU_SYMBOL_GPL(cpu_scale);
> 
> Aha.  That's the part I wasn't finding.  Would you like to submit your patch,
> or shall I send it in with a "Suggested-by" for you?

I'd prefer 'Suggested-by', as I didn't take a deep look here.

Suggested-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SJ
