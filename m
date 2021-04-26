Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530C836B765
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhDZRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234767AbhDZRD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:03:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0507E613A9;
        Mon, 26 Apr 2021 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456565;
        bh=FJd2tv+6a2FOY9AkOZSzckjWw18VJjimL2ksa5CwH3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3X64ZtuFwWWrKK8mIDkwYHxj5fOCPYpuj5tSuuCiuSdnuOF+snZGQ/WzdxasSaBP
         mLdLL681ldJ6t5iCpsviugXjIOFW/pVtelP8rpqEKl0H4z/1Nn0Wv3yH3tfTB4P6JM
         93fD08YSqpKYytug18R/G85pt4zhVcviQWMl/ZzQ=
Date:   Mon, 26 Apr 2021 19:02:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 093/190] Revert "iio: hmc5843: fix potential NULL pointer
 dereferences"
Message-ID: <YIbyMgf7itu+POVL@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-94-gregkh@linuxfoundation.org>
 <20210422092625.00005af6@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422092625.00005af6@Huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:26:25AM +0100, Jonathan Cameron wrote:
> On Wed, 21 Apr 2021 14:59:28 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > This reverts commit 536cc27deade8f1ec3c1beefa60d5fbe0f6fcb28.
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
> Hi Greg,
> 
> Checked this one.  As far as I can tell it was a valid cleanup of
> error handling. Far from critical though and unlikely to be seen in practice.
> 
> So either leave it in place, or we can bring it back later. I don't mind
> which.

Now dropped, thanks.

greg k-h
