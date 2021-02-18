Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0B931EF33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhBRTGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbhBRRYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:24:50 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3754C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UegB2Zj0n1bQJXQibuqGXU/TCSS1amPkWG/5jTW6Kdw=; b=vi+FXIyJcxRhZlxVAeloDvBqp
        lb8JZ5XRKbJaJ5PXQPyThu8TCdZAq2fl32gpRe0i+Fbamw+hFq30nb+QxA/D0hETR02PNhzksk1aM
        eyohetNJFXNBAHozAmDYP4sV7D/8JeKh7PJjwDCtu3QsH3SIq6CFeKkjxfwHInFCOQRy1/szcg6oi
        DHZ2/GJDA0wzRaz4rr232ECpLl8/Zg+0pqsuijarUxF3tDExDoLCbTvWTzub2oi+iEWMauj/PKQ84
        S5IjsBboMeRoblIj1J0JJCHDRu/87uiT89l190Q9khcIV2MzMkksxYH5J0HiI2W3669CTPRGUIxUA
        DTHwI4uJA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45110)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lCn12-0003eq-JS; Thu, 18 Feb 2021 17:23:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lCn11-0006bR-BJ; Thu, 18 Feb 2021 17:22:59 +0000
Date:   Thu, 18 Feb 2021 17:22:59 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Jari Ruusu <jariruusu@protonmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <20210218172259.GJ1463@shell.armlinux.org.uk>
References: <YA/E1bHRmZb50MlS@kroah.com>
 <8cf503db-ac4c-a546-13c0-aac6da5c073b@broadcom.com>
 <YBBkplRxzzmPYKC+@kroah.com>
 <YCzknUTDytY8gRA8@kroah.com>
 <c731b65a-e118-9d37-79d1-d0face334fc4@broadcom.com>
 <YC4atKmK7ZqlOGER@kroah.com>
 <20210218113107.GA12547@1wt.eu>
 <602E766F.758C74D8@users.sourceforge.net>
 <20210218143341.GB13671@1wt.eu>
 <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 05:19:54PM +0000, Jari Ruusu wrote:
> In-tree iwlwifi worked half-ok on early 4.9.y stable. If
> connection somehow de-autheticated (out of radio range or
> whatever) it crashed the kernel spectacularly. Eventually that was
> fixed and in-tree iwlwifi worked fine on 4.9.y and 4.14.y stable
> kernels. On second half of year 2020 (don't remember exactly when)
> iwlwifi started causing erratic behavior when some random process
> terminated, as if some exit processing left some resources
> un-freed or something weird like that.

So you bisected the stable kernel, and reported the problem so the
problem commit could be dealt with?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
