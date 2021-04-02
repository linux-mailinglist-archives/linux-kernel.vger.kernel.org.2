Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984EC352B7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhDBOaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhDBOaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:30:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA500610CB;
        Fri,  2 Apr 2021 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617373810;
        bh=wtlMjfPnqatXNqGUuL+0WIsehJgYzBBaSgLAJgTX/x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4FFftGgddVPRW+9y2ZdroAlTE2ivxD/3kPHt83U/ZRvb9k66LBq4ceJY55LQeQGD
         LjvGceJ+Cqzfu7WFVSSs902eF1+78rYUR/z+fXC8040e9v/F8wwaAF2KRidIRsJsQa
         PFvB7OjoGTUR3PCJMG5nO1sozOO/OkAce94DGYHo=
Date:   Fri, 2 Apr 2021 16:30:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Richard Gong <richard.gong@linux.intel.com>
Subject: Re: [PATCH] firmware: stratix10-svc: build only on 64-bit ARM
Message-ID: <YGcqcDnjv8xqS0en@kroah.com>
References: <20210401151329.606004-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401151329.606004-1-dinguyen@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 10:13:29AM -0500, Dinh Nguyen wrote:
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
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Acked-by: Richard Gong <richard.gong@linux.intel.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/firmware/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What commit caused this error to happen?  Can you resend this with a
"Fixes:" tag with that information in it?

thanks,

greg k-h
