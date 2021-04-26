Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2537A36B73F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhDZQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234526AbhDZQw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:52:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D485661077;
        Mon, 26 Apr 2021 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619455936;
        bh=HpvpjxzOWH+nQzrbsjDVpvNZx1uW7E+8SGjcW6aP3Ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxAgDAn37w8rEW2X8ErZAULfNxlS+WxyQB6vFlnIiGzKo70wb9ggRzWJYKHB94FKb
         qv5vCd98alOftGke+DA9H81Bj5/4aujbRa8fkv5LCYquoIGf7sAynBoHjzL1hSaqoO
         BcA7mZX4GRt7AOdSpTUAoVyVcv2yKGB21XZFsn3o=
Date:   Mon, 26 Apr 2021 18:52:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Mathew King <mathewk@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Subject: Re: [PATCH 025/190] Revert "platform/chrome: cros_ec_ishtp: Fix a
 double-unlock issue"
Message-ID: <YIbvvR9aULPCFWzo@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-26-gregkh@linuxfoundation.org>
 <8825f20c-7e58-c44e-fa7a-bca811add5a1@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8825f20c-7e58-c44e-fa7a-bca811add5a1@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 12:48:01PM +0200, Enric Balletbo i Serra wrote:
> Hi Greg,
> 
> Many thanks for the patchset and notice us to take attention about these patches.
> 
> On 21/4/21 14:58, Greg Kroah-Hartman wrote:
> > This reverts commit aaa3cbbac326c95308e315f1ab964a3369c4d07d.
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
> > Cc: Mathew King <mathewk@chromium.org>
> > Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I've reviewed the patch again (also double checked with people involved in this
> driver) and I don't spot an obvious issue with the original patch. Without it,
> on error path, the read-write sempahore used, will be released without having
> held it before.
> 
> So it's IMO a valid fix that would have to be done the same way after
> revert.
> 
> Please don't revert it.

Dropped from my patch series, thanks for the review.

greg k-h
