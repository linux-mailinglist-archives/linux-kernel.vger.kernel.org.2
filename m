Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82E6343A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCVHKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:10:16 -0400
Received: from verein.lst.de ([213.95.11.211]:53776 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhCVHJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:09:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99FE167373; Mon, 22 Mar 2021 08:09:44 +0100 (CET)
Date:   Mon, 22 Mar 2021 08:09:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] pata_legacy: Add `probe_mask' parameter like with
 ide-generic
Message-ID: <20210322070944.GC3440@lst.de>
References: <alpine.DEB.2.21.2103202152120.21463@angie.orcam.me.uk> <alpine.DEB.2.21.2103211800110.21463@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2103211800110.21463@angie.orcam.me.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interface looks a little strange, but I guess deviating from the
old ide interface for something that has only such a use case in
retrocomputing probably doesn't make much sense.

Reviewed-by: Christoph Hellwig <hch@lst.de>
