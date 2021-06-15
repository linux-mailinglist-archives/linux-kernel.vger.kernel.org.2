Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C693A7410
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFOChi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFOChd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:37:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E754361059;
        Tue, 15 Jun 2021 02:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623724529;
        bh=ykYRpc0CV7DgEx3OtSOvofUtiEcwitO1lY/EJxif8eo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z1PJwc+3YHQf2rpNJVsokoX+XM9sNUo/ZbLSK92EbJpErU18Qkpa+rN8dc333CYAb
         i7ZhIx9JJuaPECUtSYcsFauctPFdTFcRK9xzfhDls1KKLwQlo2TeY793mb72FjLFi0
         7wZ9n3o2amA6ZLOQVPnT1X8kh1NcHAOX+5w3KRvY=
Date:   Mon, 14 Jun 2021 19:35:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=) 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm/hwpoison: do not lock page again when
 me_huge_page() successfully recovers
Message-Id: <20210614193528.c2cc50d92eb76c4bea1b40e8@linux-foundation.org>
In-Reply-To: <20210611002329.GA1201351@hori.linux.bs1.fc.nec.co.jp>
References: <20210609072029.74645-1-nao.horiguchi@gmail.com>
        <20210610165059.6618498250f60674c1bb9c03@linux-foundation.org>
        <20210611002329.GA1201351@hori.linux.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 00:23:29 +0000 HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> > 
> > --- mm/memory-failure.c
> > +++ mm/memory-failure.c
> > @@ -1782,6 +1796,8 @@ int memory_failure(unsigned long pfn, int flags)
> >  
> >  identify_page_state:
> >  	res = identify_page_state(pfn, p, page_flags);
> > +	mutex_unlock(&mf_mutex);
> > +	return res;
> >  unlock_page:
> >  	unlock_page(p);
> >  unlock_mutex:
> > 
> > and...  That mutex_unlock() looks odd.  The patch adds no matching
> > mutex_lock?
> 
> Yes, memory_failure() already has one mutex_lock (introduced by
> mm-memory-failure-use-a-mutex-to-avoid-memory_failure-races.patch,
> sorry for not clarifying that), and the change introduces a separate
> return path.  But I now think that I should have used "goto unlock_mutex"
> to use existing return path.

But mm-memory-failure-use-a-mutex-to-avoid-memory_failure-races.patch
is part of Tony's three patch series which is not marked for -stable. 
So it isn't appropriate that this patch be based on top of that three
patch series.

Should Tony's patchset also be targeted to -stable?  If so then OK.

If not then please let's prepare your -stable patch against current
mainline, as it is higher priority than the 5.14-rc1 material in
linux-next.

