Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168F237456D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbhEERFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:05:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236430AbhEEQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620233748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTK6lemix9YlumzW7Uihx72Gv5mHCwrQfPIGSzcKIQo=;
        b=O844scHLoLShNn+ya1QutRHdZoFDf5cogYscuKnqR7KiJG8TR6Ft//ncJObLKMrJw0mExF
        sIVxi9aHKoJa73WMvOFVIzFzFNccCt6BFY3tfZPbtiufFrTgu3ptafephubxNHaUTZQet2
        65JLy6b3CNOW/g6Qgudt9umVpl0HI80=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-Gm9cO7FSNmupq1rkasRVMw-1; Wed, 05 May 2021 12:55:47 -0400
X-MC-Unique: Gm9cO7FSNmupq1rkasRVMw-1
Received: by mail-qv1-f69.google.com with SMTP id h12-20020a0cf44c0000b02901c0e9c3e1d0so2132202qvm.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 09:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YTK6lemix9YlumzW7Uihx72Gv5mHCwrQfPIGSzcKIQo=;
        b=Q9CkvK7hRuqU9MV9keEU1QlTcCFaBvy/HMrBLJlsKi96JOR7t+kPFmF32MKX5Bs2aA
         D41NruQduzN4mh0U0jTz7LX+UCe+ncvORfhY/wd1Q35ikSv6jsdFnHCYM3MdZYciW8hP
         jvl0e6AiONZpGahunGZstUFUtKDntFfxMWeA4DFTpgym/w7OYfrwIKZOc8lOUvA9Juka
         1pDm9yFTuqA4Nj5CA1iO21bkLv/klw9jwDNYa2rxQ2zwObwadf7AfAfbqd8vHRDEVctY
         1a/pP8xa0PKdaXSeg8r97kxfR+DABpROmvFeKv9u3TNqe7RXxKk/9EpCdwMcru6irN5n
         xMzg==
X-Gm-Message-State: AOAM530t3atjcJZco38gfmfrPjpCM1LqGfaTYV4j//h1ITZOZe21+1jj
        H7p3BkBmP+S1oSCnkAeBQPvkmRmgtp7h9FX6yzQbfv/bXq7dM9dQU+oi1iy9hc5CO5xxCYRDVwO
        6Gt9rLBdcJxtvDMNYj2Vbk9O5
X-Received: by 2002:a0c:9e17:: with SMTP id p23mr31858577qve.7.1620233746697;
        Wed, 05 May 2021 09:55:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzQgd9omI7z/ncp40KSbxb3XTdDZ40gxLFrJtkGGRso1enGHeua6FEMsXvhVC6n87Tfw63DA==
X-Received: by 2002:a0c:9e17:: with SMTP id p23mr31858560qve.7.1620233746524;
        Wed, 05 May 2021 09:55:46 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id i5sm4039327qki.115.2021.05.05.09.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 09:55:46 -0700 (PDT)
Date:   Wed, 5 May 2021 11:55:42 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Print out unknown kernel parameters
Message-ID: <20210505165542.tpptt5g7ffxcfmxe@halaneylaptop>
References: <20210503213400.27360-1-ahalaney@redhat.com>
 <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
 <20210503184606.5e8461c0@gandalf.local.home>
 <YJFho3AasxxcD/hH@zn.tnic>
 <20210504152614.mgiihv4ukqajo3jb@halaneylaptop>
 <YJKpv6vjCcCkbzNT@zn.tnic>
 <20210505163728.oh7rqpdvxrdilmfk@halaneylaptop>
 <YJLMxXp2f7YvjGJ9@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJLMxXp2f7YvjGJ9@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 06:50:13PM +0200, Borislav Petkov wrote:
> On Wed, May 05, 2021 at 11:37:28AM -0500, Andrew Halaney wrote:
> > I actually did use that recommendation essentially, the patch I've sent
> > is riding on the work done by unknown_bootoption() which is populated by
> > iterating over over the different sections parameters can live in - so
> > this is only printing out arguments that didn't match a known kernel
> > parameter. Sorry if I didn't make that clear earlier, definitely was
> > trying to listen to your advice.
> 
> Bah, don't take my "advice" too seriously - I'm just throwing out
> guesses. :-)
> 
> So ok, unknown_bootoption() handles those and AFAICT, that gets passed
> to parse_args() with the __start___param and __stop___param range.
> 
> But then there is that do_early_param() thing for early params, which
> are different and which are between __setup_start and __setup_end -
> i.e., the ones I meant above.
> 
> And that function doesn't do the unknown bootoption handling ;-\
> 
> More fun.
> 
Ah, but don't worry! It is handled, just secretly:
    unknown_bootoption()->obsolete_checksetup() walks __setup_start
:)

> > I'll have to think about this some more (the "did you mean this
> > parameter" part).. that seems like it might be more trouble than it is
> > worth, but I admittedly haven't looked into those cheap algorithms you
> > mentioned yet. The reason I say it might be more trouble than it is
> > worth is because it is easy to say "why didn't my param work", then grep
> > for it in dmesg and find it in the "Unknown command line parameters"
> > list - that's sort of the workflow I imagined would happen when someone
> > mucks with their kernel cli and doesn't get the intended result.
> 
> Oh sure - that's what I meant with "cheap". If it can't be done
> elegantly and easily, just forget it. dmesg | grep is a lot easier. :-)
> 
> Thx.
> 
Still worth considering, so at least lemme ponder it for a day instead
of being lazy.

Thanks,
Andrew

