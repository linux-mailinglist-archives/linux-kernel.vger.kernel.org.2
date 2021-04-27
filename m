Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21BC36C6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhD0ND7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235426AbhD0ND6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:03:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A8BF61026;
        Tue, 27 Apr 2021 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619528594;
        bh=dm7SlR0je7htSEuYhb+jbgvCjFCHV3SRo+u1FZc51UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyu7nf+o2O8jzltjkMY8DD48qYX67sI9JY5ZoZ2O23fr/jhvT5VpQQzYQiyuBwV/Z
         Wzv6u6Y2zTIxpx4oVOzoRGHXZoDnQFgaw6+UJoa5kvm26LteIDfdOBJRGRALDewkyy
         lpW17vJeJAj3i4cwWQU5JO3DDqlNNnbEfRzpQnAU=
Date:   Tue, 27 Apr 2021 15:03:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 006/190] Revert "media: exynos4-is: Fix a reference count
 leak"
Message-ID: <YIgLkEc2tTgv+eh1@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-7-gregkh@linuxfoundation.org>
 <e9fd0218-5ef6-784f-8702-22013b4e1593@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9fd0218-5ef6-784f-8702-22013b4e1593@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 09:04:09AM +0200, Krzysztof Kozlowski wrote:
> On 21/04/2021 14:58, Greg Kroah-Hartman wrote:
> > This reverts commit 64157b2cb1940449e7df2670e85781c690266588.
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
> > Cc: Qiushi Wu <wu000273@umn.edu>
> > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/media/platform/exynos4-is/mipi-csis.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> 
> This looks like a good commit but should be done now in a different way
> - using pm_runtime_resume_and_get().  Therefore I am fine with revert
> and I can submit later better fix.

Thanks for the review, I'll drop all 3 exynos4-is patches from this
series.

greg k-h
