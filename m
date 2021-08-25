Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E085A3F7A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhHYQ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhHYQ3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:29:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D827C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:28:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j1so175385pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=msG8GEqXO6botd24sEhmeMAsEWWJElu/gzrYBnFNGJY=;
        b=XiA3Fr4CzgyAUIS1P1KNXiyEs3I2mFNlEfCaflNW3grig51wBvKIBf6ZSqZ0/IapQ7
         0mXPzYs/Eo6tK6eDiucPNINHs/6pVbeiTLTl0X9GPCoGCZNREz3GSO0kW/qMeGhD4NJw
         gM6zQC+4pnlz/OLPIDvdjglLokhlCl/AJOMOI3yEY9F0eldkwWSG0Yr8PcH+xT5iCEG7
         NkdvkJTZ9di3VCHs1x55iMGf1mg/LyirzyFb+/PTIhiQfcG6UL5GxRwIMz6w1lW2uMo/
         4bKbNXTbtn3UAgEXKJRdD96vlwtgNAs9crEoLpBDuMsINfsPqlt3t6GQG0r9eam5gzWj
         09Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=msG8GEqXO6botd24sEhmeMAsEWWJElu/gzrYBnFNGJY=;
        b=fzO+Q5yvs5tn+M0GSYwc8GNLJCK/4RzkM6pvz63JUtn7M0UutZseS3zHfhZRBVN51s
         ui2cw+pEyGtUn5/+uTysb7++1WXpnX0DhGOiwXyfc2RmEq1YtoCQWhZlHQW/pNd3dRkH
         C288R49LmyMo6dHA8bmw0HJaWy65TgpHKjmri3sjWqV20514f2AOsF1oW9omwJ+WA01d
         ZPY2q8jPUiGACXGd1argu1R/uXO8dot0rtujtB/j1J1WakYlEQbn7LafUOZixlBbk9MV
         a1aeH8flqZ5yocwR7CtsKaF4hr7HAkUQ5HrWo3fCj/nrH6KmiYvU9/jsfARs1mQxFKPn
         3M6Q==
X-Gm-Message-State: AOAM532ZyEe1rsantYDwergL5KxII9w5iFzrdmk6CHG43TvsF5MOrX9r
        rjsOMkkkdWdtLTdPGFbndRQ=
X-Google-Smtp-Source: ABdhPJzczKOrK6z7TiC3cmttuYWtALCjvCq4pWxfvOXaZS8qNdAvp44pw2RgUumLtAiaoZ/EnZ86qQ==
X-Received: by 2002:a17:90b:120a:: with SMTP id gl10mr1939629pjb.234.1629908903748;
        Wed, 25 Aug 2021 09:28:23 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with UTF8SMTPSA id x16sm496482pgc.49.2021.08.25.09.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:28:23 -0700 (PDT)
Message-ID: <6344d757-7ef5-f6af-5f27-9c88f5befcbf@gmail.com>
Date:   Wed, 25 Aug 2021 18:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v4 01/12] firmware: arm_scmi: Perform earlier cinfo lookup
 call in do_xfer
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-2-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210824135941.38656-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> Lookup cinfo data early in do_xfer so as to avoid any further init work
> on xfer structure in case of error.
> 
> No functional change.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
