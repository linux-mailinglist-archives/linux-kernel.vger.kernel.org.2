Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52C833FA80
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhCQVbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhCQVau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:30:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368DAC061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:30:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k24so64631pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JcYcWHGmVNPGMhsAQmoPEgDMVOP5uAD1xio0p93SpaM=;
        b=F2SGL0ebm1WN1AAXVrYPAflE0RRGNbDqRh5zWT6E/VDAvVhncHQW9rlh7inOf5XErV
         eT01CBORU4s/hPImJxaRVOnYWJURa/EpWjUwCeBqyX1w70HMPLVFmoVGwzzKxMu/dyNs
         /XSl3en+t+yMb+Vh+lIsSzolMrZwLO+UCWLC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JcYcWHGmVNPGMhsAQmoPEgDMVOP5uAD1xio0p93SpaM=;
        b=oikdUxfKpNAki/mboZCT4+0s75PNeEt+XACyZChou2WRULW5XEVsRgT6nLm4XH9Zl6
         xQ8k7D+IWsol2GEIELTBtqnaTRlc4b/dSd2125tRI6lEjJcBmskbxMXfVSBCi1D7sKIc
         HyX4j/HrjQf0B+5yFwULcVFJiQKOxewShOWh47XzzvV/2M86x9qJoZOTHzg/mf6RpkEA
         tSFi/rdfuT5dzdEyYQyoPaD1eOU4hPDochSlbl8W4ArLh+m383eCtqD93aRJnXz4D13j
         1GfwducnapuYYIymA0vjlYthPCEperk0Az5D96owCS5YL8h/tZs07v3xyzDi1Wi4CsQD
         gTzA==
X-Gm-Message-State: AOAM530BWCCBVjTVvLLlTXLVAvGw4itvegMmejPl3XmI7dhk8p/b5AhB
        lFbaN1woDijTTxMJOFUlvFmjuQ==
X-Google-Smtp-Source: ABdhPJxMlmgNJs/pSay3PORwaQblP+ABwko4SMVjMmgn6A+Fl8jjpE6/b/waFyC28qknA4CB+JWDTw==
X-Received: by 2002:a05:6a00:78c:b029:1f5:d587:1701 with SMTP id g12-20020a056a00078cb02901f5d5871701mr889400pfu.59.1616016649608;
        Wed, 17 Mar 2021 14:30:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x190sm42856pfx.166.2021.03.17.14.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 14:30:48 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:30:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] seq_file: Unconditionally use vmalloc for buffer
Message-ID: <202103171425.CB0F4619A8@keescook>
References: <20210315174851.622228-1-keescook@chromium.org>
 <YFBs202BqG9uqify@dhcp22.suse.cz>
 <202103161205.B2181BDE38@keescook>
 <YFHxNT1Pwoslmhxq@dhcp22.suse.cz>
 <YFIFY7mj65sStba1@kroah.com>
 <YFIVwPWTo48ITkHs@dhcp22.suse.cz>
 <YFIYrMVTC42boZ/Z@kroah.com>
 <YFIeVLDsfBMa7fHW@dhcp22.suse.cz>
 <YFIikaNixD57o3pk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIikaNixD57o3pk@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 04:38:57PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 17, 2021 at 04:20:52PM +0100, Michal Hocko wrote:
> > On Wed 17-03-21 15:56:44, Greg KH wrote:
> > > On Wed, Mar 17, 2021 at 03:44:16PM +0100, Michal Hocko wrote:
> > > > On Wed 17-03-21 14:34:27, Greg KH wrote:
> > > > > On Wed, Mar 17, 2021 at 01:08:21PM +0100, Michal Hocko wrote:
> > > > > > Btw. I still have problems with the approach. seq_file is intended to
> > > > > > provide safe way to dump values to the userspace. Sacrificing
> > > > > > performance just because of some abuser seems like a wrong way to go as
> > > > > > Al pointed out earlier. Can we simply stop the abuse and disallow to
> > > > > > manipulate the buffer directly? I do realize this might be more tricky
> > > > > > for reasons mentioned in other emails but this is definitely worth
> > > > > > doing.
> > > > > 
> > > > > We have to provide a buffer to "write into" somehow, so what is the best
> > > > > way to stop "abuse" like this?
> > > > 
> > > > What is wrong about using seq_* interface directly?
> > > 
> > > Right now every show() callback of sysfs would have to be changed :(
> > 
> > Is this really the case? Would it be too ugly to have an intermediate
> > buffer and then seq_puts it into the seq file inside sysfs_kf_seq_show.
> 
> Oh, good idea.
> 
> > Sure one copy more than necessary but it this shouldn't be a hot path or
> > even visible on small strings. So that might be worth destroying an
> > inherently dangerous seq API (seq_get_buf).
> 
> I'm all for that, let me see if I can carve out some time tomorrow to
> try this out.

The trouble has been that C string APIs are just so impossibly fragile.
We just get too many bugs with it, so we really do need to rewrite the
callbacks to use seq_file, since it has a safe API.

I've been trying to write coccinelle scripts to do some of this
refactoring, but I have not found a silver bullet. (This is why I've
suggested adding the temporary "seq_show" and "seq_store" functions, so
we can transition all the callbacks without a flag day.)

> But, you don't get rid of the "ability" to have a driver write more than
> a PAGE_SIZE into the buffer passed to it.  I guess I could be paranoid
> and do some internal checks (allocate a bunch of memory and check for
> overflow by hand), if this is something to really be concerned about...

Besides the CFI prototype enforcement changes (which I can build into
the new seq_show/seq_store callbacks), the buffer management is the
primary issue: we just can't hand drivers a string (even with a length)
because the C functions are terrible. e.g. just look at the snprintf vs
scnprintf -- we constantly have to just build completely new API when
what we need is a safe way (i.e. obfuscated away from the caller) to
build a string. Luckily seq_file does this already, so leaning into that
is good here.

-- 
Kees Cook
