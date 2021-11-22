Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A255F45939A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhKVRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234435AbhKVRHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:07:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58EE860249;
        Mon, 22 Nov 2021 17:04:07 +0000 (UTC)
Date:   Mon, 22 Nov 2021 12:04:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/1] Create 'Reported:' and 'Reviewed:' tags for
 links in commit messages
Message-ID: <20211122120405.7a1e1c9f@gandalf.local.home>
In-Reply-To: <20211122151233.54xtnpwdmnrdj3jf@meerkat.local>
References: <cover.1637566224.git.linux@leemhuis.info>
        <20211122151233.54xtnpwdmnrdj3jf@meerkat.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 10:12:33 -0500
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> As an alternative, I can offer that we continue to use Link: trailers with
> extra data following the hashtag, as is already done for other trailers:
> 
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=215101   #report
>     Link: https://lore.kernel.org/r/fobarbaz.5551212@localhost #review
> 
> Note, that this merely for completeness, not in opposition to the proposal. I
> find the "Link:" trailer to be semantically redundant, since what follows is
> already clearly a hyperlink. Adding "Link: " in front of it is only necessary
> for consistency and machine parsing reasons.

Machine parsing is the main reason for the Link: tag. I have scripts that
key off of that tag and ignore any other "http" reference.

Perhaps the above is better, as it means we don't need to update our
scripts for that parsing.

-- Steve
