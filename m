Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1B4350294
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbhCaOp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:45:29 -0400
Received: from verein.lst.de ([213.95.11.211]:35631 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236026AbhCaOo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:44:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7AF7C68B05; Wed, 31 Mar 2021 16:44:53 +0200 (CEST)
Date:   Wed, 31 Mar 2021 16:44:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Stanley <joel@jms.id.au>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Kees Cook <keescook@chromium.org>,
        "William A . Kennington III" <wak@google.com>,
        Lei YU <mine260309@gmail.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2: Hook up splice_write callback
Message-ID: <20210331144453.GA9931@lst.de>
References: <20210330134537.423447-1-joel@jms.id.au> <20210330161715.GA12783@lst.de> <YGNuZMUkzH0tkce6@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGNuZMUkzH0tkce6@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 06:31:00PM +0000, Al Viro wrote:
> The same goes for quite a few other filesystems, actually - at least
> adfs, affs, bfs, hfs, hfsplus, hostfs, hpfs, minix, omfs, sysv, ufs 
> and vboxsf are in the same boat, and I suspect that ecryptfs and ntfs
> might be too.
> 
> Christoph, do you see any problems with doing the same thing for that
> bunch as well?

Linus asked to only fix things up where we get reports, but I think his
intent there was more random procfs and debugfs files rather than file
systems.  So just doing the sweep should be fine.
