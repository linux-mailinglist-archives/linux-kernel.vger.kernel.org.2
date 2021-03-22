Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6114343A43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhCVHJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:09:13 -0400
Received: from verein.lst.de ([213.95.11.211]:53759 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCVHIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:08:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 28D4567373; Mon, 22 Mar 2021 08:08:39 +0100 (CET)
Date:   Mon, 22 Mar 2021 08:08:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] pata_platform: Document `pio_mask' module parameter
Message-ID: <20210322070838.GB3440@lst.de>
References: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk> <alpine.DEB.2.21.2103212023190.21463@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2103212023190.21463@angie.orcam.me.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 08:55:27PM +0100, Maciej W. Rozycki wrote:
> Add MODULE_PARM_DESC documentation and a kernel-parameters.txt entry.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
