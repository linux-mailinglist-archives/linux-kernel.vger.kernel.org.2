Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076974374A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhJVJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhJVJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:23:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E0C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:21:16 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mdqje-0001HT-GL; Fri, 22 Oct 2021 11:21:10 +0200
Date:   Fri, 22 Oct 2021 11:21:10 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] staging: r8188eu: use helper to check for broadcast
 address
Message-ID: <20211022092110.d2mcmf2qe2jtkld4@viti.kaiser.cx>
References: <20211020195401.12931-1-martin@kaiser.cx>
 <20211020195401.12931-3-martin@kaiser.cx>
 <YXCFFO//n9N6MZXv@equinox>
 <f5657f12-e20e-5cd9-e872-32e294741e88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5657f12-e20e-5cd9-e872-32e294741e88@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> > > +		    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))

> Hi Martin,

> I'm not an expert regarding alignment. Is GetAddr1Ptr(pframe) always
> __aligned(2) as required by is_broadcast_ether_addr?

Hi Michael,

thanks for spotting this. To be honest, I didn't look at this in much
detail when I wrote the patch.

I suppose the pframe comes from recvbuf2recvframe().
precvframe = rtw_alloc_recvframe(pfree_recv_queue);
with
struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue; 

This should be initialised in _rtw_init_recv_priv().
rtw_init_queue(&precvpriv->free_recv_queue);
...
precvpriv->precv_frame_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(precvpriv->pallocated_frame_buf), RXFRAME_ALIGN_SZ);
precvframe = (struct recv_frame *)precvpriv->precv_frame_buf;
and the frames are added to the free_recv_queue.
RXFRAME_ALIGN_SZ is 1<<8.

So pframe should be 256-byte aligned.
GetAddr1Ptr adds 4 to the start of pframe.

I guess we're safe here.

> > > @@ -841,7 +840,7 @@ void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
> > >   		psta = pDM_Odm->pODM_StaInfo[i];
> > >   		if (IS_STA_VALID(psta) &&
> > >   		    (psta->state & WIFI_ASOC_STATE) &&
> > > -		    memcmp(psta->hwaddr, bcast_addr, ETH_ALEN) &&
> > > +		    !is_broadcast_ether_addr(psta->hwaddr) &&

> Perhaps we should add __aligned(2) to the hwaddr variable in struct
> sta_info to be safe?

> u8	hwaddr[ETH_ALEN] __aligned(2);

Hmm, some of those arrays in other parts of the kernel have
__aligned(2), others don't...

Can anyone else give some guidance?

Thanks,
Martin
