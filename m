Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9182B403A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345371AbhIHNFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344970AbhIHNFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:05:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 042FB61139;
        Wed,  8 Sep 2021 13:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631106249;
        bh=oLXIl17w04h60xVlOf3Ghf6GaP2acxlPqetjMbrp8Js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LeDglWeo8ZZdF+LHaRigY1b+mmrpBgr23zsVbL9TPek85LpYHFJJuLBSg+dKjUM9w
         E9UQ3uS4I7KCrQtXp0Zr+NRpxkpmoa9xFQHMz1xIowe7Y29Rc9f3kUcte0RLdJN4lX
         7+S+DzFbmRIGEgW8BqLMz61WWzh5ocRbaZ/eqwQE=
Date:   Wed, 8 Sep 2021 15:04:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Yu, Lang" <Lang.Yu@amd.com>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sysfs: Remove page boundary align limitation on
 sysfs_emit and sysfs_emit_at
Message-ID: <YTi0xkTVYqUpKXSt@kroah.com>
References: <20210908120723.3920701-1-lang.yu@amd.com>
 <YTitRjOZtWPTyRHd@kroah.com>
 <DM6PR12MB4250302F4EB80233D5807CB6FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4250302F4EB80233D5807CB6FBD49@DM6PR12MB4250.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top


On Wed, Sep 08, 2021 at 12:52:43PM +0000, Yu, Lang wrote:
> [AMD Official Use Only]
> 
> Thanks for your reply.
> Just curious if we don't put such a limitation, what are the consequences?
> If we remove the limitation, sys_emit/sys_emit_at api will be more flexible.
> Since the comments of  sysfs_emit/ sys_emit_at api are  
> " sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer. ",
> Why not make them more equivalent with scnprintf?

Because this is not a general replacement for scnprintf(), it is only to
be used with sysfs files.

Where else are you wanting to use these functions that this patch woulud
be required that does not haver to deal with sysfs?

thanks,

greg k-h
