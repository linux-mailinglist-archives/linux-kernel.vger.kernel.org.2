Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9330D367240
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbhDUSJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:09:09 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53884 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbhDUSJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:09:08 -0400
Received: by mail-wm1-f46.google.com with SMTP id w186so18166459wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 11:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4OrAwM6HM7t7PmS20ysML10gn7rmGmTSDSvy/li7Gk=;
        b=gA/+1srFHkele3k40mdSolKHUXHAG9S6YQoov7f9Y17b/3cBjf1FPgbkZMP/0VJnG7
         Oturt7FO98saciwKojJY4FTqBbHHr9LJtbXpF/GOs9NeWSGIQPbbDxYKcWAJG6KN3GBE
         U9O+5X71K4A6NFI7Kc/HWImxEA43+ltInl9Ri3xSGXu9B3fjjJeYxc4XWUUhvhsdYrH3
         jTqMfV7hdx052BlJOuTw60spkh7bqsemyii01i5fY9Ca0yG7rfKNkUAnGeefIhB1jxkn
         3tfWpPqz2Z3MHojLXibhKGTN8RaaKaVIqXVinS++f82/0vW4RIKorndBH4OVbIl8umTd
         dh3g==
X-Gm-Message-State: AOAM530ZqNwV5zeu5UMCWvZM2RQb8KSZPMpaBgwsb/WRwM+46kdrK1xf
        MknzFQWKJjkBf1oQl0Q3Agg=
X-Google-Smtp-Source: ABdhPJyFL82e5C7Do7GdbrxzS4rQGprDL3osqSavHza1AVDNDPZXHUjOIcv4QXJgLxl9gE6Pk4Jypw==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr11064811wma.164.1619028514200;
        Wed, 21 Apr 2021 11:08:34 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.googlemail.com with ESMTPSA id g3sm198915wrp.46.2021.04.21.11.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 11:08:32 -0700 (PDT)
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
To:     Al Viro <viro@zeniv.linux.org.uk>, Kangjie Lu <kjlu@umn.edu>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Qiushi Wu <wu000273@umn.edu>,
        x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Will Deacon <will@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <4afeeb49-620d-5a9d-29fc-453f6118a944@roeck-us.net>
 <nycvar.YFH.7.76.2104211628560.18270@cbobk.fhfr.pm>
 <CAK8KejoGgoWcEUm7gnTw+_5CuZX1+bnHoeY0Ea-pAO+gd8dbcg@mail.gmail.com>
 <YIBBt6ypFtT+i994@pendragon.ideasonboard.com>
 <CAK8Kejqq4qUT=2nqvnVM=r7H_P3dF=+3dHa6HWOCP=9GeeTbpA@mail.gmail.com>
 <6406f3ad-141d-5533-c717-e11cea4e179e@roeck-us.net>
 <YIBlggJ2hZ3TYszc@zeniv-ca.linux.org.uk>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <8bef2ac8-2e05-a0b5-3518-e59ad32e0138@kernel.org>
Date:   Wed, 21 Apr 2021 20:08:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIBlggJ2hZ3TYszc@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2021 19:48, Al Viro wrote:
> On Wed, Apr 21, 2021 at 08:59:34AM -0700, Guenter Roeck wrote:
>> On 4/21/21 8:21 AM, Kangjie Lu wrote:
>>
>>> All of the commits sent by my students are in good faith to fix some bugs.
> 
> 
> Just to make sure - does that statement cover the following commit?
> 
> commit 0c85a7e87465f2d4cbc768e245f4f45b2f299b05
> Author: Aditya Pakki <pakki001@umn.edu>
> Date:   Tue Apr 6 19:09:12 2021 -0500
> 
>     net/rds: Avoid potential use after free in rds_send_remove_from_sock
> 
> And is "Ph.D. student in Computer Science" an accurate description of
> the gentleman in question?
> 
> We all made utterly bonehead mistakes (if you want a fresh example
> of mine, take a look at 161aff1d93ab "LOOKUP_MOUNTPOINT: fold
> path_mountpointat() into path_lookupat()"; see 035d80695fae for the
> merge of the fix and explanation of what was wrong in the original
> commit).
> 
> However, there's a general expectation that once you become aware of
> dumb mistake in something you have published (and merge into mainline
> certainly qualifies as publication) you shall retract it as soon
> as possible.  If a student is not aware of such expectation, their
> advisor really ought to inform them of it.

Mentioned gentleman was also notified on 8th of April with Coverity
report that his patch is questionable:
https://lore.kernel.org/linux-next/202104081640.1A09A99900@keescook/

The report was ignored by the patch author.

Best regards,
Krzysztof
