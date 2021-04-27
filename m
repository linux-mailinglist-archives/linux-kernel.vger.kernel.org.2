Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4136C9CA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhD0Qz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhD0Qz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:55:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA6B4613D8;
        Tue, 27 Apr 2021 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619542513;
        bh=QJ4ApnE3siA4jyyCaddy75BBmZQKOCso9kt104d+AGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlZlixP9QbPCnMHYaZfDNNAETdPi26BxWDObzhyiMgWuZP03K45JbJpgl0CTIOTSa
         DHFBsxxZs9vxVgCW34ri5nhStZr7uXhbT1sTxYQvFj2BY5eqsU7u9Ggz7EdCzbmpop
         1zWRf4vi2S+1u4k2DXm3OVsPMp/iI/f7Tw9J7z2Y=
Date:   Tue, 27 Apr 2021 18:55:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH 157/190] Revert "Input: ad7879 - add check for read
 errors in interrupt"
Message-ID: <YIhB7rvHlFDew00z@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-158-gregkh@linuxfoundation.org>
 <YIBa5X+5g/qNL+N8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIBa5X+5g/qNL+N8@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:03:33AM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> On Wed, Apr 21, 2021 at 03:00:32PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit e85bb0beb6498c0dffe18a2f1f16d575bc175c32.
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
> 
> This one looks really OK to me and does not have to be reverted (unless
> Aditya will come clean and show the error introduced?).

I'll drop this revert, but it isn't usually good to be calling printk()
from an irq.

thanks,

greg k-h
