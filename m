Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883E831CC39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhBPOlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhBPOkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:40:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8041E64DFF;
        Tue, 16 Feb 2021 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613486367;
        bh=UNowcMW0SCs9nkZpIMU1XGVDBOUfCP5cIFjY9xFBtkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnvg5U1s9dgRqFeGSd8Z+1uzt5GISNX+ggmHL43B7wAFuRrdMgDDNUUH06BSwQl+D
         NvLeq7gtGG4ooNe7FPohcL4QQJwNV3EaQJN5/Opi/kgI2IdiJKw9w/73+Q5dsS+Xdu
         6ns259AlSo7mcyDIEyt8a2u4hEZVRfV3/mLd5SYOlMg3HzUnlVgH47S6djl2G33ygX
         I1h48S1YK+EgTXBS+veJ6JvCqXsN7r/3r2758MEjO3hd/WlcdrBWElGBl3oFGtU6p0
         RtLxKPS9Bh6SgLauEWeOBgrshGmx2tWNqYnHu/MHe8QdTbQLo3e6Km8t44H6G0GA0X
         R7BVQIxBZcPkA==
Date:   Tue, 16 Feb 2021 15:39:22 +0100
From:   Robert Richter <rric@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, oprofile-list@lists.sf.net
Subject: Re: [PATCH 02/29] alpha: Avoid comma separated statements
Message-ID: <YCvZGuKvtPi6ktNV@rric.localdomain>
References: <cover.1598331148.git.joe@perches.com>
 <4facd57f80c70437f085ba3a1bcf13ae0b63c3bc.1598331148.git.joe@perches.com>
 <52f038d9ff547deee4e5b5628507e61ec8d056b7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52f038d9ff547deee4e5b5628507e61ec8d056b7.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.21 10:54:42, Joe Perches wrote:
> On Mon, 2020-08-24 at 21:55 -0700, Joe Perches wrote:
> > Use semicolons and braces.
> 
> ping?
> 
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  arch/alpha/kernel/pci_iommu.c      |  8 +++++---
> >  arch/alpha/oprofile/op_model_ev4.c | 22 ++++++++++++++--------
> >  arch/alpha/oprofile/op_model_ev5.c |  8 +++++---

This patch should be rebased as oprofile is going to be removed in
5.12. A branch is in linux-next.

-Robert

> >  3 files changed, 24 insertions(+), 14 deletions(-)
