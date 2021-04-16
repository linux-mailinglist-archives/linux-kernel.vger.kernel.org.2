Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB06C36223D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236146AbhDPO3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhDPO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:29:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF15C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:29:25 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id er3so4995627qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igWDgh9IJADDLWdmr+Gx3PIyFrGEnIOdQ5FOM/bO5gA=;
        b=CLeqzciOvboS+V0QWZ8gt89bXrLcbTcsXtLsSUHh+5y4PnAka+MYG8fqJWbGh9D1BR
         CrO9xe6SLhk6YypzJtDIDis+aJX3OwJaqsy+8B+ZkzU7YU1WxnEPfYEfAKoW+1IHSEUa
         jq3Zf2Y0cfwOrN97NJquLTuF3w22mac8QFUDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igWDgh9IJADDLWdmr+Gx3PIyFrGEnIOdQ5FOM/bO5gA=;
        b=ZvGwxAX4dI9pdh5ch0PCr8i2eBpeFYLYxTDTagicSzZra2zDwsmwB/89VRtbaLYyxo
         9gHi5VfI0ekqnqLGMGY5xEeaS+M40Q2vAgVZqORSVqevEAlnNz4QVUca7aLYk/A2UqG/
         To3o/Vtq1COZH9iFRBQHAwLE7y8mL9I9sHUEABMLPorGYsrMhyspssJd8bO5MTeScYqr
         rXhcFRmZYBGyeS3j4piwAvCduNm00XFVDJkZPJ1lUh9OlejJT0wQW7r3AWSpisMhie3m
         ott35MQ5X5AGFwgDVpzLJTENURO+MBXqIizDS7s/V46TPonYlwAe2jeUbZnrHSaUV82D
         8Mpg==
X-Gm-Message-State: AOAM531aVoeKUdmkEIYgFMV11Ga0EYccYtDbiHAeAmzhvnQYy70xhCBH
        GipQs6CCGgY0SJ7kAmMw514HdA==
X-Google-Smtp-Source: ABdhPJziG4W3r7sx6F/ZJSO++dwNBbVDeBzvTjIP30O90Dt55mVyVswMckF45mWyyC3pzkEFjqxd/Q==
X-Received: by 2002:a0c:80e1:: with SMTP id 88mr8823129qvb.43.1618583364649;
        Fri, 16 Apr 2021 07:29:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:27c])
        by smtp.gmail.com with ESMTPSA id l24sm91975qki.119.2021.04.16.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:29:24 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:29:22 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YHmfQtHj1NY/oykv@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name>
 <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
 <YFMvfawY+0CncS8G@alley>
 <YHmXi303WxVZzVwI@chrisdown.name>
 <f6f66233fbd670fef82a199ab0299489618cad81.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f6f66233fbd670fef82a199ab0299489618cad81.camel@perches.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches writes:
>On Fri, 2021-04-16 at 14:56 +0100, Chris Down wrote:
>> Any better suggestions? :-)
>
>A gcc plugin that looks for functions marked __printf(fmt, pos)
>so any const fmt is stored.

I fail to see any way in which that can solve the problem described, which is 
mobility of the level information, not the existence of the format itself.  
`__printf` doesn't communicate or imply any such information, since it's 
completely level agnostic.
