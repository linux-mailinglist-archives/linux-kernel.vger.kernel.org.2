Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8196336C7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbhD0OqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236368AbhD0OqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:46:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F609613DD;
        Tue, 27 Apr 2021 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619534721;
        bh=lZM4EtBHLmrz5KIcQm+hfhduJ8ZI0sLaAJW1zVaxXMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBFH8O9vWYgoGZCDohMRZ5RiDgAGeqXQl/aFbA8aYi88pL1sQuCaC97k6fGeJ7ALx
         yV8p87GPdVI1ZJi2i7jbm1dHEalQ0vG5ZwuyGycEhfl11hoQg+bJ7HbpWPxEsA4rdG
         P6f34Cq/JCyImWG28aCelPkud05uFlapMqZZZ0LQ=
Date:   Tue, 27 Apr 2021 16:45:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 122/190] Revert "HID: logitech: check the return value of
 create_singlethread_workqueue"
Message-ID: <YIgjf4cqyJi/Ookj@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-123-gregkh@linuxfoundation.org>
 <nycvar.YFH.7.76.2104211719330.18270@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2104211719330.18270@cbobk.fhfr.pm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 05:20:45PM +0200, Jiri Kosina wrote:
> On Wed, 21 Apr 2021, Greg Kroah-Hartman wrote:
> 
> > This reverts commit 6c44b15e1c9076d925d5236ddadf1318b0a25ce2.
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
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This particular one doesn't have to be reverted, I have reviewed it again 
> and it does fix an actual bug.

Thanks, I will drop the revert from my tree.

greg k-h
