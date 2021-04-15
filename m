Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE17360547
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhDOJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhDOJJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:09:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA4AC610CB;
        Thu, 15 Apr 2021 09:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618477719;
        bh=DNcJW1urQEhxebHE8EB9/vcQ74Ke7vd8CHkmoFeMQtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPheLIHpT2I1cdVVyOVobuXxehdE5n3YMG6xyfL3v0aaRGQHA3Z19unQfEFXHcPuk
         QNM37UXZhwC8ecgZAZiY2UowdlW04OwwTD1fXf9t42h04Q6VzP/r8onqf2eBdLWAjB
         ye1v9+ljZdx/rkwD6WwCkxVyQZjCW2y4s33HSrY0=
Date:   Thu, 15 Apr 2021 11:08:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
Message-ID: <YHgClKj6FNDQoqem@kroah.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
 <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
 <YHcnckePpKDujCU+@kroah.com>
 <YHcqxMLR44laX2PZ@smile.fi.intel.com>
 <YHc68v7keeITnA3K@kroah.com>
 <87sg3sfzl1.fsf@ashishki-desk.ger.corp.intel.com>
 <YHf6s2r28XOtP2+2@kroah.com>
 <CAHp75Vf7UrRuN=rBkBYrSDz3yiUq4_k2HVvCJ7cTB=_4y8+W7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf7UrRuN=rBkBYrSDz3yiUq4_k2HVvCJ7cTB=_4y8+W7g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 11:48:48AM +0300, Andy Shevchenko wrote:
> On Thu, Apr 15, 2021 at 11:35 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Apr 14, 2021 at 10:14:34PM +0300, Alexander Shishkin wrote:
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > >
> > > >> Using raw buffer APIs against uuid_t / guid_t.
> > > >
> > > > So you want to do that, or you do not want to do that?  Totally
> > > > confused,
> > >
> > > My understanding is that:
> > > 1) generate_random_uuid() use is allegedly bad even though it's in their
> > > header,
> > > 2) poking directly at the byte array inside uuid_t is bad, even though,
> > > again, header.
> > >
> > > It is, indeed, not ideal.
> > >
> > > If agreeable, I'll update this patch to the below and respin the whole
> > > series.
> >
> > You are showing that Andy wrote this, when you are the one that did :(
> 
> > Anyway, I've dropped this single patch from the series and applied the
> > rest.  Feel free to send this patch as a stand-alone one once you have
> > the authorship issues sorted out.
> 
> Internally it was proposed by me as well, so authorship is correct.

And I am supposed to know this how?

Come on people, you know better than this...
