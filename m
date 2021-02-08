Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1560C313DE9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhBHSnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhBHQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:46:40 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06335C061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 08:46:00 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id r13so7204643qvm.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 08:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z4+/UAUxX6/4+nPbgYcfOOvOW20Oi6mUCWX13gHCXgY=;
        b=n+rZGS7J7T6hTq7r5Upn5tvO1h7vkY11CCBAIcmUASxzHtyardQi95qQmpG2K/da4Q
         si2FUTkAMPjV8JGmwTKCLVCNpZpyt1p3uMPzTgAHV/tM3PfZIBNWwjmR3cNfZEX54BRO
         qdwLvUjPG+tCppsNDyA210ZE8RSfHpatTzTYyW9pjvkDsVEN41Sqk5KTC+i5DUUcjWzP
         oSzEllgyYeL5bIM47qNhkl1XXmOOkawKiOYKgofXl+Kpu0whPCYNDj2xkK3us2XFAdAS
         jK7zVt6pGpPK7fzVc+KKY2oF7lwKTIHbIV6s1C5t+3hYs8u/wW3bNmtnS5UmVJResgSy
         0KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z4+/UAUxX6/4+nPbgYcfOOvOW20Oi6mUCWX13gHCXgY=;
        b=J25+3oqez8ca48K8PQ5HB2DnuP7TyFaO8R7TkilaoZ+lzxI9ZImI4f0RpmW1Su2ZVh
         g4iycx057t9t0W+wy6y/hftMihdZNH0iYLXcDt+pfCoYoKRM5Zgo4e3Kxib3Cfa1bTjN
         doC0N6ko3h/PPLjzaNXP/t5CMHbWL4GGKUAY8OSJIjphSlR6hb6HsdfN9G9uJ1CpMFLp
         Dp+fVIjFBuHpDwxfuAgRJQJi8tUNjmiV7ol44cQx/0w+on9nT9dGTW3sTUZXazqv3UPp
         SqZuQZElURT+Yz6I2Pr3O+iOHCYeqp5j5wttCjnmfDTlzTJHLTZVla+gZf5o9TsGXgF0
         fb2Q==
X-Gm-Message-State: AOAM533txS0ApiYixcFTZlgqjtsPUvhqo1VNnSDHecpRC7ID+WliEBwU
        KKmvpsmFicHnno2+XuChL6eAfw==
X-Google-Smtp-Source: ABdhPJy1vA1cI1LOaho8Kgv1Fcgi9XIoSGsEjoFJTCWodC6JvrV0g0151q82VJfIPMcWcOYam3jCTw==
X-Received: by 2002:ad4:40c6:: with SMTP id x6mr16677381qvp.10.1612802758643;
        Mon, 08 Feb 2021 08:45:58 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id t71sm17182587qka.86.2021.02.08.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 08:45:57 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:45:56 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: Remove the redundant psi_task_tick
Message-ID: <YCFqxEw0wJC6UGiE@cmpxchg.org>
References: <20210207115642.75620-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207115642.75620-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 07:56:42PM +0800, Chengming Zhou wrote:
> From: zhouchengming <zhouchengming@bytedance.com>
> 
> When the current task in a cgroup is in_memstall, the corresponding psi_group
> is in PSI_MEM_FULL state

This is correct.

> so we can remove the redundant psi_task_tick from scheduler_tick to
> save this periodic cost.

But this isn't. It IS the task tick that makes it so. The state change
tracking counts MEMSTALL tasks and ONCPU tasks, but it doesn't check
whether the ONCPU task is the MEMSTALL one.

It would be possible to incorporate that into psi_task_switch(), but
you have to be careful with the branches because that path is often
hotter than the timer tick.

This patch by itself breaks page reclaim detection, so NAK.
