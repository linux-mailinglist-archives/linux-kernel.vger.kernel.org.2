Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6416039B9BB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFDNXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhFDNXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:23:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CEE1613DE;
        Fri,  4 Jun 2021 13:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622812867;
        bh=SMxbVQRzNDu0pT/nHKStbHojRrJ+0xUGMcKy6TjIlTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsRy32iqiFbpWQ8vFzOS9pgLGg83/Go3/g7y3c8JAe3JzbMs2y1q85g98trrhZ7i7
         alkB1K/BmLjm5vVvXRr7R08LZR4/s+FFu48UiNVctWNM8ncxPU62QdFH3imH6CPxKO
         4+vcr6l2rlRBh0zg467HdJBgFwyG0KCtpfh4YciM=
Date:   Fri, 4 Jun 2021 15:21:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        collins@gene3.ait.iastate.edu,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        grandmaster@al2klimov.de, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
Message-ID: <YLoowE6cxZYCysVa@kroah.com>
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <875yyxbenm.fsf@meer.lwn.net>
 <20210601220643.uzep2ju2zlcmpa57@begin>
 <874keh9qk9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874keh9qk9.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 04:18:46PM -0600, Jonathan Corbet wrote:
> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> 
> > Jonathan Corbet, le mar. 01 juin 2021 12:53:01 -0600, a ecrit:
> >> I am concerned about one thing, though: the licensing of this document
> >> is not GPL-compatible, which means we can't build it into the rest of
> >> the docs.
> >
> > ? I see various GFDL-1.1-no-invariants-or-later documentation in
> > userspace-api/media notably, do they have such build restriction? What
> > is actually posing problem in the GFDL licence?
> 
> Those media docs are separate from the rest of the kernel
> documentation.  Other than that, all FDL in Documentation/ was
> dual-licensed, last time I checked.
> 
> The problem is that the kernel docs, when built, include a great deal of
> code and text taken directly from the kernel source.  The built docs are
> thus a derived product of the kernel and the result needs to carry a
> GPL-compatible license.  I've spent some time talking with lawyers about
> this, and they have confirmed that view of things.
> 
> This document should not have entered Documentation/ with that license;
> had I known this was happening at the time, I would have raised a fuss.
> As a standalone .txt file there is probably no legal problem, but that
> changes as soon as you bring it into RST TOC tree.

Sorry about this, I totally missed this issue when moving the code out
of staging.

greg k-h
