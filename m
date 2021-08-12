Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456033EA52D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhHLNJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:09:44 -0400
Received: from verein.lst.de ([213.95.11.211]:44273 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237402AbhHLNJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:09:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A09F268AFE; Thu, 12 Aug 2021 15:09:14 +0200 (CEST)
Date:   Thu, 12 Aug 2021 15:09:14 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     Brian Cain <bcain@codeaurora.org>
Cc:     'Christoph Hellwig' <hch@lst.de>, iommu@lists.linux-foundation.org,
        'Russell King' <linux@armlinux.org.uk>,
        'Dillon Min' <dillon.minfei@gmail.com>,
        'Vladimir Murzin' <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "'Manning, Sid'" <sidneym@quicinc.com>
Subject: Re: add support for the global coherent pool to the dma core
Message-ID: <20210812130914.GA22352@lst.de>
References: <20210712061704.4162464-1-hch@lst.de> <03d501d783c4$1d3f10e0$57bd32a0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03d501d783c4$1d3f10e0$57bd32a0$@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:20:34AM -0500, Brian Cain wrote:
> > this series adds support for using the global coherent (aka uncached)
> > pool to the generic dma-direct code and then switches arm-nommu and
> > hexagon over to it, together with a bunch of cleanups.
> 
> Christoph,
> 
> Thanks for sending this -- I will take a look and give some feedback soon.

Any chance you'll get to this in the next days?  I'd love to merge this
series for the current merge window with a little time in linux-next.
