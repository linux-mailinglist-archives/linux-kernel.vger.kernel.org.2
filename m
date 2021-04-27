Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1F636C9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237715AbhD0QvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236405AbhD0QvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:51:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D9DA613D9;
        Tue, 27 Apr 2021 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542229;
        bh=Rp3gOPPwFf3EOQNq77Ku+vQ5D/s8YJR3r46OhoSn6TE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eE6sE5zVPxxXw7tz0MyS0diFqLULPzrPskTO4stOvboH0PgUfqhlm/FmFxdt6BbWZ
         e5pqsGV8UNqCsaNMd0rq0OtQ3N7OZXfspguoS5RvMKm2K40tF+EIN0aLxba1I83ySn
         zAZpE3DnfCjI7D/Fi9suo7EtJweMnKvHjqrIsrwI=
Date:   Tue, 27 Apr 2021 18:50:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 170/190] Revert "net: dsa: bcm_sf2: Propagate error value
 from mdio_write"
Message-ID: <YIhA0zGpWSUSjZKH@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-171-gregkh@linuxfoundation.org>
 <30b2efa4-f873-a391-00c7-f1eb278a3db1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b2efa4-f873-a391-00c7-f1eb278a3db1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:20:24PM -0700, Florian Fainelli wrote:
> 
> 
> On 4/21/2021 6:00 AM, Greg Kroah-Hartman wrote:
> > This reverts commit e49505f7255be8ced695919c08a29bf2c3d79616.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> While this commit does not fix a known problem, the driver should have
> arguably propagated the return values and it did not, so I would be
> inclined to keep it.

Looks good, I'll drop my revert, thanks for the review.

greg k-h
