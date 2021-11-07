Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D9C44735B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhKGOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhKGOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:46:11 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8FCC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 06:43:28 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mjjOG-0001YN-Rp; Sun, 07 Nov 2021 15:43:24 +0100
Date:   Sun, 7 Nov 2021 15:43:24 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin.kaiser@paytec.ch>
Subject: Re: [PATCH 0/4] staging: r8188eu: clean up the calibration code
Message-ID: <20211107144324.xqoab3imqxawymfz@viti.kaiser.cx>
References: <20211107143100.9047-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107143100.9047-1-martin@kaiser.cx>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Thus wrote Martin Kaiser (martin@kaiser.cx):

> From: Martin Kaiser <martin.kaiser@paytec.ch>

Sorry, the cover letter uses the wrong address.
The actual patches are ok.

Could you take the patches anyway or should I resend the series?

Thanks,
Martin

> Remove a bit of unused code related to calibration.

> Martin Kaiser (4):
>   staging: r8188eu: remove unused phy_PathA_IQK_8188E parameter
>   staging: r8188eu: remove unused phy_PathA_RxIQK parameter
>   staging: r8188eu: remove constant phy_IQCalibrate_8188E parameter
>   staging: r8188eu: clean up _PHY_PathADDAOn

>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 114 ++----------------
>  .../staging/r8188eu/include/HalPhyRf_8188e.h  |   5 -
>  2 files changed, 12 insertions(+), 107 deletions(-)

> -- 
> 2.20.1


