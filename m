Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58D2402522
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 10:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbhIGIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 04:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238139AbhIGIbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 04:31:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C18AD60F6D;
        Tue,  7 Sep 2021 08:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631003395;
        bh=xEsWL8K7ntcxAJFIUIR6KAw9E+YQxXyV84cgOTyJhdw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SuRQIclMTnJcs3/IWoL/K0+9uDMKd2ePkqP1mCZJvnRHiFvOO+nj5+NyRPOuob9oD
         8WNQ94A0ZeqlKq33+Z31WUxmNwALU0bCic7JOoYQoLsLL4gTgBmHtqu80l1JcN1VC8
         qZL33jnrvGhpF5z4u0tu4oasB0XJg/HUT5PGka6BPa9z6+PKX445ddDNhU5g2e0FBC
         JWfaPN8EnwULPoqTPkjGKR6+TRQY9HqeqQfKhbfiVtBK/IaVmv7nTHBuWRIUngNgTl
         8tpkbwiFXYZvCRrHeUJ4/yM+g/VWTE8Y+NOQq2HznuxxAfo+TRFB6jDHE2oVJIDPpK
         P6QUaWXg2bo0Q==
Message-ID: <6452f931cdc61f01a09611b3c1a0b5f7aeb1e784.camel@kernel.org>
Subject: Re: [PATCH] mailbox: bcm2835: Make use of the helper function
 devm_platform_ioremap_resource()
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 07 Sep 2021 10:29:50 +0200
In-Reply-To: <20210907074056.2094-1-caihuoqing@baidu.com>
References: <20210907074056.2094-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-07 at 15:40 +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

