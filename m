Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D571331972
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCHVjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:39:05 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:46797 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCHVih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:38:37 -0500
Received: by mail-io1-f54.google.com with SMTP id u8so11579759ior.13;
        Mon, 08 Mar 2021 13:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wu8ygw+DLkA/IZAWrdk6TaRb1zQwZe4XwnS40aehw3k=;
        b=laEuazBARK4NQ+18ZPWnAfqAAKjSG7w2NsUn8mFUEgKF2tRh/JM/aFtFQL8dbRR48o
         pxbdkrzFs55xeo/bABvch3qZXYfB9zl9p3Oc96lOcwtjNPDTZlNoIIbQLCTt2bb32xrh
         Tc9tGzfXrPKXf+pKtNPrrLiUY0h6qvU3B9WYria2NrdTR+Swx87eBdwcvfbJ7F2NO+4k
         GUsnw4JLUQWrWm+W1cBhC2kPZpoU8n0zG3dNzzI66bwB4qfGMxx+4tSkCsvIgQWeYLsR
         hUpSJ36F5lFJXEJS7SU04wAAfad/EA5AaWeLg+VtuoRg+hJNkGpvXlUQIbWTWZRECHoZ
         QEmw==
X-Gm-Message-State: AOAM531p9VTmSxTkHcUoFbHb0TP73n6nwsCS09A5WYng0BbKMOYb/ahC
        2LScdf5c4GAD0U89YX6fRQO5Ou20sQ==
X-Google-Smtp-Source: ABdhPJzHQtVzOuYxFh4XozV1PFZ2C9+1/yYdPuIGWskBfSzRjszK9pn6TUPXZl+8u85DAeAq15IZ+w==
X-Received: by 2002:a02:53:: with SMTP id 80mr597992jaa.96.1615239516846;
        Mon, 08 Mar 2021 13:38:36 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s7sm6458068ioj.16.2021.03.08.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:38:36 -0800 (PST)
Received: (nullmailer pid 2999323 invoked by uid 1000);
        Mon, 08 Mar 2021 21:38:34 -0000
Date:   Mon, 8 Mar 2021 14:38:34 -0700
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] dt-bindings: misc: add binding for generic ripple
 counter
Message-ID: <20210308213834.GA2973251@robh.at.kernel.org>
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210226141411.2517368-2-linux@rasmusvillemoes.dk>
 <20210308172153.GA2505339@robh.at.kernel.org>
 <12be138b-631a-4f82-aae9-6bbdc7bc2bcf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12be138b-631a-4f82-aae9-6bbdc7bc2bcf@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 09:02:29PM +0100, Rasmus Villemoes wrote:
> On 08/03/2021 18.21, Rob Herring wrote:
> > On Fri, Feb 26, 2021 at 03:14:10PM +0100, Rasmus Villemoes wrote:
> >> While a ripple counter can not usually be interfaced with (directly)
> >> from software, it may still be a crucial component in a board
> >> layout. To prevent its input clock from being disabled by the clock
> >> core because it apparently has no consumer, one needs to be able to
> >> represent that consumer in DT.
> > 
> > I'm okay with this as it is describing h/w, but we already 
> > 'protected-clocks' property which should work.
> 
> Hm. Unless
> https://lore.kernel.org/lkml/20200903040015.5627-2-samuel@sholland.org/
> gets merged, I don't see how this would work out-of-the-box.

Hum, no really clear what the hold up is there given it seems it was 
asked for. Letting it sit for 5 months is certainly not the way 
to get it merged. Anyways, that's the kernel's problem, not mine as far 
as DT bindings are concerned.

> 
> Note that I sent a completely different v2, which made the gpio-wdt the
> clock consumer based on feedback from Guenter and Arnd, but that v2
> isn't suitable for our case because it post-poned handling of the
> watchdog till after i2c is ready, which is too late. Somewhat similar to
> https://lore.kernel.org/lkml/20210222171247.97609-2-sebastian.reichel@collabora.com/
> it seems.

Now at that one in my queue... I think 'protected-clocks' is the best 
way to avoid any driver probe ordering issues. It's the only thing that 
really captures don't turn off this clock. The ripple counter binding 
doesn't really capture that or what it is related to. Also, the 
ripple-counter driver could be a module and you'd still have the same 
issue as v2.

> >> +
> >> +Required properties:
> >> +- compatible: Must be "linux,ripple-ctr".
> > 
> > Nothing linux specific about this.
> 
> True, but I was following the lead of the existing gpio-wdt binding. Is
> there some other "vendor" name one can and should use for completely
> generic and simple components like these? "generic"?

Most 'generic' and GPIO based interfaces have no vendor prefix.

Rob
