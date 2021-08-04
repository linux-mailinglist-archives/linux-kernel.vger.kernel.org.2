Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770963E02F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhHDOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhHDOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:21:28 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34676C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 07:21:16 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mBHlf-0000JZ-53; Wed, 04 Aug 2021 16:21:11 +0200
Date:   Wed, 4 Aug 2021 16:21:11 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove RT_TRACE and DBG_88E prints
 from ioctl_linux.c
Message-ID: <20210804142111.pukmtsxaqdixll3r@viti.kaiser.cx>
References: <20210802073917.8647-1-martin@kaiser.cx>
 <20210804131214.GK1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804131214.GK1931@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> On Mon, Aug 02, 2021 at 09:39:17AM +0200, Martin Kaiser wrote:
> > @@ -4203,7 +3940,6 @@ static int rtw_dbg_port(struct net_device *dev,
> >  			u16 start_value = 0;
> >  			u32 write_num = extra_arg;
> >  			int i;
> > -			u8 final;
> >  			struct xmit_frame	*xmit_frame;

> >  			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
> > @@ -4216,12 +3952,6 @@ static int rtw_dbg_port(struct net_device *dev,
> >  				rtw_IOL_append_WB_cmd(xmit_frame, reg, i+start_value, 0xFF);
> >  			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
> >  				ret = -EPERM;
> > -
> > -			final = rtw_read8(padapter, reg);
> > -			if (start_value+write_num-1 == final)
> > -				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
> > -			else
> > -				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
> >  		}

> I don't have a problem with the patch but these tests don't make any
> sense now that we don't print a Success/Fail at the end.  (We should
> probably delete the whole function and all the related code)

I removed the IOL tests (case 0x78) in v2, similar to the rtl8723bs
driver.

Thanks,
Martin
