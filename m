Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FDA3D0A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhGUHsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232239AbhGUHiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:38:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 652C96120A;
        Wed, 21 Jul 2021 08:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626855517;
        bh=z2equphG3PLJALWqpeve2io1ixFxOq5eYXLDsLQ3NQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEwCFAB0b+qQUtcpNrTg0XsEuz1hN0R/qeTkzjZ8OLU6bbGjoSKbHA2kvFVb94XIZ
         ZY+n7tAxVjLnsFd7xOgy5OFqqfR/0bzJTcU2En/6ReE9Fh4JMUmkwBxJytTob75cVR
         33TDPWUzPMD7XWSNWDGMl7OMgmugzbgiJr2tRMFk=
Date:   Wed, 21 Jul 2021 10:18:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: core: Remove set but unused variable
Message-ID: <YPfYWk5afrgGecDR@kroah.com>
References: <20210701154647.18975-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701154647.18975-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 05:46:47PM +0200, Fabio M. De Francesco wrote:
> Remove variable sec_idx because is set but unused. Issue detected by
> GCC with -Wunused-variable.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Does not apply to my tree :(
