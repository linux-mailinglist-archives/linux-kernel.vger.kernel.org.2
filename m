Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D84459510
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhKVSv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:51:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237048AbhKVSvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:51:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E05960F70;
        Mon, 22 Nov 2021 18:48:39 +0000 (UTC)
Date:   Mon, 22 Nov 2021 13:48:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 0/1] Create 'Reported:' and 'Reviewed:' tags for
 links in commit messages
Message-ID: <20211122134837.7489d725@gandalf.local.home>
In-Reply-To: <3823dfb9-cc72-57ae-a296-92d506de1531@leemhuis.info>
References: <cover.1637566224.git.linux@leemhuis.info>
        <20211122151233.54xtnpwdmnrdj3jf@meerkat.local>
        <20211122120405.7a1e1c9f@gandalf.local.home>
        <3823dfb9-cc72-57ae-a296-92d506de1531@leemhuis.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 19:40:46 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> Hmmm. I'm not opposed, but I wonder if 'Reported:' and 'Reviewed:' are
> this tiny bit easier to handle (both for placing and analyzing scripts)
> that makes the difference between "nice idea, but fails to be used in
> the field" and "after some tradition phase this becomes the new normal"
> in the end.

Either way is fine for me. My scripts are trivial and easy to update. I'm
more worried about what other people may use.

-- Steve
