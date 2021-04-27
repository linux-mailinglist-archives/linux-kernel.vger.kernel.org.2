Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454CC36C5A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbhD0L5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhD0L5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:57:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 401A661002;
        Tue, 27 Apr 2021 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524597;
        bh=ffW6olAWRHisx/BGpvkTqqYtX6ybOLlMlG9m07ERQkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6lPQxXQovHAeg4TDO9+239uNjY5O15ntkadBPXpt3Ve52e2DE0EwHu4FzYzUDAgQ
         NAMvwvRMMVypR47VUcGUcrcU/RtzwlTLiuDyJH/sxZFxcG16if5VsXrOp0Om1/x4Ae
         ZwF+vbCSoTUkIJgs6SliLk7RRhC9mpzsLPM8eaaY=
Date:   Tue, 27 Apr 2021 13:56:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 190/190] Revert "ethtool: fix a potential missing-check
 bug"
Message-ID: <YIf78yOIngfXOxjA@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-191-gregkh@linuxfoundation.org>
 <bb8f7b4-ac22-b062-4c59-928513cad0f4@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8f7b4-ac22-b062-4c59-928513cad0f4@namei.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 06:06:59AM +1000, James Morris wrote:
> On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:
> 
> > This reverts commit d656fe49e33df48ee6bc19e871f5862f49895c9e.
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
> > Cc: Wenwen Wang <wang6495@umn.edu>
> > Cc: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> The original patch looks valid and fixes a race. 

Thanks for reviewing, now dropped.

greg k-h
