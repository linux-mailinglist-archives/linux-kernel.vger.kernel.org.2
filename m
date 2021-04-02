Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5959352AD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbhDBMvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 08:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBMve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:51:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96324C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 05:51:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e18so4660838wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nx/y0V7SG5Dyvykx3F/w3c6A3gkIAlcrFn1/AlSQ0j8=;
        b=BaXG7KQW8vs3sBZrXTRJziZT0eLt8oYc7+lAdiRwmlfxrgqSHF2NW2VfftCtgDPbhS
         GER8Jq+uUH+lD43PghdYrxqJ90TPvz0KF/IldT1hmqnzo3e89SvT8FwBrt1gYyh1tNDy
         eMpxUx//pQV1cwWxyB521E+itPHPyN9s4zAnVU7pVaa5S60BdOTLU1z7Hf6n8pfvl9zG
         O3HFKkAR38JYHrPDOL9I6voohksB2Svpud0MCNBism3/iY6Tt2Xw2NP2zLVhSiZc/+Ry
         XrdA5ilyXW/3J3ekguxrU2nVjqi7eXRCZeeCgjClth/MS6EJbi1N9qf/OE//OMTu+IFt
         wRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nx/y0V7SG5Dyvykx3F/w3c6A3gkIAlcrFn1/AlSQ0j8=;
        b=SBePA1C/9zX6vIAYhbiNukCAsbzprIWxc3s+UL5SHNX4FkpnW7+tqBxiVeBJsxaAW5
         /yLnGeBI/gJV7XaLuREr94oSdzr7WwDf2Mtr46DWMa3/gjiTN4/XAbGJklBzaGPQhEZT
         gt4bv4nY5UZMr11VrpPNum6IIUAAHJC2ZNGfhnnrLo84ecXt2yI9lNseXZZZqpyNKa4L
         0Gw/EanWPnmbhSh/f8VWc+iVQq8wezw1/edf06eeBj+aho8Ebq/4mE3IcMhVyxI0KJOg
         hgQsk4k9HgGNnZUJp3aaADRUE3IeVnKdaI/Ues+YEkYF5ffzb51mj5liUmdn/sdmy08D
         ZrAQ==
X-Gm-Message-State: AOAM533gP0MvLvGHFNMriUpS9BGbWczYuiO5kIw4RBQUQNUIJ5HqoWDf
        xYv0Xhk1l7cZkEMM1J1tTv0=
X-Google-Smtp-Source: ABdhPJzu1gDRbNr7CO1boGVpP3Ap9LPMQU3DMAcfNcV2yuS+fU04+hqPkGNOAIfSrCVqgGwQ95JPww==
X-Received: by 2002:adf:8292:: with SMTP id 18mr3401134wrc.160.1617367891334;
        Fri, 02 Apr 2021 05:51:31 -0700 (PDT)
Received: from agape.jhs ([5.171.80.213])
        by smtp.gmail.com with ESMTPSA id l6sm14030489wrt.56.2021.04.02.05.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 05:51:31 -0700 (PDT)
Date:   Fri, 2 Apr 2021 14:51:28 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/16] staging: rtl8723bs: remove all RT_TRACE logs in
 core/rtw_wlan_util.c
Message-ID: <20210402125127.GB1420@agape.jhs>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
 <34bf6cdc7bdf5c64d47cb3525897970644de7052.1617356821.git.fabioaiuto83@gmail.com>
 <2014e0fc141d73d907c781ca31c822c96d3a7c47.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2014e0fc141d73d907c781ca31c822c96d3a7c47.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 03:37:57AM -0700, Joe Perches wrote:
> On Fri, 2021-04-02 at 12:01 +0200, Fabio Aiuto wrote:
> > remove all RT_TRACE logs
> > 
> > fix patch-related checkpatch issues
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  .../staging/rtl8723bs/core/rtw_wlan_util.c    | 26 +++++--------------
> >  1 file changed, 6 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
> []
> > @@ -1382,25 +1374,19 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
> >  	if (encryp_protocol == ENCRYP_PROTOCOL_WPA || encryp_protocol == ENCRYP_PROTOCOL_WPA2) {
> >  		pbuf = rtw_get_wpa_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
> >  		if (pbuf && (wpa_ielen > 0)) {
> > -			if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
> > -				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
> > -						("%s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is %d\n", __func__,
> > -						 pairwise_cipher, group_cipher, is_8021x));
> > -			}
> > +			if (rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher,
> > +					     &pairwise_cipher, &is_8021x) == _SUCCESS)
> > +				;
> 
> 		This sort of if is a bit silly.
> 		Better would be to remove the test and just use:
> 
> 			rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher,
> 					 &pairwise_cipher, &is_8021x);
> 
> >  		} else {
> >  			pbuf = rtw_get_wpa2_ie(&bssid->IEs[12], &wpa_ielen, bssid->IELength-12);
> >  
> > 
> >  			if (pbuf && (wpa_ielen > 0)) {
> > -				if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen+2, &group_cipher, &pairwise_cipher, &is_8021x)) {
> > -					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
> > -							("%s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, is_802x is %d\n",
> > -							 __func__, pairwise_cipher, group_cipher, is_8021x));
> > -				}
> > +				if (rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher,
> > +						      &pairwise_cipher, &is_8021x) == _SUCCESS)
> > +					;
> 
> 				rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher,
> 						  &pairwise_cipher, &is_8021x);
> 
> etc...
> 
> Lastly, another suggestion would be to just submit a single patch
> removing _ALL_ the RT_TRACE uses not intermixing various other cleanups
> with the series and then do those other cleanups.
> 
> Using a coccinelle script like:
> 
> $ cat RT_TRACE.cocci
> @@
> expression a, b, c;
> @@
> 
> -	RT_TRACE(a, b, (c));
> 
> $ spatch -sp-file RT_TRACE.cocci drivers/staging/rtl8723bs/
> 
> And then clean up the various bits you think are inappropriately done.
> 
> 

thank you Joe, I tried with (RT_TRACE.cocci in parent folder)

user@host:~/src/git/kernels/staging$ spatch -sp-file ../RT_TRACE.cocci drivers/staging/rtl8723bs/
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
0 files match

i don't know what's wrong... I run on a Debian Buster

