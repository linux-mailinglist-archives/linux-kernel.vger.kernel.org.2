Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792AA3A3E64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFKI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbhFKI7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:59:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD97E60BD3;
        Fri, 11 Jun 2021 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401836;
        bh=qxwgRf4LdwHO/2Ovh83Zjv0Go9Pwc/wkHU5/VzPSFaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ovk6bZEotf8awDD7cDKrKgwckHuynVFqj8pY5PVMe86tmGFItP4xOJc+E+BUIqTMI
         ZdR2E4IcTKAW4FUSZy6b1VnCrhFaUhOmTGSg6PlWYzrg4VMdGPaKMzOWxTPKEV/g/c
         lRpbANOomdbmjPICDN86kKPrZfsBYE4Vx1GsCRa4=
Date:   Fri, 11 Jun 2021 10:57:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 5/9] nvmem: core: add a missing of_node_put
Message-ID: <YMMlalfdeIW4W1RC@kroah.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
 <20210611083348.20170-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611083348.20170-6-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:33:44AM +0100, Srinivas Kandagatla wrote:
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> 'for_each_child_of_node' performs an of_node_get on each iteration, so a
> return from the middle of the loop requires an of_node_put.
> 
> Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Looks like this needs to go to the stable kernel trees, so when your
resend this series, please add the proper "cc: stable" line to the
signed-off-by area as is documented.

thanks,

greg k-h
