Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF83EA612
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhHLN4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:56:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58074 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhHLN4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:56:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 165961FF48;
        Thu, 12 Aug 2021 13:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628776533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BmT1j6qqHbPM2jS2S8E/xfI9/JWiNOKmyXSgPPv98Co=;
        b=XtpXglPcXvwy6s31knA1FcW3z8ni55RU5q6muMK6UMf6zDRGEkuJXMF9UU+ADYzotIidL4
        JdscLBzXSjlwmvrCSqOI6q8jJs7oXvkMv1OFamIJ1G5dE9aN5pBEmYWaXD4wKcZdEsSqDd
        g9nBNhwjJC5Vi7vSVm2/q/ACcM8Eq/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628776533;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BmT1j6qqHbPM2jS2S8E/xfI9/JWiNOKmyXSgPPv98Co=;
        b=eWiABirBTr1iTjq5zL550BwS+SjtNWRuTwBZFXZ8lbYv60bjrXYdCxJB5lmJ+EEHrGNkJ8
        jAW26dwEGiLVSbAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id BAA2DA3F39;
        Thu, 12 Aug 2021 13:55:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9236D1E14BC; Thu, 12 Aug 2021 15:55:29 +0200 (CEST)
Date:   Thu, 12 Aug 2021 15:55:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>,
        dvyukov@google.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] possible deadlock in dquot_commit
Message-ID: <20210812135529.GD14675@quack2.suse.cz>
References: <000000000000a05b3b05baf9a856@google.com>
 <20210810041100.3271-1-hdanton@sina.com>
 <20210811041232.2449-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811041232.2449-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-08-21 12:12:32, Hillf Danton wrote:
> On Tue, 10 Aug 2021 11:21:42 +0200 Jan Kara wrote:
> >
> >I'm not quite sure what you are asking about but yes, dquot_acquire() grabs
> 
> It is hard to understand the rooms in mutex for two lock owners.
> 
> >dquot->dq_lock, then e.g. v2_write_dquot() acquires dqio_sem, then
> >ext4_map_blocks() acquires i_data_sem/2 (special lock subclass for quota
> >files).
> >
> >What is unexpected is the #0 trace where i_data_sem/2 is acquired
> >by ext4_map_blocks() called from ext4_write_begin(). That shows that
> >normal write(2) call was able to operate on quota file which is certainly
> >wrong.
> 
> The change below can test your theory.
> >
> >My patch closed one path how this could happen and I'm puzzled how
> >else this could happen. I'll try to reproduce the issue (I've already tried
> >but so far failed) as see if I can find out more.
> 
> Actually there is one check for quota file near 100 lines of code lower,
> and copy it to just before taking i_data_sem to avoid writing the file of
> wrong type.
> 
> Now only for thoughts.
> 
> +++ x/fs/ext4/inode.c
> @@ -616,6 +616,8 @@ found:
>  		if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
>  			return retval;
>  
> +	if (ext4_is_quota_file(inode))
> +		return -EINVAL;
>  	/*
>  	 * Here we clear m_flags because after allocating an new extent,
>  	 * it will be set again.

This would be certainly wrong. ext4_map_blocks() is used for accessing and
allocating blocks for quota file. It is ext4_write_begin() that should not
be called for the quota file. I've run the reproducer here for couple of
hours but the problem didn't trigger for me. Strange.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
