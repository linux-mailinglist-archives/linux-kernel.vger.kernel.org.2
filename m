Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E140436B764
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbhDZRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234754AbhDZRDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:03:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AF8761026;
        Mon, 26 Apr 2021 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456542;
        bh=Qd7F+DP+NZyOutFxxX0aFpQpnzzEMhVoGMl+UGveDpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kswk1YUpxcDw08ZCCh9b40ql5XuSTgRjkB6JPi4FgJwSSO+0QfNtp0cGobe2UkTm/
         +wH55pnHuofzuPIw7UCGfeMOqQQp5lVT6zfSUbl/5U8rEOcIpYbb7CirmFu9VNQB6F
         zOHShp8hxvRwKmRogdKjwbUTUFDQdrpL1CZNodQw=
Date:   Mon, 26 Apr 2021 19:02:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 094/190] Revert "iio: adc: fix a potential NULL pointer
 dereference"
Message-ID: <YIbyG1v4h5Y54P7J@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-95-gregkh@linuxfoundation.org>
 <20210422093209.00006cc5@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422093209.00006cc5@Huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:32:09AM +0100, Jonathan Cameron wrote:
> On Wed, 21 Apr 2021 14:59:29 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > This reverts commit 13814627c9658cf8382dd052bc251ee415670a55.
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
> Checked.  Original patch was valid.  Don't mind how we handle it though.
> Can bring back later if it's dropped for now.

Now dropped, thanks.

greg k-h
