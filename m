Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6186C419807
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhI0Pjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhI0Pjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:39:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D7736103B;
        Mon, 27 Sep 2021 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632757087;
        bh=01pncTuL6mO/zCZjIXlbG8UzM8/W78TrZdnq4pIw33o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEyrA67ttikhX6GLVEUDRcYmxqD9leWM5LJz6W62G+Du840GRcEsMo+hCrNx107XE
         LO0OVd+DcdRgfhWDVnHRut1UEKtXlwCWi83DsF+Lz9Ww1Svn9AoZtvYQ0ro/qGm220
         9Z7ttoqdls5NZWyrDMe5mUY+X6JSGPexQxm4BSvA=
Date:   Mon, 27 Sep 2021 17:37:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v9 10/16] staging: r8188eu: shorten and simplify calls
 chains
Message-ID: <YVHlRf7C6m+2Si+3@kroah.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
 <1836626.W0nMHyKdkH@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1836626.W0nMHyKdkH@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 02:37:52PM +0200, Fabio M. De Francesco wrote:
> On Friday, September 24, 2021 2:26:49 PM CEST Fabio M. De Francesco wrote:
> > --- Preface ---
> > 
> > This is v10 of "shorten and simplify calls chain". The 14 (v7) + 2 (v8) 
> > patches have already been applied to staging-testing, so we have been 
> > requested to reset the numbering of the remaining patches to 01/16, while 
> > discarding from v9 the above-mentioned 16 patches (otherwise we would
> > have submitted a series containing 32 patches, that is 1 patch less than
> > v8 because it has been dropped by us in what we considered it
> > unnecessary - it was about fixing a misspelled word in a comment).
> 
> Hello all,
> 
> Please disregard this weird cover. I don't know how I've been able to make 
> the mess you see in the subject. The good one has been sent soon after this.
> And please, let me know if it is necessary to resend in order to have the 
> cover letter as the first email of the thread.

Nah, I can figure it out, looks good, let's queue it up and see what
breaks :)

thanks,

greg k-h
