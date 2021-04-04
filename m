Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1D35384E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbhDDOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhDDOJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:09:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E698E6137A;
        Sun,  4 Apr 2021 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617545337;
        bh=xl+7XKTLR0WrCk5FtwjexorYvsXfLCsm+c+QWTkifBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2t+gcO50wZNEroUhtaRA2K6AWKDI96UTXqTMyHfmYal0T8Li/Uhwn2to0UvY8nJpu
         n6mk4qYIrPQJ4YBiCqL+UvZ2pMxCYFh9qPYx6YksfRJ0AvC4eN+pJu86A5ynm1LxYL
         7RxmrPYsFzfPqZgFxRfyUIMLOP/4GNMDoicNIvnQ=
Date:   Sun, 4 Apr 2021 16:08:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Richard Gong <richard.gong@linux.intel.com>
Subject: Re: [PATCHv2 RESEND] firmware: stratix10-svc: build only on 64-bit
 ARM
Message-ID: <YGnIdZ5mbTJnREGB@kroah.com>
References: <20210404124609.122377-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210404124609.122377-1-dinguyen@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 07:46:09AM -0500, Dinh Nguyen wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> The Stratix10 service layer and RCU drivers are useful only on
> Stratix10, so on ARMv8.  Compile testing the RCU driver on 32-bit ARM
> fails:
> 
>   drivers/firmware/stratix10-rsu.c: In function 'rsu_status_callback':
>   include/linux/compiler_types.h:320:38: error: call to '__compiletime_assert_179'
>     declared with attribute error: FIELD_GET: type of reg too small for mask
>     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ...
>   drivers/firmware/stratix10-rsu.c:96:26: note: in expansion of macro 'FIELD_GET'
>     priv->status.version = FIELD_GET(RSU_VERSION_MASK,
> 
> Fixes: 4483397b0353 ("ARM: socfpga: drop ARCH_SOCFPGA")

Where is this commit id?  I don't see it in Linus's tree, is it
somewhere else?

thanks,

greg k-h
