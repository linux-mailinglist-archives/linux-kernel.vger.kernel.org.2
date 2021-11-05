Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E81A44694E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhKETxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:53:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53686 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhKETxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:53:22 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 88D1D1FD54;
        Fri,  5 Nov 2021 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636141841;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JNwd7X2iEE09DTErgxUeujO/mrcL8e8h2ujAlV8kmBM=;
        b=ZQpK7EmcQOr9qzxapbFJ8mQ1BmdXADMcUfIODEIKxtNzqsDK/lpIP2AtvkJjCV7fJRKwoi
        p8yMktfKeA8989Z88Y5Gwn6Ao3efeUwQu1/XAPTUuRjzUsqBtHggm6nHkcxKegikpJoSmt
        orBi227JgsTK1NzLDORbT9HX+Kk+oPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636141841;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JNwd7X2iEE09DTErgxUeujO/mrcL8e8h2ujAlV8kmBM=;
        b=7kdb9Vttjf+ZCnGUaUElWMFKRLDvGqgQcsKN+i55wNdUefirb5bzaxu64YHsO0OTelVBNS
        zjzUj+6q0rMfoNAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7C8C42C144;
        Fri,  5 Nov 2021 19:50:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6AEDCDA799; Fri,  5 Nov 2021 20:50:04 +0100 (CET)
Date:   Fri, 5 Nov 2021 20:50:04 +0100
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: Kmap-related crashes and memory leaks on 32bit arch (5.15+)
Message-ID: <20211105195004.GJ28560@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qu Wenruo <wqu@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20211104115001.GU20319@twin.jikos.cz>
 <CAHk-=whYQvExYESEOJoSj4Jy7t+tSZgbCWuNpdwXYh+3zq2itw@mail.gmail.com>
 <CAHk-=whBOXM3mh-QtzK-EQtDEHQLcziAXu07KxU1crUc5jiQUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whBOXM3mh-QtzK-EQtDEHQLcziAXu07KxU1crUc5jiQUg@mail.gmail.com>
crom:   David Sterba <dsterba@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
From:   David Sterba <dsterba@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 04:37:25PM -0700, Linus Torvalds wrote:
> On Thu, Nov 4, 2021 at 3:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > If (a) works, but (b) still fails, then it must be some odd
> > interaction issug withs-----ing else. Which sounds unlikely, since I
> > don't think we really had anything that should affect kmap or anything
> > in this area, but who knows...
> 
> And bisection ends up perhaps somewhat painful, but sounds like the
> way to go if there's no other path forward.

Just to give an update, I tested several merge commits and the btrfs
merge is the first bad (037c50bfbeb33b4c).

Last good is the one right before that,

9c6e8d52a7299  Merge tag 'exfat-for-5.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
(plus the fixup to make it compile e66435936756d9bce)

The remaining test to do is the merge conflict resolved by me, as you
suggested.
