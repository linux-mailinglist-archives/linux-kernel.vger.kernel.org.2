Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1AC39B944
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFDM64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 08:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhFDM6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:58:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CABF361090;
        Fri,  4 Jun 2021 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622811414;
        bh=bXk9UiSEUzB+QZBXcKoOU1eQSq9uMgs4UN0fcnYBfPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVsgwuhwYuGSCN79OYnTdx6+D6U31F92849hdd5F+CYPeGVch/w616wnTxxXkeVfA
         lpwS9bmf7wQuGkUxJYpja0wLF8l4FZI+wedYvB9G6O9nkg1PoF1FLgy/l0K0cZovRA
         dMMxlSAm4nvw8IzqROib5XLpH/Z3fG7bPkd9gvts=
Date:   Fri, 4 Jun 2021 14:56:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Initialize debugfs/ksysfs earlier?
Message-ID: <YLojEy3wjq2R8Zsa@kroah.com>
References: <20210603125534.638672-1-adrian.ratiu@collabora.com>
 <YLjVYaVfNGEkqPAQ@kroah.com>
 <87y2bqwwfz.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2bqwwfz.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 11:00:00PM +0300, Adrian Ratiu wrote:
> Hi and thank you for the quick response!
> 
> On Thu, 03 Jun 2021, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > On Thu, Jun 03, 2021 at 03:55:33PM +0300, Adrian Ratiu wrote:
> > > Hi Greg & all,  I would like to add a new debugfs file like in the
> > > next patch but I'm having a problem with commit 56348560d495
> > > ("debugfs: do not attempt to create a new file before the filesystem
> > > is initalized").
> > 
> > You should have had a problem before that commit happened as well,
> > right?
> > 
> 
> Actually no, it works without problems before commit 56348560d495 and also
> works if I revert that commit or move the debugfs_init() and its dependency
> ksysfs_init() before the driver core init.

And the file shows up properly?  How can that be?  Is it ok to create a
file before the superblock is created in the system?  For some reason I
thought these were just silently failing and no one noticed.  Maybe we
should revisit that commit...

thanks,

greg k-h
