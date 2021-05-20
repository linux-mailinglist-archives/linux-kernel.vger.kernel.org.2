Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07598389CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhETFO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETFO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:14:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5D4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 22:13:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso4653037pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9cwhp3bw5wRVRJ7C8bZKGP756k5sXb+PQe55pMQ2v5c=;
        b=j/JX7YiEWDtDQ+bknCG5bF9teVwisdvh9sVh5yX24yiib4iCFhSyvpmXOM1S/Lb3J9
         xq+Tk/5f6X4vC3bvXna00fwni6V6KAqezdUDWWkDJnZ0PD6Zp1vs5HGIpPjGA8THKUNF
         zx8NT88xtKBx6YHocEV6fBdj5eNrYLny4zehM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9cwhp3bw5wRVRJ7C8bZKGP756k5sXb+PQe55pMQ2v5c=;
        b=tl4A5vyNRvE6esy3eOb87JeQrn+J1mUoi5tNXjGyI3e93vVnHyqixwq8HiUzXhqk9J
         ZYC7lpwPFXsJ0G0hM5iKrSBQagM7spq+71NgbDh229vEg6mt77LNUglw2A04ZTW6K4hw
         g5ScXXRMjcZNsi01jz2uIUtQ3LcfKi7KGvbqHTVI/UNTZNQ8FiqGpOrF9hoBg+YNaPPH
         G/dHCNAElf1nECoy8iCp1n5PsR+b1vhRPdIzMwTltEgYn5cVCjZow/gdKTT0KpU6YkAN
         zeCTRmlbNCG8DjCU5kpy1L/SXjBlCsA5W2JWQlhMkRMU92Zt0QXlJv8AOqozE6+fw9/X
         d0mg==
X-Gm-Message-State: AOAM532hD7GJJFRCyKZS7rDl/7i9xo0QXb/JX/gQAP05u91ht5UcsCOM
        WqdVYaGxi9MvRiP70CxAvDW2zg==
X-Google-Smtp-Source: ABdhPJz3tsVU2Oy+l8umuNLtrOuQcx/bMDNbYaqOGqpLgRq4NZXwY0B2MSxIRiD3wu2Np6NBkQLtcQ==
X-Received: by 2002:a17:90b:607:: with SMTP id gb7mr2786738pjb.5.1621487617260;
        Wed, 19 May 2021 22:13:37 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:48db:abf:343e:b4f7])
        by smtp.gmail.com with ESMTPSA id 23sm868589pgv.90.2021.05.19.22.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 22:13:36 -0700 (PDT)
Date:   Thu, 20 May 2021 14:13:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: revert cleanup handling of false positives
Message-ID: <YKXv/CtdWwiqoAHa@google.com>
References: <20210517140612.222750-1-senozhatsky@chromium.org>
 <YKPfDQoN5hToB9nk@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKPfDQoN5hToB9nk@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/18 17:36), Petr Mladek wrote:
> On Mon 2021-05-17 23:06:12, Sergey Senozhatsky wrote:
> > This reverts commit 9bf3bc949f8aeefeacea4b1198db833b722a8e27.
> > 
> > I can reproduce the case when resumed VCPU starts to execute
> > is_softlockup() with PVCLOCK_GUEST_STOPPED set on this VCPU:
> > 
> > 	watchdog_timer_fn()
> > 	{
> > 		...
> > 
> > 		kvm_check_and_clear_guest_paused();
> > 
> > 		...
> > 
> > 		duration = is_softlockup(touch_ts, period_ts);
> > 		if (unlikely(duration)) {
> > 			....
> > 		}
> > 	}
> > 
> > Which means that guest VCPU has been suspended between
> > kvm_check_and_clear_guest_paused() and is_softlockup(),
> > and jiffies (clock) thus shifted forward.
> 
> Are jiffies really updated here?

I guess so. Why not?

VCPUs are not brought up simultaneously, it's up to the host that
schedules them. So, for instance, when we resume VCPU-3 and it
discovers this_cpu PVCLOCK_GUEST_STOPPED the VCPU-0 can already
be resumed, up and running, adding ticks to jiffies.

Am I missing the point of your question?
