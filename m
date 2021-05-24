Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADAA38E152
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhEXHGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232120AbhEXHGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:06:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C56A6109E;
        Mon, 24 May 2021 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621839893;
        bh=5zRR35sopPhIcbOdDfJMCF+fxbhWMxuprvD3qD7vU90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTUHXiEmEu4Z38Xe70Xhzj+FH+CoG8u+7HhiAlIAuuAmZ3Xhr+Jg8TZggNPeypDmK
         HrsAZ9j8Tehr83WzRDC0+UZ/CHOvUsNg/ZcLbR4sr45DzQrILOEuNh7E79Xwu8Fyc3
         6lI4osyFqxW7eXDFVRlj0SgClrnN+kR/kFbQSzLA=
Date:   Mon, 24 May 2021 09:04:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nizamhaider786@gmail.com
Cc:     lkundrak@v3.sk, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] char: pcmcia: scr24x_cs: Fix failure handling
 Handled failure cases of pcmcia_enable_device() and device_create()
Message-ID: <YKtQFL1AIunsyZhn@kroah.com>
References: <20210523151111.2968-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523151111.2968-1-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 08:41:10PM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 
> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>

I can not take patches without any changelog text :(

