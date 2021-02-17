Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9C931DD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhBQQdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhBQQdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:33:04 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CBEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:32:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g6so18014549wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 08:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p8EXC5f8XmmEzFQQjXafcaeNFWSNN27JEw5tE0rgszc=;
        b=bIhQ0iKTGuHw5g/CU7AUMxGI7Wx/Uw1wz8DNcOjWPieW4H2gELFxvII2Kt6ZinzQae
         EhyyW1uKRYZlpFx33gsuy+Tm7s5NifyDJcGcReXNKKRJB3m54g5MPaS+y60EJedDzTJZ
         6keodpR2GbdqsnZ5w0tmtKGDmLq9Rmd5lYZRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p8EXC5f8XmmEzFQQjXafcaeNFWSNN27JEw5tE0rgszc=;
        b=WmNMvZWe41gc/X5AhX8bM4Yv/Ku/atOFCZ/4oGvKVJnLL/cq+YVTRS0vXLLzZoSMUk
         3LGrEPB3FaTLGC4Q1gyfEX49Ed3HWQ+kTpdhEdcsaY1MC01PO2DlcRtRyO6ou/HTGKsH
         OfrL9dfHSRs5CcncMFCCFSdTRSb2DwkVoDU6VaRyzA/ESrr1bkELtPXi158lEm4qpzqC
         BodSY0XyR0BF6jRNl8iy6dveZqhlXFvy0qjqWkCIHvRZOP/aQv66f+9LvfaTk3lKr06A
         87yt6v6vSML+i1krF2LsDKz6MKIfOEVBej/8egPch2TJPwggbihi0RCnqAvgK+9Ei6Gp
         aiqw==
X-Gm-Message-State: AOAM53102J6THvCAc2vskXeLcv6BV3dfsIKoCgPMHWW1Evxu3xjaf4Ru
        QZFCaLXsjuA3n7TW+DuPrvgMfg==
X-Google-Smtp-Source: ABdhPJxiUQMMmqhgCiDn93K542yhJm0V+P6nFzza7SpnK4m1/WSNNsKW/8rNVP0Es1sxIPfriUtoXg==
X-Received: by 2002:adf:de86:: with SMTP id w6mr101058wrl.32.1613579542483;
        Wed, 17 Feb 2021 08:32:22 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:76fd])
        by smtp.gmail.com with ESMTPSA id t30sm4871829wra.56.2021.02.17.08.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:32:22 -0800 (PST)
Date:   Wed, 17 Feb 2021 16:32:21 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: code style: Re: [PATCH v4] printk: Userspace format enumeration
 support
Message-ID: <YC1FFVCNQpaJwO/N@chrisdown.name>
References: <YCafCKg2bAlOw08H@chrisdown.name>
 <YCv9Xb7ePnDy9xRf@alley>
 <YCwAbGoVuZJspcx5@chrisdown.name>
 <YC0/xQTephcfo6GL@alley>
 <YC1DjeZmBWmJe35c@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YC1DjeZmBWmJe35c@chrisdown.name>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>open(f);
>  debugfs_file_get(f);
>  fops->open();
>    inode->private = ps;
>  debugfs_file_put(f);
>
>remove_printk_fmt_sec(); /* kfree ps */
>
>read(f);
>  debugfs_file_get(f);
>  fops->read();
>    ps = inode->private;  /* invalid */
>  debugfs_file_put(f);

Er, sorry, inode->private is populated at creation time, not at open(). The 
same general concern applies though -- as far as I can tell there's some period 
where we may be able to _read() and `ps` has already been freed.
