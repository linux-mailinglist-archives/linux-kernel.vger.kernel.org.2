Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EA14452CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhKDMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 08:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhKDMTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:19:14 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96552C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O+Qxm2sTsf748cbw2uJnyaNmoAjGx59jmTwMD7TBqa4=; b=wT6Go5EEJp6k32JUs+xycY0uMK
        DtQTQfl8uxH7y98wSY+MLjgpOsjrNupM41o3vKTFMovE4F59g8JZBSrsXt3IbqIVfn4NsZhTnqdIL
        2Xy5vdhlzNdPsYspX4XuXqNGDbKyWz3TSWLC0QolOAJ1L/dJcR0AlHsPl+Et2choR/5Gkpph8d7YR
        HSSJZzGTAzjCxciDeiYkGNVpa7C2JYataGNgdS4jONSbRfKpnAVmqXHZTOBmDjrqVnnLH8rs3LudY
        sKJYytvRlpkrEiOu6ubwA9/Nm4Ky6OxJ6vtOhb2KWVETCUKAfWjwwh4FFFcFZK2IXK6rjuTanKjI/
        WVlab7Qw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55474)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mibfU-0005wI-G3; Thu, 04 Nov 2021 12:16:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mibfT-0007K0-Tp; Thu, 04 Nov 2021 12:16:31 +0000
Date:   Thu, 4 Nov 2021 12:16:31 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Jon Medhurst <tixy@linaro.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: fix early early_iounmap()
Message-ID: <YYPPH7E/s/SWdM4m@shell.armlinux.org.uk>
References: <990f4427968071d59bcbb7411da73acc379d3ac4.1635986046.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <990f4427968071d59bcbb7411da73acc379d3ac4.1635986046.git.mirq-linux@rere.qmqm.pl>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 01:37:15AM +0100, Michał Mirosław wrote:
> Currently __set_fixmap() bails out with a warning when called in early boot
> from early_iounmap(). Fix it, and while at it, make the comment a bit easier
> to understand.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: b089c31c519c ("ARM: 8667/3: Fix memory attribute inconsistencies when using fixmap")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

LGTM. Please drop it into the patch system, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
