Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284EF35805E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhDHKNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhDHKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:13:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A4C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 03:13:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f6so1485631wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ySqfjwEYIH9v0T/5ZEFK3YGLiqMJEr02neElvQ2cvsA=;
        b=PkDRORcsDtVfj7ynfbmk4D6QY+xyClAY1udDmGwg6Nm+SsfNbIDaLnfUNPAtPo/pf/
         1B2YHs2+QHHIVM0LeIDFkODzx7Wx/xXbqjUZAg9II283INay5JGlosS+qqJhPh5OvDB3
         902ZWrO4hr/bmNcs1lFIvidLYVI0ZuYxdNJk1ZwDQ9v4YfIQHgZ+P1gCkP3H8BuzVjgT
         xO3QG1jhRYzRe2uvVpbNJlhtcfqf6Q4VO/cEEkuR/ajTm+6dXs9g4fnL9IONA3UUrwzb
         F5bW+pUqGLvs0eTaHwMkoZGtcmzS4DHqrpXOFeT86KpO0KJ9jiEjg1FTPk90w5Z99+0O
         lagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ySqfjwEYIH9v0T/5ZEFK3YGLiqMJEr02neElvQ2cvsA=;
        b=l119XPtMItK9HqJ0lSt2QX2leYUUueDAprcX6nwEfKK48mPBhGc/9xS0HQBjQjImHw
         WKBptpYpC/8sQM7SCzQ/cPftjNX1v1UjCP/V6lMdp58e9AHki3C7XMCe8pK9cIXx4DUY
         WtBuCYHYFt1guQVmZEXMgFeaZKlyEjf26aq6pHEumCK98+/51rvz6AW/X7BrjgPQfAEO
         UepGqJXfYSSVIOYICNOYvlHaCsTuYovT6U5d+S/duC3L03NAaaOMPB2ztDs12/Q5sbAc
         fquh0YfsUChLIvgLM+KOP7WY4WW0OLxNDYrkpNOarTa4D15RoUyMV7b+nCrte9rVQc7B
         uxIQ==
X-Gm-Message-State: AOAM532jK7SrTKGZT+kGdTpjjHl4l96T+R3osPCNEhIb+8ZsK0tAEJgk
        DihbV/5pjNmufrr0s7ROvZU=
X-Google-Smtp-Source: ABdhPJx6+er9m7fHOJOvKhS1mLBuebdoyISgNk02O3mgsdy8PyLQuv/PLuugk9/ZzNIMhP+0gPNiTQ==
X-Received: by 2002:a05:6000:18ab:: with SMTP id b11mr10102517wri.403.1617876810901;
        Thu, 08 Apr 2021 03:13:30 -0700 (PDT)
Received: from agape.jhs ([5.171.81.167])
        by smtp.gmail.com with ESMTPSA id t6sm12057923wro.36.2021.04.08.03.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 03:13:30 -0700 (PDT)
Date:   Thu, 8 Apr 2021 12:13:27 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lkp@intel.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove unused variables
Message-ID: <20210408101326.GA1648@agape.jhs>
References: <20210408092702.25863-1-fabioaiuto83@gmail.com>
 <YG7Q525hyhqzbXp/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG7Q525hyhqzbXp/@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 11:46:15AM +0200, Greg KH wrote:
> On Thu, Apr 08, 2021 at 11:27:02AM +0200, Fabio Aiuto wrote:
> > remove declared and assigned unused variables
> 
> You need to be a lot more specific here.

Shall I describe that some of these became unused
after DBG_871X removal?

> 
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> For all of these?

yes, actually, not just the ">>" marked ones, but also
all others reported in automatic email.

Shall I limit to the marked ones?

Should I put in In-Reply-To the test robot email?

Or just the output of the test robot in the changelog?

