Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6243688C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 23:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbhDVV5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 17:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbhDVV5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 17:57:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936A9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 14:57:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u11so18403806pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 14:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pnjm52HzazkxwK3GynZC11MQxdChi8kdZDeopKjh0qs=;
        b=GoZY0m0UZ0qQmrGqTkM9jPX2cL2TrHHFeXSKlSSh1aO048hkOhNa5R2SD2MAI2Twj4
         4x4IJRObeEktdNGj4ydKg16PqwKvSnrnFUA2bJAXC0Y7OHZbZPtH94vy0PGzSnpSumU1
         KE7sr3Eoh9JxN10ziswKngkMeQ7OKotmWHTg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pnjm52HzazkxwK3GynZC11MQxdChi8kdZDeopKjh0qs=;
        b=GL+cgHgpNzXwlb5rpvBRK3veAaYeDya6z25sVKo65wnOBZgaljD4rRzF1Kh0EusGpe
         GB0stmbtLanMXEPoH7p4t6piXi+Qir17SNtK9Knzmyv0KUhiqNyoNmcrWDuY0QfYpXZM
         fYgAOMcfZAQ4etOUi7MW1WwtOoRx0BEX4Tk3cvf9dzn4/1H/eKqjIlPrWuIRB/Av7KGO
         zkKnIZA+QpIYa/EOmMSylmaKi7QaZ2G7KEr9mlyH2Ppb98Gydl6Joya7NcjJBn4ccQiI
         Bew/MaKWbYkBhkNh0+0yztmLN8P5B0rDBlscOYXPicU7S4+3DDhjb/3dkSyiT97iG6/B
         jh9w==
X-Gm-Message-State: AOAM5315vj1eU0OdOcImOy55jTClkAoK7mwEtRJamLKhWcID35hPjnRz
        UAOaaoMf7XhRVJflftCRj+8Zzg==
X-Google-Smtp-Source: ABdhPJzHOU+Y/AVznnmhkZbbIJrhefJYkSnZ6h5VeisYc1+tERO6bvrsbiS6SUYbfJKBvqYO2ZImGQ==
X-Received: by 2002:a17:90b:3002:: with SMTP id hg2mr875206pjb.64.1619128635194;
        Thu, 22 Apr 2021 14:57:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x83sm2808798pfc.219.2021.04.22.14.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 14:57:14 -0700 (PDT)
Date:   Thu, 22 Apr 2021 14:57:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <jikos@kernel.org>, Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <202104221451.292A6ED4@keescook>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:57:55PM +0200, Greg Kroah-Hartman wrote:
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.

Hi,

The LF Technical Advisory Board is taking a look at the history of
UMN's contributions and their associated research projects. At present,
it seems the vast majority of patches have been in good faith, but we're
continuing to review the work. Several public conversations have already
started around our expectations of contributors[1].

- Kees, speaking on behalf of the TAB

[1] https://lore.kernel.org/ksummit/a72a13e56ee5f19b0dee9ae8c1928b020e8809c2.camel@HansenPartnership.com/

-- 
Kees Cook
