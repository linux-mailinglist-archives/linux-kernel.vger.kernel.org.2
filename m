Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663F4348DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCYKGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhCYKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:06:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1DBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xe6ylj/Aipy5eoc+Obq+1c+zJSRHW8XclzYOw2iqLCs=; b=hPXOiulEAAW7UncDYf+e0EZiD
        vae10Xiph4oqbWA9EUUe88dCiUCETxcbekCdbxhbMNFLIW44k7PzW7x3NStM9ybKCphoI6HOOtEt1
        zHpYIk3+JLxZcYwQ+XPWtOxaN3DcRYW2esHiammjafjhRApT2GizViKtofl8Mo1iXjz0ZfsJ7Mgbv
        d5on9SJq0TfBce/Sn0VuXFNPeYj0eM3g7uFAPLCXMU+Ck3+h2UrqN+PITMtIjOxBKDDq1sDqruW3P
        EtXXp+6yRMxQ+SHg+SE/6ugI2aizt7/9x4FCZDHD1Ss0bT83sV3vjbwdmgsaSiY+3+k4QIk6O0fpc
        5hOXl2efg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51710)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lPMsT-0001Xr-Jq; Thu, 25 Mar 2021 10:06:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lPMsQ-0005v5-22; Thu, 25 Mar 2021 10:06:06 +0000
Date:   Thu, 25 Mar 2021 10:06:06 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Liu Xiang <liu.xiang@zlingsmart.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, liuxiang1999@gmail.com
Subject: Re: [PATCH] ARM: fix smp_processor_id() in preemptible warning in
 harden_branch_predictor()
Message-ID: <20210325100605.GL1463@shell.armlinux.org.uk>
References: <20210325095049.6948-1-liu.xiang@zlingsmart.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325095049.6948-1-liu.xiang@zlingsmart.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:50:49PM +0800, Liu Xiang wrote:
> When CONFIG_HARDEN_BRANCH_PREDICTOR is selected and user aborts occur,
> there is a warning:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: errnotest/577
> caller is __do_user_fault.constprop.4+0x24/0x88
> CPU: 1 PID: 577 Comm: errnotest Not tainted 4.14.188-rt87-fmsh-00004-g58055877a #1
> Hardware name: FMSH PSOC Platform
> [<8010d6d4>] (unwind_backtrace) from [<8010a228>] (show_stack+0x10/0x14)
> [<8010a228>] (show_stack) from [<80698f44>] (dump_stack+0x7c/0x98)
> [<80698f44>] (dump_stack) from [<803d17d0>] (check_preemption_disabled+0xc4/0xfc)
> [<803d17d0>] (check_preemption_disabled) from [<80110eb8>] (__do_user_fault.constprop.4+0x24/0x88)
> [<80110eb8>] (__do_user_fault.constprop.4) from [<801112e4>] (do_page_fault+0x2dc/0x310)
> [<801112e4>] (do_page_fault) from [<801012a8>] (do_DataAbort+0x38/0xb8)
> [<801012a8>] (do_DataAbort) from [<8010b03c>] (__dabt_usr+0x3c/0x40)
> Exception stack(0xb21d1fb0 to 0xb21d1ff8)
> 1fa0:                                     fffffff4 00000000 00000054 fffffff4
> 1fc0: 00000000 00000000 7ed81cc8 7ed81ca0 0007a440 00000000 00000000 00000000
> 1fe0: 00000000 7ed81ca0 00010493 0001f330 20030010 ffffffff

This is not the right fix - preemption is supposed to be disabled before
this function is called. I'm not sure at the present time what the right
fix is supposed to be because I've forgotten most of the background
behind why this was placed where it is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
