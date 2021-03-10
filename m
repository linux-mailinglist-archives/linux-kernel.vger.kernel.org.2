Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1088334871
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhCJUAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231953AbhCJUAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:00:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D34964FB3;
        Wed, 10 Mar 2021 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615406432;
        bh=pVgQV4hgVAutwj1GryhZ9nxWErZLYiahMjlWWHBGa4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/5yve2vuxSJ9sf+pnPtdB8dNt8V91hiJIZOyG8lICUzUa8ivNp0nsSPZPx7Swimq
         9nTVe34G11TZluYs8zWG2jK51uwTkjWT1lS3A7fPjOy6F01X2hxQngSFXe6na83eMh
         l9ax8htkr+0viTrdSkd2RTZeZr/w24U9ygHa8ubpKLJoEbtxMvgsUaW0bJV7pYyW6r
         nPz02aNgmdK3GYFfrFhA+5O6wvgnukYOr570eB1FvCArw2aFkIMQ/0IqSZ52zK50xY
         prW3NBiRWFRaVXhiO0lMI3yhC0hBqrlbhG61uzGh6SIV1+LNeRBE9B978+zrkcnDmu
         ARTRFU683c6Lw==
Date:   Wed, 10 Mar 2021 12:00:30 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH 1/1] nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a
 Samsung PM1725a
Message-ID: <20210310200030.GA3377333@dhcp-10-100-145-180.wdc.com>
References: <1615377076-3251-1-git-send-email-dmtrmonakhov@yandex-team.ru>
 <20210310132156.GA12145@lst.de>
 <20210310134110.GA13063@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310134110.GA13063@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 02:41:10PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 10, 2021 at 02:21:56PM +0100, Christoph Hellwig wrote:
> > Can you try this patch instead?
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2021-February/023183.html
> 
> Actually, please try the patch below instead, it looks like our existing
> logic messes up the units:

This seems like a good opportunity to incorporate TP4040 for non-MDTS
command limits. I sent a proposal here

  http://lists.infradead.org/pipermail/linux-nvme/2021-March/023522.html

And it defaults to your suggestion if the controller doesn't implement
the capability.
