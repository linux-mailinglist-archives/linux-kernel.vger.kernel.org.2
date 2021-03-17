Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD633F884
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhCQSyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhCQSyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:54:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFBDC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:54:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t20so30207plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rMyvcCmECo2UF5BrQ0BBNWIYi9bGONy40iMZu5iyOik=;
        b=nNqBakMSl8IOlJP8VjLFEVNGJ0s7A0Cm/0SrdHwHagrx/CjP3IXO6bwNoX0gISXwce
         H5D/P0RcWDi+nBaB76Sg2uELMIYV8PLRi+MojQBWRzAfibbDXQ3Q98MukRBTVA7i9j+0
         o6gFizrXvhM1yAZWXgRmdGTZZPGD7E3H07i5TDWcAUWReX6jCIJI2lIiVNuiZx0Vju3c
         LRK+dAjPPiXH14E5U+ZGImniyBP5onJs4N7uxM0vihP1k+gNDHtOcp+QaK8ZWSm5Mgj5
         AfpIwmqlio95IH8VIo/vq99aHeSWnpaVh74XQnE0eTAXUj9esOk/qvo+CmF5jEYUyxy+
         R4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rMyvcCmECo2UF5BrQ0BBNWIYi9bGONy40iMZu5iyOik=;
        b=Kz45TBpuUdJTQmRHfjcacUCqrS6fcjA3uG1I5U7e+HOngUgbGXk9LkYcBSLqgzRMR7
         P6xhS3+TZ/bjG4b4ZnEFpd5pKhm9tX9go5cXTrhvtbqV/jhpu4n198XNlXL8LaeGjsEp
         5TBVtvHP00yjNbhAhr9JpxbwafuLc1MRwsnUvNBG9TzG4bjvAt/D6WVa8n4bALFagCwQ
         ekfJdFITCiQ7BsS8z4v8Fef+CRp3LNH4sY0MYE6fQIq2cbEBPU5iJQdGxDv8sYBdEGlP
         zI/182J+BmQ9tEuS4cRPnFB+bYrloaZ2pn0vsyIzj/pFVNKKyUXA9XgL69JFdW26n7+T
         lqvQ==
X-Gm-Message-State: AOAM533w3MbWhvtTFyVdy8/S0GanT8x3xh5LFYM/2zRgTXWCdq5AfAd7
        BMnO4yep8STr4SazeLOFiOASMg==
X-Google-Smtp-Source: ABdhPJxoJ/lR426aplD+YyMkxVJUtHq6Vt1FBVhabjeKlgXTrUcdrMGKFzdHnIdTH+dr9vJJdjvERw==
X-Received: by 2002:a17:90b:514:: with SMTP id r20mr247990pjz.145.1616007251900;
        Wed, 17 Mar 2021 11:54:11 -0700 (PDT)
Received: from [2620:15c:17:3:b56a:51db:a0a1:259f] ([2620:15c:17:3:b56a:51db:a0a1:259f])
        by smtp.gmail.com with ESMTPSA id y9sm3522935pja.50.2021.03.17.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:54:11 -0700 (PDT)
Date:   Wed, 17 Mar 2021 11:54:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Oliver Glitta <glittao@gmail.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: add a kselftest for SLUB debugging
 functionality
In-Reply-To: <20210316124118.6874-1-glittao@gmail.com>
Message-ID: <982058b5-6db0-d85d-126b-502f24447528@google.com>
References: <20210316124118.6874-1-glittao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, glittao@gmail.com wrote:

> From: Oliver Glitta <glittao@gmail.com>
> 
> SLUB has resiliency_test() function which is hidden behind #ifdef
> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> runs it. Kselftest should proper replacement for it.
> 
> Try changing byte in redzone after allocation and changing
> pointer to next free node, first byte, 50th byte and redzone
> byte. Check if validation finds errors.
> 
> There are several differences from the original resiliency test:
> Tests create own caches with known state instead of corrupting
> shared kmalloc caches.
> 
> The corruption of freepointer uses correct offset, the original
> resiliency test got broken with freepointer changes.
> 
> Scratch changing random byte test, because it does not have
> meaning in this form where we need deterministic results.
> 
> Add new option CONFIG_TEST_SLUB in Kconfig.
> 
> Add parameter to function validate_slab_cache() to return
> number of errors in cache.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
