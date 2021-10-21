Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF29D43672B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJUQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhJUQEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:04:22 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B7C061220
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:02:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id c4so706142pgv.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aQXnGSvGwqVsJ8nP8kr+l4vStpxJv5nNjrJiBNRwZ+M=;
        b=jhcXD7uXJAO9grkMAifc99WARslOnjDNWHarUyzrdB0UVxuWb42YrgWWVyzhkJtx6N
         FU3tSvW3JDgvVfLXOyckE3uKTYO/9/PIzybZXNdE8CPK20RMM9jQWkTlCEogsh811zdS
         B6u+g+Ze6cDw7Y18Te1VGsUkKIkZoT7CpHEhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aQXnGSvGwqVsJ8nP8kr+l4vStpxJv5nNjrJiBNRwZ+M=;
        b=Thj1XtJafHT6z/8Lk9/P7agSN4wOYdAodhhqGQqO9oK4TV7aaVRR83GVy/QUsiz/fn
         r6Tq461gV3SmCnu3HwFD/zx1KfNY5MkT1rCD5nrGzMMRy9m99M1mUnSMsTol8ASYHtgX
         hRTom2ZgNStBGeNviHoHvFrOb+1NGgVUIj8jg1REVY98hLMt4Hm9pJG6dn5NjLy+jjj5
         hlLTh9HhYbImCIkQonMXYBgnVvVyV7dvzNstW2cDq+Deg3PmoWr85HXDaLzox6Z7uhIP
         L7PQrKks0w3xSomKJn7wV5HxjjjLl+TqlLGmoNexOaNHrJ0O/NsM4elNDWNbll2IFPEP
         g0Mg==
X-Gm-Message-State: AOAM530eFXW0UE4whjH73lZmcADXQFKGWExmWED/xS5vlP2S3TOGUtdV
        KOnTUrccHXh9dTDsjP8h4Shtbw==
X-Google-Smtp-Source: ABdhPJx1yhwpe/xDEMSeojXmDAbO0TukzgYU8mc+AUTj9ZKyfVJv0GgYxvFuub4zNr1a2522ltR6+g==
X-Received: by 2002:a63:731a:: with SMTP id o26mr5153446pgc.248.1634832125531;
        Thu, 21 Oct 2021 09:02:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2sm6595890pfa.34.2021.10.21.09.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:02:05 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:02:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 02/20] exit: Remove calls of do_exit after noreturn
 versions of die
Message-ID: <202110210858.41719190D2@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-2-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:48PM -0500, Eric W. Biederman wrote:
> On nds32, openrisc, s390, sh, and xtensa the function die never
> returns.  Mark die __noreturn so that no one expects die to return.
> Remove the do_exit calls after die as they will never be reached.

Maybe note that the "bust_spinlocks" calls are also redundant, since
they're in die(). I note that is a "mismatch" between the do_kill()
in die() (SIGSEGV) and after die() (SIGKILL). This patch makes no
behavioral change (the first caller would "win"), but I thought I'd note
it in case some architecture would prefer a different signal.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
