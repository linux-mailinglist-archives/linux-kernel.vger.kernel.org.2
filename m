Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA8344DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCVR6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:58:24 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:46516 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231310AbhCVR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:58:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ACDBC12801FD;
        Mon, 22 Mar 2021 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1616435880;
        bh=js5x8RonEdB9AM7IqO+7/faDn1iuZEitNT8uFo3jGV4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=xjapXEFkDLOda/4rY0+u8LcCnC7IgZ0r+ACiNJEtyIDDZmpCQCVmNt+yhHQ/ilqaz
         LimD1raxsCscvzx8IB+vEMzRY+dHEZRIf3v2RTOYd91+UQixoJxThu0L78cjHmrVTM
         v5O3QbzZazLBuOtoi1pG2KdJjYnGqLe06leJGXBE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nr2UoEAftmQx; Mon, 22 Mar 2021 10:58:00 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 49FEF12801CA;
        Mon, 22 Mar 2021 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1616435880;
        bh=js5x8RonEdB9AM7IqO+7/faDn1iuZEitNT8uFo3jGV4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=xjapXEFkDLOda/4rY0+u8LcCnC7IgZ0r+ACiNJEtyIDDZmpCQCVmNt+yhHQ/ilqaz
         LimD1raxsCscvzx8IB+vEMzRY+dHEZRIf3v2RTOYd91+UQixoJxThu0L78cjHmrVTM
         v5O3QbzZazLBuOtoi1pG2KdJjYnGqLe06leJGXBE=
Message-ID: <e93ad98a34828a4140fa59c1fb5b01f03c6f4245.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] RFC: create mailing list "linux-issues"
 focussed on issues/bugs and regressions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Greg KH <gregkh@linuxfoundation.org>, workflows@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Mon, 22 Mar 2021 10:57:59 -0700
In-Reply-To: <20210322171636.fkep2lby6gnve4su@chatter.i7.local>
References: <613fe50d-fc9c-6282-f1f3-34653acb2ee9@leemhuis.info>
         <20210322171636.fkep2lby6gnve4su@chatter.i7.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-22 at 13:16 -0400, Konstantin Ryabitsev wrote:
> On Mon, Mar 22, 2021 at 04:18:14PM +0100, Thorsten Leemhuis wrote:
> > Note, there is a second reason why ksummit-discuss is CCed: another
> > reason why I want to create this new list is making it easier to
> > find and track regressions reported to our various mailing lists
> > (often without LKML in CC, as for some subsystems it's seems to be
> > custom to not CC it). 
> 
> FYI, there will soon be a unified "search all of lore.kernel.org
> regardless of the list/feed source" capability that may make it
> unnecessary to create a separate list for this purpose. There's
> active ongoing work in the public-inbox project to provide parallel
> ways to follow aggregate topics, including query-based subscriptions
> (i.e. "put a thread into my inbox whenever someone mentions my
> favourite file/function/device name"). This work is not complete yet,
> but I have great hopes that it will become available in the next
> little while.
> 
> Once we have this ability, we should be able to plug in multiple
> sources beyond just mailing lists, including a feed of all
> bugzilla.kernel.org changes. This should allow someone an easy way to
> query specific bugs and may not require the creation of a separate
> list.
> 
> I'm not opposed to the creation of a new list, of course -- just want
> to make sure it's aligned with the improvements we are working to
> make available.

I suspect the problem is that there's no known useful search string to
find a bug report even given a searchable set of lists, so the main
purpose of this list would be "if it's on here, it's a bug report" and
the triage team can cc additional lists as appropriate.  Then we simply
tell everyone to send kernel bugs to this list and ask maintainers to
cc it if a bug report shows up on their list?

James


