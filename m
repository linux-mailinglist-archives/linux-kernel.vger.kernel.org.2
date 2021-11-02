Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF24444252A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 02:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhKBBhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 21:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhKBBhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 21:37:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59239C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 18:35:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u17so4348540plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 18:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=6pCTTHi9Wlvjb+KMDPqRjVtEGfFxP2f85KljOLiCuhQ=;
        b=jOY7quIUlD+Xt80Fw5Yo5iFmJqufm0iV+gkvcf8iZoXVSdjJE3zqyEws+9KwGYkrEz
         hOiBTWXs9FPOLiUfsxqs9NT5OsSHDYjIWSEK7XYE+/LeiYfONTPKKEwe6AmbjbWfZ28I
         Ec7JRgym0XV+lK/W4sn49eHprpfpjgYQLNpQjl/rDyvVH/m3uPZwqWDU7rryzGL5diDk
         OTQCuHBbEOiN4T4PjdFmYoYuuAqMvo+cd636+ltLRZLCCNEsQlozlXv/BNCequS/8hm6
         LJCvs9zxcZIKEv9cgyGuh0T3lCo1TGQGoxaVKVmsCowVMOqNRyAX1L857TMiEg7jwDkH
         XeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=6pCTTHi9Wlvjb+KMDPqRjVtEGfFxP2f85KljOLiCuhQ=;
        b=qibOyk0mlruhA5imi4qjZla/IUbKh2orPnlxao8gXmPZpJbvoJKLpaj+1Rj+c8iGSE
         9bCJ2u3RRG25aJk5oI+1cP63mTOO7KHUB6T+gzOPHaUuzm88pf36CqgyOybAk1xqZS1r
         S9LkimxlT0qQTKRR+0AjArzwjKgQghbSSSV61bcPrusKhn1M+Do+k/JNwepIJG5fbmfO
         hKu03/CpvZp27GB3WfTDbd/AmKV/uSlX6DDR2Wm7iN8e21Jv0EXcA6LlzXyI5moN9jan
         NFsoDaUANTsHrtJluvth0TnYSN620QpMD/AIUTh6CM2u5P5IG+rNnMjjJ/L09Y8KiNCV
         iavQ==
X-Gm-Message-State: AOAM533azai1itKuckIHrIUqjvWlvgjBiarOAAlsbnQDY0tN3cmja5P9
        wJBfw034vGoqBHKJ64hhLxs=
X-Google-Smtp-Source: ABdhPJw6RU5Cxtx/A0mifHD5O124Dat7NO2cm1e4h/MnfyHv1OAcYkJ3NIkIbV/gEjhIYPMzD8W9Mw==
X-Received: by 2002:a17:902:8b8b:b0:13d:e91c:a1b9 with SMTP id ay11-20020a1709028b8b00b0013de91ca1b9mr29015857plb.60.1635816906914;
        Mon, 01 Nov 2021 18:35:06 -0700 (PDT)
Received: from ?IPV6:2601:645:8400:1:99e5:9255:239c:47f4? ([2601:645:8400:1:99e5:9255:239c:47f4])
        by smtp.gmail.com with ESMTPSA id u6sm3356122pfg.30.2021.11.01.18.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 18:35:06 -0700 (PDT)
Message-ID: <8957c970-88f2-40a8-835f-062ed7a982af@gmail.com>
Date:   Mon, 1 Nov 2021 18:35:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Performance regression: thread wakeup time (latency) increased up
 to 3x
Content-Language: en-US
From:   Norbert <nbrtt01@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>, frederic@kernel.org
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
 <8691a8ec-410d-afe8-f468-eefe698c6751@gmail.com>
 <YW1ZjroFfmKM9HJe@hirez.programming.kicks-ass.net>
 <4674203.GXAFRqVoOG@kreacher>
 <70998f86-74d7-7ced-867e-f17695bc88e7@gmail.com>
In-Reply-To: <70998f86-74d7-7ced-867e-f17695bc88e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/23/21 22:09, Norbert wrote:
> (The more important part being SCHED_FIFO.)

Please ignore this side-comment. The decisive factor is 
isolated/nohz_full vs normal.

There are indications that "normal" times have become worse lately 
(measured in 5.14.14), relative to earlier, but in that area the 
fluctuations I see in my current tests are too large to get a clear picture.

Best, Norbert


