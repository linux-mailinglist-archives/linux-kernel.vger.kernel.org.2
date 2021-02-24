Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2551F32392B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhBXJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:05:37 -0500
Received: from verein.lst.de ([213.95.11.211]:36710 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234359AbhBXJDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:03:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 81EFD68D0A; Wed, 24 Feb 2021 10:02:59 +0100 (CET)
Date:   Wed, 24 Feb 2021 10:02:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nds32: use get_kernel_nofault in dump_mem
Message-ID: <20210224090259.GA4630@lst.de>
References: <20200720114448.205876-1-hch@lst.de> <20200720114448.205876-2-hch@lst.de> <20200721110717.GA19721@atcfdc88> <20200721112800.GA27356@lst.de> <20210128101633.GA6249@lst.de> <20210224074742.GA509@lst.de> <CAEbi=3cQ+5ir3X6R3=cn3q1w4JqsRYVw5REqnQVLY5icyT8=xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEbi=3cQ+5ir3X6R3=cn3q1w4JqsRYVw5REqnQVLY5icyT8=xQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 04:59:37PM +0800, Greentime Hu wrote:
> Christoph Hellwig <hch@lst.de> 於 2021年2月24日 週三 下午3:47寫道：
> >
> > On Thu, Jan 28, 2021 at 11:16:33AM +0100, Christoph Hellwig wrote:
> > > On Tue, Jul 21, 2020 at 01:28:00PM +0200, Christoph Hellwig wrote:
> > > > Can you pich the patches up in the nds32 tree for Linus?  There are
> > > > not short-term dependencies on them.
> > >
> > > It seems like these patches are still sitting in linux-next and never
> > > made it to Linus/
> >
> > ping?
> 
> Sorry for late.
> Acked-by: Greentime Hu <green.hu@gmail.com>

Well, I'm mostly interested in eventually getting it sent to Linus
given that it has been in linux-next for months.
