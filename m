Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6B459300
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbhKVQc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:32:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239597AbhKVQcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:32:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A99C60D42;
        Mon, 22 Nov 2021 16:29:18 +0000 (UTC)
Date:   Mon, 22 Nov 2021 11:29:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
Message-ID: <20211122112916.498810bb@gandalf.local.home>
In-Reply-To: <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
References: <cover.1637566224.git.linux@leemhuis.info>
        <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 08:33:42 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> Introduce the tags 'Reported:' and 'Reviewed:' in addition to 'Link:',
> as the latter is overloaded and hence doesn't indicate what the provided
> URL is about. Documenting these also provides clarity, as a few
> developers have used 'References:' to point to problem reports;
> nevertheless 'Reported:' was chosen for this purpose, as it perfectly
> matches up with the 'Reported-by:' tag commonly used already and needed
> in this situation already.

I like the differences between "Reorted:" and "Reviewed:", although I may
keep the "Link" instead of Reviewed because my automate scripts just give
the link of the patch, and there's seldom a review attached to it :-/

That said, I would like a way to have versions show a link to the last
version that was reviewed.

v1: has no tags

v2: has a Reviewed: tag to v1.

v3: has a Reviewed: tag to v2

[...]

Then the final commit could have a "Link" or "Reviewed" tag to v3, even
though there may not be any reviews to v3, but v3 has the link to v2, and
v2 has the link to v1, etc.

-- Steve
