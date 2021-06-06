Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52CC39D191
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 23:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFFVR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 17:17:59 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:55282 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhFFVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 17:17:57 -0400
Received: from [192.168.0.2] (unknown [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id E3DBC7A021C;
        Sun,  6 Jun 2021 23:16:05 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Ben Skeggs <bskeggs@redhat.com>
Subject: Re: nouveau broken on Riva TNT2 in 5.13.0-rc4: NULL pointer dereference in nouveau_bo_sync_for_device
Date:   Sun, 6 Jun 2021 23:16:03 +0200
User-Agent: KMail/1.9.10
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <202106052143.52488.linux@zary.sk> <202106052334.23943.linux@zary.sk>
In-Reply-To: <202106052334.23943.linux@zary.sk>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202106062316.03369.linux@zary.sk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 June 2021 23:34:23 Ondrej Zary wrote:
> On Saturday 05 June 2021 21:43:52 Ondrej Zary wrote:
> > Hello,
> > I'm testing 5.13.0-rc4 and nouveau crashes with NULL pointer dereference in nouveau_bo_sync_for_device.
> > Found various reports like this but that was back in februaryso that should be fixed now.
> 
> So it is the same bug. Broken since 5.11. This revert fixes it in 5.11:
> https://lists.freedesktop.org/archives/dri-devel/2021-February/298531.html
> 
> Added some debug printks to nouveau_bo_sync_for_device:
> [   22.225048] ttm_dma=fc33b500
> [   22.225066] ttm_dma->num_pages=18
> [   22.225071] i=0 num_pages=16
> [   22.225077] ttm_dma->dma_address=00000000
> [   22.225094] BUG: kernel NULL pointer dereference, address: 00000000
> 
> So ttm->dma_address is NULL.
> 

Tested reverting f295c8cfec833c2707ff1512da10d65386dde7af again and it does not work...
Not sure what I did before.

Bisecting between 5.10 and 5.11 is impossible - I keep hitting neverending stream of bugs.
As always with nouveau...

-- 
Ondrej Zary
