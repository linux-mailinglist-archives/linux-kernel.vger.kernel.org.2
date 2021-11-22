Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA845960D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbhKVU1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:27:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233434AbhKVU1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:27:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A7E60FD7;
        Mon, 22 Nov 2021 20:24:28 +0000 (UTC)
Date:   Mon, 22 Nov 2021 15:24:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
Message-ID: <20211122152426.7c2b3ab4@gandalf.local.home>
In-Reply-To: <aa158444-4319-a019-1031-095a69105447@leemhuis.info>
References: <cover.1637566224.git.linux@leemhuis.info>
        <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
        <20211122112916.498810bb@gandalf.local.home>
        <aa158444-4319-a019-1031-095a69105447@leemhuis.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 19:50:35 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> > That said, I would like a way to have versions show a link to the last
> > version that was reviewed.
> > 
> > v1: has no tags
> > 
> > v2: has a Reviewed: tag to v1.
> > 
> > v3: has a Reviewed: tag to v2
> > 
> > [...]
> > 
> > Then the final commit could have a "Link" or "Reviewed" tag to v3, even
> > though there may not be any reviews to v3, but v3 has the link to v2, and
> > v2 has the link to v1, etc.  
> 
> Is that really worth it? Isn't it sufficient if the commit links to the
> last public review posting, as that already should link to all earlier
> review postings. Sure, not everybody is doing this right now, but maybe
> just educating people to do so is better than creating something new.

Isn't "as that already should link to all earlier review postings" what I'm
suggesting above? I haven't seen many people do that yet.

-- Steve


