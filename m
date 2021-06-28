Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6809A3B5F36
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhF1Nlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:41:35 -0400
Received: from verein.lst.de ([213.95.11.211]:36508 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231955AbhF1Nl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:41:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 258586736F; Mon, 28 Jun 2021 15:38:59 +0200 (CEST)
Date:   Mon, 28 Jun 2021 15:38:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rob Landley <rob@landley.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: dma_declare_coherent_memory and SuperH
Message-ID: <20210628133858.GA21602@lst.de>
References: <20210623133205.GA28589@lst.de> <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a55cf69-8fe1-dca0-68c7-f978567f9ca0@landley.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 05:36:08PM -0500, Rob Landley wrote:
> On 6/23/21 8:32 AM, Christoph Hellwig wrote:
> > Hi SuperH maintainers,
> > 
> > I have a vague recollection that you were planning on dropping support
> > for non-devicetree platforms, is that still the case?
> 
> We'd like to convert them, but have to rustle up test hardware for what _is_
> still available. (There was some motion towards this a year or so back, but it
> petered out because pandemic and everyone got distracted halfway through.)
> 
> (We should definitely START by converting the r2d board qemu emulates. :)
> 
> > The reason I'm asking is because all but one users of
> > dma_declare_coherent_memory are in the sh platform setup code, and
> > I'd really like to move towards killing this function off.
> 
> Understood. Is there an easy "convert to this" I could do to those callers?

Well, the replacement is to declare the device memory carveouts in the
Device Tree.
