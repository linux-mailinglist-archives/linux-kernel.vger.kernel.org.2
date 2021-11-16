Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D3B45363B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhKPPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:46:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42294 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhKPPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:46:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9E49821891;
        Tue, 16 Nov 2021 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637077422;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdU3ZtCLDsWLBeLjGc1suDgGFypFD7LtqB59Xy3SG2Y=;
        b=FHrsUWSlrrgR8lLN0Y4S3L98GxIsW99UFd6YC0uTj6pXAes9crtq6yzg4u5NNtlSW6nDff
        VAnpSE/8lwssUV0g7zenZcHnltdyamGIB0Jsw824emJ922ZZKIOfWzsUUTcw3XxhHHToHf
        bDsRYWdPPEeKTC1jphQxygdXO4nBNDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637077422;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vdU3ZtCLDsWLBeLjGc1suDgGFypFD7LtqB59Xy3SG2Y=;
        b=tCfAGl7yqJsP7cPsocIFZW72qcnEedXjrfzG2hhgffKNT3Bevp0ALO0QGS485OsedZ4YOY
        /sNzaXTu095YwsAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 947AEA3B81;
        Tue, 16 Nov 2021 15:43:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1BFF8DA799; Tue, 16 Nov 2021 16:43:38 +0100 (CET)
Date:   Tue, 16 Nov 2021 16:43:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>,
        Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: Kmap-related crashes and memory leaks on 32bit arch (5.15+)
Message-ID: <20211116154338.GQ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20211104115001.GU20319@twin.jikos.cz>
 <CAHk-=whYQvExYESEOJoSj4Jy7t+tSZgbCWuNpdwXYh+3zq2itw@mail.gmail.com>
 <CAHk-=whBOXM3mh-QtzK-EQtDEHQLcziAXu07KxU1crUc5jiQUg@mail.gmail.com>
 <20211105195004.GJ28560@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105195004.GJ28560@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 08:50:04PM +0100, David Sterba wrote:
> On Thu, Nov 04, 2021 at 04:37:25PM -0700, Linus Torvalds wrote:
> > On Thu, Nov 4, 2021 at 3:09 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > If (a) works, but (b) still fails, then it must be some odd
> > > interaction issug withs-----ing else. Which sounds unlikely, since I
> > > don't think we really had anything that should affect kmap or anything
> > > in this area, but who knows...
> > 
> > And bisection ends up perhaps somewhat painful, but sounds like the
> > way to go if there's no other path forward.
> 
> Just to give an update, I tested several merge commits and the btrfs
> merge is the first bad (037c50bfbeb33b4c).
> 
> Last good is the one right before that,
> 
> 9c6e8d52a7299  Merge tag 'exfat-for-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
> (plus the fixup to make it compile e66435936756d9bce)
> 
> The remaining test to do is the merge conflict resolved by me, as you
> suggested.

So the result is that the merge conflict from Linus resolved the kmaps
correctly, there was a bug in the lzo refactoring patch itself that
caused some page array overflow and some random address was accessed.

I'll send a pull request in a day, I've been validating the patch on the
unmerged base and on rc1, also with various debugging options on.
Curiously, with SLOB there's an early crash while still doing the
compression, but with SLUB (and debugging enabled) there is not an
immediate crash but some other warning/assertion notices a page with
mapping (unexpected).
