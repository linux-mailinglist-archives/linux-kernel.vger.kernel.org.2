Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D886D3464DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhCWQVF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Mar 2021 12:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhCWQU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:20:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE64561477;
        Tue, 23 Mar 2021 16:20:26 +0000 (UTC)
Date:   Tue, 23 Mar 2021 12:20:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        workflows@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: RFC: create mailing list "linux-issues" focussed on issues/bugs
 and regressions
Message-ID: <20210323122025.77888b49@gandalf.local.home>
In-Reply-To: <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
        <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
        <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 20:25:15 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

> I agree to the last point and yeah, maybe regressions are the more
> important problem we should work on – at least from the perspective of
> kernel development.  But from the users perspective (and
> reporting-issues.rst is written for that perspective) it feel a bit
> unsatisfying to not have a solution to query for existing report,
> regressions or not. Hmmmm...

I think the bulk of user issues are going to be regressions. Although you
may be in a better position to know for sure, but at least for me, wearing
my "user" hat, the thing that gets me the most is upgrading to a new kernel
and suddenly something that use to work no longer does. And that is the
definition of a regression. My test boxes still run old distros (one is
running fedora 13). These are the boxes that catch the most issues, and if
they do, they are pretty much guaranteed to be a regression.

I like the "linux-regressions" mailing list idea.

-- Steve
