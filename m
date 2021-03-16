Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563EF33D4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhCPN1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhCPN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:27:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8EFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 06:27:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so10468850wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 06:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=67uoJKdYBh8tQV40HIG90UexwfHLuY9jTAB6z5BSSrA=;
        b=HMhpx5SEBC+Au2+GhEcsH/vL4DzQcuHWMUHGM3+CxAfeXPJW5W9c7y+bpE8KQTsGkf
         8MgD0w1B23LEPRpVlRfUuFf1zgyuuZHkXSrmwHgQfgYh28jTjn+IgpLso6a3uj836qxV
         K4uJdZdpsEgCSRZEQYnFIbbb85YV6TnJBcDdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=67uoJKdYBh8tQV40HIG90UexwfHLuY9jTAB6z5BSSrA=;
        b=UpFTM7yP02e6RXUY5TQYhYWYYhstNzSCXoft0I5jsT0wGLTVFiHWrsAB6m4Wzaw51Q
         d6KyG2NMDOrUy1Cypuv0kqiK0bJ4NHuOHGy9zIvgFGPI3rp8JfhWSI0TioOFMeYAPTQG
         LBmM3/kg1At6aVBUTaB0FufgdMAFp0O2hgM/XYK2Rfx7CHOWf0nP0pITYuE5nIPGnTbO
         A9/iBIfb09VW4kXU9UVzwlvqPPEYmJi8Khe+jitcpD6fHfMFhhWVe4C+64Ln5mB0tMq1
         E9tYYSG91IaOwqs8CW37jfdatfp69ejDQXXjT8hU732BCCGDauHJaYDnhJuXtv4QsqwW
         XgSg==
X-Gm-Message-State: AOAM530vShRUv/bFqtVwKftm3R1KTmhvSdO6sxtmKhVcgahtDyyvZxC3
        k5yI9P/xwqEdgRmU5xHB74U/8g==
X-Google-Smtp-Source: ABdhPJy2vnjiRPaz8kylIqsrFYYSv6pCZwN9ldhAXs1JicKsDcMJIb0IEWwo7urOQDh+fgApOxjIjw==
X-Received: by 2002:adf:a219:: with SMTP id p25mr5036828wra.400.1615901221495;
        Tue, 16 Mar 2021 06:27:01 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::4:54e6])
        by smtp.gmail.com with ESMTPSA id g11sm21801555wrw.89.2021.03.16.06.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 06:27:00 -0700 (PDT)
Date:   Tue, 16 Mar 2021 13:27:00 +0000
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
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YFCyJBg26TGdjBxu@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEtNKMF3KH1kUDxY@alley>
 <YEtyUM07gsqR6ltG@chrisdown.name>
 <YE8wvGHhbV4nAGGI@alley>
 <YE9RK89jLbLQcSEq@chrisdown.name>
 <YFCY2VIlpYc6cANM@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YFCY2VIlpYc6cANM@alley>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek writes:
>> In my mind, pi_start is really just a special case of pi_next, so the code
>> flow makes sense to me. I'm happy to change it to whatever you like, but
>> it's not immediately obvious to me what that is :-)
>
>Good question! I have missed that pi_start() can be called also with non-zero
>pos when seeking.
>
>OK, pi_start() has to handle pos == 0 special way, so let's handle it
>there. Call pi_next() only when pos != 0.
>
>The following code should do the job. I took this from my previous reply.
>It is already based on the other suggested changes:

That also looks fine, thanks. I'll hopefully have time to send v6 this week.

Thanks for your detailed feedback! :-)
