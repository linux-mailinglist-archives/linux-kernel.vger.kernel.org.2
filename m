Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEB43B10C8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFVXum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFVXum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:50:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE2FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:48:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l11so371564pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 16:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1RLgLXFqq15csoH4mq8p9nRQFwbdP0zTabyf/tYFG10=;
        b=YPa84iRAnYkf5piFulXZq/HkilfXRQ3MLwDKZzmg7i/H9vuxfGZv3SBI3EZm/A+4Vi
         m63w1tMma38bckF+PeEqE8jgjONOWWJnvquUeCg7aCzM+xshaf3zTNDVmQLr3+uExrT3
         svxrKrE/9RgfO3e2sHZ3q0iTFlw+MjvC5fDjIQ3lpK4feVcVJAAwqIy1r/MTvOgMnlXm
         kIhsefT+1IXMXwis8cMYjJkJpkH2quXKhmWvP+Xd4HPxZ+JhTw+LvsXgZWSOsbs1MjsR
         ijF7WcPf27pAnpjtRjGV7BxmwULHBYAI0oIrg/thOwFWz0M+09RuKMoRUpWRcDEUuriA
         aV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1RLgLXFqq15csoH4mq8p9nRQFwbdP0zTabyf/tYFG10=;
        b=ZDNKjLz/0+vGVJkwHR3juduvwVLJ33JMvmvDt5E12z5u9zSuV9XtnszFozNCZlI0Q+
         GW9wBGIO9PWvZRJaVQhfw1FDyHSQhAR+a0/q7uPAvdMcNpBjSWPR3TKIQ8TCy3YUUALT
         pmldDV+Hpub0VJbzkC6a/9vhj1PgYEOhsuyjrA8DGPi/UYz77IvF9yiiKjB27Qrxi9jy
         3+bdmveobD2A95b2OPzgXYHZkai341EQsZpf+S9Hs4tn40cDs5v6D5pqXnqmDMwgfHOs
         d80WXwzbYkyMALsiM4wBlPCx/1g38FlOA0HioCwhWjq7L/YMX5+U6M6lNLTW2Z90C5kn
         sjLw==
X-Gm-Message-State: AOAM532Mah2CN6C5Ln0/giW1kksmbGnmjrccsFdZo//9LzZ5yTwVGNr6
        rY8V6407ugNATta8diMojjVNQQ==
X-Google-Smtp-Source: ABdhPJwJ7Hw20uNoS9B9yHkLdXS3x3FMfrLRgrDzQnYt/Vg/6dXxWr5rKejLwAyLwzlo0y49dMqOsA==
X-Received: by 2002:a17:902:b588:b029:11d:b246:c59a with SMTP id a8-20020a170902b588b029011db246c59amr2824548pls.58.1624405704049;
        Tue, 22 Jun 2021 16:48:24 -0700 (PDT)
Received: from [2620:15c:17:3:d578:e7ed:94b1:7b] ([2620:15c:17:3:d578:e7ed:94b1:7b])
        by smtp.gmail.com with ESMTPSA id f15sm20903238pgg.23.2021.06.22.16.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 16:48:23 -0700 (PDT)
Date:   Tue, 22 Jun 2021 16:48:22 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     gumingtao <gumingtao1225@gmail.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        gumingtao <gumingtao@xiaomi.com>
Subject: Re: [PATCH v3] slab: Use __func__ to trace function name
In-Reply-To: <31fdbad5c45cd1e26be9ff37be321b8586b80fee.1624355507.git.gumingtao@xiaomi.com>
Message-ID: <53523c2b-342a-bf69-ba76-d5b10d6ad96@google.com>
References: <cover.1624355507.git.gumingtao@xiaomi.com> <31fdbad5c45cd1e26be9ff37be321b8586b80fee.1624355507.git.gumingtao@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021, gumingtao wrote:

> It is better to use __func__ to trace function name.
> 
> Signed-off-by: gumingtao <gumingtao@xiaomi.com>

Acked-by: David Rientjes <rientjes@google.com>
