Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2424239D8B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFGJ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhFGJ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:27:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9961EC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ahI4EjLeMtgUVhOc3FIcZMMSyQ69ejVHOU/RKcqIyic=; b=m1Tk55uAonIzZBWxsbz0KW3fk
        LzPVVQ1qiGJllgv+O5oq/0nQZS89Y3Ow7pZhjPKEyHJAYEQpj6XJdv6CedeYuCe2rr2cWVOzGOwNW
        ziol3gbNG6cSxD/I/IKgxdmbufaPQhmb6uLERMrkGK5Mo2Wblfh8ONFF3AR8RDvCU5ZdJHiLNDCXU
        3NVNb8bo79Pcif6ha08SLe5EeyHv770fS6r0kdPHw76cFVaSWAD7ASpZ+dY5kXZFE0+SxFnpv4fXY
        Hm6YyqCMs1NOZwLEMGTri/VYtl9wVsOiLjnWLoWx78lJMfQvGFI3mYsrfK9c2L27dG80DU+zJn53w
        clASIeBng==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44782)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lqBVy-0000EJ-LG; Mon, 07 Jun 2021 10:25:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lqBVw-0005nz-Ey; Mon, 07 Jun 2021 10:25:44 +0100
Date:   Mon, 7 Jun 2021 10:25:44 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 03/15] arm: convert to setup_initial_init_mm()
Message-ID: <20210607092544.GB22278@shell.armlinux.org.uk>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <20210604070633.32363-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604070633.32363-4-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 03:06:21PM +0800, Kefeng Wang wrote:
> Use setup_initial_init_mm() helper to simplify code.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
