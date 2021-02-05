Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3443310185
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhBEATY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhBEATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:19:18 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946C0C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3qiwTtiRexNU06q9SlH9uc4782jDzsHVPuIDd7Pu/Gc=; b=t/MouobXLK03vbm6TokVYmHCr
        DyN93cPvDOsTnuVgFGtJW2obPq6+Ym6CxVCKzguqWcvpbrf4Glsn+7iXeWe3uO3fzFJ3P+j+K1k+1
        61PMIo3XpFqOaQa7NX30VSOhtOEQmh53ru+rsQ0MiiLgbq02i7/uZdt+YcTaK/NuVEtAmgo29kS7s
        Te7mlDF2BqmEOX+4U63KIEsuvP7bgTNBnjfo2q5KVvVR2aOVyBHIMVCkWiSP18zP+pO27U4YvAXH9
        dUXqkUwSQXqlL0bqEJ5tLOuZB3VTjgiBksmYtlvw1soOFW0ARQXrVYVSoe+hxsygMA9X2t6Qduiwv
        CBiOD/WhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39302)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7opW-0007CJ-Gr; Fri, 05 Feb 2021 00:18:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7opV-0005eC-7k; Fri, 05 Feb 2021 00:18:33 +0000
Date:   Fri, 5 Feb 2021 00:18:33 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        penberg@kernel.org, geert@linux-m68k.org, rppt@kernel.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210205001833.GE1463@shell.armlinux.org.uk>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
 <20210201160838.GH1463@shell.armlinux.org.uk>
 <20210201200734.GC15399@p4>
 <20210201201633.GJ1463@shell.armlinux.org.uk>
 <20210201202742.GA17243@p4>
 <20210204234841.GA19339@p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204234841.GA19339@p4>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:48:42PM +0000, Giancarlo Ferrari wrote:
> Can I ask about having it integrated ?

Thanks for testing. Are you willing for me to add:

Tested-by: Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>

to the commit log?

I can move it into the fixes branch which I want to send to Linus by
Saturday at the very latest.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
