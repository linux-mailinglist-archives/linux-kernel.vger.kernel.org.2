Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18836ED9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbhD2Ps7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD2Ps5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:48:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C4C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:48:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x19so75220963lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3NyxbJCwhqb1aqLdIOSz5lukrN8T+dDDlsyMoLY0gW4=;
        b=cbYC8SxTjuN7PL/HHpWnlrg/QN1hbVMX8F6WKSRM2DjP4eDx+2x+t4E0/GMgzTxeUO
         8IZnyKtuvzyQ3D8CHxgPBCUcbxohWBWSZeMojKYswbWhlX3U9Q7Th0J/+IhWbre9r0Eb
         5cKkEh5sjhR2Us2DIWa/9crBm8yfFuMvC1foJOzjGZQrUSCMc4K4SAcEAyLTokeM1vWn
         PILewUSWyy4LQur7FqhLQWHTyKwEPBcJDwFFE4IoDouS9bHTEzFU4Ch1b6fDojeAV6on
         6mS/xGS/4MMurv31BIf6i016OPdTJjBIyh9tq7CKBVCAiaEeLWvq8GgyjFLUMkr5oOaJ
         o4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NyxbJCwhqb1aqLdIOSz5lukrN8T+dDDlsyMoLY0gW4=;
        b=icju8V0QGfn9+x6swRZKvK8ugZe/0bBVvlpNDA5xLpAf0eWA9JvyVgpz/1fYtaKSnS
         epp/T9IXef25UAJxsP7Xcxz35d/ZP9Bb8CcmDnVX4/aO3XMg5m40fM9+Kd3AJcRFo/cV
         VSnJfIkDlGJzDDEUdhJtjQ0cAYYny6zB7o7iTdn+ctk5oxSOoPTgobfu/Lc+8FdqTWaM
         5U5gFDSzGirkv3wgB/MhUcK2DFxzMe4WO3qyV+OEC/JllsHaRTTLad2JspIY1N9V9qsa
         +fwO55utshm8Cx900h5xvTuLl+OUQPdBYVnoZoKUB8GMG/fjIg79HGAkTNmxXLFAvP6W
         aZxg==
X-Gm-Message-State: AOAM530xpbJTYJ2LjKKSSxWR6KITFmEovi2p8dRFKOnQ3p1rluE3fO2E
        doAtJpF8ga5Es0eahKBlrhRweg==
X-Google-Smtp-Source: ABdhPJxG/sG67SG3OP0g0HlxPZkucJvHMsVb7rMJuwC8Q4cClb/EyKqoa1z0wyOYJzSIY4vZ+1XSmQ==
X-Received: by 2002:ac2:5f6a:: with SMTP id c10mr159706lfc.286.1619711287786;
        Thu, 29 Apr 2021 08:48:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j8sm13949lfg.250.2021.04.29.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:48:06 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 29D45101C51; Thu, 29 Apr 2021 18:48:07 +0300 (+03)
Date:   Thu, 29 Apr 2021 18:48:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Simon Ser <contact@emersion.fr>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: Sealed memfd & no-fault mmap
Message-ID: <20210429154807.hptls4vnmq2svuea@box>
References: <vs1Us2sm4qmfvLOqNat0-r16GyfmWzqUzQ4KHbXJwEcjhzeoQ4sBTxx7QXDG9B6zk5AeT7FsNb3CSr94LaKy6Novh1fbbw8D_BBxYsbPLms=@emersion.fr>
 <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgmGv2EGscKSi8SrQWtEVpEQyk-ZN1Xj4EoAB87Dmx1gA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:51:58AM -0700, Linus Torvalds wrote:
> On Tue, Apr 27, 2021 at 1:25 AM Simon Ser <contact@emersion.fr> wrote:
> >
> > Rather than requiring changes in all compositors *and* clients, can we
> > maybe only require changes in compositors? For instance, OpenBSD has a
> > __MAP_NOFAULT flag. When passed to mmap, it means that out-of-bound
> > accesses will read as zeroes instead of triggering SIGBUS. Such a flag
> > would be very helpful to unblock the annoying SIGBUS situation.
> >
> > Would something among these lines be welcome in the Linux kernel?
> 
> Hmm. It doesn't look too hard to do. The biggest problem is actually
> that we've run out of flags in the vma (on 32-bit architectures), but
> you could try this UNTESTED patch that just does the MAP_NOFAULT thing
> unconditionally.
> 
> NOTE! Not only is it untested, not only is this a "for your testing
> only" (because it does it unconditionally rather than only for
> __MAP_NOFAULT), but it might be bogus for other reasons. In
> particular, this patch depends on "vmf->address" not being changed by
> the ->fault() infrastructure, so that we can just re-use the vmf for
> the anonymous case if we get a SIGBUS.
> 
> I think that's all ok these days, because Kirill and Peter Xu cleaned
> up those paths, but I didn't actually check. So I'm cc'ing Kirill,
> Peter and Will, who have been working in this area for other reasons
> fairly recently.
> 
> Side note: this will only ever work for non-shared mappings.

I think it's show-stopper for the use-case, no? IIUC, the mappings is used
for communication between a compositor and a client and has to be shared.

> That's fundamental. We won't add an anonymous page to a shared mapping,
> and do_anonymous_page() does verify that. So a MAP_SHARED mappign will
> still return SIGBUS even with this patch (although it's not obvious from
> the patch - the VM_FAULT_SIGBUS will just be re-created by
> do_anonymous_page()).
> 
> So if you want a _shared_ mapping to honor __MAP_NOFAULT and insert
> random anonymous pages into it, I think the answer is "no, that's not
> going to be viable".

+ Matthew, Dan.

DAX uses zero pages in page cache to avoid allocating backing storage read
accesses to holes. Maybe we can generalize it beyond DAX to any page cache
and add a (per-inode?) flag to do the same for accesses beyond i_size?

> So _if_ this works for you, and if it's ok that only MAP_PRIVATE can
> have __MAP_NOFAULT, and if Kirill/Peter/Will don't say "Oh, Linus,
> you're completely off your rocker and clearly need to be taking your
> meds", something like this - if we figure out the conditional bit -
> might be doable.
> 
> That's a fair number of "ifs".
> 
> Ok, back to the merge window for me, I'll be throwing away this crazy
> untested patch immediately after hitting "send". This is very much a
> "throw the idea over to other people" patch, in other words.
> 
>             Linus



-- 
 Kirill A. Shutemov
