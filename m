Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2436CB95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbhD0TXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbhD0TXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:23:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB86C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:22:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id b17so6038928pgh.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LY3gFeU1q8iFKq/jC5H7kixgFmtS9nXWZUQKza2+nQs=;
        b=ejLPFi54AqigD8xCtEcI/bn70WATJRYG2As1qBC+YuXQm1SWv9m/hdgTmS4XanEjDa
         HETTiVSvoPYLGmWkamYz8vD2hCsgq6UA08Quwf3V4hfiqAAFKfczCF5Q4cLDB7I0uJok
         4QZgWpSJFOMS3zB+nE7AkDBWoirqoJka4Zhg7FYqrkU+Xp/ymomR10ZcbzEsdbdxkqwH
         RQPJUPC63PiEOAeeh+Du2ean63zb8FaKjsHoE2hfuZothOtvyZMOIMa+Ofi17rq8Nraf
         PdgSyfF5M6Xu4E2ZXQDga2ZCjH8TmPzoAnQ/aQWJ9OtfZTR6+GLV0dt45U8SgGzn6Rl2
         GYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LY3gFeU1q8iFKq/jC5H7kixgFmtS9nXWZUQKza2+nQs=;
        b=TOilWPBQUe4sYFp25ZLIsfdnlWSpWf/q/K8yDFEVAbu9CvxscgnjD2gbGj+vYmtrr2
         ZtVa0q2KX4TafBw4Emyl9+4pykMCxwfIVYYqqgqRZ8D2bkR7y3fdG8aCHRi0aiSBsskD
         FCju/rLe9usZzhk3OQSR/QKaHtIEEZW8OjnwomCJ9UvJ1gKs+aUDS42G43lM4512c3ZC
         zNlz9Nz4kVdmoBGlpn9jND3iMFfrtgZAwOYtHrub3+kttRY1jugCmklBEZ25zBCrrfsg
         vs9dLFzdVXAZnyA+p3cuTcK/4+NrRLknOgHPCNHR52l57PoQgXCLx4K/BU7jKmXMxCoi
         AEkw==
X-Gm-Message-State: AOAM5317/wYmGOt5eHFGRGzhUtKtuR4kM46ZfJhYfgYDK9MoRROKTNl8
        r9RafQXS6x+pFgEAU9KzbU4=
X-Google-Smtp-Source: ABdhPJwaL7+AZ4DCM1AlZRGBZKnB963269r6QYz20bya8l+XEOVQPhiKTwF8Nzzoxn6QFE093IBHbw==
X-Received: by 2002:a63:e509:: with SMTP id r9mr23769212pgh.384.1619551336543;
        Tue, 27 Apr 2021 12:22:16 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c54e:55f9:7bf8:7932])
        by smtp.gmail.com with ESMTPSA id f15sm461778pgv.5.2021.04.27.12.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:22:14 -0700 (PDT)
Date:   Tue, 27 Apr 2021 12:22:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 157/190] Revert "Input: ad7879 - add check for read
 errors in interrupt"
Message-ID: <YIhkZOWJiOlDJCYS@google.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-158-gregkh@linuxfoundation.org>
 <YIBa5X+5g/qNL+N8@google.com>
 <YIhB7rvHlFDew00z@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIhB7rvHlFDew00z@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 06:55:10PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 10:03:33AM -0700, Dmitry Torokhov wrote:
> > Hi Greg,
> > 
> > On Wed, Apr 21, 2021 at 03:00:32PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit e85bb0beb6498c0dffe18a2f1f16d575bc175c32.
> > > 
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > 
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > 
> > This one looks really OK to me and does not have to be reverted (unless
> > Aditya will come clean and show the error introduced?).
> 
> I'll drop this revert, but it isn't usually good to be calling printk()
> from an irq.

How else do you suggest we tell that something is wrong when
communicating with the device? For these types of devices the
communication is essentially unsolicited so we can't pass failure to a
caller to deal with it (i.e. unlike USB there is no URB posted that we
could fail and use as a mechanism to signal error to some other layer)
and while we could invent "something went wrong" input event so far
there was no interest in having anything like that.

I'd suggest sending KOBJ_ERROR uevent when a device driver detects
anomaly in the device it controls, but I wonder how systemd would react
given past experiences with KOBJ_BIND/KOBJ_UNBIND.

The message is ratelimited so it will not overfill the logs...

Thanks.

-- 
Dmitry
