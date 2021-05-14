Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CFD38090A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhENL6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232747AbhENL54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:57:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D23336145B;
        Fri, 14 May 2021 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620993405;
        bh=E9e2y+IFPdCftijFqW61ibIycNH5E2hUB1iXNd99SZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4Cc4NjPRTZbz6HTon3ipnm8vc5hTd3GJMHKH2rk6xoSb7u5ofdCNXV0nDdmlwLdT
         3NNojOpbMmwxeso9KfI2S9edqo7A7qVooHO+qGPnhOgqecEG/bHngDvMaWU0mjeRpy
         +tZ4hKMsGut0eh72KJVip733eLb0SuLyfU7mwGOI=
Date:   Fri, 14 May 2021 13:56:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250:Add SUNIX SDC series uart driver
Message-ID: <YJ5leuqnTKJ0srnS@kroah.com>
References: <20210514115148.5562-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514115148.5562-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:51:48PM +0800, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
> 
> Add SUNIX SDC series uart driver
> 
> Signed-off-by: Morris Ku <saumah@gmail.com>

Please resend all of these asa a proper patch series, and always use
scripts/get_maintainer.pl to know what mailing lists and developers to
add to the cc: line.

thanks,

greg k-h
