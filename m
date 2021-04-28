Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC336D958
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhD1OOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhD1OOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:14:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D74EE61424;
        Wed, 28 Apr 2021 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619619243;
        bh=LrI9EyriTNzlF19LSDUJcI9lL1R/vtRwbqVxLduTtIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUuQDDlV5/Weo5NpINpcpgbKVC3oTwegSq+1ZGp+9bav91ppzXIUL+jJKMZQvI7ZC
         LEmcSQBcyP6vQ6HR3cUREPha/3TQTiqyb4Y1qNlrsjq7MX35xc1XxySN1EI5DH35Lm
         VLXt+35DsqVRNuu0+mumLlWuIIHBDHsRUpaae9x8=
Date:   Wed, 28 Apr 2021 16:14:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 157/190] Revert "Input: ad7879 - add check for read
 errors in interrupt"
Message-ID: <YIltqNnVfBZ4F1kY@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-158-gregkh@linuxfoundation.org>
 <YIBa5X+5g/qNL+N8@google.com>
 <YIhB7rvHlFDew00z@kroah.com>
 <YIhkZOWJiOlDJCYS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIhkZOWJiOlDJCYS@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:22:12PM -0700, Dmitry Torokhov wrote:
> On Tue, Apr 27, 2021 at 06:55:10PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 21, 2021 at 10:03:33AM -0700, Dmitry Torokhov wrote:
> > > Hi Greg,
> > > 
> > > On Wed, Apr 21, 2021 at 03:00:32PM +0200, Greg Kroah-Hartman wrote:
> > > > This reverts commit e85bb0beb6498c0dffe18a2f1f16d575bc175c32.
> > > > 
> > > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > > faith" to try to test the kernel community's ability to review "known
> > > > malicious" changes.  The result of these submissions can be found in a
> > > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > > 
> > > > Because of this, all submissions from this group must be reverted from
> > > > the kernel tree and will need to be re-reviewed again to determine if
> > > > they actually are a valid fix.  Until that work is complete, remove this
> > > > change to ensure that no problems are being introduced into the
> > > > codebase.
> > > 
> > > This one looks really OK to me and does not have to be reverted (unless
> > > Aditya will come clean and show the error introduced?).
> > 
> > I'll drop this revert, but it isn't usually good to be calling printk()
> > from an irq.
> 
> How else do you suggest we tell that something is wrong when
> communicating with the device? For these types of devices the
> communication is essentially unsolicited so we can't pass failure to a
> caller to deal with it (i.e. unlike USB there is no URB posted that we
> could fail and use as a mechanism to signal error to some other layer)
> and while we could invent "something went wrong" input event so far
> there was no interest in having anything like that.
> 
> I'd suggest sending KOBJ_ERROR uevent when a device driver detects
> anomaly in the device it controls, but I wonder how systemd would react
> given past experiences with KOBJ_BIND/KOBJ_UNBIND.
> 
> The message is ratelimited so it will not overfill the logs...

Sending uevents from an irq is not a good idea, as you say :)

I don't know what the best way to "fail" this is, a ratelimited printk()
seems to be about all you can do.  Luckily hardware doesn't fail that
often in this manner.

thanks,

greg k-h
