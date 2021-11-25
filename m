Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851E745DEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356312AbhKYQmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:42:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhKYQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:40:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4CB060EB5;
        Thu, 25 Nov 2021 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637858213;
        bh=9fnH95eMHD+AARZyCzt4YZ3kg3T21/xouuTuMp70H/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5Hcr15dUkWVhX2vxmZbm0nvKdDLhoyXTRsuX8i7jg4UkppF33qZoTydfV8RxI/4S
         uU/pJXAkWgWmK11kKQsfGjWDxMT29oqJPvNuddRzKbXVUVkwHY6FTkA/nr3A96bDcu
         1nIl93Nt40wxjblAbTsWDyUeQXv9meHNvMClO3Ws=
Date:   Thu, 25 Nov 2021 17:36:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zameer Manji <zmanji@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: 8188eu: remove unused code in ieee80211.h
Message-ID: <YZ+7lttAi1BPCgW2@kroah.com>
References: <20211117143234.1508695-1-zmanji@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117143234.1508695-1-zmanji@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:32:18PM +0000, Zameer Manji wrote:
> This header file contains lots of code that is unused
> and safe to remove.
> 
> Signed-off-by: Zameer Manji <zmanji@gmail.com>

You have a mistyped word in your subject line, please fix.

thanks,

greg k-h
