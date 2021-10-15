Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B542EA77
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbhJOHpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhJOHpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:45:53 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0BC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:43:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kk10so6669917pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 00:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=JsqJIuW2tTU9s9E7GtfTtQg//PboImxDKBnfFLFqtxI=;
        b=g2nK1Fp7LfmN3pMjwLUHZWNCPJtRo8yVXK0cmTAS2Ho2+phzh/J5DNXnc4BP4e9Asb
         XKkK4557lSVHGcN6DJSXFDYRj9lsKN2TuqaUlUeo4gV8KqEyw7MW8oZG3BO13GRT/OeD
         l/y+6/bJOyyMWQJm8B4TWjRztndQMnzijjrHBHd6LKztqEamkYgPMlL87FuoDLUn3WNf
         7oRIlQ0JwNXICE9vxeKI4YnVrLKrurnLHZAmLCDpATYTKdpj0Vwv8NOpOubREaBeFJG0
         OYmKcjbc+RoQ5EW8NpNpI2+D0wCDqLo5Adz3xxnkVhIZnkXEnSgtJmN/4No2rmXuQeVb
         UNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=JsqJIuW2tTU9s9E7GtfTtQg//PboImxDKBnfFLFqtxI=;
        b=fiZ68Nmphy6FMoICkPRNnOETk+qt6XbO86UKTSMJp2v+TEXhzRss13BUlHsAHY18vS
         1HbSu/B4TSWAlIl9WX9UdpdIUwcK7dN2Y0nitYFmltYdxGvNV+u1IA5hs4fig8MkU6DC
         iKEjm58kGkJcr1OZd7S04CXS9Bmlzk6lqDyYHqQ0CBxZmlMP1OsiPftUM/f3/ZqE/7Sv
         hpwQtv8XnPIXT42muQjtm3Vygqe8vY6p059oMnRyiJ5ep5oo4URTSyxQOmmInUPNLCVe
         viHdhXR9alKcK51gg8NnO7AzMVsajdaBozwHZ0H6XJAVacjwoF9mfoYfIMJYdk/tYc1w
         lMIw==
X-Gm-Message-State: AOAM530V+Z72VXZ7VFHFhfwhcVbk3LopfDVF1txY+wgkktkqPERDnn+V
        xoil0Ddh60U+rcf2R25Ny06+j/honzQO+63b
X-Google-Smtp-Source: ABdhPJxsOSjTY38zyZ9r3vqeEA8MTLsKLUy4egv35LJuq44GEu9ZgRu7g0tKd72fvXH4AD0MUTw3Zg==
X-Received: by 2002:a17:90a:1950:: with SMTP id 16mr11598841pjh.126.1634283827200;
        Fri, 15 Oct 2021 00:43:47 -0700 (PDT)
Received: from ?IPV6:2601:645:8400:1:ffb7:9e6f:baa:dfce? ([2601:645:8400:1:ffb7:9e6f:baa:dfce])
        by smtp.gmail.com with ESMTPSA id q73sm4568850pfc.179.2021.10.15.00.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 00:43:46 -0700 (PDT)
Message-ID: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
Date:   Fri, 15 Oct 2021 00:43:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Norbert <nbrtt01@gmail.com>
Subject: Performance regression: thread wakeup time (latency) increased up to
 3x
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Performance regression: thread wakeup time (latency) increased up to 3x.

Happened between 5.13.8 and 5.14.0. Still happening at least on 5.14.11.

Short story:
------------
On isolated  CPUs, wakeup increased from 1080 ns to 3550 ns. (3.3x)
On non-isol. CPUs, wakeup increased from  980 ns to 1245 ns. (1.3x)

Such an increase is surely not an expected part of an intentional
change, especially considering that threads on isolated CPUs are often
latency sensitive. Also, for example, it significantly increases
throughput on contended locks in general (1.3x).

Long Story:
-----------
Time measured from before futex-wake on thread A, to after futex-wait 
returns on thread B.

Times are similar for eventfd write -> blocked-read, just a bit higher.

Thread A and B have affinity set on two neighboring CPUs on Threadripper 
Zen2 CPU at fixed frequency 4.0 Ghz. On isolated CPUs, with SCHED_FIFO, 
on non-isolated CPUs with SCHED_OTHER, however that does not make a big 
difference (I also measured the other combinations).

Measured 5.13.0, 5.13.8, 5.14.0, 5.14.9 and 5.14.11.
Some on Fedora 35 Beta, some on ClearLinux 35100.
All given times are measured with multi-user.target (no GUI shell). 
Times on graphical.target (with GUI shell) are about 10% higher.

These values are not an average of separate shorter and longer times:
This is a typical distribution:
(None are less than 3300 ns, and none are more than 5099 ns.)
  count with 33nn ns: 858
  count with 34nn ns: 19359
  count with 35nn ns: 57257
  count with 36nn ns: 6135
  count with 37nn ns: 150
  count with 38nn ns: 48
  count with 39nn ns: 11
  count with 40nn ns: 10
  count with 41nn ns: 10
  count with 42nn ns: 10
  count with 43nn ns: 7
  count with 44nn ns: 11
  count with 45nn ns: 3
  count with 46nn ns: 6
  count with 47nn ns: 3
  count with 48nn ns: 4
  count with 49nn ns: 1
  count with 50nn ns: 3

Also the times for the futex-wake call itself increased significantly:

On isolated  CPUs, wake call increased from 510 ns to 710 ns. (1.4x)
On non-isol, CPUs, wake call increased from 420 ns to 580 ns. (1.4x)

This is my first time reporting a kernel problem, so please excuse if 
this is not the right place or form. (Also I don't yet have the know-how
to bisect arbitrary kernel versions, or to compile specific patches.)
