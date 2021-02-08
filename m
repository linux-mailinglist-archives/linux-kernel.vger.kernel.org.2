Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4640314204
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhBHVje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhBHU7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:59:54 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47DC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:59:14 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id d20so17087368oiw.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sm/IPDoPOmDmZ8bSmx2HQVSLY3l8ULrZwipaoTvgM4o=;
        b=sVVBvCj3UyNzhDaEN9Qe/sqSDv7IwiNCv5caVUortlEEED1WBRxcRC0nBq49TVfkUf
         Ha/kc5IAaEpZipIa5BFBRrrFWxZCHuWnqCsK0J8g1bz1Xsgn+gUFOlF//NKFIyIIYs4A
         9/sjgHYThZNkonT5xwZyG5/clfQ5wr4iOlpRTNPn5mUmum+RyUyk5yja8uDQD1dtc5/I
         6lk2C3RlTNyWwDuoTk0wz/w8J7N8oy7W28/F5BHCHHim5eemhIp2wQWRtITaUaAk7nxD
         ZqRAbREizJqYVgAZNBZLSW8lOw3uRZWCxSHsKZw9rUFjbVTv3+nK0oYdX9NxcfdP6U6i
         pGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sm/IPDoPOmDmZ8bSmx2HQVSLY3l8ULrZwipaoTvgM4o=;
        b=CxS0k4y9mQp017YCqUOi4gd6KyDW5eDYCvWw9jk30eckTqlEywrDOTyrsNuHic7xq3
         pmRa2TV234CisCESZR9Gg/JM/2YZuJXV75oAqNSQz1N2GmeMyARAd/zLqx94PTrHNz8L
         zhOa9mgbwavXOGNcriDgts7g4rAqAoyXKtG/7PDk/dWnnROzX4Xmx6p8wreVoPO6vYFN
         SkBxm7T7WjTw4TesQ9lrCOIZlGda1oJw46e8t4SRzAlZxdpAjU2uxnlPs0/Pf2dV5yRB
         5jRjrZ5XQRHGoAGdoGLRr2ren90D1wiQ8Q2S3Y3TcVq6pzUTrlDHqNgTAWqxkkjTpZqM
         lSIg==
X-Gm-Message-State: AOAM5318kEU1yQcBxEpBUxSsDycCFR1rf8oI4/7BXlNjlVV8XqWptaQD
        9bk1COKiz//2yhouXPyPc1p/rTJsqJk=
X-Google-Smtp-Source: ABdhPJxhZh2sm+aHu5k5tQH7af7Q/qDNYpzGS6mqsRae6n0wADWnHZYDPJxT7PP678GN+UPaJ4a69w==
X-Received: by 2002:aca:6289:: with SMTP id w131mr383232oib.69.1612817953891;
        Mon, 08 Feb 2021 12:59:13 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21sm3821721oot.34.2021.02.08.12.59.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Feb 2021 12:59:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 8 Feb 2021 12:59:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc7
Message-ID: <20210208205911.GA179375@roeck-us.net>
References: <CAHk-=wgxhBkWH0D6chYcwqDvdh2rB5ZVpToxodz5Q6qaFd_qyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgxhBkWH0D6chYcwqDvdh2rB5ZVpToxodz5Q6qaFd_qyg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 02:32:37PM -0800, Linus Torvalds wrote:
> So it's the biggest sporting day of the year here in the US, when
> everybody is getting ready to watch the yearly top TV commercials,
> occasionally interrupted by some odd handegg carrying competition that
> I still haven't figured out the rules for after twenty-odd years here.
> It's kind of a more violent and hands-on team-oriented version of the
> traditional egg-and-spoon race, and involves a lot of standing around,
> apparently waiting for the next commercial to come on.
> 
> Outside the US, everybody scratches their heads about the whole thing,
> and hopefully life goes on with the weekly celebration involving
> compiling and testing new kernels instead.
> 
> Right?
> 
> Anyway, this is hopefully the last rc for this release, unless some
> surprise comes along and makes a travesty of our carefully laid plans.
> It happens.
> 
> Nothing hugely scary stands out, with the biggest single part of the
> patch being some new self-tests. In fact, about a quarter of the patch
> is documentation and selftests.
> 
> The rest is just the usual random noise - architecture updates,
> drivers (gpu and usb stand out a bit), some filesystem fixes, and a
> few core VM and networking fixes.
> 
> Go forth and test. Unless you're glued to the TV, of course.
> 

Build results:
	total: 153 pass: 153 fail: 0
Qemu test results:
	total: 430 pass: 430 fail: 0

Guenter
