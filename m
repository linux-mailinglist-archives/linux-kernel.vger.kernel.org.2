Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4547F30D6BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhBCJwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:52:40 -0500
Received: from verein.lst.de ([213.95.11.211]:50338 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233644AbhBCJwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:52:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 671BF6736F; Wed,  3 Feb 2021 10:51:48 +0100 (CET)
Date:   Wed, 3 Feb 2021 10:51:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     serebrin@amazon.com, dwmw@amazon.co.uk, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Add 48-bit DMA address quirk
Message-ID: <20210203095148.GA8897@lst.de>
References: <20210203094338.19473-1-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203094338.19473-1-sironi@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 10:43:38AM +0100, Filippo Sironi wrote:
> Certain NVMe controllers don't support 64-bit DMA addresses.  Instead,
> they are limited to 48-bit DMA addresses.  Let's add a quirk to use them
> properly.

WTF?  This is such a grave NVMe spec compiance bug that I do not think
we should support this buggy mess in Linux.
