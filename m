Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7C3F9050
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 23:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbhHZVu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 17:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243620AbhHZVu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:50:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32AF760F4A;
        Thu, 26 Aug 2021 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630014609;
        bh=hC7ZzrqCtbXGsVzPqLaOoa81+2MI7Xu6zHkd5OCUP/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8bgQG2VYWIjLv0SfzTNOe802IG8Gezo89RDmoqzG06mPTpEceRga82osrD2gHJMX
         R51NfJjRl95hoyX0zozzbws9S2D8WK/QUbZ0BbJuO2J6e7bhw5wRouyQn2GvecLgA4
         tkavCAPhKLXALgnnGAxuPXKE6vAW7kS8nd34jgLe89aKR5F/kq4wuGHLw6JPS2Lqam
         0BXO5/G30cyU2MPp0o2DU38/C3Dc1kdV0JCqwG1CfqPDKPa5USZH4xpvJYmpM7pSCY
         WoST8Utu/YGjiNNXkCwDczUUcYwuUdqk5Y8VELPPbV1wQvgOeOoSC55XzpZ/rmecx2
         6heM9gGC4xhxA==
Date:   Thu, 26 Aug 2021 15:50:07 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Make nvmet_init_cap dependent on passthru controller
Message-ID: <20210826215007.GA58085@C02WT3WMHTD6>
References: <CGME20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852@uscas1p1.samsung.com>
 <20210826211522.308649-1-a.manzanares@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826211522.308649-1-a.manzanares@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 09:15:45PM +0000, Adam Manzanares wrote:
> nvme_init_cap unconditionally sets support for one or more command sets. When
> using a passthru controller this may cause a conventional namespace to be
> ignored when checking the namespace identification descriptors which must
> include the command set identifier when the cap is set to support one or more
> command sets. Since the namespace identification descriptors come from the
> passthru controller they may not include the command set identifier causing the
> namespace to be ignored.
> 
> Adam Manzanares (2):
>   nvme: move nvme_multi_css into nvme.h
>   nvmet: use passthru cntrl in nvmet_init_cap

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
