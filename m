Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD36534A348
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCZIiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCZIhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:37:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47D6861A44;
        Fri, 26 Mar 2021 08:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616747870;
        bh=HGsGnoth2ZOZS+sjsAFalgHFAKd065RGy6pi92g7wx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJ8z8x6vuSW6qeM5GEtRUqkwRr9Zc4YHEx1EzbEMy9KlkAep15GklBnnZlMMqEOlI
         i+4EMw6EyHbAok6ri9e+irAT1PXuX4PwPNDFryc97mEKcvmc2Ur1yK138ZwE49889E
         ZhQiMMpRtlbJlvAe38UUpknc/Ofh1MQ0zwiDtepY=
Date:   Fri, 26 Mar 2021 09:37:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     zhangxuezhi1@yulong.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix a typo
Message-ID: <YF2dXIxMOUyLzfnQ@kroah.com>
References: <1616745915-194644-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616745915-194644-1-git-send-email-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 04:05:15PM +0800, Carlis wrote:
> From: "Carlis" <zhangxuezhi1@yulong.com>
> 
> Change 'tft' to 'TFT'

Why?  What is wrong with "tft"?

> 
> Signed-off-by: Carlis <zhangxuezhi1@yulong.com>

Full name please.

thanks,

greg k-h
