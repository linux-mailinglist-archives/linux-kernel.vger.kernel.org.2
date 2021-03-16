Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52D33D4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhCPNhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhCPNgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:36:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1762AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 06:36:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z2so7459805wrl.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 06:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7bLhDPuLSWfk3cqi2O7Xv2xxQBRYGHZeZiusa5rwe4c=;
        b=emDDfnDkZjL5XROGG8NZ0S6eXGoBK42uXSn4PwxAtCFdKRWSeXpnxiqXZbcHLgTDwn
         WbXrCMOmzzFxRA+gTc4tuG2qVsiEHRR4QtFMHWsDei2xQtxOQWCY5mXCuNigLEqoeyrR
         olqfMy2S2C/TklVqX3tP6ArISoKpsAJaZsou1S+kEq8vrcwHcdGPzOKRJU0E8djsqo0K
         1AvSr+52ZCMU0us5YCmrKKt3ola+fyp6zgAxe7ovlAKHLTsNAn9VaOlLhl1PASPTd7iN
         VF75QxzZxqAX6S8wq+hdzEQgpEldVonE/P3k6BT2lLLI4etEoqwVbfan8OCctqR0R2Ct
         e/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7bLhDPuLSWfk3cqi2O7Xv2xxQBRYGHZeZiusa5rwe4c=;
        b=pu6noTk4HK6TdhlWwyzifD7tElQK4BQ+wKg6ZR1K1TyyMhzECaLI+1D/TMqfRNFpsH
         BTDw36PYeedNp/IVBlclHuk51Nab46hPF6EBO/eq6c/2p2Wk0wQr/P8T6/uV0BijADpJ
         UjM0stWrXEGiqlyV7U7LCdRRXHhl2MXJDj4nFreZfcLowJy+HA3kB1o7QWEhUZxK1X3B
         kkxnzpIxZ34yhyh+nxJuaeO/rEtWfYN890cEp384wzTrQNxmfAW9OjH4J4QuHS5Cy8Cy
         EJ8fZaAJ8I6y7mVtJj4MrEjnjgzQcK2pATXuB58BWlKr+04zcVcheFjGOqXozPHoa89w
         ZTiA==
X-Gm-Message-State: AOAM531AGTuJXFyqAKi0MD7y51DLeoSbEueicqSvJkntUML4x/aHKJQf
        9E9PJNKOchRY19NIctU4DvCpCnoKlxE=
X-Google-Smtp-Source: ABdhPJxwUCtxObCyAsCDfc6iKpAkZsob7P2k/VT17EV8+d65j/GD8O6eDW33c1ggIUQ1AgRb2QdUsA==
X-Received: by 2002:adf:c186:: with SMTP id x6mr4981647wre.253.1615901803815;
        Tue, 16 Mar 2021 06:36:43 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id 21sm3279133wme.6.2021.03.16.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 06:36:43 -0700 (PDT)
Date:   Tue, 16 Mar 2021 14:36:39 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, kernelnewbies@kernelnewbies.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_PM
Message-ID: <20210316133638.GA1465@agape.jhs>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
 <77ea39e63246fa4756afcf2bdea573f43fefc74c.1615801721.git.fabioaiuto83@gmail.com>
 <YFCY564YYio8lkUT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFCY564YYio8lkUT@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:39:19PM +0100, Greg KH wrote:
> On Mon, Mar 15, 2021 at 11:15:02AM +0100, Fabio Aiuto wrote:
> > remove conditional code blocks checked by unused CONFIG_PM
> > 
> > cleaning required in TODO file:
> > 
> > find and remove code blocks guarded by never set CONFIG_FOO defines
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > index 2ff71d001c07..5748e1c1a25c 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> > @@ -3198,14 +3198,6 @@ static void rtw_cfg80211_preinit_wiphy(struct adapter *padapter, struct wiphy *w
> >  	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
> >  	wiphy->flags |= WIPHY_FLAG_OFFCHAN_TX | WIPHY_FLAG_HAVE_AP_SME;
> >  
> > -#if defined(CONFIG_PM)
> > -	wiphy->max_sched_scan_reqs = 1;
> > -#endif
> > -
> > -#if defined(CONFIG_PM)
> > -	wiphy->wowlan = &wowlan_stub;
> > -#endif
> 
> How this is "unused"?  This is a real config option, did you just change
> the logic here?
> 
> thanks,
> 
> greg k-h

Hi Greg,

ignore this patch. I missed that definition of PM config option.
I dropped it off my own local repo.

Thank you,

fabio
