Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D86F3E02DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbhHDONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbhHDONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:13:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF7C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 07:13:21 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mBHdx-0000E0-VE; Wed, 04 Aug 2021 16:13:13 +0200
Date:   Wed, 4 Aug 2021 16:13:13 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: r8188eu: remove RT_TRACE and DBG_88E prints
 from usb_intf.c
Message-ID: <20210804141313.enaysxjdmspfgy4i@viti.kaiser.cx>
References: <20210801173023.1370-1-martin@kaiser.cx>
 <20210804113234.GG1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804113234.GG1931@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> On Sun, Aug 01, 2021 at 07:30:22PM +0200, Martin Kaiser wrote:
> >  #endif

> > -	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
> > -	 * suspend influence */
> > -	if (usb_autopm_get_interface(pusb_intf) < 0)
> > -			DBG_88E("can't get autopm:\n");
> > -
> >  	/*  alloc dev name after read efuse. */
> >  	rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
> >  	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);

> This patch accidentally removes the usb_autopm_get_interface() call.

Thanks, I didn't notice this. Just sent out v2.
