Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D843568A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346391AbhDGKDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350474AbhDGKA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:00:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17CFD6139E;
        Wed,  7 Apr 2021 10:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617789648;
        bh=dq2l8SzGida214C1HlxuWOTmoGpBfHB90BZbdJOThsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JC6mTEvv+Be4FbH6f9gqgw8eaHBOhDYEsLixBL6cvDGpiGvGCnDymRSWcfCYfVwRH
         f556wNaG/XlCw3/UYlMSUcVYb2bDQnaLubTjVMKfbjk9z1JuiDocJoBKG80EzE1DFj
         v463JOEJhvpr3902AGn7sDs/kTfETn3jon9c7wy8=
Date:   Wed, 7 Apr 2021 12:00:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] docs: reporting-issues: make everyone CC the
 regressions list
Message-ID: <YG2CztxS4jTia8wM@kroah.com>
References: <cover.1617786974.git.linux@leemhuis.info>
 <813fc7b082a4b47ec6d34542971e9bba74fd4a51.1617786974.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <813fc7b082a4b47ec6d34542971e9bba74fd4a51.1617786974.git.linux@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:21:56AM +0200, Thorsten Leemhuis wrote:
> Make people CC the recently created mailing list dedicated to Linux
> kernel regressions when reporting one. Some paragraphs had to be
> reshuffled and slightly rewritten during the process, as the text
> otherwise would have gotten unnecessarily hard to follow.
> 
> The new text also makes reporters include a line useful for automatic
> regression tracking solution which does not exist yet, but is planned.
> The term "#regzb" (short for regression bot) is inspired by the "#syz"
> which can be used to communicate with syszbot (see
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md).

While I understand the wish to automate things like this, the #syz
marking will actually cause something to go off and do some work, and is
only relevant for a very small number of developers, all of whom know to
look up the instructions before doing so.  But the #regzb marking will
be requested to be added by random users who never have submitted a
problem report before, OR from long-time kernel developers who are lucky
to ever remember to read the documentation as they "know" how to do
this.

So this increased workload by people on the two ends of experience is
going to be rough, I predict a very low rate of adoption :(

What is the tag going to be good for?  The reports will need to be
handled by a person anyway and classified and tracked out-of-band from
the list somehow.  Will a tag do all that much here?

thanks,

greg k-h
