Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F744303C6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 18:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbhJPQfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 12:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhJPQfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 12:35:13 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95220C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:33:05 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mbmcG-00068K-JN; Sat, 16 Oct 2021 18:33:00 +0200
Date:   Sat, 16 Oct 2021 18:33:00 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/8] staging: r8188eu: another round of removals
Message-ID: <20211016163300.xlu2zsroe3frocpc@viti.kaiser.cx>
References: <20211016113008.27549-1-martin@kaiser.cx>
 <YWrxIllg1fMkV1/5@equinox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWrxIllg1fMkV1/5@equinox>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Phillip Potter (phil@philpotter.co.uk):

> On Sat, Oct 16, 2021 at 01:30:00PM +0200, Martin Kaiser wrote:
> > Remove some more dead code and unused definitions.

> > Martin Kaiser (8):
> >   staging: r8188eu: remove empty trigger gpio code
> >   staging: r8188eu: interface type is always usb
> >   staging: r8188eu: remove two checks that are always false
> >   staging: r8188eu: remove unused function prototypes
> >   staging: r8188eu: PHY_SetRFPathSwitch_8188E is not used
> >   staging: r8188eu: clean up Hal8188EPhyCfg.h
> >   staging: r8188eu: remove procfs functions
> >   staging: r8188eu: CurrentWirelessMode is not used

> >  drivers/staging/r8188eu/Makefile              |   1 -
> >  drivers/staging/r8188eu/core/rtw_debug.c      | 886 ------------------
> >  .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  14 +-
> >  .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |   3 +-
> >  .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   8 +-
> >  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  38 -
> >  drivers/staging/r8188eu/hal/odm.c             |   3 -
> >  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   2 -
> >  drivers/staging/r8188eu/hal/usb_halinit.c     |   8 -
> >  .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  78 --
> >  drivers/staging/r8188eu/include/hal_intf.h    |   1 -
> >  drivers/staging/r8188eu/include/odm.h         |  11 +-
> >  .../staging/r8188eu/include/rtl8188e_hal.h    |   1 -
> >  drivers/staging/r8188eu/include/rtw_debug.h   | 148 ---
> >  14 files changed, 6 insertions(+), 1196 deletions(-)
> >  delete mode 100644 drivers/staging/r8188eu/core/rtw_debug.c

> > -- 
> > 2.20.1


Hi Phil,

> Looks good from what I can see, many thanks. Built and tested on my
> USB-N10 Nano.

> For whole series:
> Acked-by: Phillip Potter <phil@philpotter.co.uk>

thanks for reviewing and testing.

Best regards,
Martin
