Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB287323812
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhBXHsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:48:37 -0500
Received: from verein.lst.de ([213.95.11.211]:36493 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233626AbhBXHsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:48:25 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5CF5768D0A; Wed, 24 Feb 2021 08:47:42 +0100 (CET)
Date:   Wed, 24 Feb 2021 08:47:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>
Cc:     Christoph Hellwig <hch@lst.de>, green.hu@gmail.com,
        deanbo422@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] nds32: use get_kernel_nofault in dump_mem
Message-ID: <20210224074742.GA509@lst.de>
References: <20200720114448.205876-1-hch@lst.de> <20200720114448.205876-2-hch@lst.de> <20200721110717.GA19721@atcfdc88> <20200721112800.GA27356@lst.de> <20210128101633.GA6249@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128101633.GA6249@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:16:33AM +0100, Christoph Hellwig wrote:
> On Tue, Jul 21, 2020 at 01:28:00PM +0200, Christoph Hellwig wrote:
> > Can you pich the patches up in the nds32 tree for Linus?  There are
> > not short-term dependencies on them.
> 
> It seems like these patches are still sitting in linux-next and never
> made it to Linus/

ping?
