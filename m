Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15A734D9BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhC2Vxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhC2Vxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:53:41 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AE2C061574;
        Mon, 29 Mar 2021 14:53:41 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso13694013oti.11;
        Mon, 29 Mar 2021 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e4SKluglhzWUQpMNV8EgeGf+vV0YVh7d1RjcaSkMlkA=;
        b=gLK2vGPTtbS0z+6i7fY981NhNKiTXGRxl0XrjeL6LeM5i3M3ztqViB1UGEtiBUNqvD
         wHLipPbYMdVtskW59uHO2gUR5KhImfIpFQHD39MFQL5Q1PjIEX9PVVRJB82YluGutm0G
         r+Mu55B8jLpMFbtYS1sjbJjYwzxZoFGJ0CPmKwNylM1/kQFRVw8xxaIq+Iio3hauFIWq
         89nLWJX1SB+1I3T6WSljfTK/FIu+g5PaSqyp8JxfobxOalUJHnhieiq9mZ6jHG5eB+Hu
         1d2pFln5NOf8SHHdy4PVGl9EOk2HnaV0svTqkNfmnvxrXW6G62vBoybS71PcC9Cz9u5C
         d/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=e4SKluglhzWUQpMNV8EgeGf+vV0YVh7d1RjcaSkMlkA=;
        b=DOZY6yMfo0jDyCRusO8qk1nud8S2Z8fhhKQQsXXURCx4HPa2puRosvsyUTGjZaL4j5
         SPq/ge0+5ICZ09Ofi8PeU/oOe1MN2NmxHZK8S9uG8dRIma2iiHFjNVaZLS+gvKFHQWlo
         aDZChiUwW26083U2Lvb/2+fS8T8vmaakT2+AGPQYun3T6hLDQbziu+VxtuOkJ2Q/gOc2
         GARJ1qWJr+yUpJKNKXzkVq5YI/rzTu7lrRdUrLwlOUZB/QRsQ9lzlaHW10ZzRR48Kp9E
         ni1QCPZQKkqVHQ5iOYmayJsRtKH2h6HgWIckSE3KYb/AvkVEKonkCEvjfzf9YvSw0ZDY
         JnPg==
X-Gm-Message-State: AOAM531HKiWgTPiM2QKHWuvJ2L+jo70hAI24M+pDu4K/Qd7HEJrOaiDl
        tbxWf8nxWdMekndS2ZcCVvIjMRww998=
X-Google-Smtp-Source: ABdhPJzxueuH0SH312BGa5vbmqumqgx5QQKyht9Lv5vulcmfN85oRQwn3szVxLuQWYp/BvfiBydQCg==
X-Received: by 2002:a05:6830:1b7a:: with SMTP id d26mr17855125ote.324.1617054821169;
        Mon, 29 Mar 2021 14:53:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e34sm4661694ote.70.2021.03.29.14.53.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Mar 2021 14:53:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Mar 2021 14:53:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonas Malaco <jonas@protocubo.io>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nzxt-kraken2) mark and order concurrent accesses
Message-ID: <20210329215339.GH220164@roeck-us.net>
References: <20210329082211.86716-1-jonas@protocubo.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329082211.86716-1-jonas@protocubo.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 05:22:01AM -0300, Jonas Malaco wrote:
> To avoid a spinlock, the driver explores concurrent memory accesses
> between _raw_event and _read, having the former updating fields on a
> data structure while the latter could be reading from them.  Because
> these are "plain" accesses, those are data races according to the Linux
> kernel memory model (LKMM).
> 
> Data races are undefined behavior in both C11 and LKMM.  In practice,
> the compiler is free to make optimizations assuming there is no data
> race, including load tearing, load fusing and many others,[1] most of
> which could result in corruption of the values reported to user-space.
> 
> Prevent undesirable optimizations to those concurrent accesses by
> marking them with READ_ONCE() and WRITE_ONCE().  This also removes the
> data races, according to the LKMM, because both loads and stores to each
> location are now "marked" accesses.
> 
> As a special case, use smp_load_acquire() and smp_load_release() when
> loading and storing ->updated, as it is used to track the validity of
> the other values, and thus has to be stored after and loaded before
> them.  These imply READ_ONCE()/WRITE_ONCE() but also ensure the desired
> order of memory accesses.
> 
> [1] https://lwn.net/Articles/793253/
> 

I think you lost me a bit there. What out-of-order accesses that would be
triggered by a compiler optimization are you concerned about here ?
The only "problem" I can think of is that priv->updated may have been
written before the actual values. The impact would be ... zero. An
attribute read would return "stale" data for a few microseconds.
Why is that a concern, and what difference does it make ?

Thanks,
Guenter
