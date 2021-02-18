Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C55931ECE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBRRJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231879AbhBRO35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:29:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9E0264E76;
        Thu, 18 Feb 2021 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613658554;
        bh=W/vP5B7kuDrYnokP92ychColA8JdWdOs46EX1GvjWFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atkky+PvrUMS2jEIL1tOYbPwGA99pLkmcTrYyIl/FmA9pVjRo3Hpa2ZfORr4qJUdd
         AMIeDbZjjesr+WO//NH9EDXqzfzNoUJbqnRAN3nZwZqKJ77m4o5b/Tjvj/zirbNRGW
         gGw/9Rix8+I+QKT2h9rLOVg6gYJtQHIZn2Kzgh5U=
Date:   Thu, 18 Feb 2021 15:29:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jari Ruusu <jariruusu@users.sourceforge.net>
Cc:     Willy Tarreau <w@1wt.eu>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC55t1vkRuC9uXcx@kroah.com>
References: <ef30af4d-2081-305d-cd63-cb74da819a6d@broadcom.com>
 <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <YC4atKmK7ZqlOGER@kroah.com>
 <20210218113107.GA12547@1wt.eu>
 <602E766F.758C74D8@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602E766F.758C74D8@users.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 04:15:11PM +0200, Jari Ruusu wrote:
> Willy Tarreau wrote:
> > The only set of fixes that can be trusted are the "official" stable
> > kernels, because they are the only ones that are approved by the patches
> > authors themselves. Adding more stuff on top of stable kernels is fine
> > (and done at your own risk), but randomly dropping stuff from stable
> > kernels just because you don't think you need that is totally non-sense
> > and must not be done anymore!
> 
> This may be little bit off-topic... but stable kernel.org kernels
> can also bit-rot badly because of "selective" backporting... as in
> anything that does not apply cleanly gets dropped regardless of
> how critical they are.
> 
> I will give you one example: Intel WiFi (iwlwifi) on 4.19.y
> kernel.org stable kernels is currently missing many critical
> locking fixes.

Why has no one asked for the specific upstream commits to be backported
if this is the case?

> As a result, that in-tree iwlwifi driver causes
> erratic behavior to random unrelated processes, and has been doing
> so for many months now. My not-so-politically correct opinion is
> that in-tree iwlwifi is completely FUBAR unless someone steps up
> to do professional quality backport of those locking fixes from
> upstream out-of-tree Intel version [1] [2] of the driver.

Why does any out-of-tree driver come into play here?  What is wrong with
the in-kernel code?

> For me
> only way to get properly working WiFi on my laptop computer is to
> compile that Intel out-of-tree version. Sad, but true.

Why use 4.19.y on a laptop in the firstplace?  That feels very wrong and
is not the recommended thing to use the LTS kernels for.

thanks,

greg k-h
