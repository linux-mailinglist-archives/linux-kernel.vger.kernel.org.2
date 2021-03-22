Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4180345226
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCVV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:57:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56150 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229730AbhCVV5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:57:09 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12MLuuMT020632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 17:56:57 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 754A315C39CC; Mon, 22 Mar 2021 17:56:56 -0400 (EDT)
Date:   Mon, 22 Mar 2021 17:56:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
Message-ID: <YFkSqIN90S4a3HiF@mit.edu>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
 <CAHk-=wgiYqqLzsb9-UpfH+=ktk7ra-2fOsdc_ZJ7WF47wS73CA@mail.gmail.com>
 <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62b60247-7838-a624-706e-b1a54785b2a5@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:25:15PM +0100, Thorsten Leemhuis wrote:
> I agree to the last point and yeah, maybe regressions are the more
> important problem we should work on – at least from the perspective of
> kernel development.  But from the users perspective (and
> reporting-issues.rst is written for that perspective) it feel a bit
> unsatisfying to not have a solution to query for existing report,
> regressions or not. Hmmmm...

First of all, thanks for working on reporting-issues.rst.  If we can
actually get users to *read* it, I think it's going to save kernel
developers a huge amount of time and frustration.

I wonder if it might be useful to have a form which users could be
encouraged to fill out so that (a) the information is available in a
structured format so it's easier for developers to find the relevant
information, (b) so it is easier for programs to parse, for easier
reporting or indexing, and (c) as a nudge so that users remember to
report critical bits of information such as the hardware
configuration, the exact kernel version, which distribution userspace
was in use, etc.

There could also be something in the text form which would make it
easier for lore.kernel.org searches to identify bug reports.  (e.g.,
"LINUX KERNEL BUG REPORTER TEMPLATE")

					- Ted
