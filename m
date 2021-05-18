Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2C387F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351490AbhERSXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344766AbhERSXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:23:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103F1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:21:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 69so5578692plc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1e63VQEbzixPZI8jcGn1DLk4gw20bFcvX2ohIhmiG/o=;
        b=qwBq7IW75d80Sz22CjJqhe8jhFaPd8CyX3Vwq4+Y9auxN9jQ3s8QRbVJ2hFZwDRD1T
         jvudEb1iP34QJSXI3EaH/HI+WpaeY1OAzkppr5QwQZbcePzwbMfBjJU9QBhVM/INndT7
         2KmnjqTaLL1zDxkkCXvV6Bh/H5Z+OSdrctUNfdHu5tjrWMXCfWL8YR4v8vjp7EeNQk/5
         9ifPysh8F3ftVzzZ+qrltFvZsbbNL9xGGo9kvHSeR+6cRT5vyZRF1chKrEEt7OEQ2hd8
         EFNJPWZlTXomfMwVi2YUlO19KOPtXpdj55HuAd3V9OvBvB0RwiOwKSqkiw2PZgN00sd4
         QS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1e63VQEbzixPZI8jcGn1DLk4gw20bFcvX2ohIhmiG/o=;
        b=a8eTwLjHb7sFIe8tTMMNU516sQwuv5MCyad3LXLUdoKdiaim4KpM6xyqPCPi+RNXBP
         8/RW/zj211Edrn4gRQ73wgpjNkRj972DhZV1A78XMj7ki/cSLwR9Pi8QB6IDITzL2nfG
         fJKIhHbQF0nXZc96gceOQ3j1JhHkRfL5nBFA/NWMEpnWhBPY1+WRjEB/nOSzmBYXyH8h
         P7Im59AB4+G0cEmIQUN3r0Zd68HoKkJn74mCXOe1LsIfj3yyMUsQ2JMdp0MGQQyOWFo8
         tTULdnpW1mSbl1ADZhQ+A2CmuPWy0d9Sewf6V47gbMzJzUxE3Hc/iT9guz1LcdqyO+uF
         xmTw==
X-Gm-Message-State: AOAM532JyMwDX1eS7h5xHUwBnqbG/zC3v1JWJ8cNuyonooZpPoQDajCi
        +usSgjTQAucVa4/4FfJu5ow=
X-Google-Smtp-Source: ABdhPJzkLM4QSRsQfVmLe0hk4mt92HUXyO+a5ZF1QIKGLfejVRNRpFLhSCNN47lnizWuCD7b90X+2Q==
X-Received: by 2002:a17:90a:bd01:: with SMTP id y1mr6349243pjr.166.1621362109734;
        Tue, 18 May 2021 11:21:49 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id m1sm13701191pfb.14.2021.05.18.11.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:21:49 -0700 (PDT)
Date:   Wed, 19 May 2021 03:21:42 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] mm, slub: Fix support for clang 10
Message-ID: <20210518182142.GB10380@hyeyoo>
References: <20210518181247.GA10062@hyeyoo>
 <20210518181629.GA10380@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518181629.GA10380@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And Naresh, Thank you for reporting the problem!

If there's any problem with it or I can improve anything,
any feedback will be welcomed. and I'll reply soon.

Thanks,
Hyeonggon
