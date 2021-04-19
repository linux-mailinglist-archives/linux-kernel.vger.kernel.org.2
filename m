Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1070E364942
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbhDSRzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhDSRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:55:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AE1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Gpg37cvlNUMgLhfhroZl1NiOwZjHB+4OxYlq13ZJrJg=; b=QX7pEvmkb1sjPZOTLUFK+4Wc+y
        2ebvKMHggZF8U18gdY0LB4pUiveA9irbibMC0nU5zyWDPe0jQwgEShicv1UBgKN/uCl5LJCWQjZ/z
        19ikclN4b7Z+dqcDyMXsXw5Le9AaxzSs7r71YKyfadDt4qvZDuSF+31mczbUnH2a+ojonjb0lyoZd
        9JQlyjIdkW/0QT5vqGVv/lUEGWyHxaKOQPaNG1biKNQyi/5hRWwZurt8zgEOHZViTK1A8sCyqdD+9
        ecpBIvD0Pj1XpjuLdUNFs+7On834xSrTSvTksEN34y9bfL2HsdgmmTi7f1f5D0uHNteIABXHtBXBu
        HQ53Y81w==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYY6Y-00E5iM-Fi; Mon, 19 Apr 2021 17:54:43 +0000
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
Message-ID: <d295f001-575d-f14c-b0c1-1444dd29a03e@infradead.org>
Date:   Mon, 19 Apr 2021 10:54:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1627725d-1c7e-109f-f995-e761bb022ccc@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/21 10:10 AM, Randy Dunlap wrote:
> On 4/19/21 2:01 AM, Robert Foss wrote:
>> The DRM_SIL_SII8620 kconfig has a weak `imply` dependency
>> on EXTCON, which causes issues when sii8620 is built
>> as a builtin and EXTCON is built as a module.
>>
>> The symptoms are 'undefined reference' errors caused
>> by the symbols in EXTCON not being available
>> to the sii8620 driver.
>>
>> Fixes: 688838442147 ("drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL")
>> Signed-off-by: Robert Foss <robert.foss@linaro.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>>
>> LKP reported issue:
>> https://lore.kernel.org/lkml/202104040604.SSTe2Cxf-lkp@intel.com/
>>
>>
>> Changes since v1:
>>  - Fix typo on comment
>>
>> Changes since v2:
>>  - Randy: Changed from `depends` to `select` 
> 
> I don't know why my name is on that. I didn't
> suggest any change -- I just reported that v2
> had a problem.
> 
> 
>>
>>
>>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>> index 22a467abd3e9..70402da5cc70 100644
>> --- a/drivers/gpu/drm/bridge/Kconfig
>> +++ b/drivers/gpu/drm/bridge/Kconfig
>> @@ -169,7 +169,7 @@ config DRM_SIL_SII8620
>>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>>  	depends on OF
>>  	select DRM_KMS_HELPER
>> -	imply EXTCON
>> +	select EXTCON
>>  	depends on RC_CORE || !RC_CORE
>>  	help
>>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
> 
> 
> Thanks. Works For Me.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Actually I can upgrade that to:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


ta.
-- 
~Randy

