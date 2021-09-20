Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB22412B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347412AbhIUCUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344291AbhIUCNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:13:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DEDC09CCC2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:28:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j6so17085092pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=thLxpg55L9L13LgTK3I+f/Vrx/go018u31qP2p6Akx0=;
        b=WHXDWtWcwFGk7LtXnSZ+PjQsT2VIAEZhKXrYUYCUqx275UrjId3tNEFrVrFval+6VY
         ASne1xFDtcgrVAHM0ho6Jz0an8+X7rpaMwNgpvvoptvSiH7Nh4vjF4vM8+OwOEh54BVO
         he7wqilNLX8KmGWIidRONIwihDDVpXGrUbUOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=thLxpg55L9L13LgTK3I+f/Vrx/go018u31qP2p6Akx0=;
        b=RtBw6JlBs+AN0LLSkNA8WjPLshDcZh4aHOX/nlQVWA9fYIsjUDCUjseDPvWYIHvl+I
         TLgiqX25BSebiEMe+UUD79pi3PuO+eGE+vfu33qDGyDSYubrdusgDg0zb0/J+q1Rro9f
         1mEw9CwOPHy4d1jLJ7q44PJ5ckj+LWOlA2KDUuO6tzSub5zzdu20nOLv61DV1FOrqX1h
         d7TS10FrsgmRG9BTrG7rb6Ow13FOcamWeJE/trwHQMGjm643ZXYLDoOmWs6gn9DtfluE
         UwUIe8PmN81E8fE+bMdeY+Oj8KpxxOab2Ah0hgXe0iQJ8VhvMhXhvwCtw8Pr7a+AwYZo
         gysQ==
X-Gm-Message-State: AOAM531CHXzahPBz8pla6R0fs4fPm3TQRgKUUpv/11HZJGjUmdGPuND+
        ioFWNUA4ZHQw7LomOeE0y1X2Mw==
X-Google-Smtp-Source: ABdhPJwhFVKdYlCToObhylE8KnrZUUrTqmif27AzPVOfkfhLdgmla4KXX1yzLyQmcd3Kf9O4pHq1Dg==
X-Received: by 2002:a62:7c01:0:b0:447:cd36:c9a7 with SMTP id x1-20020a627c01000000b00447cd36c9a7mr3827780pfc.2.1632162532349;
        Mon, 20 Sep 2021 11:28:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6sm1965997pgc.68.2021.09.20.11.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:28:51 -0700 (PDT)
Date:   Mon, 20 Sep 2021 11:28:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug
 is enabled
Message-ID: <202109201126.E9902480D9@keescook>
References: <20210601182202.3011020-1-swboyd@chromium.org>
 <20210601182202.3011020-5-swboyd@chromium.org>
 <202109200726.2EFEDC5@keescook>
 <CAE-0n50v6Wm2OBsy5-Q3B9VrNhH+_uyDDa8Ps3MeXsCLZczW3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50v6Wm2OBsy5-Q3B9VrNhH+_uyDDa8Ps3MeXsCLZczW3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 11:23:01AM -0700, Stephen Boyd wrote:
> Quoting Kees Cook (2021-09-20 07:29:54)
> > On Tue, Jun 01, 2021 at 11:22:02AM -0700, Stephen Boyd wrote:
> > > Obscuring the pointers that slub shows when debugging makes for some
> > > confusing slub debug messages:
> > >
> > >  Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17
> > >
> > > Those addresses are hashed for kernel security reasons. If we're trying
> > > to be secure with slub_debug on the commandline we have some big
> > > problems given that we dump whole chunks of kernel memory to the kernel
> > > logs. Let's force on the no_hash_pointers commandline flag when
> > > slub_debug is on the commandline. This makes slub debug messages more
> > > meaningful and if by chance a kernel address is in some slub debug
> > > object dump we will have a better chance of figuring out what went
> > > wrong.
> > >
> > > Note that we don't use %px in the slub code because we want to reduce
> > > the number of places that %px is used in the kernel. This also nicely
> > > prints a big fat warning at kernel boot if slub_debug is on the
> > > commandline so that we know that this kernel shouldn't be used on
> > > production systems.
> >
> > Eeeek. I missed this patch. NAK NAK. People use slub_debug for
> > production systems to gain redzoning, etc, as a layer of defense, and
> > they absolutely do not want %p-hashing disabled. %p hashing is
> > controlled by the no_hash_pointers boot param (since v5.12), and needs to stay
> > separate from slub_debug.
> >
> > Can we please revert this in Linus's tree and in v5.14?
> >
> 
> This is fine with me as long as debugging with slub_debug on the
> commandline is possible. Would you prefer v1 of this patch series[1]
> that uses the printk format to print unhashed pointers in slub debugging
> messages?
> 
> [1] https://lore.kernel.org/r/20210520013539.3733631-1-swboyd@chromium.org

I'd like to keep %px use in the kernel minimized. Seeing full pointers (%p
hashing disabled) can be done with the no_hash_pointers boot param, and
that's used in other debug cases as well. I'd rather keep it a global
knob.

Thanks!

-Kees

-- 
Kees Cook
