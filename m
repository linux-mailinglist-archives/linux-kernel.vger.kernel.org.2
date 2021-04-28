Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E526736D2ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhD1HTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236464AbhD1HTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:19:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16099600D4;
        Wed, 28 Apr 2021 07:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619594301;
        bh=8V301gzhnRSt2xyReEmb+GbAQZ/IKOdrhRvN20Q2lDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LaQVaGlLVJIClm/IogEEkmBX1wzF9ik44Nsx1D60BM00u93qiB+ymoyxYFYr5pe5l
         +PxWMVdaOKZskj6NwwOUsMfQ2HM5d5K37ruIzfV1COPruBQAs4kw6hXos1v60BUfdr
         qK6/HOegnUUCgCpTU5g5B/SQlwC3eu3V4+7vWMbQ=
Date:   Wed, 28 Apr 2021 09:18:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 088/190] Revert "mmc_spi: add a status check for
 spi_sync_locked"
Message-ID: <YIkMOrfvuW0J/ioi@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-89-gregkh@linuxfoundation.org>
 <YIAmS4jc5W21epzh@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIAmS4jc5W21epzh@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:19:07PM +0300, Laurent Pinchart wrote:
> Hi Greg,
> 
> Thank you for the patch.
> 
> On Wed, Apr 21, 2021 at 02:59:23PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 611025983b7976df0183390a63a2166411d177f1.
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
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks for the review!

> I don't spot an obvious issue with the original patch though.

Ulf did :)

