Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880253FC17E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 05:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbhHaDZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 23:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbhHaDZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 23:25:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28042C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:24:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id bg1so4481045plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nh8QbybUxMKQlOPkd+HKBg02cmIy6cujpaQR8rotc4c=;
        b=DX8HU5l4DeZ83daIwHgTk1M+kD/9wXnm/Y3mlgSXciOJy/yAoEnXXGQv8cL2MUHnmv
         k40lHE3qKlnMyO7w7HFsF+yK/2WgjlBkHPYjfRegABp4hadlK2cEFzvpM0q16nhsHGuy
         Ak2k8DNLBXrgp5q0EslxY5jf6rEZ1fEqq57PlY/7q00PlDm1jQrFPDJ3dTaASASvBfGd
         NrF22aoRZ1gDQdE86fcuJ26HqB7XYTfplG/NMAfAbA6jyHghovXU1Ia40r+nKqEU1Zsq
         Idui2ye6uTIdgjIZCciVyjNCl2Hk4xoyp/XpKHAvnaQA1j/kUodvQIJaczc2zlWQCcNe
         e/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nh8QbybUxMKQlOPkd+HKBg02cmIy6cujpaQR8rotc4c=;
        b=ZSNCderR9ceRtEVOO9xARjdOyIVh/Pkixpplzyv5O4DoN8mTOFhKUZ2tCTAJOdZStn
         WXtnr814oJLiraFJGJ8XeErfnyHj/NajUD00TOSze1p4l9zkRrcnR3G2K4WfYRPfyRsQ
         zZIdZ7yRClGnu4j7rdNaTVpk7WJfICDOvORItcTlngjP5ehCKbSqCmpbR0t/v1ysKtZw
         1LB7T9x1yaPZl/Oi3HmfOtbVEBlKsGLnKtf6d+P3YdWVARcT51rQxxyLPAomYW37oL8S
         fOGyoksZvfjdfBILzl51d++bhRanWbGBZ0nBbZOYWRxeR9r/jImKcCh4GyCK+8/afYIP
         STlg==
X-Gm-Message-State: AOAM531FwiqAVYFuuSAebM37/vVN76z2y2I2Umrsvp02tPY6v8JUAUx5
        B9zyuu30wdL5zwB/CaoT34Lv9g==
X-Google-Smtp-Source: ABdhPJx1b/+PRDoFjIZKp9RsshBFxphB5OqcNMFTBdZUyMKJ1Lh7iLDocREeBTy+tvzUbK//JcQ+wg==
X-Received: by 2002:a17:90a:bb0b:: with SMTP id u11mr2717140pjr.18.1630380257768;
        Mon, 30 Aug 2021 20:24:17 -0700 (PDT)
Received: from [10.76.43.53] ([61.120.150.72])
        by smtp.gmail.com with ESMTPSA id a15sm15637611pfn.219.2021.08.30.20.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 20:24:17 -0700 (PDT)
Subject: Re: [PATCH 3/3] mm: mmap_lock: add ip to mmap_lock tracepoints
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210729092853.38242-1-ligang.bdlg@bytedance.com>
 <CAJHvVcjBH+Vry8v5T0FWyFWWDY6_AqSxZcVQxXRm=LR8v=ML-Q@mail.gmail.com>
 <585f936d-9d27-a481-f590-bd07f98f34de@bytedance.com>
 <20210730160319.6dfeaf7a@oasis.local.home>
 <89c20b62-c0ab-3200-fb33-eb2058b7ba67@bytedance.com>
 <b0b30c3d-0fb8-7d29-2a60-0cce0309986b@bytedance.com>
Message-ID: <4cded873-3706-8d2c-765c-5c896aa13714@bytedance.com>
Date:   Tue, 31 Aug 2021 11:24:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b0b30c3d-0fb8-7d29-2a60-0cce0309986b@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven! Sorry to bother you ;)

(I resend this email because the last one was not cc to mailing list.)

It has been ten days since my last email. What's your opinion about my 
patch "[PATCH 3/3] mm: mmap_lock: add ip to mmap_lock tracepoints"? 
Briefly, lock events are so frequent that ip collection and lock event 
collection cannot be separated, otherwise it will cause the wrong order 
of data.

I am developing a tool to analyze mmap_lock contend using this feature. 
Adding ip to mmap_lock tracepoints is quite convenient.

Sorry to bother you again. Hoping for your reply. Thanks!

-- Gang

On 8/20/21 2:18 AM, Gang Li wrote:
 > On 8/2/21 10:44 AM, Gang Li wrote:
 >> On 7/31/21 4:03 AM, Steven Rostedt wrote:
 >>> Yes, synthetic events are just like normal events, and have triggers,
 >>> stack traces, and do pretty much anything that another event can do.
 >>>
 > Hi!
 >
 > I find that sometimes the output data is out of order, which leads to 
inaccurate time stamps and make it hard to analyze.
