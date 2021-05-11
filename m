Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6237AD31
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhEKRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhEKRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:39:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC7DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:38:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h16so3840492pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FupqfUsY9asJf3WP4K9WVhemFcz2lS+rGky33/1iF+Y=;
        b=OuO2HEk3F3eO1a3nOlckORBlQgGMVb04Lz4y4c2xcQPPO6DaCHca8dzz0vzMGQWTsk
         ul1RaMC72uujrqNpQ6nJ8pMXPZjZfc3xzLXKx1K7YFnOLohGSYFT1Nx0Nk8ikwSe336W
         LB+pk7xcw+cOKExZyot0Ww1Z2VHfYuHgJp7Un2HF0mgFP43RUAmGJS+VniRQEQ7hj4x5
         k9AgZiuKwUX5Hz3rcSeDiKBvKUP6OZp3KcJSrvE5DnDG6akwcnK+CB44t+MM2mr+fA27
         gMfveLaqThvOrBqolTGy0twWzgQlopnUM/wehO9rEgE/6NiVavoSg6Ys7SERzzH/1WNZ
         cu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FupqfUsY9asJf3WP4K9WVhemFcz2lS+rGky33/1iF+Y=;
        b=nxqF02Aow96B6hQGsKTlW8Yeuez3BJQDpBIEJI3UM/CIz8ZOGcDYhv22AzvmZO2ZLv
         kjLVBxJ2ASVCJDwMzN57J7imc1CNWsRkDMMabb1fZcYlCrbm7QdUhsDp4G7tPYforph0
         8m2a6afFo4+fNn9OrbsbMu8Sg+q5TO3HbjTHdHvzYhSLS4NBOhYAuXOxTOKF1VuY7Kmv
         HfQ2Y7nF98f0znlcnFcLX5fQsYdJHr7bd1tqypH4bGv9KZygO7TTAWw/ovNKwQfH0Lxo
         B4XwIqtrNuKqe0T0DcO80HszVT0L8ZzlMFn4om0zzv80qhhZGQwHhdZrF1wdkvIjwpEN
         YvWQ==
X-Gm-Message-State: AOAM5336sjG+Dzw94XetoGFTwnn6njBV+HSEVODQMZxV4twjVxHrJXvl
        Hxn2Uf0dejPbkG+eGJyF9VM=
X-Google-Smtp-Source: ABdhPJzr/jJknX8G3x9Um6i2uXuvM2XUw171TBsK34q+Eg1UjmKiXg3e96WpuU1QjGrbLwb0esAwYQ==
X-Received: by 2002:a63:5143:: with SMTP id r3mr31584227pgl.346.1620754728669;
        Tue, 11 May 2021 10:38:48 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id q184sm13963395pfc.208.2021.05.11.10.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 10:38:48 -0700 (PDT)
Date:   Wed, 12 May 2021 02:38:43 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     vbabka@suse.cz, akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-ID: <20210511173843.GA54689@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511173448.GA54466@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for being annoying. I noticed that I sent patch in wrong format
(and wrong subject.) so sent patch v3 again in right format. so the bot
can pick up the patch.

please let me know if I can help something!
