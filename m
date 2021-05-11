Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02253379B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhEKAHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhEKAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:07:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E143C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:06:01 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a2so17184846qkh.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUM6GCiWQ87fBmMe4R6b3VuwWCudO1qdVICMp3zaKIc=;
        b=KFj5l6zhdrS0fLCWMGjmr/xO4BlTFtZoz3C0X6f4yXPAPd4QFYCKQ6VCRUB/RhrcYc
         /aNljSGJlQqpYw9kb4Ei54tqu7LZbNffzPVR359jRbFKseto3PQlwou2i3Frh18gwxLZ
         83EJdcrxGqEoNBrlRvGIOn9J8VC7CuWrNZTlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUM6GCiWQ87fBmMe4R6b3VuwWCudO1qdVICMp3zaKIc=;
        b=CwBSJnAmr3gRE0021iKpIv9X5VfwqD4YMVvIzTQU4uAo3l0jz9rt8GqKUSS8L3/ibv
         VzDvNswc35NPu9PsOGR7VJBT9tVcbN5GS/NmwQl/iTjO+a/zOhT6NfAzckFVVfXPdzuI
         UAz1aNwo+2yjLjTBj/WGFl8s/3c/et7Yv5ikGntxb6m3QSeRV1MvBauOfbdclCfrZK86
         sGyHJWlktN++pOIcHkmRm626j5ZFOsvMNEAE7VZk3bwwvA61XWo96AfRzRqycd5Hok79
         dqNrnZ8Nwb3fLMH4jQ4eCq0KIyjsZ8bkf7QqfNakNQ5wHWdJSkHXudRE0mjyAHzrHrWo
         RmiA==
X-Gm-Message-State: AOAM532YPXNjwGixd0t9xQ7Z74IzhtBDFoCZP054lKAixWBiBr2Jj6sJ
        MCbz1HhjPwt+fwXHMJUptCwTmP2shjJt/g==
X-Google-Smtp-Source: ABdhPJyDjx9V6by26x8o2E1g8UyMNQcLsFN1Tgfddq20j8XN2ncl5fX9q5yPpY610pL/dNGeY7QT5w==
X-Received: by 2002:a05:620a:8dd:: with SMTP id z29mr25433183qkz.84.1620691560338;
        Mon, 10 May 2021 17:06:00 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y4sm12642728qti.53.2021.05.10.17.05.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 17:05:59 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id e190so23983953ybb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:05:58 -0700 (PDT)
X-Received: by 2002:a5b:8cc:: with SMTP id w12mr37539122ybq.32.1620691558469;
 Mon, 10 May 2021 17:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210510150413.59356-1-andriy.shevchenko@linux.intel.com> <20210510150413.59356-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210510150413.59356-2-andriy.shevchenko@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 10 May 2021 17:05:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VpuyYBv2tj5AHLx7U7vfCpH1A6hfG_amscZ6OupRwEHg@mail.gmail.com>
Message-ID: <CAD=FV=VpuyYBv2tj5AHLx7U7vfCpH1A6hfG_amscZ6OupRwEHg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] kdb: Switch to use %ptTs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, JC Kuo <jckuo@nvidia.com>,
        Joe Perches <joe@perches.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-tegra@vger.kernel.org, linux-nilfs@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 10, 2021 at 8:04 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use %ptTs instead of open-coded variant to print contents
> of time64_t type in human readable form.
>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/debug/kdb/kdb_main.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

I kinda doubt anyone would really care if we just switched kdb to just
the old "%ptT". Probably no machines are parsing this string.

...but in any case, now that the nifty new format is there we might as
well use it. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
