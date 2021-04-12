Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0FA35C802
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbhDLN4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbhDLN4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:56:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6D0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:55:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w3so20444360ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CHE3PEKmt4PiYb+8QucOok1H1iAClDgNrdUbB5VajiU=;
        b=Y1IBVfNnkpqfWHMc9n+xO7iRonUwPUxYkDvVp/GdMcKNdsY6xsX4RkediQ+glSWwu4
         J1eSFCpPi16FdZGI9QnJG4yuXnCfdvg6oLhT2ZvlrmrRqVIP6YxNBX6uWE6zT8VxezqI
         7KgZMSwOpZBHYXYYBp/AqRnbV9vkfUudvOX7ZcVXUcLR9WpUnbLmaP/gzdQTEgbZwkyt
         OO3DkTHbjBoDB4uewLLCS7C6NglKjPJNcwYFPUAmYJE8rzaRoIJvKTE2naR5A++eC7r3
         hNpeXrHvGwTAHgOJPRV5GoN8p83v7s7kuR4JYBhk1/poI1Szgi7yP3KbTAQ5o3Otfzeu
         cDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CHE3PEKmt4PiYb+8QucOok1H1iAClDgNrdUbB5VajiU=;
        b=MZcOlVMB+BVcy4p6/bPpqPySE38TKpuRqbzjuBT/RKJdTKVEOEHE/5TPi3O3y41+x+
         agRxmHeZchbD2vnJj2D7CZ13daIehmGwnJQFUJe+MkHcx5XTikBpnmuElKZHusiRcBZi
         VbadRNClHErN92iXNSJ4DDrb/XCyD8uk59xWC6N6yk64EuryDQI/7WRQSMdAVHLuv4Wf
         qE6sjLerjPf4LDD+nOlwXBsIYbHuhqXucN8orr019jVC2T59JBb0QgRY9ia+PTv2Megb
         sa2pPoro/KMJmzWLGIvAEKey3kCjvl/Gz+oN6/OmmyPUmfbkXSwsbOxhA+Ihlt9hlq/i
         YVkw==
X-Gm-Message-State: AOAM533okp2SpvlevuJ1wDBERHBqzgGdMgTaHBjSOllAWWwM7kbQB/Cs
        d5wqoK8DWK/cR3+d3GnfU5IbbNhx0JaZXQ==
X-Google-Smtp-Source: ABdhPJwV+A9Rln/7A8ARvKJL0fEz1anXCCSJrnljNI82mFk155ylDOFnoef3CfGrqt9BlsWx4AmhNQ==
X-Received: by 2002:a17:906:9a81:: with SMTP id ag1mr18018154ejc.464.1618235752397;
        Mon, 12 Apr 2021 06:55:52 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id q16sm5867591ejd.15.2021.04.12.06.55.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 06:55:51 -0700 (PDT)
Subject: Re: [PATCH 4/5] ASoC: lpass: use the clock provider API
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210410111356.467340-1-jbrunet@baylibre.com>
 <20210410111356.467340-5-jbrunet@baylibre.com>
 <0c8c3b5d-891a-9bfa-3bbc-4982542df38a@linaro.org>
 <1jmtu38znu.fsf@starbuckisacylon.baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9d56c9ea-a64a-2939-1bce-dcd40ca16b40@linaro.org>
Date:   Mon, 12 Apr 2021 14:55:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1jmtu38znu.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2021 13:17, Jerome Brunet wrote:
>>>    -	return of_clk_add_provider(np, of_clk_src_simple_get, va->hw.clk);
>>> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &va->hw);
>> Now that we convert this to devm, You missed error path and driver remove
>> where we delete clk provider. This should be removed as well as part of
>> this patch.
> Indeed. I should not have switched to devm here - It was not really the
> purpose of the patch. Habits I guess.
> 
> Do you prefer I stick with devm (with the suggested fix) or revert to the
> no-devm way for the v2 ? It makes no difference to me TBH.

devm should be good.

--srini
> 
