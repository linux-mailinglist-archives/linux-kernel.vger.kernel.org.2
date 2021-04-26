Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09B336B763
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhDZRCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234466AbhDZRCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:02:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E44061026;
        Mon, 26 Apr 2021 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456520;
        bh=6s5DB/7FPricOAX2is2wMOelVSpm/Dnrz4d/27Ea4dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKWv8qOtKm5XieGLWFwcJ4FT5NHvK8eNRC6iJQzWRUAK34glegBtihSXJa5OXuM70
         a/TtIHh88UgjP422U/BCjROZecIFGreJVVg+QTfGw+DCq30keEMH/aPl/xHytXOn2/
         mJr0cnNy908kSPXmph3zIfC9TOxrmCIMeZT30Ix8=
Date:   Mon, 26 Apr 2021 19:01:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 164/190] Revert "iio: ad9523: fix a missing check of
 return value"
Message-ID: <YIbyBtb34hvvDlJS@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-165-gregkh@linuxfoundation.org>
 <20210422093505.00006f77@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422093505.00006f77@Huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:35:05AM +0100, Jonathan Cameron wrote:
> On Wed, 21 Apr 2021 15:00:39 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > This reverts commit ae0b3773721f08526c850e2d8dec85bdb870cd12.
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
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Checked. Original fix was correct.  As with others I don't mind how we handle
> this.  Can either drop the revert, or bring it back later.

I'll drop the revert now, thanks for the review!

greg k-h
