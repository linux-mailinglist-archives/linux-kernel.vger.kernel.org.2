Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B243397709
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhFAPrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhFAPrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:47:06 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A939DC061760
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:45:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d9so9711476ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1brf0TNGK9dwPAZExXLrTnxWg27vyStpEfD6aI5ecy8=;
        b=nS/BVQ3ejh6rcsl5a0NIHHQxjse1R5LazqmOG+3eXyGRU+q/nl+xUDLNctRJgLvegh
         BC69FqoULkVis6CuHWC8Yuf2oGoVT8PXeqfYUK3DcvBTbVj4y+jpM5EssUrK+PJDJDV4
         xKzVGCrz5lkEWTqXevoTnH0ANphqdIVteYcRR/4uBBZOIN1+/LKDuTMjrFa4QYySIBse
         ycN+Ymd+JhjHrQ2hJ/YkyDXHDeC2OUkvKQLM10HVpZiSGAfq+08rTs1o2Ry95UsblpRy
         IwqAF56foyLEcb8TseIQPIcMxZk63ZH88PxnVo9JWg8au6E0dkTp61LlxJxKC9mvYe2+
         9kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1brf0TNGK9dwPAZExXLrTnxWg27vyStpEfD6aI5ecy8=;
        b=rVB+wiX87Mf+KDgE4aYIuB3WznfxmdETtDF1x2ZuDtBmi1kc1UyPo4+ej5b2FgI0t0
         oj4zbazJx/+m4Y9hbU8cV8HnclDqeqhQ7ZQGnOj4i1+MI+lesm90uMIkR4x5SwubK9vN
         EUGkFgc9DM1f8VQLnxj2EgVjKjxZV6gdWTgIIEvEY2PxBrM1oTnfEtk0PiuTYlKq3CSs
         071KA4DMAk6l8KLOBcPlq+3ugDGWpvcJiGGwkRAnKPcWNz57F9QmfRpl9wsak5txFUkF
         +8TBSi8ulqpFfNWBL/VKJa13uemeSBmzU3Yd7FEWqJkteiS8wlr13abCbMBIq5DQBsLY
         n8JQ==
X-Gm-Message-State: AOAM533QWpOVcEjTbiT4ifrJZU700ZRCZZxQYEuaqD2fvSc1fYHCTABN
        TmVRF28xBr0KVTwtL67dPG8OalCO98TFf4jZ
X-Google-Smtp-Source: ABdhPJwIj+QcEChAd/1kOz1Xi+4cuMbU6cLoWuWHFMrj2FsfndoQg3rFiqlgFJIYq2C9kzccYY99wA==
X-Received: by 2002:a6b:b58d:: with SMTP id e135mr2809576iof.46.1622562323604;
        Tue, 01 Jun 2021 08:45:23 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x5sm9526336iom.43.2021.06.01.08.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 08:45:23 -0700 (PDT)
Subject: Re: [RFC 4/4] io_uring: implement futex wait
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc:     Andres Freund <andres@anarazel.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org
References: <cover.1622558659.git.asml.silence@gmail.com>
 <e91af9d8f8d6e376635005fd111e9fe7a1c50fea.1622558659.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd824ec8-48af-b554-67a1-7ce20fcf608c@kernel.dk>
Date:   Tue, 1 Jun 2021 09:45:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e91af9d8f8d6e376635005fd111e9fe7a1c50fea.1622558659.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 8:58 AM, Pavel Begunkov wrote:
> Add futex wait requests, those always go through io-wq for simplicity.

Not a huge fan of that, I think this should tap into the waitqueue
instead and just rely on the wakeup callback to trigger the event. That
would be a lot more efficient than punting to io-wq, both in terms of
latency on trigger, but also for efficiency if the app is waiting on a
lot of futexes.

-- 
Jens Axboe

