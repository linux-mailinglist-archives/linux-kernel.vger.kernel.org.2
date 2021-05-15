Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A3038162C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 07:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhEOFgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 01:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhEOFgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 01:36:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C46C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=7Ru1fewOZoxv7rNfLocXp+aXHVSyGJy/85o672PXY7Q=; b=v6Ig97OVffr2x2DZ6kbnmGC83R
        c3vgQ+qgmL5V31F3Habt1nLANo9Nij0HI5DmEBFFhczSkZw8y9O5VwUcymbhUaCaJsIcU9MGj5XBd
        xJdnLQuF3fWNDI9C8/mm+yBzOqN4xFmA5Ocw/Sq6Y3bo2/Ux8tcMmUmkC8U527kldJvmHpMdPz96d
        nct2Tu6EufhqqEvSUJzOuQU+v01XalOaZE1XFqr0we7sdMVuhjP1LzGR/qE+rdu8N5XDGXR/4ronH
        ELDSOypK6H0OI7G3g6fcHNqdoRKNt/fjIANaJqUlcqfDhyWTDIxmN33teIMbSdHpX89BZ9M1nDhjc
        2DDtFEmA==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhmwu-00COk6-H8; Sat, 15 May 2021 05:34:52 +0000
Subject: Re: [PATCH v3] drm/bridge/sii8620: fix dependency on extcon
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Robert Foss <robert.foss@linaro.org>, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, cw00.choi@samsung.com, m.purski@samsung.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kernel test robot <lkp@intel.com>
References: <20210419090124.153560-1-robert.foss@linaro.org>
 <1627725d-1c7e-109f-f995-e761bb022ccc@infradead.org>
 <d295f001-575d-f14c-b0c1-1444dd29a03e@infradead.org>
Message-ID: <75b35f2f-72bb-522a-afd8-6c26cd553588@infradead.org>
Date:   Fri, 14 May 2021 22:34:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <d295f001-575d-f14c-b0c1-1444dd29a03e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 10:54 AM, Randy Dunlap wrote:
> On 4/19/21 10:10 AM, Randy Dunlap wrote:
>> On 4/19/21 2:01 AM, Robert Foss wrote:
>>> The DRM_SIL_SII8620 kconfig has a weak `imply` dependency
>>> on EXTCON, which causes issues when sii8620 is built
>>> as a builtin and EXTCON is built as a module.
>>>
>>> The symptoms are 'undefined reference' errors caused
>>> by the symbols in EXTCON not being available
>>> to the sii8620 driver.
>>>
>>> Fixes: 688838442147 ("drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL")
>>> Signed-off-by: Robert Foss <robert.foss@linaro.org>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> ---
>>>
>>> LKP reported issue:
>>> https://lore.kernel.org/lkml/202104040604.SSTe2Cxf-lkp@intel.com/
>>>
>>>
>>> Changes since v1:
>>>  - Fix typo on comment
>>>
>>> Changes since v2:
>>>  - Randy: Changed from `depends` to `select` 
>>
>> I don't know why my name is on that. I didn't
>> suggest any change -- I just reported that v2
>> had a problem.
>>
>>
>>>
>>>
>>>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>> index 22a467abd3e9..70402da5cc70 100644
>>> --- a/drivers/gpu/drm/bridge/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/Kconfig
>>> @@ -169,7 +169,7 @@ config DRM_SIL_SII8620
>>>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>>>  	depends on OF
>>>  	select DRM_KMS_HELPER
>>> -	imply EXTCON
>>> +	select EXTCON
>>>  	depends on RC_CORE || !RC_CORE
>>>  	help
>>>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
>>
>>
>> Thanks. Works For Me.
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> Actually I can upgrade that to:
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Hi,
Is anyone merging this patch?

thanks.
-- 
~Randy

