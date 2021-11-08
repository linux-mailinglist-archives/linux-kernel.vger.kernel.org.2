Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31444990E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbhKHQId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhKHQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:08:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790CAC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 08:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/HWgYNgcAyi53NUcet37YcktMzyD1RP2R5IycsZ1Svo=; b=bthRD5QObmLAL6qGx/FdUDefnz
        +GP4vfdVocRUeHOfaRdq5vEAamdbhP7tuForNCPVjvwy3puANyvS4/CCSY0jaaDWIT0Yo26APvSJl
        Z4PwVMD4bSjXNU7hifDp7hG7Z6yc01thPJEthp95Rkl0oBTDIAu/G0zZUucKRFjT8QR1jqRA7O6F9
        EMHPBuEqXgu5n+zNwx/q1vSW4F7xxL54Fq9Vxcc9MZg5QPbUSVGunOXfydkekx63f2IECBTE6xNPF
        VZDALgpCpKBt5m/xrUjOoetiHRBAg7ugOHXPmzeTd3QLpParQMI5qeFMrAnP5dyAkovlkahA6vCxl
        hqut8nSA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk79V-00GufO-Q1; Mon, 08 Nov 2021 16:05:45 +0000
Date:   Mon, 8 Nov 2021 08:05:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Modules updates for v5.16-rc1
Message-ID: <YYlK2QKpmb+ipalA@bombadil.infradead.org>
References: <YYWxSlB1CNhhjUTQ@bombadil.infradead.org>
 <CAHk-=wjQyGhKCM+F8vRS6SSesXk1rZEP4QxdTjvr8DXmC-e1Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQyGhKCM+F8vRS6SSesXk1rZEP4QxdTjvr8DXmC-e1Lg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 11:08:02AM -0800, Linus Torvalds wrote:
> On Fri, Nov 5, 2021 at 3:33 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > As requested by Jessica, I'm stepping in to help with modules
> > maintenance. This is my my first pull request, so if there are any
> > issues with it please let me know so I can fix things for the next
> > time around to make it even smoother for you.
> 
> Well, I want to see what I'm getting.
> 
> That's what "git request-pull" is all about - it does most of the
> formatting particularly if you have a tag with the explanations
> already like you seem to have.
> 
> That very much includes a diffstat and a shortlog, so that I see that
> "yes, what I got is actually what you intended for me to get" (and so
> that I can do a first quick scan of "this is what's coming" before I
> even do the pull - sometimes I use that to judge whether I should do
> the pull now,. or leave it for later when I have more time to go
> through something).

Odd, so I used 'git request-pull' and this page for guidence:

https://www.kernel.org/doc/html/latest/maintainer/pull-requests.html

Sadly, no diffstat or shortlog was provided in:

git request-pull modules-linus git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ modules-5.16-rc1

  Luis
