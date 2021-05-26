Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5DE3920D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhEZT3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbhEZT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:29:11 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D68C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 12:27:39 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so2088513oty.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=XLye5dQGV2iB+VVuo0c6btLDSSuBEMFIhskiJnvHVYE=;
        b=Th5Nl+hYwEnZ+/OeAZzVsdhzied7v7MgxFvVj2nodjNlf4B0V9dqPcI7kOoa1HfK/t
         aTg76GIhBg8QQ+gnFmEDQ18hEZTFTNR9q9tAjaFhvnZLW4AXwFjw5IzGBqzrVEnNXpYs
         cSGmvPIOnLQJixXlHYQMmBOCzMXKD439PiAeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=XLye5dQGV2iB+VVuo0c6btLDSSuBEMFIhskiJnvHVYE=;
        b=qV93cY89s3eJvxNeKD7W7Z7TQDScmmNHkwO3sdVvFARM11JT0ex8JRwDync11teonN
         +NiGVO5vuVvwTR7rCs9nbtF9Oxc37hrsMtFV5fLPKgL6A212musR3X04ijvG9uPYswsZ
         ws5nQxvtn0YraUK0DzLGIjFh22OnrXVuwEf0rC1VZ9ZigEOwBBvTsXMb+lVinj3dYkta
         4RLs+O+Z055rsHbqmrPd5PhffT1RsBqlYXpGWSDWzkEseXLqm/kyWVeRuTm48X5l5DJp
         0Mw6K4NkunHeJZJ+ZEXVDB7HKUXUiHGe4mNlatkqR2DiRMIQjYHZQ/9ddVjjIlTx0Ydg
         VnCQ==
X-Gm-Message-State: AOAM531dl7NSsOW5GxheBv3JvVO6klGI73nmNUhjGcJ6fmFDuqj/N2TJ
        tHsNWxyvnblrW+UYcG79jKiy7ZsTCBoPL9MbgZfg5w==
X-Google-Smtp-Source: ABdhPJxmCzw3SOm2nc1UuS4XbsXRw1QkeeGorCYH2p0j+n9kIHqeE9+ZBWGu1fqJIYtpQcsAP2a3ReNuzbpYD1N1Sng=
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr3602055otp.34.1622057258594;
 Wed, 26 May 2021 12:27:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 May 2021 15:27:37 -0400
MIME-Version: 1.0
In-Reply-To: <YK5Rayu+nOoI2QZ4@alley>
References: <20210526025625.601023-1-swboyd@chromium.org> <20210526025625.601023-5-swboyd@chromium.org>
 <555eaf8b-deb2-fa49-ddef-a74645848159@suse.cz> <YK5Rayu+nOoI2QZ4@alley>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 26 May 2021 15:27:37 -0400
Message-ID: <CAE-0n50PogTpc8G9DR23DnX2K2pkvz-1vrO+iNAFOkhrzAOong@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] slub: Force on no_hash_pointers when slub_debug is enabled
To:     Petr Mladek <pmladek@suse.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Petr Mladek (2021-05-26 06:47:23)
> On Wed 2021-05-26 12:48:47, Vlastimil Babka wrote:
> > On 5/26/21 4:56 AM, Stephen Boyd wrote:
> > > Obscuring the pointers that slub shows when debugging makes for some
> > > confusing slub debug messages:
> > >
> > >  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> > >
> > > I opted for extern because I guess we don't want to advertise
> > > no_hash_pointers_enable() in some sort of header file? It can be put in
> > > a header file
> >
> > Hm looks like the bots disagree. I suppose a declaration right above definition
> > in lib/vsprintf.c would silence them, but I'll leave it to printk maintainers if
> > they would prefer that way or traditionally
> > include/linux/kernel.h
>
> I slightly prefer to put it into kernel.h. I expect that some more
> debugging facilities would want to enable this in the future.
> But I would accept even the "ugly" declaration in vsprintf.c.

Ok no problem. Would printk.h be more appropriate?
