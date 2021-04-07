Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32DD356363
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 07:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbhDGFkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 01:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhDGFkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 01:40:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD097613C0;
        Wed,  7 Apr 2021 05:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617774036;
        bh=1XZqIx6SDJy9lK+nO0VwaLN+iUjNHhA/ArlJSIl3ljo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xoGkVLoXvJNh3XlnGqJyeiXaD8SRMrd+VXkZihtDE1peRfYWMq+extQsBidMHAMh6
         NOKLHwyINIZ5qtzNU1PYmRBKh2vOx11QkT2cb45cgqZbE+Y6KjatF4Gkkp3vNCkhR3
         ONcjDXD/Jk2smbQyAv7FA+Bkkhx6xlIbR+X/kAlM=
Date:   Wed, 7 Apr 2021 07:40:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sergei Krainov <sergei.krainov.lkd@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: avoid multiple line dereference
Message-ID: <YG1F0UoHuuGXctim@kroah.com>
References: <20210406231517.GA30925@test-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406231517.GA30925@test-VirtualBox>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:15:17AM +0200, Sergei Krainov wrote:
> fix post-commit hook checkpatch issues:
> 
> WARNING: Avoid multiple line dereference - prefer 'adapter->mlmepriv.cur_network.network.InfrastructureMode'
> +			adapter->mlmepriv.cur_network.network.
> +			InfrastructureMode)
> 
> WARNING: Avoid multiple line dereference - prefer 'adapter->registrypriv.dev_network.MacAddress'
> +						 adapter->registrypriv.
> +							dev_network.MacAddress;
> 
> WARNING: Avoid multiple line dereference - prefer 'pnetwork->network.Configuration.FHConfig.DwellTime'
> +		 le32_to_cpu(pnetwork->network.Configuration.FHConfig.
> +			     DwellTime);
> 
> WARNING: Avoid multiple line dereference - prefer 'pnetwork->network.Configuration.FHConfig.HopPattern'
> +		 le32_to_cpu(pnetwork->network.Configuration.
> +			     FHConfig.HopPattern);
> 
> WARNING: Avoid multiple line dereference - prefer 'pmlmepriv->scanned_queue'
> +					    r8712_find_network(&pmlmepriv->
> +					    scanned_queue,
> 
> WARNING: Avoid multiple line dereference - prefer 'pmlmepriv->scanned_queue'
> +					     r8712_find_network(&pmlmepriv->
> +					     scanned_queue,
> 
> WARNING: Avoid multiple line dereference - prefer 'pstapriv->sta_hash_lock'
> +					spin_lock_irqsave(&pstapriv->
> +						sta_hash_lock, irqL2);
> 
> WARNING: Avoid multiple line dereference - prefer 'pstapriv->sta_hash_lock'
> +					spin_unlock_irqrestore(&(pstapriv->
> +						sta_hash_lock), irqL2);
> 
> WARNING: Avoid multiple line dereference - prefer 'pmlmepriv->scanned_queue'
> +						 r8712_find_network(&pmlmepriv->
> +						 scanned_queue,
> 
> WARNING: Avoid multiple line dereference - prefer 'pnetwork->network.MacAddress'
> +						 pnetwork->network.
> +						 MacAddress);
> 
> WARNING: Avoid multiple line dereference - prefer 'pmlmepriv->scanned_queue'
> +				ptarget_wlan = r8712_find_network(&pmlmepriv->
> +						scanned_queue,
> 
> WARNING: Avoid multiple line dereference - prefer 'adapter->securitypriv.AuthAlgrthm'
> +					if (adapter->securitypriv.
> +					    AuthAlgrthm == 2) {
> 
> WARNING: Avoid multiple line dereference - prefer 'adapter->securitypriv.binstallGrpkey'
> +						adapter->securitypriv.
> +							binstallGrpkey =
> 
> WARNING: Avoid multiple line dereference - prefer 'adapter->securitypriv.busetkipkey'
> +						adapter->securitypriv.
> +							busetkipkey =
> 
> WARNING: Avoid multiple line dereference - prefer 'adapter->securitypriv.bgrpkey_handshake'
> +						adapter->securitypriv.
> +							bgrpkey_handshake =
> 
> WARNING: Avoid multiple line dereference - prefer 'adapter->securitypriv.PrivacyAlgrthm'
> +							 adapter->securitypriv.
> +							 PrivacyAlgrthm;
> 
> WARNING: Avoid multiple line dereference - prefer 'ptarget_sta->x_UncstKey'
> +						memset((u8 *)&ptarget_sta->
> +							 x_UncstKey,
> 
> WARNING: Avoid multiple line dereference - prefer 'ptarget_sta->tkiprxmickey'
> +						memset((u8 *)&ptarget_sta->
> +							 tkiprxmickey,
> 
> WARNING: Avoid multiple line dereference - prefer 'ptarget_sta->tkiptxmickey'
> +						memset((u8 *)&ptarget_sta->
> +							 tkiptxmickey,
> 
> WARNING: Avoid multiple line dereference - prefer 'ptarget_sta->txpn'
> +						memset((u8 *)&ptarget_sta->
> +							 txpn, 0,
> 
> WARNING: Avoid multiple line dereference - prefer 'ptarget_sta->rxpn'
> +						memset((u8 *)&ptarget_sta->
> +							 rxpn, 0,
> 
> WARNING: Avoid multiple line dereference - prefer 'tgt_network->network'
> +				r8712_get_wlan_bssid_ex_sz(&tgt_network->
> +							network));
> 
> WARNING: Avoid multiple line dereference - prefer 'pmlmepriv->cur_network.network'
> +					if (is_same_network(&pmlmepriv->
> +					    cur_network.network,
> 

That's a lot of information we don't need in a changelog text, please
summarize when possible :)

>  					ptarget_wlan =
> -						 r8712_find_network(&pmlmepriv->
> -						 scanned_queue,
> -						 pnetwork->network.
> -						 MacAddress);
> +						 r8712_find_network(&pmlmepriv->scanned_queue,
> +						 pnetwork->network.MacAddress);

As bad as the original line here is, this isn't all that much better at
all, right?  How about working to fix the huge indentation levels in
this function instead, which will resolve all of this mess properly?
That would be a much better way to solve this.

thanks,

greg k-h
