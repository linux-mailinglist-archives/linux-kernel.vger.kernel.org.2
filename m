Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC02236C798
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhD0OOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhD0OOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:14:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C591C613D9;
        Tue, 27 Apr 2021 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619532815;
        bh=9NtXHbEtmqErtV8uV6mYVw8lYJQR+Gfn5iirqIgDKZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sP8FNCa3IEdwQ4N4uIDKJdDRYO+HlzCVH0G2Pye4uSQ+Pe14YEj8N2FUxdcrOwEVy
         vh2hEO/xk0gYdQ3LR1S1d37EkXMWCvhTaHJkLJxnRxiU9E0NMcQOTrM96Z54tTLp77
         fXpq9uNOsrQUdxWp/ealb+da56lhX88j0I4SGR4U=
Date:   Tue, 27 Apr 2021 16:13:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 177/190] Revert "hwmon: (lm80) fix a missing check of bus
 read in lm80 probe"
Message-ID: <YIgcDZu1GjN9wXFm@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-178-gregkh@linuxfoundation.org>
 <78ac6ee8-8e7c-bd4c-a3a7-5a90c7ccb399@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78ac6ee8-8e7c-bd4c-a3a7-5a90c7ccb399@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 07:03:42AM -0700, Guenter Roeck wrote:
> On 4/21/21 6:00 AM, Greg Kroah-Hartman wrote:
> > This reverts commit 9aa3aa15f4c2f74f47afd6c5db4b420fadf3f315.
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
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> I don't immediately see a problem with this patch, but the other patch
> introduced at the same time by the same author was indeed malicious,
> and the bug it introduced was easy to overlook, so I agree that
> this patch should be reverted.
> 
> [ When introducing error handling into this probe function, errors
>   in lm80_init_client() should be addressed as well. This patch did
>   not do that and thus had limited value anyway. ]

Thanks for the review!

greg k-h
