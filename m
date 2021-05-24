Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39FE38F552
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhEXWF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhEXWFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB897C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=X6QjIgCjSkktmUC8r8lDQ/1sPXjmihqtCFFRU2jTnac=; b=Lx2PDy06QjselzfFWDsq/EVfft
        x7xy6UMcphs7tBH5S0kQ3X3To4LRE6q2guURkBVqBe7CMtJmDrlzvLDrnc/RFPR1V2rZnH1yNhdNk
        phOe/0Al+TCCkan2k46/qY9TQTVYpp1/cfevIBzT0BNEX7gpamJJC+6FuHCDaTgFYjfCD71TvFdHD
        1MKMluMgo5+ElUW9+UI/DSIe1rsMY0GGQdrXCyOrko8n2on1jSQGu1RIFgAFIX1RumDEUVntqBSti
        E/YnHHFix0a5ABs+7051Y0fFGXiAxXUYUbPjgn5UErvGSffI6pcWe1vo5i07OtExjWU9foeGegNFe
        piH/5QgQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llIgQ-0022fR-DD; Mon, 24 May 2021 22:04:22 +0000
Subject: Re: [PATCH] lib/math/rational.c: Fix divide by zero
To:     Daniel Latypov <dlatypov@google.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Trent Piepho <tpiepho@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        oskar@scara.com, Yiyuan Guo <yguoaz@gmail.com>
References: <20210523001806.3927609-1-tpiepho@gmail.com>
 <YKuFPeH0sIFqrBt6@smile.fi.intel.com>
 <CAGS_qxoKTyNBxoezkEVVrACGsFuzJwteepVpDzp+4KH+CgbMsw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b5511f68-814b-1f8c-08d2-a7dbddce4e8d@infradead.org>
Date:   Mon, 24 May 2021 15:04:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAGS_qxoKTyNBxoezkEVVrACGsFuzJwteepVpDzp+4KH+CgbMsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 9:55 AM, Daniel Latypov wrote:
> diff --git a/lib/math/Kconfig b/lib/math/Kconfig
> index f19bc9734fa7..20460b567493 100644
> --- a/lib/math/Kconfig
> +++ b/lib/math/Kconfig
> @@ -15,3 +15,14 @@ config PRIME_NUMBERS
> 
>  config RATIONAL
>         bool
> +
> +config RATIONAL_KUNIT_TEST
> +       tristate "KUnit test for rational number support" if !KUNIT_ALL_TESTS
> +       # depends on KUNIT && RATIONAL  # this is how it should work, but
> +       depends on KUNIT
> +       select RATIONAL # I don't grok kconfig enough to know why this

Only to set the symbol CONFIG_RATIONAL.
Then when 'make' descends into the lib/math/ subdir and looks at its Makefile,
it will decide to build the binary rational.o.

obj-$(CONFIG_RATIONAL)		+= rational.o


> is necessary
> +       default KUNIT_ALL_TESTS
> +       help
> +               This builds unit tests for the rational number support.
> +
> +               If unsure, say N.


-- 
~Randy

