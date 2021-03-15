Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DB533C778
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhCOULG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbhCOULC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:11:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D35BC06174A;
        Mon, 15 Mar 2021 13:11:02 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3AEA72C4;
        Mon, 15 Mar 2021 20:11:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3AEA72C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1615839062; bh=WOJeu1ca+L02MsbEMhWpF0h1yJ7lNL7Kmfo9J6yUvEI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=I/OR3ApdHyIxqXVZNfKplKUI32tK7xlDYkT7Fuv1RB+1oSl3EvmYbnnWPuGzF/ioU
         Jr3xGin7OHEk6WsGaKLp1IIDn7U7O+LHiMx47+B9wHs8vhpVV+3i83aPjBLPsPnxWq
         62rhGfCmB+jvV0e6HH67SC+B7FRPpY8FyWN8uvaN36F5ErYkzE294AntyEx/ECPtWk
         IsBU5X11We97Wp0WhKffcQGKySXM7R0yrgcG16QThQjMq0J5KKAzvhB6QqBETl1q5O
         Av+ipiEfeARxT/mJXJP9T2mesk8bEioO+CZOzYsBAmNG+5vewfe8OrMAD4YjfnfSfe
         r8LBks9gE8Ung==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] docs: reporting-issues.rst: shortcut for
 reporting stable regressions
In-Reply-To: <148a84de8d109ebbc01a337fb93cb246410c4351.1615116592.git.linux@leemhuis.info>
References: <cover.1615116592.git.linux@leemhuis.info>
 <148a84de8d109ebbc01a337fb93cb246410c4351.1615116592.git.linux@leemhuis.info>
Date:   Mon, 15 Mar 2021 14:11:01 -0600
Message-ID: <878s6o18kq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Provide a much shorter and easier process for users that deal with
> regressions in stable and longterm kernels, as those should be reported
> quickly.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Randy Dunlap <rdunlap@infradead.org>

Seems generally good, but I had a couple of comments...

> v2
> * revist, lots of small improvements in various places
>
> v1
> * https://lore.kernel.org/linux-doc/20210214145454.357392-1-linux@leemhuis.info/
> * initial version
> ---
>  .../admin-guide/reporting-issues.rst          | 140 ++++++++++++------
>  1 file changed, 94 insertions(+), 46 deletions(-)
>
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 24ee78455d3e..937797e52837 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -106,6 +106,10 @@ process won't feel wasted in the end:
>     issue, or a really severe problem: those are 'issues of high priority' that
>     need special handling in some steps that are about to follow.
>  
> + * If you are facing a regression within a stable or longterm version line
> +   (say something broke when updating from 5.10.4 to 5.10.5), head over to
> +   'Dealing with regressions within a stable and longterm kernel line'.

I would s/head over/scroll down/.  Otherwise readers may well wondering
where to go to find this section.

>   * Locate the driver or kernel subsystem that seems to be causing the issue.
>     Find out how and where its developers expect reports. Note: most of the
>     time this won't be bugzilla.kernel.org, as issues typically need to be sent
> @@ -215,23 +219,42 @@ rebased on new stable or longterm releases. If that case follow these steps:
>     deemed unsuitable for backporting. If backporting was not considered at
>     all, join the newest discussion, asking if it's in the cards.
>  
> - * Check if you're dealing with a regression that was never present in
> -   mainline by installing the first release of the version line you care
> -   about. If the issue doesn't show up with it, you basically need to report
> -   the issue with this version like you would report a problem with mainline
> -   (see above). This ideally includes a bisection followed by a search for
> -   existing reports on the net; with the help of the subject and the two
> -   relevant commit-ids. If that doesn't turn up anything, write the report; CC
> -   or forward the report to the stable maintainers, the stable mailing list,
> -   and those who authored the change. Include the shortened commit-id if you
> -   found the change that causes it.
> -
>   * One of the former steps should lead to a solution. If that doesn't work
>     out, ask the maintainers for the subsystem that seems to be causing the
>     issue for advice; CC the mailing list for the particular subsystem as well
>     as the stable mailing list.
>  
>  
> +Dealing with regressions within a stable and longterm kernel line
> +-----------------------------------------------------------------
> +
> +This section is for you, if you face a regression within a stable or longterm
> +kernel version line, e.g. if something breaks when updating from 5.10.4 to
> +5.10.5 (a switch from 5.9.15 to 5.10.5 would not qualify). The developers want
> +to fix such regressions as quickly as possible, hence there is a streamlined
> +process to report them:
> +
> + * Check the archives of the Linux stable mailing list for existing reports.
> +
> + * Check if the kernel developers still maintain the Linux kernel version
> +   line you care about: go to the front page of kernel.org and make sure it
> +   mentions the latest release of the particular version line without an
> +   '[EOL]' tag.
> +
> + * Install the latest release from the particular version line as a vanilla
> +   kernel. Ensure this kernel is not tainted and still shows the problem, as
> +   the issue might have already been fixed there.
> +
> + * Make sure it's not the kernel's surroundings that are causing the issue
> +   you face.

I can imagine that a lot of readers would have no idea what that means.
In fact, I'm not entirely sure what that means...

> + * Send a short problem report by mail to the people and mailing lists the
> +   :ref:`MAINTAINERS <maintainers>` file specifies in the section 'STABLE
> +   BRANCH'. Roughly describe the issue and ideally explain how to reproduce
> +   it. Mention the first version that shows the problem and the last version
> +   that's working fine. Then wait for further instructions.
> +
> +
>  Reference section: Reporting issues to the kernel maintainers
>  =============================================================
>  
> @@ -433,6 +456,22 @@ fatal error where the kernel stop itself) with a 'Oops' (a recoverable error),
>  as the kernel remains running after the latter.
>  
>  
> +Regression in stable or longterm kernel?
> +----------------------------------------
> +
> +    *If you are facing a regression within a stable or longterm version line
> +    (say something broke when updating from 5.10.4 to 5.10.5), head over to
> +    'Dealing with regressions within a stable and longterm kernel line'.*

So you want to send them back upward here?

> +Regression within a stable and longterm kernel version line are something the
> +Linux developers want to fix badly, as such issues are even more unwanted than
> +regression in the main development branch, as they can quickly affect a lot of
> +people. The developers thus want to learn about such issues as quickly as
> +possible, hence there is a streamlined process to report them. Note,
> +regressions with newer kernel version line (say something broke when switching
> +from 5.9.15 to 5.10.5) do not qualify.

Given the length of this file, I really wonder if there isn't some way
to cut back on the amount of repeated text?

Thanks,

jon
