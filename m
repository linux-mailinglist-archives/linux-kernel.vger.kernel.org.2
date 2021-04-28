Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8325436D1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhD1Fxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhD1Fxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:53:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DBEF60E0B;
        Wed, 28 Apr 2021 05:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619589182;
        bh=pvFyP4U4yhRgxSZajdzI402m+lQIKufgQTOmom2kc9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgJbv9U8VY7nGkMv8CkUWD1c7gp+Fea3TH42wmoWL0PIPZY55vwazK9JvKzpy0HLz
         ElWBEZNfM9l2INqqO4XW55KgGUtty3IzM6F6vAPef0FW4JXCJQqS1ge+jhUVC6elhm
         6qc0YKgpvuWRbb6EFbwAtyKyrw9XIf8fooqk1gWY=
Date:   Wed, 28 Apr 2021 07:52:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 066/190] Revert "bpf: Remove unnecessary assertion on
 fp_old"
Message-ID: <YIj4N0KBSCw7DuN0@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-67-gregkh@linuxfoundation.org>
 <YIhQsRZ9LgZKlkPw@kroah.com>
 <56b8a42d-261e-1fc0-f572-8c3c1a98701d@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b8a42d-261e-1fc0-f572-8c3c1a98701d@iogearbox.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:28:31PM +0200, Daniel Borkmann wrote:
> On 4/27/21 7:58 PM, Greg Kroah-Hartman wrote:
> > On Wed, Apr 21, 2021 at 02:59:01PM +0200, Greg Kroah-Hartman wrote:
> [...]
> > >   kernel/bpf/core.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 75244ecb2389..da29211ea5d8 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -230,6 +230,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
> > >   	struct bpf_prog *fp;
> > >   	u32 pages;
> > > +	BUG_ON(fp_old == NULL);
> > > +
> > >   	size = round_up(size, PAGE_SIZE);
> > >   	pages = size / PAGE_SIZE;
> > >   	if (pages <= fp_old->pages)
> > 
> > The original commit here is correct, I'll drop this revert.
> 
> Ok, sounds good to me, thanks! (If there would ever be an incorrect fp_old with NULL, then at
> latest we crash in fp_old->pages anyway, so the BUG_ON() was not needed.)

Thanks for the re-review, much appreciated.

greg k-h
