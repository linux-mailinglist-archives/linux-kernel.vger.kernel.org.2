Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EECD3AEA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFUNle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 09:41:32 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:39:17 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t40so19909207oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SlsfaUgftQgrdURbxAicfaKybIgGMEKD/HUsa5tnDsk=;
        b=e12KD3PF21L2iNu0VZlijI3q/XSQ7XCl/FiSrwzQdSAp5vMIfOzbU2aO1OBhUZbOZn
         Xn9nC76rff40g+QCcKhiOmhVmD1ylNuQp/gH1Hvzrzqp70Q7n+iEBmGXLUJ0eVtpHBIl
         mr0rKTlFmnN4BkScw+jD9MmVZF9/cqoUlLSP5sJ2839bxM0k5Bsn7PeG8684RjaydpiG
         ixZcjN06m2QY3iL6tnq8WjJuSetGmbSa3v1mbYVDlH2gQL+Pfnfw0ukyBQB6E3U2duJI
         ZNxmgepfvrJePKCearRMRZ99dB/TGgvcLVkgP2/YdpJtT6U9SbbQHGtHw4Io2iVM3WnQ
         rLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SlsfaUgftQgrdURbxAicfaKybIgGMEKD/HUsa5tnDsk=;
        b=XpuSWMPC1mBUjCH1Zu0DxFCiDzuTD9r9xRowp/Kbz4O/RlsPFsQ1coO04fqAQVCecI
         tL6Oxt8lg79TOcuuyBiUorxYbV2kkvE3YH9p6fGCVAa5Lav1L+MBpDCdrIxWALRmKtwT
         DkYTF8caVrM8WCBZHcijOtA208LFjw/dJR3E+1u/JG9m1xodCjJvuabbPnU8mEAAj5dH
         ZGr+towwYj/SSDm9gA+AiA2diD3bxvUlMxuEvhZStuPa47vFwUGlJB9Z3tYFP7JQ7i3L
         OKYA8A1lf+JVgyQY3tFcWlhoMvO5QLqDbUl7VMRCP/aHMOgShvGw3Pz12W6Qe33A9ye4
         j9PA==
X-Gm-Message-State: AOAM5312eqe4B0R0IV3hUwp0BXUg9S9osNfYKH3geyoyhg6c/F63l2Py
        nDBQ3e0ZVlTru7SwwlNmlMYxH4Gw664=
X-Google-Smtp-Source: ABdhPJzgMi8FPvodak6dJOOpaajWJsWXOqJU3MnX2P5P1QRclc+zwWwEZb/isLRNJnr6A7T3aRuL1Q==
X-Received: by 2002:aca:cfc9:: with SMTP id f192mr17576108oig.127.1624282757150;
        Mon, 21 Jun 2021 06:39:17 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q9sm3656426ots.1.2021.06.21.06.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 06:39:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 21 Jun 2021 06:39:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.13-rc7
Message-ID: <20210621133915.GA2892783@roeck-us.net>
References: <CAHk-=wjj38E8hW+unHZ9EaJrS6x+4Tnz0qffjvLcGf70dXkKnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjj38E8hW+unHZ9EaJrS6x+4Tnz0qffjvLcGf70dXkKnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 03:40:16PM -0700, Linus Torvalds wrote:
> So we've had a very calm last week, and in fact if it hadn't been for
> the networking side, it would have been positively tiny.
> 
> Just over half the commits are from the networking tree, and honestly,
> though networking changes dominate, it's not like there's a ton of
> networking changes - it's all  pretty small.
> 
> The two largest commits are a revert and a code movement patch for a
> build issue.
> 
> So there's not a huge number of patches in here, and most of the
> patches are pretty small too. A fair number of one-liners and
> "few-liners".
> 
> Which is just how I like it.
> 
> Let's hope the trend continues for next week, and I'll be a happy camper.
> 
> Go test,
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 462 pass: 462 fail: 0

Guenter
