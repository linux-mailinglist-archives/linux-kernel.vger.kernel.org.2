Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DE6398E30
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhFBPTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:19:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52718 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhFBPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:19:33 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48E461FD89;
        Wed,  2 Jun 2021 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iqJ6ZU1Fg7hct0fRYvmiTWw8Y+3JAogrAeK3zWvbsDo=;
        b=ClMfueLgOwK2fs6Ct/duprwdzSe0RN7EMpCpWn7BeNdwSP1MLFC3Hv0PWtrKZF3bdoLZA0
        Lv32Ucaktj/s56yFmEFl6tQ+9hGeW5nMN3j4fi95lS/GL9bdzyzpFBGzca8b5kFD+fztoK
        jrt6BFKj0tZh5eUA5h0eLrQ+fEErKUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647069;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iqJ6ZU1Fg7hct0fRYvmiTWw8Y+3JAogrAeK3zWvbsDo=;
        b=dEFZe+LOmFqNdAYwVTa3T61wLN0GaIzXgV5IDTINiGB7yjXdvr964o83jrRqENEYFnqn8f
        um3fE+Suvb//ePBA==
Received: by relay2.suse.de (Postfix, from userid 51)
        id 4627BA3C50; Wed,  2 Jun 2021 15:34:32 +0000 (UTC)
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 77EDFA8011;
        Wed,  2 Jun 2021 14:52:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 41D6D1F2CAC; Wed,  2 Jun 2021 16:52:52 +0200 (CEST)
Date:   Wed, 2 Jun 2021 16:52:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: __buffer_migrate_page() vs ll_rw_block()
Message-ID: <20210602145252.GA23647@quack2.suse.cz>
References: <20210601132316.GA27976@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601132316.GA27976@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-06-21 15:23:17, Vincent Whitchurch wrote:
> I'm seeing occasional squashfs read failures ("squashfs_read_data failed
> to read block") when compaction is run at the same time as reading from
> squashfs, with something like the commands below.  The kernel version is
> the latest stable/v5.4 kernel, v5.4.123.
> 
>  while :; do echo 1 > /proc/sys/vm/compact_memory; done &
>  while :; do echo 3 > /proc/sys/vm/drop_caches; find fs/ > /dev/null; done &
> 
> On this kernel, squashfs uses ll_rw_block().  The problem is that
> ll_rw_block() ignores BHs which it can't get a lock on, but
> __buffer_migrate_page() can take the lock on the BHs in order to check
> if they can be migrated.  If __buffer_migrate_page() holds the lock at
> the same time that ll_rw_block() wants it, the BH is skipped and I/O is
> not issued for these blocks, and squashfs ends up seeing
> !buffer_uptodate() and erroring out.
> 
> On newer kernels, squashfs doesn't use ll_rw_block() anymore, but I
> still see other users of that function in other filesystems, and AFAICS
> the underlying problem of the race with __buffer_migrate_page() has not
> yet been fixed.
> 
> I'd be happy to receive any suggestions about the right way to fix this.

Well, if you care about squashfs, the best solution would IMO be to
backport 93e72b3c612adc ("squashfs: migrate from ll_rw_block usage to BIO")
and the followup fixes (there are several of them as far as I can see by
Fixes tags) to your kernel - stable tree would be IMHO willing to take the
series if you add your justification that it fixes read failures for you.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
