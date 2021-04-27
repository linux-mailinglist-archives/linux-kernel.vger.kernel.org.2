Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB836C1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhD0JjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 05:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhD0JjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:39:15 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709B9C061574;
        Tue, 27 Apr 2021 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=afn9nmNIxFRLwOFFN/FYrwOWDcs+ca/WH39CVLuFbjM=; b=yZ5ojcOkFduIjmE9ZnzvAvK0J
        H8uzQfiUMbyvjJaqtQxj50/4uIuE3eYJjaTNY0gIua3S+Aseml8cF0RFzNCz/ElR6ayWeIdGApqcH
        5N6YnIwFVzTNizm5GCsYTTM161K92GM2aw/X/hie0kGp4ssnVvC2bakszXr/GyRVXOThAXTg2rW5K
        jK1zlwy2T578+wPHBGEhqbgQeE1TtSUsOHpQ5z/VLlcXSO0BHGo2MLK5Gu8a1stOuXsYgFJTfGeBq
        QA3N/T326+vHVypbMKVMUNKc1/PDopDj4AWku1f4hUOzlbF783zCe7g7SdAyZR5gWGAMHYskNRfQL
        965B93FPQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52786)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lbKAU-00015G-1L; Tue, 27 Apr 2021 10:38:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lbKAT-0004WA-Op; Tue, 27 Apr 2021 10:38:09 +0100
Date:   Tue, 27 Apr 2021 10:38:09 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: <linux/clk.h>: correct clk_get_parent()
 documentation
Message-ID: <20210427093809.GU1463@shell.armlinux.org.uk>
References: <20210427031342.5333-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427031342.5333-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 08:13:42PM -0700, Randy Dunlap wrote:
> Make the kernel-doc return value agree with both the stub implementation
> in <linux/clk.h> and the non-stub function in drivers/clk/clk.c.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-clk@vger.kernel.org
> ---
> There are several drivers that call clk_get_parent() and use its
> return value as though it returns an ERR_PTR(). I am working on a
> patch series to fix those.

The whole premise of the CLK API is that:

- clk values that IS_ERR() returns true are errors
- clk values that IS_ERR() returns false are valid

and that is that - nice, simple, easy to understand. So the
documentation is correct. If clk_get_parent() needs to return an
error, it does so by returning an error-pointer, not by returning
NULL.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
