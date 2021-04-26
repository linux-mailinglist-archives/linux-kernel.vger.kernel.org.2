Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38A336B762
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhDZRCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234987AbhDZRCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:02:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F225261076;
        Mon, 26 Apr 2021 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456491;
        bh=uRnZESRHc2NQ2+UvxxU1OR32mDnFivfXpX/QYWAVuH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLD/Bwmprla381zYTXEm2ckx+vAvEmoqV+Jtrw3eJgacn7MycjAg1jsE2nxORsqJy
         cCRQ23DenyysDXWTtL7wP5gWlOZKhy6e+1EO0qLXEpU5RM7/JztP+OIeEqJa7/Bq/x
         GGL3/P30aRecXefviRRbKYbUndNbCqdmLZ+p7qtY=
Date:   Mon, 26 Apr 2021 19:01:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 055/190] Revert "fs: ocfs: remove unnecessary assertion
 in dlm_migrate_lockres"
Message-ID: <YIbx6L17mkfmbnT+@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-56-gregkh@linuxfoundation.org>
 <20210422084208.GB5316@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422084208.GB5316@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:42:08AM +0200, Pavel Machek wrote:
> On Wed 2021-04-21 14:58:50, Greg Kroah-Hartman wrote:
> > This reverts commit 67e2d2eb542338145a2e0b2336c1cdabd2424fd3.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> This patch is correct AFAICT.

Now dropped, thanks.

greg k-h
