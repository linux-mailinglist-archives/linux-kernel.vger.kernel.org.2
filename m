Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7EA3440D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhCVMWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhCVMWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:22:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6334C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:22:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g25so9390999wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ikIZSwyf4jRr16q+og8b4DfODlnWJVLR/fPpQRhS4KQ=;
        b=O34dCGzPMCGQPZRNT1XEP8AO5LwgGIchiopo1V4qKN6VhfxijjD67aZbOl23wZnujm
         upU1BxY/UXuPwfad1CGslT+WD3uCOAcKGsWsllTE9lwal+NHGQNu0SNV+aV74op5jBZb
         kGGFP2miV0omhYZ9BO5H5JnDYD8EGwvFKtoXJ9EvOMcFAIdlQYqw1WiIk5nHZYNduz0i
         2ZWBancYTN95QNyZkUZofcQb4ECB6Z4PNMEilALlXNUSrpHfRuPTHoGaF9qIQwXHPngw
         q+16ILZ7AQc4MXq7N8RRgddC54tTrazIfEquIoqfhFb87OJghFsT1VpcI8Ln8OF0fe/p
         pG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ikIZSwyf4jRr16q+og8b4DfODlnWJVLR/fPpQRhS4KQ=;
        b=PmwyxkQ2IvuS70u0RbgHfRW3ZvYfqarGYo7SJz5VZE8Opq8yjJ4BPGwuAa6MPIYp0W
         2bUhpj0IxtyZPMRLXwv1djcIaDi0jxF+S7izRe1fvROawtsctevvBNLF93cMoZ4YKp/t
         jmui8R+yUc+m/APjF3Dl7YvWZjJU8BAsfiN5EKAihCbhIYiDgOKm/kaHL967s/avxIKz
         dHPDlwnEaKhKFchDQpX5y9JXkY3rxQd4pLO7TH4sOwk9/enWYZ/kGdDJtcKoiK9EYZQi
         JMrE2mnfFF8awH7KMkPjGVHtPqevzCaQwEyyUCJtO7Z0viOh28bMzL1O19HV7j68UdzZ
         pT7g==
X-Gm-Message-State: AOAM530yqs8rGYdktAGwdSpRzc9RkaZn2aaKWs9jxsl78Hlmb5yGhXOk
        KK/ZmAvNfQdiLSjDwZAqbFoaYP4NHp97Vg==
X-Google-Smtp-Source: ABdhPJyyhUL/t48IjIWRAItGEB4Mbx+avaMfeXyGzb8Y2ow9IoKsa+vD4OefK+vG25yaKgdqniu21A==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr16000412wmm.27.1616415733441;
        Mon, 22 Mar 2021 05:22:13 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d8b:d5f9:2138:169c? ([2a01:e34:ed2f:f020:d8b:d5f9:2138:169c])
        by smtp.googlemail.com with ESMTPSA id h20sm16182883wmm.19.2021.03.22.05.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 05:22:12 -0700 (PDT)
Subject: Re: drivers/clocksource/dw_apb_timer_of.c:66
 timer_get_base_and_rate() warn: 'timer_clk' not released on lines: 64.
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <20210222062151.GL2087@kadam>
 <abe304b5-bd65-d8d1-509a-b1a58ffc9816@linaro.org>
 <644a72b7-72de-8286-a977-b46aae36dc72@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b750f895-6424-18f5-b054-698cf4f0914f@linaro.org>
Date:   Mon, 22 Mar 2021 13:22:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <644a72b7-72de-8286-a977-b46aae36dc72@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2021 13:21, Dinh Nguyen wrote:
> Hi Daniel,
> 
> 2/21 4:58 AM, Daniel Lezcano wrote:
>>
>> Dinh,
>>
>> is it possible to have a look at this issue?
>>
>> Thanks
>>
> 
> Sorry, but somehow I missed cc'ing you when I first sent the patch.
> 
> I've resent it just now.

Ah, thanks!

 -- D.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
