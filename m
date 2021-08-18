Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519613EFEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbhHRILY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238692AbhHRILW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:11:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48F8A6102A;
        Wed, 18 Aug 2021 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629274247;
        bh=1sILUclATRKtsS/plrCACO8tmHQ7R9A44nAdTJCXC7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9PuO6pum/doGoYAFQBXBq6E1ZeDVerApYvERzxemFxfyqNtRnnfKzGJBJEyIZScy
         iFtUUKiaAwF+wXuT4Z4+5BC5IoZB6bgyDEWjk7gDRTpSB+Ar0dZS1mSQ2Htkifo5zD
         DqcrYtmOP/ky2ha8Kf6kCR/0353Zxdp7wBylLZeo=
Date:   Wed, 18 Aug 2021 10:10:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     daniel watson <ozzloy@challenge-bot.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: put '{' on struct's first line
Message-ID: <YRzAhNrPdVW0B5CJ@kroah.com>
References: <20210818044105.23128-1-ozzloy@challenge-bot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818044105.23128-1-ozzloy@challenge-bot.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 09:41:05PM -0700, daniel watson wrote:
> From: Daniel Watson <ozzloy@challenge-bot.com>
> 
> Moved the opening curly brace to the end of the opening
> line of the phy_stat struct for style consistency.
> 
> Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
> ---
>  drivers/staging/rtl8723bs/include/rtl8192c_recv.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

This change does not apply to my tree at all.  Make sure that you are
working off of the latest development tree, and not older kernel trees
(like Linus's), otherwise you will end up duplicating work that others
have already done.

thanks,

greg k-h
