Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAFE4192BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhI0LHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbhI0LHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:07:30 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF7C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:05:52 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id z11-20020a4ad1ab000000b0029f085f5f64so5863873oor.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=waRvB9fZNkViCCDTQrVe/BvOxgqBfO5q5GdwYMSRpkc=;
        b=SezwVY7xYJ6cynVnmBm2507bW41aCSZovWhY15w6KzqPaqOhAa9Ms8pTRI0NLxwdhX
         LV7vDgAmxOhv2xrJU2S3hAUukSvCyZs1wuV7sKW00d/5nv0TdF9ngX5S2/9Is8C3rKET
         q7vPbtwxgSDFXoSEJY43snjzvvlwgGkReNz1t+cXHUz0im9P4TKK7WVgtVLpktXqa1yB
         jud6eC84BJdhxnvXjoJxnUh8Whvi+4QCrGh/0L0lwZcBAjrFWXL0LGKmhiCPVIauPj3n
         uHrTHa7rVKsUdydoExvPiNRoVYKQ8D9p2M3/53HbumrKI1+IEQxGXpx7VfPfflB5f8Xy
         lahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=waRvB9fZNkViCCDTQrVe/BvOxgqBfO5q5GdwYMSRpkc=;
        b=tzV6mRDwYppc3gmRAT7AyyDj0h1AXKk1nnai+IuFtEgVZ/lEvqLIONZy9MgwRO1IJq
         dn90BzYYWGJF72B2fX/jh48ZT1NZkSBoB6Zn/k0g2UqhCbUPeGzG7H/TbCax8KVulBwh
         xU0bqtUpv2/rGBsh6zgvq3Stm1ntbA3diKpl5JCl7ROYXekqdvw0S7Z02j9tR21CEa40
         BuTeoxo9n4UUzzdWh3zZmRFFZycrrUdFAcS2tf4pjlUmRGaeIgocsZbyy0jH15GHQwRw
         tUsXJ0FWkz+WXQCuoQnf2xVa6tLwRTJr/p+5UTEbfYXiQVpyUb+CiahfxVNhVZsV4O5j
         1xXA==
X-Gm-Message-State: AOAM5307AbfvMt4WyIVGDtJmoasXVd8UOolmRKOYnBNMMjMUnlBgAUbx
        xLMdF1ys4k6DFHkt3kILclqxP7g3L3U=
X-Google-Smtp-Source: ABdhPJxZs4U4QSZUGMEILNCeGI8FsW3nZT+FgStW96KgL0ZyuEyXdXHWujy67/ip0YXl87pl0HzKww==
X-Received: by 2002:a05:6820:60c:: with SMTP id e12mr13256917oow.49.1632740751580;
        Mon, 27 Sep 2021 04:05:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w7sm3141820oic.12.2021.09.27.04.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 04:05:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 27 Sep 2021 04:05:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc3
Message-ID: <20210927110548.GA771805@roeck-us.net>
References: <CAHk-=wgoE8XBPVA6Mu4CygxX9TE0FgWaAsVUJOe8KQH-CzEcAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgoE8XBPVA6Mu4CygxX9TE0FgWaAsVUJOe8KQH-CzEcAA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 02:21:52PM -0700, Linus Torvalds wrote:
> So after a somewhat rocky merge window and second rc, things are now
> actually looking pretty normal for rc3. Knock wood.
> 
> There are fixes all over, and the statistics look fairly regular, with
> drivers dominating as they should (since they are most of the tree).
> And outside of drivers, we have a fairly usual mix of changes -
> architecture fixes, networking, filesystems, and tooling (the latter
> being mostly kvm selftests).
> 
> Shortlog appended, it's not too long and easy to scan through to get a
> flavor for the details if you happen to care.
> 
> Please do give it a whirl,
> 

Build results:
	total: 153 pass: 152 fail: 1
Failed builds:
	mips:allmodconfig
Qemu test results:
	total: 480 pass: 479 fail: 1
Failed tests:
	sparc64:sun4u:nodebug:smp:virtio-pci:net,i82559er:hd

Almost there ...

Guenter
