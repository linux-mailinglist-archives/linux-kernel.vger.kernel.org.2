Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A4456611
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhKRXGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 18:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhKRXGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 18:06:37 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:03:36 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q17so6573321plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 15:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHrbExnXZgmeqdOPBr38Jb3LnjXrVdWeB9/h8JiDP+A=;
        b=ge2HvWGhuo4ysoUNfLiJPxgp7kiUKbsJ5Olo7uwvq6HIT29FquP3azYe1+Za1rthGu
         AmzdFuu9iJ+CElNDPuI9nPaLJxkqjgF3WO1nljgHQp21PlwRh7FDfQlOrazZSlcfLGnx
         YyItqmcESVVjXl6X4FEvhyNmCqLbV6fvH+nG7b9rbNm2i549yiHnJ0KrJuQFA0Mfi0k7
         eJZn2qH2RuIiplcRniJxkJxwt9wz4ZFZpWQOcrV3a6gMG59lNm50d8Gpra8JdYvKSalY
         aQIOVFWIDIjEgecYwyXy+pIuCA5LM67bunLMPSH27HcBIt/OFJ5J6Rk0d/iyeRFDQNtw
         axCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XHrbExnXZgmeqdOPBr38Jb3LnjXrVdWeB9/h8JiDP+A=;
        b=fXbNqtW96bt7THAVMKQ3G1GXMjHynbU8mfNZFJb2SR4EsCUJSVBv/995UP2OM3KEo2
         IOyvdjnzT4uLokAJN9SRsZ6BnS1YNuawoVnLK+1FEX++5PpSTnVRAjfaVEFdUQWoRI2F
         C4bCjrqB3e68qoDAbdfqYSgaptWUx359pq5m69fPwaRS0VG0w+2C0zw79yx7D2t8qhc+
         1sS695ivIyEJgOX35E3sHFPHXPOM25dssv2FWZUnon4WENlsTyzrEmV1fTZH1usaUU4X
         fIACJIJIMYXhwzsCMoXHEZ9K1EI6j70CJbB28yQ6XmST106eZmHz5D36W3KbAP6VERVv
         VMEw==
X-Gm-Message-State: AOAM531Nox7un/NCvnUixAPVhAwqS4RVMZAV4LY8bAZlB5vn7L7BsN4M
        V4nCUiUJUb/I/HybkoU8Zp4=
X-Google-Smtp-Source: ABdhPJwiKVfJQsz5tR1rBwuG1qYqi6FqsWfbJjYgDon3jpjXgENdOYgo5U3q28W6Kh5R6tn8IRvp+w==
X-Received: by 2002:a17:902:c206:b0:142:631:5ffc with SMTP id 6-20020a170902c20600b0014206315ffcmr70919510pll.38.1637276616058;
        Thu, 18 Nov 2021 15:03:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q1sm672876pfu.33.2021.11.18.15.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 15:03:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 18 Nov 2021 13:03:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernfs: switch global kernfs_rwsem lock to per-fs lock
Message-ID: <YZbbxK1F7jY/RBFF@slm.duckdns.org>
References: <20211118230008.2679780-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118230008.2679780-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 03:00:08PM -0800, Minchan Kim wrote:
> The kernfs implementation has big lock granularity(kernfs_rwsem) so
> every kernfs-based(e.g., sysfs, cgroup) fs are able to compete the
> lock. It makes trouble for some cases to wait the global lock
> for a long time even though they are totally independent contexts
> each other.
> 
> A general example is process A goes under direct reclaim with holding
> the lock when it accessed the file in sysfs and process B is waiting
> the lock with exclusive mode and then process C is waiting the lock
> until process B could finish the job after it gets the lock from
> process A.
> 
> This patch switches the global kernfs_rwsem to per-fs lock, which
> put the rwsem into kernfs_root.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Greg, I think this is the right thing to do even if there is no concrete
performance argument (not saying there isn't). It's just weird to entangle
these completely unrelated users in a single rwsem.

Thanks.

-- 
tejun
