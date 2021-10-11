Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB40428613
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 06:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhJKEzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 00:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhJKEzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 00:55:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248CBC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 21:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=P0t0Nb7/BEiZE2BJv/szrltUJNee38UN+mVCx+ibybY=; b=4C41MIj8XdOsV8runiNljiQhOZ
        2wKUIxrqYY4QwscCaTOXCgS90y3fHcEWv4G6k9mi+2Km2vp3lF31Z4mDExrgT5HiX6OdsF1TGh8vR
        XoeTJKFLgHR3d91/5s2GiNRR9gl82uTvOsiuHBtG6ggnzVq8f0QQst6VnC+WPDpYwF6H4lJI43TQW
        qxzHhxFKh/LdaqiYRnNtz4C3xuucR43oRXQDN5Dltv3kwuyfn8B2G6Gqmt5BLD1p3GfxfpL7FnBQx
        16bp12OWwlT4IlYU31qn+vjRIq+GBeeZctkTNLRypWX1IpMjFaRxqXv4rNpKszay+5aegmHBs6D50
        ydR7hCkg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZnJ6-007gXb-P8; Mon, 11 Oct 2021 04:53:00 +0000
Subject: Re: [RFC PATCH 3/4] driver: hwpf: Add Kconfig/Makefile to build
 hardware prefetch driver
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20211011043952.995856-1-tarumizu.kohei@fujitsu.com>
 <20211011043952.995856-4-tarumizu.kohei@fujitsu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <700a5781-26ac-bf75-19e3-67ef56e159a5@infradead.org>
Date:   Sun, 10 Oct 2021 21:52:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011043952.995856-4-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/21 9:39 PM, Kohei Tarumizu wrote:
> diff --git a/drivers/hwpf/Kconfig b/drivers/hwpf/Kconfig
> new file mode 100644
> index 000000000..24528ca85
> --- /dev/null
> +++ b/drivers/hwpf/Kconfig
> @@ -0,0 +1,24 @@
> +config ARCH_HAS_HARDWARE_PREFETCH
> +	bool
> +
> +menuconfig HARDWARE_PREFETCH
> +	bool "Hardware Prefetch Control"
> +	depends on ARCH_HAS_HARDWARE_PREFETCH
> +	default y
> +	help
> +	  Hardware Prefetch Control Driver
> +
> +	  This driver allows you to control the Hardware Prefetch mechanism.
> +	  If the hardware supports the mechanism, it provides a sysfs interface
> +	  for changeing the feature's enablement, prefetch distance and strongness.

	      changing


-- 
~Randy
