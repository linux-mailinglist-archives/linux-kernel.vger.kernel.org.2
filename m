Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF5382A42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhEQKya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbhEQKyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:54:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7BBC061760;
        Mon, 17 May 2021 03:53:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d78so3800407pfd.10;
        Mon, 17 May 2021 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NdeCX4rjV+Zv636bnH2MvIF9sfediJRTDxYI7vsVq7k=;
        b=KG7yrpr7MFAaHLzYMouAZxv9oYOv9wi/b9Rc3Z5FIjrar5ybjaMalFTe+M4WifUFR3
         1WPNVODXgT711AWAOJpQ78shc6URv865j4YHD38PcADSNKkRbjyjiKwAFT8G4GLEbpT8
         GBFXNal/CncMmsW23kg1jVtFP0xiQIohMkoDwY2St+2ltardX7wX7sg3fxhoVDuYxhJR
         uBGQZ2AlQ6lSwEc+jq3C4oig0UOM0CL9zM2ReQJ1t3aOr/bfZ9UkBsPKY4LOLKo2uIiY
         Qht/ITjszwrxIKA6h01Mdt9Gqklxd2vc9X7feBufOxj5O9UFmcGUipgAi8piOQS9+6Wb
         i0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NdeCX4rjV+Zv636bnH2MvIF9sfediJRTDxYI7vsVq7k=;
        b=KRgBSgKCpJKz665JUANJ/Q+iIcpZjlCCr+kxukm6u0z7ZgIYjmWMndCs4nEP6Agaof
         hxd1lIZrMUBrFcAAY8DGLfd17RtothPOCsM+9vFVHH6CnqgHieEaDvr0zsl9cXtVX7du
         lr2kdnBholt/TLHWmXSRpm5IcsCf/UBHIz94V4E3WC4e7YEhAugQ1HI1TTWwHqFQfwnx
         TJzxJuzvOtuT5coV2XX7MD11FNbS+10V4RjHxEux8YfDaBtTGZO0nXd2bWjWPS7noA1r
         wvzgQMhXsMQX1N/g//BHiXpA9QK3w0lQFR6Gx/8cXArLpSIwco0YIIOSegBmn+fj6MFP
         yKrw==
X-Gm-Message-State: AOAM532xHUNCfg2yuQrEXA9uXtdDbC9BbYLPCi5O+4CsY70bspkYUPjx
        KZTIH6SLd4/STdZGE6hCg54=
X-Google-Smtp-Source: ABdhPJzDEhmdVneoa/XCfz/yhzalZIFsiA1AKlDrfI2clNnDIRj7U0J1kbN7rPLHWZOF5hi64uiwkQ==
X-Received: by 2002:a65:6a05:: with SMTP id m5mr22050754pgu.319.1621248786769;
        Mon, 17 May 2021 03:53:06 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id a16sm9825613pfa.95.2021.05.17.03.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 03:53:06 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v3 16/16] docs: RCU: replace some characters
To:     mchehab+huawei@kernel.org
Cc:     bigeasy@linutronix.de, corbet@lwn.net, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, nfraprado@protonmail.com,
        paulmck@kernel.org, rcu@vger.kernel.org, rdunlap@infradead.org,
        rostedt@goodmis.org, tiwai@suse.de, will@kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <909f3108e85895828bf3633f183e8f364cb4d752.1621159997.git.mchehab+huawei@kernel.org>
Message-ID: <57bb2653-8754-707f-6d54-9a64dccd3c50@gmail.com>
Date:   Mon, 17 May 2021 19:53:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <909f3108e85895828bf3633f183e8f364cb4d752.1621159997.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 May 2021 12:18:33 +0200, Mauro Carvalho Chehab wrote:
> The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
> conversion and some cut-and-pasted text contain some characters that
> aren't easily reachable on standard keyboards and/or could cause
> troubles when parsed by the documentation build system.
> 
> Replace the occurences of the following characters:
> 
> 	- U+00a0 (' '): NO-BREAK SPACE
> 	  as it can cause lines being truncated on PDF output

These NO-BREAK SPACEs originate from "&nbsp;"s in html docs converted by
commit ccc9971e2147 ("docs: rcu: convert some articles from html to ReST").

I think the patterns found in these files ("~" denotes NO-BREAK SPACE):

    CPU~0
    Tasks~T1, T2, and~T3
    line~n
    lines~m and~n
    ...

are quite appropriate and nice-to-have contextual markers.

Despite the claim above, I don't believe these NO-BREAK SPACEs can cause
any truncation in the PDF output, because they combine short numbers or
symbols with terms such as "CPU", "Task", and "line". 

So I'd like you all to keep these NO-BREAK SPACEs.

If there ever emerges such truncations, they can be taken care of
case-by-case bases.

        Thanks, Akira

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../Data-Structures/Data-Structures.rst       | 46 ++++++------
>  .../Expedited-Grace-Periods.rst               | 36 +++++-----
>  .../Tree-RCU-Memory-Ordering.rst              |  2 +-
>  .../RCU/Design/Requirements/Requirements.rst  | 70 +++++++++----------
>  4 files changed, 77 insertions(+), 77 deletions(-)

