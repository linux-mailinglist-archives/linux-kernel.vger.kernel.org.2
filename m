Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0476334A48A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCZJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhCZJeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:34:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3B7460190;
        Fri, 26 Mar 2021 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616751240;
        bh=ozywuCe/NeMTTH6FqmHhUeqC8Fwy1YXXVeK7rORIDy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIlycJAf81tbDszupCyGPvoi3Ds3VV+CJbENSkdZVExP9PqjQnzVsd4KUbRTZ5HKq
         gfVqhdCst39/COBH2bcdsjYez9EJ/6eOOdB9fqWjnvrrbf1di+BnGG1CchhWYfsyOd
         QQvo7NuesBq/UP82PmTyEy8SF2EMYtvxPayHiua8=
Date:   Fri, 26 Mar 2021 10:33:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     carlis <zhangxuezhi3@gmail.com>
Cc:     zhangxuezhi1@yulong.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix a typo
Message-ID: <YF2qhUD1lz3LbEhC@kroah.com>
References: <1616745915-194644-1-git-send-email-zhangxuezhi3@gmail.com>
 <YF2dXIxMOUyLzfnQ@kroah.com>
 <20210326171634.000011f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326171634.000011f5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 05:16:34PM +0800, carlis wrote:
> On Fri, 26 Mar 2021 09:37:48 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Mar 26, 2021 at 04:05:15PM +0800, Carlis wrote:
> > > From: "Carlis" <zhangxuezhi1@yulong.com>
> > > 
> > > Change 'tft' to 'TFT'  
> > 
> > Why?  What is wrong with "tft"?
> > 
> I think abbreviations should be capitalized.

Why?  What requires this?

thanks,

greg k-h
