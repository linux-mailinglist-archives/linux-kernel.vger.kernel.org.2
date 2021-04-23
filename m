Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F06368DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241026AbhDWHKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhDWHKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:10:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B18B56121F;
        Fri, 23 Apr 2021 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619161809;
        bh=FGIGAh/APMY+SEmREebL3RMzj4OUlwesmva8CiqfQGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRHmRYzvcK+gneytIGbn4pYINisOaDPuQczzGn8P8CkZKCOIn4JHhrSHaRXt+PuSV
         naqMU7aGdGcbuRgtn1XzSm+NpXV8kJGD3EcZ13DLfOt55ZbSQSmboWrBBvT+p0fEwr
         qTeE8gZmUN4bkQI0wYXT71Iay1HizWwGv3IOA7oQ=
Date:   Fri, 23 Apr 2021 09:10:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jiri Kosina <jikos@kernel.org>, Will Deacon <will@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <YIJyzkgglMrAzIwh@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421180155.GA2287172@nvidia.com>
 <18edc472a95f1d4efe3ef40cc9b8d2611d4ab990.camel@redhat.com>
 <6b19f57c-8d4f-ef3f-9792-f52900137522@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b19f57c-8d4f-ef3f-9792-f52900137522@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 09:01:26AM +0200, Krzysztof Kozlowski wrote:
> On 22/04/2021 20:53, Doug Ledford wrote:
> > On Wed, 2021-04-21 at 15:01 -0300, Jason Gunthorpe wrote:
> >> On Wed, Apr 21, 2021 at 02:57:55PM +0200, Greg Kroah-Hartman wrote:
> >>> I have been meaning to do this for a while, but recent events have
> >>> finally forced me to do so.
> >>>
> >>> Commits from @umn.edu addresses have been found to be submitted in
> >>> "bad
> >>> faith" to try to test the kernel community's ability to review
> >>> "known
> >>> malicious" changes.  The result of these submissions can be found in
> >>> a
> >>> paper published at the 42nd IEEE Symposium on Security and Privacy
> >>> entitled, "Open Source Insecurity: Stealthily Introducing
> >>> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu
> >>> (University
> >>> of Minnesota) and Kangjie Lu (University of Minnesota).
> >>
> >> I noted in the paper it says:
> >>
> >>   A. Ethical Considerations
> >>
> >>   Ensuring the safety of the experiment. In the experiment, we aim to
> >>   demonstrate the practicality of stealthily introducing
> >> vulnerabilities
> >>   through hypocrite commits. Our goal is not to introduce
> >>   vulnerabilities to harm OSS. Therefore, we safely conduct the
> >>   experiment to make sure that the introduced UAF bugs will not be
> >>   merged into the actual Linux code
> >>
> >> So, this revert is based on not trusting the authors to carry out
> >> their work in the manner they explained?
> >>
> >> From what I've reviewed, and general sentiment of other people's
> >> reviews I've read, I am concerned this giant revert will degrade
> >> kernel quality more than the experimenters did - especially if they
> >> followed their stated methodology.
> > 
> > I have to agree with Jason.  This seems like trying to push a thumbtack
> > into a bulletin board using a pyle driver.  Unless the researchers are
> > lying (which I've not seen a clear indication of), the 190 patches you
> > have selected here are nothing more than collateral damage while you are
> > completely missing the supposed patch submission addresses from which
> > the malicious patches were sent!
> > 
> > This all really sounds like a knee-jerk reaction to thier posting.  I
> > have to say, I think it's the wrong reaction to have.
> 
> Nothing stops you from participating in the review of this
> revert-series, if you think these are valuable commits. Patches getting
> the review, won't be reverted (as I understood).

You understand correctly :)
