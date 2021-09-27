Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3202419470
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhI0Ml7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:41:59 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33642 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234341AbhI0Ml6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=VHmnvYIAZmrSYdI15AbGglauUUWcdf2/62XeLUmuxd0=; b=BzVbVsqX8jfoLeyweDNgUxA71K
        vuy/+WcwPmEIKm2U+iFQIpmkKiBWIxDD2YHgoNUhmwb6YmENfV8Yy7or1ksHxwEMFvCm8HjZ/P2Pe
        vnD0AUgY8fYNtqRI9W3QJ9s2SnX6ZtjnS22Gyji39L5NrASnsg69JjYQdnGerJaijCdc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mUpvX-008R94-9T; Mon, 27 Sep 2021 14:40:11 +0200
Date:   Mon, 27 Sep 2021 14:40:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     soc@kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dove: mark 'putc' as inline
Message-ID: <YVG7q1L6iN+rkIwK@lunn.ch>
References: <20210927095343.1015422-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927095343.1015422-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:53:33AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This can cause a randconfig warning without the 'inline' flag
> that every other platform uses:
> 
> In file included from arch/arm/boot/compressed/misc.c:29:
> arch/arm/mach-dove/include/mach/uncompress.h:14:13: error: 'putc' defined but not used [-Werror=unused-function]
>    14 | static void putc(const char c)
>       |             ^~~~
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
