Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C228B3B1D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhFWPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:13:14 -0400
Received: from verein.lst.de ([213.95.11.211]:51187 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWPNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:13:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 137E168AFE; Wed, 23 Jun 2021 17:10:53 +0200 (CEST)
Date:   Wed, 23 Jun 2021 17:10:53 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     Brian Cain <bcain@codeaurora.org>
Cc:     'Christoph Hellwig' <hch@lst.de>, 'Arnd Bergmann' <arnd@arndb.de>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Sid Manning' <sidneym@codeaurora.org>,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: how can we test the hexagon port in mainline
Message-ID: <20210623151053.GB3256@lst.de>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 09:39:21AM -0500, Brian Cain wrote:
> > -----Original Message-----
> > From: Christoph Hellwig <hch@lst.de>
> ...
> > 
> > Hi all,
> > 
> > the oldest supported gcc version in mainline is gcc 4.9.  But the only
> > hexagon crosscompiler I can find is the one Arnds website points to here:
> > 
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/
> > 
> > which is a non-upstream gcc 4.6.1 port.  How are we supposed to even
> > build test hexagon code?
> 
> We have provided a clang-12-based toolchain here:
> 
> https://codelinaro.jfrog.io/artifactory/codelinaro-qemu/2021-05-12/clang+llv
> m-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz

Do you have something that is just a small compiler like Arnd's gcc
build?  That tarball is already 264MB with xz compression, which does
not compare very favorablt to the 7MB for gcc.  And I fear I don't
really have space for that on my setups..
