Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F73459BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhKWF5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhKWF5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:57:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C39060D42;
        Tue, 23 Nov 2021 05:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637646885;
        bh=lznfS8zSE5nuh0D8xA9Fyveb7LHT+lLHRDD/nS7+tso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tzLfOYh6lSaaZTx0okiy5e+Hnb53Coyocau6LI6SM3nP3obJi7X7TGxrN7wL/GRZB
         vhQK61+iwzDsSltQbeqxWmy+8Y7i1hY8tcQ9JdfQ7xEs/ATuF3nFHyxjmDNplOlDhK
         UFoYXAPfFnmbUzZQg6FZTXsualzL2FyIjqM9Y/K7W0aFTCIY/N45jlDIUicQp3xGWi
         Bkm/6u7FsJptEFGFbxWuhdhg7xUeyhBAhPE03lhT7ZM3na4Q1X3k5kw8Y7S/vQQCig
         PPsGM4B7ostAdBajRmmTD8Z5+KLLt32itGGG2Mma27Z1plD+0+NWR4eWH92rav0sEJ
         lYKHHgsVcYhgw==
Date:   Tue, 23 Nov 2021 11:24:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     davidcomponentone@gmail.com
Cc:     kishon@ti.com, sjakhade@cadence.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] phy: cadence-torrent: use swap() to make code cleaner
Message-ID: <YZyCIUzvG+eERc32@matsya>
References: <20211104065233.1833499-1-yang.guang5@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104065233.1833499-1-yang.guang5@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-21, 14:52, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.

Applied, thanks

-- 
~Vinod
