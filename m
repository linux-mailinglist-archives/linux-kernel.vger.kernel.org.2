Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0E8394C2E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 14:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhE2MUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 08:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2MUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 08:20:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 05:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S53zc6j3xQp7Y0M3lUKk/E9CGWHQewIosEX7fP5r7/g=; b=tzQNKz3csnSbMclRoZtcpuSEz
        hz3BxU8yFkWn2IyITweBEY0BOJBhN86+s6cTQH8QfeNIUentCryZiJhBOFZG48FDCkiicx7upAD83
        2Fwuz9RVJev4pCzXN1TaCSaQseM9UZ4IOdu4YjPUy34DczT/4oNrX5oSseEtPYxlR3IMJwVNE3RpR
        pIfMNzKLkX70U98oHhtualdSNhF1lxUkzFkDVlJDW7ULVT9DM0XdUIM5RQpemsQMlZCxMlDh8/83D
        YGglSoAQP7FucsZMrfEVRuMhMqqrkkxHGbjQcSmnW+uHMfY8dVUb++FphYgZLlpjx1hdvHRc3O4N0
        ycC0byOYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44470)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lmxvX-0000sd-I2; Sat, 29 May 2021 13:18:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lmxvT-0005f9-7m; Sat, 29 May 2021 13:18:47 +0100
Date:   Sat, 29 May 2021 13:18:47 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/15] arm: convert to setup_initial_init_mm()
Message-ID: <20210529121847.GR30436@shell.armlinux.org.uk>
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
 <20210529105504.180544-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529105504.180544-4-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 06:54:52PM +0800, Kefeng Wang wrote:
> Use setup_initial_init_mm() helper to simplify code.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Obviously, without having visibility of the contents of
setup_initial_init_mm(), it's impossible to say whether this change is
correct or not, so I won't be providing any acks/reviewed-bys for it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
