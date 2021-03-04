Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A38232CE31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhCDIOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:14:23 -0500
Received: from verein.lst.de ([213.95.11.211]:40865 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234006AbhCDIOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:14:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B527D68B05; Thu,  4 Mar 2021 09:13:29 +0100 (CET)
Date:   Thu, 4 Mar 2021 09:13:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Art Nikpal <email2tema@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: using deprecated initrd support, will be removed in 2021
Message-ID: <20210304081329.GA12996@lst.de>
References: <CAKaHn9KMef4ahpEFEYiS+V2CnJSDK_w+MWLfPkgUb_+vJEGH4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKaHn9KMef4ahpEFEYiS+V2CnJSDK_w+MWLfPkgUb_+vJEGH4Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:18:05PM +0800, Art Nikpal wrote:
> hello Christoph
> i have see your patch https://lkml.org/lkml/2020/7/14/1508
> /* using deprecated initrd support, will be removed in 2021*/
> 
> How can I clarify the situation ?!
> 
> im using squashfs as ramdisk / all system works  as all in ram kernel +
> initrd (squashfs)
> and i think it's very useful  - how can we replace it ?

With a simple initramfs, you should be able to chose the same compression
algorithms as you do for squashfs right now and generate a better image.

> and another question:  why need to remove it - if it works fine ?

It causes a fair amount of maintainance burden in the kernel, and also
is less efficient for the user.
