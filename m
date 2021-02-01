Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D4730B17E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBAUR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhBAURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:17:17 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2827C0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 12:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aK3vS4XWIKg20GCInUmdQbVB0NkYn+deg1AmYhOATD0=; b=SpI98f+GjEpUcBlyJ/DkBEn+d
        vMBGh5oOToZ9Xe3jZpLU3KhP4wb8IEQ5oxu5vJ8e42Lv8+Pq0SNMqquGrxq738oD2MOI7BpUL0b+m
        bSowVtKDULiEWA5pxlG/jGyqHfG/z6NHGjetI72OKtim6+MmFIOJNFReUbLKOgTFDynXxAh9P7Nb0
        n6sd5qRmjafqF/xAfiR/3SPtuFlvlIxjNlsamBJ1PBAc1zJgQa13IBrpPZZ1Seg3d3kioPsMa2Acq
        kwQPO9t/8GjVDUR2Ei2KEHwduNZ9pFtFYz+Sb74RQP4KJaNokNuKifYvJAV6MzEcvx94ILgAgZGRg
        qKuwz35TA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37918)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l6fcg-0003i5-Pj; Mon, 01 Feb 2021 20:16:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l6fcf-0002JA-K4; Mon, 01 Feb 2021 20:16:33 +0000
Date:   Mon, 1 Feb 2021 20:16:33 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Giancarlo Ferrari <giancarlo.ferrari89@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        penberg@kernel.org, geert@linux-m68k.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        rppt@kernel.org, giancarlo.ferrari@nokia.com
Subject: Re: [PATCH] ARM: kexec: Fix panic after TLB are invalidated
Message-ID: <20210201201633.GJ1463@shell.armlinux.org.uk>
References: <1612140296-12546-1-git-send-email-giancarlo.ferrari89@gmail.com>
 <20210201124720.GA66060@C02TD0UTHF1T.local>
 <20210201130344.GF1463@shell.armlinux.org.uk>
 <20210201135714.GB66060@C02TD0UTHF1T.local>
 <20210201160838.GH1463@shell.armlinux.org.uk>
 <20210201200734.GC15399@p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201200734.GC15399@p4>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:07:37PM +0000, Giancarlo Ferrari wrote:
> Hi,

Hi,

> Why we should align 3 ? For the fncpy I suppose.

Slightly arbitary really - it gives a nice 8-byte alignment to the data.
.align 2 would also be sufficient.

> I don't know now how to proceed now, as you (Mark and you) do completely
> the patch.

Please can you test my patch and let us know if it solves your problem
(or even if it works! I haven't tested it beyond build-testing.)

> You see is my first kernel patch submission :) .

Yay. Sorry for giving you a different patch - Mark is quite right that
there's a better solution to this problem, which is eliminating the
set_kernel_text_rw() call. The only reason I cooked up the patch was
doing that would be more in-depth (as you can see from the increased
size of the patch.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
