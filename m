Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE24433F67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 21:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhJSTrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSTrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 15:47:05 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39510C06161C;
        Tue, 19 Oct 2021 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ikxZZf5qplCBT+zQNa/Q3/V1ehE/BtQKefk6PvgVhMI=; b=Xpz1VDBO13VAz0YldOrMMO+3C9
        G3dnSCDwHIM98RYiz37ambGdNlG/vGfX8efOKBnMQzqXWktS3F9f2zNTePCuC/x7ZBofHbLyWWzII
        4XWJwmEKaSbzxNtk6uwmTBjA0WgWUhpispL3FuvyBYf5vvCpDE34UZU7tKE9ZWHmrQ6X/OVcSQZda
        P0cjI8Arj3PR+XBV47pDJVFdeKPGb7P8y3MLJ1mueVME0ArSY4+kVp6EyMO5vNQytMo7TauWCZwjl
        txjZLIyE4rB/W98cknDsGr6TVqsU+uwdt0G/+9p0lpEXsUAAMP4VWQeu/OtgHwJqA3mAA8aK7Gnwi
        8g793Wgw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcv2W-002XOP-Dm; Tue, 19 Oct 2021 19:44:48 +0000
Subject: Re: [v4] ASoC: max98520: add max98520 audio amplifier driver
To:     George Song <george.song@maximintegrated.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, george.song@analog.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com
References: <20211019084914.14622-1-george.song@maximintegrated.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c6d2ea5-e138-960b-bb83-fadf5c2996f7@infradead.org>
Date:   Tue, 19 Oct 2021 12:44:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019084914.14622-1-george.song@maximintegrated.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/21 1:49 AM, George Song wrote:
> +config SND_SOC_MAX98520
> +	tristate "Maxim Integrated MAX98520 Speaker Amplifier"
> +	depends on I2C
> +	help
> +	  Enable support for Maxim Integrated MAX98520 audio
> +	  amplifier, which implements a tripler charge pump

                                         ^^^^^^^ correct or typo?

> +	  based boost converter and support sample rates of

	                            supports

> +	  8KHz to 192KHz.


-- 
~Randy
