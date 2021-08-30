Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AEF3FB61D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbhH3MeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232267AbhH3MeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:34:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AD3D60C40;
        Mon, 30 Aug 2021 12:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630326793;
        bh=vV+7QnNcsLi7ddrn19KrBeLW/vMy+0JLtPVhL5tRbOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlcaD79YuVD6E4snc6M8dEemUht+nc/NxwaoDzP60kuXKC6zG6Ydi3emsqcj02bH8
         8k007CSBzgrFoUkX3fmlUSqBqcUz5s0wASf1qdOUp1m68IAgCyKB2vbWwlMgT8DZJD
         fIh5imSlsfUEO0g9371knT/i95Q+PITkizeR1zWtbDk1oOmMcnT2UefIadUEubfwiq
         G9BZmfRtJ/WEcH1Vpzz5P5J4cAWyu+Wil9htTcOhDiakLkJoX237X2oeV4O1N7u87O
         9DbwP6fHGbV0nq/Ptuqs5iPf+dXip7GB3G92uKWrz7Irka9CeBf2yOAPeUwWmavu4f
         OaBGc5wwttE3A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mKgTJ-00061h-KY; Mon, 30 Aug 2021 14:33:05 +0200
Date:   Mon, 30 Aug 2021 14:33:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: greybus: Convert uart.c from IDR to XArray
Message-ID: <YSzQAd0Rg5CF/eLe@hovoldconsulting.com>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com>
 <YSyg/Db1So0LDGR+@hovoldconsulting.com>
 <2879439.WEJLM9RBEh@localhost.localdomain>
 <YSzGkNfG6HOayiXi@hovoldconsulting.com>
 <YSzMB80NOkNvdjy1@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSzMB80NOkNvdjy1@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 01:16:07PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 30, 2021 at 01:52:48PM +0200, Johan Hovold wrote:
> > Whether the API is better is debatable. As I said, almost no drivers use
> > the new XArray interface, and perhaps partly because the new interface
> > isn't as intuitive as has been claimed (e.g. xa_load() instead of
> > ida_find()). And IDR/IDA isn't marked/documented as deprecated as far as
> > I know.
> 
> I can't just slap a 'deprecated' attribute on it.  That'll cause a
> storm of warnings.  What would you suggest I do to warn people that
> this interface is deprecated and I would like to remove it?

I'd at least expect a suggestion in the IDR documentation to consider
using XArray instead.

> Why do you think that idr_find() is more intuitive than xa_load()?
> The 'find' verb means that you search for something.  But it doesn't
> search for anything; it just returns the pointer at that index.
> 'find' should return the next non-NULL pointer at-or-above a given
> index.

We're looking up a minor number which may or may not exist. "Find" (or
"lookup" or "search") seems to describe this much better than "load"
(even if that may better reflect the implementation of XArray).

And no, I would not expect a find implementation to return the next
entry if the requested entry does not exist (and neither does idr_find()
or radix_tree_lookup()).

Johan
