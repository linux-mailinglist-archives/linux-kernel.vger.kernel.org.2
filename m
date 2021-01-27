Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686EB305066
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhA0EGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhA0DEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:04:22 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F36C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:11:20 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o16so536734pgg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EH107V0qHe4lpkhqCGoKSuCGg2LIT/KImLmOrT/s6Dw=;
        b=Wt03rxO9pM9PTlv5wbYP5+mrWYcGk2cHJDzo8RLH8lPT3QCXeNYcEA8WrbesKIne1t
         uX8FYv4xhstwsopGXCm5qbu9WmS6xEm1whaLlalC3Q3Igro680KVE6zwCul7uYlPC6CB
         H97rcWMf6sca6KQIKZhFnR1ni0rpx7QX5RieCeb4h+OAqVxA17hyJd3Jw3HEdBor+rLT
         A2jmtxiVL0yi93V0URJkD47NPsnDikCXvX6pwGVAdBbzzL/jc/6VNLK+SBnpTqH/8ATJ
         d3fXR9vg1xIv9tjVqbx88DCHBtUMJDL1BO54BEURcj9AkMCKsBvwcvlI1mZfVLJJz33g
         wjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EH107V0qHe4lpkhqCGoKSuCGg2LIT/KImLmOrT/s6Dw=;
        b=DVuu6gf55CAmf9LAtvInnnLQ0iXItZeRqBUoR8nkXSQVEfsQ01CkB/lwLrEeKNvU4d
         pbWzzuIxjzrenacVvdE0t+htjkPF1zXqzEIrPaTrTdpwg8DBOwgfjNQ7KixjsAKL2tF5
         k51ZBeZt4Pq7s23KOuz7BET+62bgfpxMjWsVApBfhdRkFi6oh5F+IrIyEtHtKHXMHGjO
         TCV7w16FlO3/mfjydLVTTIXuS5XoxHrwlMUL+Y8tj4dMF9lJcslOcby1s6VcWI652IaY
         oGHTNfD3GiKookYztQ7Ve43GxjGMZoEUeCOvaKDKJpH2EK44H7JPGFAHVDnrSyPhW/+9
         vMuw==
X-Gm-Message-State: AOAM532qdPnOGrp1MbqLmTrINan8jAtbR/mm/1I8BLHsLtXQNwCfmXVy
        sBm8GYmtNC/3tX7DjaVKjyT5H/UC1IF9hA==
X-Google-Smtp-Source: ABdhPJyIvaPv1wouz78zD3aKzYPCMkCDcwYI88xdQeGdF4EN9BNFDuXK74eUS3tIUYiQyXaoZpBJNQ==
X-Received: by 2002:a63:a301:: with SMTP id s1mr7639161pge.325.1611713480243;
        Tue, 26 Jan 2021 18:11:20 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id y11sm346406pff.93.2021.01.26.18.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 18:11:19 -0800 (PST)
Date:   Wed, 27 Jan 2021 11:11:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Timur Tabi <timur@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Petr Mladek <pmladek@suse.com>, roman.fietze@magna.com,
        keescook@chromium.org, linux-mm@kvack.org,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 0/2] introduce DUMP_PREFIX_UNHASHED for hex dumps
Message-ID: <YBDLxddRw5u+IA6B@jagdpanzerIV.localdomain>
References: <YAYtbbHAHeEwunkW@jagdpanzerIV.localdomain>
 <20210119014725.GH2260413@casper.infradead.org>
 <YAa2oCNWjExWlQTu@jagdpanzerIV.localdomain>
 <09c70d6b-c989-ca23-7ee8-b404bb0490f0@suse.cz>
 <cd9e7a31-e4f6-69d3-0648-c6228108b592@kernel.org>
 <083dd940-60c1-4cc8-fc89-8815b253d5c5@suse.cz>
 <a9b38fe7-8a22-71b7-1e84-0ebf1e864306@kernel.org>
 <20210126123912.23a5c3a1@gandalf.local.home>
 <20210126124032.0915f408@gandalf.local.home>
 <87mtwv8ptz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtwv8ptz.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/26 20:29), John Ogness wrote:
> 
> On 2021-01-26, Steven Rostedt <rostedt@goodmis.org> wrote:
> > And even if we make this a boot time option, perhaps we should still
> > include that nasty dmesg notice, which will let people know that the
> > kernel has unhashed values.
> 
> +1
> 
> The notice would probably be the main motivation for distros/users to
> avoid unhashed values unless truly debugging. Which is what we want.

+1 for boot param with a scary name and dmesg WARNING WARNING WARNING that
should look even scarier.

Timur, do you have time to take a look and submit a patch?

	-ss
