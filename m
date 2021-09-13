Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045CB409BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346258AbhIMSEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346246AbhIMSDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:03:49 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32077C0613D8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:02:28 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u18so10242140pgf.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cYi40BkhVJV1s9UwCAK3qxpR0NPFRGQvgiD+V+l72EI=;
        b=DK2QdqG7X/jo8MfX6deH5O283TNqMeHOgykZvBWPfzHG/gw76BT6V+Y9s98hsSQL3r
         ZS5Z0vLgEamLVCfOFY9Aey4EPtaU0cGVMqincoNRQWgGtPWhUAbzV8QJOMfJsw7X0NNH
         U0f5RH47k7UbiQDrlXtmn90vI5u8vnjXer5UlqPhOESh8nAEWrYDuGsqOXVGSMITk8Rd
         TGOalCq33sDquYxkVmTwbVkJJzdPxMmVr8pMFvRCyGBTvtsKuUOUOOtXp1QuBpSy/Rm0
         azPiElKSWKwyt5vJYEZAbipgNlYpeWe9cxH0P54MUm1VyacgM3/lb8/62RHNe5Ynw1nu
         rGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cYi40BkhVJV1s9UwCAK3qxpR0NPFRGQvgiD+V+l72EI=;
        b=3m/jNvw8NQAIplV/xhgEGxRc/Lad2AVSVUdZ7mPnTud4g6Epi+KKS+b5vzqrwdNmF3
         VcOmyDi+kwZLwnuLG/4ap/fni/9BfwpEneBkyKfxkF3A7Z2qBt5gyb7H1V/4VOwtmmyp
         GGJ5JnRDteIpMd8lxo4k7A4WSnd9wGoyGYJqFp6jXzhA5nRYdgw08cAEzyjhNX2ZGLv4
         052GURVt7WhJ7tDbmkPhczvDJMYJcoZgR37opknCHTvLzfuTfnvMcEfLKcJQ+QD9QgRq
         Wl77ZUdcZDU4JaS8DWTIsSkoYZmrgjitbIkc3gyIvWOlnFXNgflgpjtmq1PPYlQQ+Sr0
         nXBA==
X-Gm-Message-State: AOAM5300tdbV0JBaP+GcF+z3BQZthJHMaYpzJnQFF4z5YGR3PnFEizCf
        clb1rfqzb5+EGOi3KKZHk+A=
X-Google-Smtp-Source: ABdhPJwa2AwNce+2oet4bU2Lr50vJJ0m7h9o2hu3CxK78LBxeFgC5tnEjy0g3QoHxE6VsgwISzoMnw==
X-Received: by 2002:a63:1259:: with SMTP id 25mr12268930pgs.48.1631556147639;
        Mon, 13 Sep 2021 11:02:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id r2sm9321578pgn.8.2021.09.13.11.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:02:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 08:02:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Subject: Re: [PATCH v2 6/6] workqueue, kasan: avoid alloc_pages() when
 recording stack
Message-ID: <YT+SMKI1SW3FOACn@slm.duckdns.org>
References: <20210913112609.2651084-1-elver@google.com>
 <20210913112609.2651084-7-elver@google.com>
 <YT+EStsWldSp76HX@slm.duckdns.org>
 <CANpmjNPA9qW8i=gHvrdMRag0kOrOJR-zCZe6tpucOB4XN8dfWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPA9qW8i=gHvrdMRag0kOrOJR-zCZe6tpucOB4XN8dfWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:58:39PM +0200, Marco Elver wrote:
> > Please feel free to route with the rest of series or if you want me to take
> > these through the wq tree, please let me know.
> 
> Usually KASAN & stackdepot patches go via the -mm tree. I hope the
> 1-line change to workqueue won't conflict with other changes pending
> in the wq tree. Unless you or Andrew tells us otherwise, I assume
> these will at some point appear in -mm.

That part is really unlikely to cause conflicts and -mm sits on top of all
other trees anyway, so it should be completely fine.

Thanks.

-- 
tejun
