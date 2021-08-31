Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04BA3FCE39
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240866AbhHaUOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhHaUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:14:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C273C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pxk8GG60X+2yyobrSu3E/AhsnJLMw7NHv2ZY1OGYPLA=; b=FBEs/xlJysw8HQAyQjF7MUWNMS
        De2n17pxbQ2xl+NP//J2C8FdgxiOn5GaG568uQ4xBswpLfcfSotviKb/4v24SeBynq4+kZXekuzgc
        /euaXeiom93NNxQk+a/pGbWeZgCbc/33axph0y0UG+SSeD572JZ0l4CkK9HtjJSiczv+/cQapT7GL
        MuJVdbS1L1xPGUwr4ezVDYbzSjwbxnTtDqz7GEQcum7reqcsnLL324QBS1yyPHcOMqsswP+vPFZ0+
        ae/4Qhu2DN0lImdyqbGJtGEEWmsoVPfF2PZDCZI5o+1wqWlLjpf1WEwz5tyY9F+rDnxd7MfyVyorg
        xw+sCYRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLA7s-001Wyc-Sl; Tue, 31 Aug 2021 20:13:08 +0000
Date:   Tue, 31 Aug 2021 21:12:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tawah Peggy <tawahpeggy98@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] [Outreachy Kernel] Staging: wlan-ng:
 cfg80211: Fix Lines should not end with a '('
Message-ID: <YS6NSLhZKx0mlcYC@casper.infradead.org>
References: <20210824031551.GA80985@peggy-InsydeH2O-EFI-BIOS>
 <YSTAnuoGF4zuAFrg@casper.infradead.org>
 <CADT-=4mWmUmBQtwwdRXUCPZfePbX6gQB_+ZrVwuE-GC=TYE2rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADT-=4mWmUmBQtwwdRXUCPZfePbX6gQB_+ZrVwuE-GC=TYE2rw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 01:41:58PM +0100, Tawah Peggy wrote:
> Thanks for your feedback Mattew,
> please what approach do you suggest I use?

[please don't remove mailing lists; other people may benefit from the
answers to your questions]

There are a number of different approaches you can take to fixing this
kind of warning.

1. Reduce indentation.  This call seems to be indented 3-4 levels,
so maybe it would be good to pull part of this function out into
a helper function.

2. Use a local variable.
			type center_freq = request->channels[i]->center_freq;
			ieee80211_frequency_to_channel(center_freq);

3. Reduce the length of the function name.  ieee80211_frequency_to_channel
is quite a long identifier.  Maybe it would be worth renaming.

4. Introduce a helper function, eg

static inline foo something_to_channel(struct bar *channel)
{
	return ieee80211_frequency_to_channel(channel->center_freq);
}

...

			something_to_channel(request->channels[i]);

There's a judgement call to be made, and without looking at the function
in detail, I don't know which of these methods might be best.

> tawah peggy
> 
> On Tue, Aug 24, 2021 at 10:50 AM Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Aug 24, 2021 at 04:15:51AM +0100, Tawah Peggy wrote:
> > > -                     ieee80211_frequency_to_channel(
> > > -                             request->channels[i]->center_freq);
> > > +                     ieee80211_frequency_to_channel
> > > +                             (request->channels[i]->center_freq);
> >
> > This is the wrong way to fix this warning.  Function names should not be
> > divorced from their arguments.
> >
