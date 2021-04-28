Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812D936D41A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbhD1Imz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbhD1Imx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:42:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D897C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:42:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2791C2C1;
        Wed, 28 Apr 2021 10:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1619599326;
        bh=eIKOtb0EwVMW8rF2TDb6io7j7TuJD3/NY/qCSlvVNG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGkxOVmepCbC4IZxdYxGlmJ7HbfiujAcvbwCqAFEvboBnePzCLqgK6rzhZc2Y1vyr
         KOK4ViLGV2Gt7OhlF0C/35k03V5lExNQ9U+S9PmF+UGhTq+1cerGRTU9KkeSXOv2sX
         GsWZ4cE7PDt0LeF80ZymrtJcoNYa10zcbZXDS3Hw=
Date:   Wed, 28 Apr 2021 11:42:00 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 088/190] Revert "mmc_spi: add a status check for
 spi_sync_locked"
Message-ID: <YIkf2OFKCbIz8tiB@pendragon.ideasonboard.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-89-gregkh@linuxfoundation.org>
 <YIAmS4jc5W21epzh@pendragon.ideasonboard.com>
 <YIkMOrfvuW0J/ioi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIkMOrfvuW0J/ioi@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Apr 28, 2021 at 09:18:18AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 04:19:07PM +0300, Laurent Pinchart wrote:
> > On Wed, Apr 21, 2021 at 02:59:23PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit 611025983b7976df0183390a63a2166411d177f1.
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
> > > 
> > > Cc: Kangjie Lu <kjlu@umn.edu>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks for the review!
> 
> > I don't spot an obvious issue with the original patch though.
> 
> Ulf did :)

I've replied separately, I still think it's not an issue :-)

-- 
Regards,

Laurent Pinchart
