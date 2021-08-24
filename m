Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B393F6296
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhHXQTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232533AbhHXQTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:19:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BF0C61212;
        Tue, 24 Aug 2021 16:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629821913;
        bh=QTaqs0FhrQlrtdtn3tmJQ3pJZp4aSw6kwOmgsRbriCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M10dg2TSUsDx9Qot+PnjKv8t9f/eoMfPlxc29XOR29p7Q3JgPv0IIlrArewAPGAsv
         aqRM1WchCvEy/n26oh6W+3uWJRmr3FD/zCslIugrnzKJCTANKQWrbGIvrU2jVpdk6y
         SBoZm62Q1PSmRes21qZBOjWKEPZTnhlezGjvT7nw=
Date:   Tue, 24 Aug 2021 18:18:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 2/2] staging: r8188eu: Make some clean-ups in
 usbctrl_vendorreq()
Message-ID: <YSUb1BPAGmP9wngU@kroah.com>
References: <20210824142823.16845-1-fmdefrancesco@gmail.com>
 <2327592.S5L5zkRU50@localhost.localdomain>
 <a5bfab84-16cc-52ad-5cdb-038765bf0b36@gmail.com>
 <1730935.6n1DRfr91A@localhost.localdomain>
 <8984a400-0d1a-07cc-cff4-c0eeef81fc79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8984a400-0d1a-07cc-cff4-c0eeef81fc79@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 07:04:31PM +0300, Pavel Skripkin wrote:
> On 8/24/21 6:59 PM, Fabio M. De Francesco wrote:
> > On Tuesday, August 24, 2021 5:43:26 PM CEST Pavel Skripkin wrote:
> > > On 8/24/21 6:39 PM, Fabio M. De Francesco wrote:
> > > > Oh, I know where it comes from... :)
> > > > > It's a patch of mine that is in the queue, waiting to be
> > > reviewed and applied.
> > > > Please see: https://lore.kernel.org/lkml/20210819221241.31987-1-fmdefrancesco@gmail.com/
> > > > oh.... there are _a lot_ of pending changes :)
> > > 
> > > I guess, we need smth like public-mirror with already reviewed and
> > > working changes
> > 
> > It's becoming a serious problem. A lot of times I see people who is asked to
> > rebase and resend, not because they forget to fetch the current tree, instead
> > because the tree changes as soon as Greg start to apply the first patches in the
> > queue and the other patches at the end of the queue cannot be applied.
> > 
> > Anyway,I understand that Greg cannot apply a patch at a time soon after
> > submission but in the while the queue grows larger and larger.
> > 
> 
> 
> It can be easily fixed. We need public fork somewhere (github,
> git.kernel.org ...) and we should ask Greg to add remote-branch to his tree.

No, not going to happen, sorry.  I will catch up with patches when I get
the chance and then all will be fine.  This is highly unusual that there
are loads of people all working on the same staging driver.  No idea why
everyone jumped on this single one...

relax, there is no rush here...

greg k-h
