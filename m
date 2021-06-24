Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C2C3B344A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhFXRGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 13:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFXRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:06:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 10:04:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j2so7446992wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=reNOTaP2efg37V1x42Oean+Lk4w5ae2OM6AA/EosNCI=;
        b=tvq83KoEmz8ywg5WU0KwBvuX1MRUMsqkNoZjuP1rNt2eICFOkMxmv80okUT7MsNbFR
         BA85wHt+pW5N9B/JXkGsbQmoF12LrU5QdJGL6R4eUWZgkGmgtN/obioDiXopOX6N3v3R
         ydKhqv5HE2M0SVtnc87jIohIkF5DShUxrk2qzREt8mhT8pyfNwus3/h790t0fjtpevgh
         S6N+jzdBMZf0CSM/WgcobrpIEYdSIiLwWaeaZkFDyS8i7cPQy1T9d48sbmLQY/d0eLAa
         /Cwwu+P+BrqP4QxSuY/sPyxgb9XpZIeUCCtvNoi/m7eFt0lupBwmIWDIrDgA1ZngcqaM
         Kq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=reNOTaP2efg37V1x42Oean+Lk4w5ae2OM6AA/EosNCI=;
        b=bSENh0583InZi9spY1F48j0rkyL5cnH0YoJ4UttoAEWd62aR3WEvWeXGh1ZCLKv1M6
         TE0KNNnD+WfRQ+FzdbNjjEQ/FDlLz39Q+9Jz3LozY9Xhc3ORPiVmyzAMeTdWHMSi3faN
         fnxgig2R58FQoVGfDBhn0QQ2uGcNfXLqpJqsHiK147+BDFBTMDPrgoa5lE+7ZxELMuqw
         GCwGI1Mfgvp06bYoExX+Itg1vNbirv1BmAv99FCrz8H9kjJd3AfDJsEWbMFzm0bQABQb
         SWsr2yWT8UXECPHFkmUxVMgb91+g4NfRYBl46JPSDVw/uz7ySW108Hamzxzyo+Mz/6kK
         MQ2A==
X-Gm-Message-State: AOAM533bQVhVyt5D7oA7VwagcpsVA9w0HhR70PwuwML1KlErWNWBF55r
        CY4fGKOoE3YPbjGYYbL7W32/OX2KMTE3Rn96
X-Google-Smtp-Source: ABdhPJzLu44U1cdvbKio83wDqyvMaCULv9DYk6srisf1pIMN2AvaQkOPJePNjl8eAwyW7/pQ26HfpQ==
X-Received: by 2002:a05:6000:178c:: with SMTP id e12mr4997120wrg.140.1624554248732;
        Thu, 24 Jun 2021 10:04:08 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c52d:3cc5:c823:ade0? ([2a01:e34:ed2f:f020:c52d:3cc5:c823:ade0])
        by smtp.googlemail.com with ESMTPSA id 9sm9919512wmf.3.2021.06.24.10.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 10:04:07 -0700 (PDT)
Subject: Re: [PATCH 0/2] thermal: int340x: processor_thermal: Add new PCI MMIO
 based thermal driver
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210525204811.3793651-1-srinivas.pandruvada@linux.intel.com>
 <1244a17de6b1e48131d7cf23fc10b7e085cffc6f.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9253d77e-cede-f4eb-46ed-2cfe8d488dff@linaro.org>
Date:   Thu, 24 Jun 2021 19:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1244a17de6b1e48131d7cf23fc10b7e085cffc6f.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2021 18:19, Srinivas Pandruvada wrote:
> On Tue, 2021-05-25 at 13:48 -0700, Srinivas Pandruvada wrote:
>> This series adds a new thermal driver, which uses PCI MMIO for
>> temperature and trips. To reuse
>> the code the first patch just reorganizes the existing code.
>>
> Any comments on this series?

I've been through the series and it looks fine for me. Except a typo in
the log 'anabled' but I fixed it.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