> 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_cmd.c      |  3 ---
> >  .../staging/rtl8723bs/include/rtw_security.h  | 18 -------------
> >  .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 26 +++----------------
> >  3 files changed, 3 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > index baf8b1e0f43c..e94eb1138cf1 100644
> > --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> > @@ -387,7 +387,6 @@ int rtw_cmd_thread(void *context)
> >  	u8 ret;
> >  	struct cmd_obj *pcmd;
> >  	u8 *pcmdbuf;
> > -	unsigned long cmd_start_time;
> >  	u8 (*cmd_hdl)(struct adapter *padapter, u8 *pbuf);
> >  	void (*pcmd_callback)(struct adapter *dev, struct cmd_obj *pcmd);
> >  	struct adapter *padapter = context;
> > @@ -438,8 +437,6 @@ int rtw_cmd_thread(void *context)
> >  			continue;
> >  		}
> >  
> > -		cmd_start_time = jiffies;
> > -
> >  		if (rtw_cmd_filter(pcmdpriv, pcmd) == _FAIL) {
> >  			pcmd->res = H2C_DROPPED;
> >  			goto post_process;
> 
> How about one patch per variable that is being removed as this was fine,
> but others below are not ok.

so just one patch per variable removed, right?
I will send a small patchset instead of this.

> 
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
> > index b71f0959108b..5c787e999aab 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> > @@ -332,24 +332,6 @@ static inline u32 rotr(u32 val, int bits)
> >  /* This is based on SHA256 implementation in LibTomCrypt that was released into
> >   * public domain by Tom St Denis. */
> >  
> > -/* the K array */
> > -static const unsigned long K[64] = {
> > -	0x428a2f98UL, 0x71374491UL, 0xb5c0fbcfUL, 0xe9b5dba5UL, 0x3956c25bUL,
> > -	0x59f111f1UL, 0x923f82a4UL, 0xab1c5ed5UL, 0xd807aa98UL, 0x12835b01UL,
> > -	0x243185beUL, 0x550c7dc3UL, 0x72be5d74UL, 0x80deb1feUL, 0x9bdc06a7UL,
> > -	0xc19bf174UL, 0xe49b69c1UL, 0xefbe4786UL, 0x0fc19dc6UL, 0x240ca1ccUL,
> > -	0x2de92c6fUL, 0x4a7484aaUL, 0x5cb0a9dcUL, 0x76f988daUL, 0x983e5152UL,
> > -	0xa831c66dUL, 0xb00327c8UL, 0xbf597fc7UL, 0xc6e00bf3UL, 0xd5a79147UL,
> > -	0x06ca6351UL, 0x14292967UL, 0x27b70a85UL, 0x2e1b2138UL, 0x4d2c6dfcUL,
> > -	0x53380d13UL, 0x650a7354UL, 0x766a0abbUL, 0x81c2c92eUL, 0x92722c85UL,
> > -	0xa2bfe8a1UL, 0xa81a664bUL, 0xc24b8b70UL, 0xc76c51a3UL, 0xd192e819UL,
> > -	0xd6990624UL, 0xf40e3585UL, 0x106aa070UL, 0x19a4c116UL, 0x1e376c08UL,
> > -	0x2748774cUL, 0x34b0bcb5UL, 0x391c0cb3UL, 0x4ed8aa4aUL, 0x5b9cca4fUL,
> > -	0x682e6ff3UL, 0x748f82eeUL, 0x78a5636fUL, 0x84c87814UL, 0x8cc70208UL,
> > -	0x90befffaUL, 0xa4506cebUL, 0xbef9a3f7UL, 0xc67178f2UL
> > -};
> > -
> > -
> >  /* Various logical functions */
> >  #define RORc(x, y) \
> >  (((((unsigned long) (x) & 0xFFFFFFFFUL) >> (unsigned long) ((y) & 31)) | \
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > index a9820d813d8b..8d29ca9ba67f 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> > @@ -33,10 +33,6 @@
> >  static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
> >  	6000000, 9000000, 12000000, 18000000, 24000000, 36000000, 48000000, 54000000};
> >  
> > -static const char * const iw_operation_mode[] = {
> > -	"Auto", "Ad-Hoc", "Managed",  "Master", "Repeater", "Secondary", "Monitor"
> > -};
> > -
> >  void indicate_wx_scan_complete_event(struct adapter *padapter)
> >  {
> >  	union iwreq_data wrqu;
> > @@ -1125,7 +1121,6 @@ static int rtw_wx_set_mlme(struct net_device *dev,
> >  			     union iwreq_data *wrqu, char *extra)
> >  {
> >  	int ret = 0;
> > -	u16 reason;
> >  	struct adapter *padapter = rtw_netdev_priv(dev);
> >  	struct iw_mlme *mlme = (struct iw_mlme *)extra;
> >  
> > @@ -1133,8 +1128,6 @@ static int rtw_wx_set_mlme(struct net_device *dev,
> >  	if (mlme == NULL)
> >  		return -1;
> >  
> > -	reason = mlme->reason_code;
> > -
> >  	switch (mlme->cmd) {
> >  	case IW_MLME_DEAUTH:
> >  		if (!rtw_set_802_11_disassociate(padapter))
> > @@ -2440,7 +2433,6 @@ static int rtw_dbg_port(struct net_device *dev,
> >  	u8 major_cmd, minor_cmd;
> >  	u16 arg;
> >  	u32 extra_arg, *pdata, val32;
> > -	struct sta_info *psta;
> >  	struct adapter *padapter = rtw_netdev_priv(dev);
> >  	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
> >  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
> > @@ -2542,15 +2534,7 @@ static int rtw_dbg_port(struct net_device *dev,
> >  
> >  					break;
> >  				case 0x05:
> > -					psta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
> > -					if (psta) {
> > -						int i;
> > -						struct recv_reorder_ctrl *preorder_ctrl;
> > -
> > -						for (i = 0; i < 16; i++)
> > -							preorder_ctrl = &psta->recvreorder_ctrl[i];
> > -
> > -					}
> > +					rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
> 
> Odd, but ok.
> 
> >  					break;
> >  				case 0x06:
> >  					{
> > @@ -2568,9 +2552,8 @@ static int rtw_dbg_port(struct net_device *dev,
> >  					break;
> >  				case 0x09:
> >  					{
> > -						int i, j;
> > +						int i;
> >  						struct list_head	*plist, *phead;
> > -						struct recv_reorder_ctrl *preorder_ctrl;
> >  
> >  						spin_lock_bh(&pstapriv->sta_hash_lock);
> >  
> > @@ -2579,13 +2562,10 @@ static int rtw_dbg_port(struct net_device *dev,
> >  							plist = get_next(phead);
> >  
> >  							while (phead != plist) {
> > -								psta = container_of(plist, struct sta_info, hash_list);
> > +								container_of(plist, struct sta_info, hash_list);
> 
> Did that build???  If so, that's obviously not correct.
>

yes it builds..

> >  
> >  								plist = get_next(plist);
> 
> So you now have a loop that does nothing?
>

so will I remove the whole loop?
 
> thanks,
> 
> greg k-h

thank you,

fabio
