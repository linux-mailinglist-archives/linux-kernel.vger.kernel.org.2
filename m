Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F73E398AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFBNdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:33:37 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:46946 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFBNdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:33:07 -0400
Received: by mail-ej1-f52.google.com with SMTP id b9so3805145ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CmMKEjn5wAawQySc5ZWj7VIbRiSvzSHnPMe8fkp0pgw=;
        b=kAxAlm1SDECm+U40H38LsnsUnrYJO14WdtHq27vPyu2WTYmqehBdHDrnM4i2dVrtRp
         GawhKW8IWFOrqlcEVUxBbmL9F/agDS1sv8q7HZ+2hJkhz76rZvve91nV9kxYKrTp/sfv
         XRFmJA2DS1vwJ55grpA6mxEprRo+q4vB4fdEPQcZHj+6dpJDGFfNtrLe+MR5ouSvecq2
         nD7SzKSiT2bt3up2Qdw+YAuyN46/z6clv4YfaolSuECeo4chfScIPvSRhMQ233CzyC20
         Q61OmYhmKg4u5wyn/pYVnpbmNtzHUU3b7KjqCNPZtYE1u0VFITxMerKVzwAph2EuEzbk
         pkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CmMKEjn5wAawQySc5ZWj7VIbRiSvzSHnPMe8fkp0pgw=;
        b=Y3mL7lM5a4+bPmEo/ePkhAylLROQF0Z9qHtaynfa8U4VZC1L5ezXdRiPNitbC7zUw8
         EpFr9/n7I+EvJQlrPBxgfW7f53xZkPDp7KPO6WDZeg1ysAvUaCEs7HvpxCOpJnP/STM0
         4Um/GG00m9p3CcS4aUcepy2+XHoP4N74SL5lF0TgnpBTkFbh0OQC9a39I0L5ilyHbuDH
         eoemih5QGjP1+YqPquhLF/oGlQhUmJCYu5wPrhL7XjK3HUSyw98IUnmDMaeq3ECeZ5Up
         arvvPNZRsGxE8589rW+CSNRi3bkUw5nGnXzJspnIX/712Eux+yRtIGXA/lZ29VWCfRFI
         gCpQ==
X-Gm-Message-State: AOAM533kP3qp63NGyXF4J1KD10sEZ5I76t35LhDaDB0GBaxuSO4JXuZa
        b6wGA1iiYK74S7bP3R0l0P+mmQ==
X-Google-Smtp-Source: ABdhPJzg+epbXioL5/fO0o9gGBXzXyN7l/jPgr2tavbf7OQrtL0PJbH3WM8ENHvucWWNwIYcVXt8Hw==
X-Received: by 2002:a17:906:3818:: with SMTP id v24mr25708052ejc.197.1622640609750;
        Wed, 02 Jun 2021 06:30:09 -0700 (PDT)
Received: from [192.168.1.28] (hst-221-100.medicom.bg. [84.238.221.100])
        by smtp.googlemail.com with ESMTPSA id l8sm1352966eds.79.2021.06.02.06.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 06:30:09 -0700 (PDT)
Subject: Re: [PATCH 3/3] venus: Add a handling of QC10C compressed format
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
 <20210429105815.2790770-4-stanimir.varbanov@linaro.org>
 <37d5e58c-ce5b-07f8-396f-662258a9b229@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <f5df5da4-6904-8e9f-0bf0-0c18cde1cc8a@linaro.org>
Date:   Wed, 2 Jun 2021 16:30:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <37d5e58c-ce5b-07f8-396f-662258a9b229@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/21 1:01 PM, Hans Verkuil wrote:
> On 29/04/2021 12:58, Stanimir Varbanov wrote:
>> This adds QC10C compressed pixel format in the Venus driver, and
>> make it enumeratable from v4l2 clients.
> 
> enumeratable -> possible to discover
> 
> (or possibly 'enumerable', but I prefer the phrase suggested above)
> 
>>
>> Note: The QC10C format shouldn't be possible to enumerate by the
>> client if the decoded bitstream is not 10bits. This is not
> 
> 10bits -> 10-bits
> 
>> implemented in this patch yet.
> 
> Obvious question: will this be done in a later patch that is being
> prepared? Would it be better to wait until such a patch is available?
> 

Yes, It will be implemented in v2.

-- 
regards,
Stan
