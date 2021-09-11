Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF9407A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 22:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhIKUPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbhIKUPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 16:15:04 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE0C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 13:13:50 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mP9Ne-000250-8j; Sat, 11 Sep 2021 22:13:42 +0200
Date:   Sat, 11 Sep 2021 22:13:42 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] staging: r8188eu: remove rtw_set_rpwm
Message-ID: <20210911201342.jiratddjuniccisc@viti.kaiser.cx>
References: <20210911141521.24901-1-martin@kaiser.cx>
 <20210911141521.24901-6-martin@kaiser.cx>
 <760ac39a-5562-cac5-0b7b-e42f6628743c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <760ac39a-5562-cac5-0b7b-e42f6628743c@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> On 9/11/21 16:15, Martin Kaiser wrote:
> > After we dropped the call to set HW_VAR_SET_RPWM, the rtw_set_rpwm
> > function doesn't do anything useful.

> > Remove the function and the rpwm component of struct pwrctrl_priv,
> > which is not used outside of rtw_set_rpwm.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >   .../realtek/rtl8192cu/include/rtw_pwrctrl.h   |  1 -
> >   drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 34 -------------------
> >   drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 --
> >   3 files changed, 37 deletions(-)

> > diff --git a/drivers/net/wireless/realtek/rtl8192cu/include/rtw_pwrctrl.h b/drivers/net/wireless/realtek/rtl8192cu/include/rtw_pwrctrl.h
> > index a4cb292e1aea..303df55c521a 100644
> > --- a/drivers/net/wireless/realtek/rtl8192cu/include/rtw_pwrctrl.h
> > +++ b/drivers/net/wireless/realtek/rtl8192cu/include/rtw_pwrctrl.h
> > @@ -309,7 +309,6 @@ extern void cpwm_int_hdl(PADAPTER padapter, struct reportpwrstate_parm *preportp
> >   #endif


> The patch does not apply to staging-testing.

> Looks to me that the change in

> .../realtek/rtl8192cu/include/rtw_pwrctrl.h

> made it into this patch by accident?

thanks for spotting this, Michael. I'll send a v2 on Monday.

Best regards,
Martin
