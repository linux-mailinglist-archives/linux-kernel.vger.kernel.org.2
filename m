Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B68399D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFCJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCJTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:19:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADE3B60231;
        Thu,  3 Jun 2021 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622711823;
        bh=KCav+JvpFdv8yvqK8orQkoPhphzYanj9JUINXnx67VQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qm/neZbEPgQSRQBkppuQW4HUSpT7h8BXO2ioYpgMLaUW2/VK6BXkZWylwC3gHl0bW
         oMhaK42e6bPn+IS7Zfz10KYedfo49vln3sTk2MdK9SdjpyLTgPFnldpbyMpr4qNG5y
         /D9HgqCh2qdwWo4qlH2XkcJ4Ii5g3YZRRk219fNw=
Date:   Thu, 3 Jun 2021 11:17:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiabing Wan <wanjiabing@vivo.com>
Cc:     Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Qiang Ma <maqianga@uniontech.com>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: core: fix some incorrect type
 warnings
Message-ID: <YLieDLLcsTctEwXD@kroah.com>
References: <1622708703-8561-1-git-send-email-wanjiabing@vivo.com>
 <AO6AtgBODjnoS0IYaAQ1bKoy.3.1622709415201.Hmail.wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AO6AtgBODjnoS0IYaAQ1bKoy.3.1622709415201.Hmail.wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 04:36:55PM +0800, Jiabing Wan wrote:
>  
>  
> Hi,all
> 
> I fix these warnings by refering other patches.
> 
> Actually, I don't understand clearly what I did.  
> 
> But there are no warnings after this fix.
> 
> So if this fix were totally wrong, please told me and 
> gave me some suggestions.
> 
> It is important for me to fix a sparse bug.

Do not fix sparse bugs just for the sake of fixing sparse bugs.  Fix
things you know are needed to be fixed.

Please look closer at this to ensure that you really are fixing this
correctly and understand what you are doing before sending it out.

thanks,

greg k-h
