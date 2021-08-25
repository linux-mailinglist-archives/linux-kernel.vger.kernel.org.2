Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69DD3F7AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbhHYQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbhHYQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:36:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28E2C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:36:02 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so4555046pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s0+rp6z8jjdTqo4OKBccDTvotE55xCOyRdUmD8Bu+cQ=;
        b=rYs6bh7bv5koZN8J82jP9WVRvIlne+GWZHC+cZU0bRJIS9WlNfu8fOghNHGFo1PY/M
         Fzx2jd9Tpwtpgwq5mGtElwxY4rwDL+TkxqPps4ZTz0Ka0LXC/A7rnJNeHWVSET75ydgR
         nFtFAPvOj5YpVkheSZHleWTE25ZHRBmoA5Xigjsim4vob1Qruhgj1uQvo5u+Iki2xxyZ
         g39iGh2yKcbFTmIrtuF1/pLQofIVb3dxzPnhK5Ct9AmIiK44QmnCwm/OkONRf2oBDCh5
         LDuh6hVC43TYCHrns6nrQShGasVdFoTID5DXFQtEzEZBvV1A/bgqRUMlxAFLWSEOiR5u
         r67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s0+rp6z8jjdTqo4OKBccDTvotE55xCOyRdUmD8Bu+cQ=;
        b=HbL8L/ETyfznSd7YxxKw776Jlrmc5Rzz3CIQ8Owh52s6KMjYSiqQjwNb+u5B7VwYZA
         mBxSgJlx2Egqkr8GRbign3xCbv9OPpykAW36B4pyEwlWhphDNJxcEKcIcaljaj9KB3nf
         DG+anH+VZozvMHbNFdsFdLSPOOZCbMfV0rBp6AojZyzkb9ivyB6x0S60w6rizGkHIAI6
         nYPy6RzU+PYdDW8PnQRjHBNUq6sZ7tjuGY2HuuD/tV+wYbDR9hj8QmJmPGHVqtJC9ZXE
         9VI82ttuIenfOaAfxaNQFZreirjWuXSTTzyj1AcgYYMk0UbOf22f2cmSKZehGC6Rw3AW
         uqxg==
X-Gm-Message-State: AOAM532/hzGZvYxkosMO2JSpEdDeF6/SK5fSyzUKpOfnKkO2LaZFRiEJ
        b3aIMEcxcM/x01J1ePVruiE=
X-Google-Smtp-Source: ABdhPJwO73c4UIf9guuRJP8EgIXTHhZdRkzloa4IO/hbo9fUI4Z6oteJ0Gc1Phb0xp0Prv06vmVZbw==
X-Received: by 2002:a17:902:7d90:b0:134:d977:22de with SMTP id a16-20020a1709027d9000b00134d97722demr13681037plm.30.1629909362414;
        Wed, 25 Aug 2021 09:36:02 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with UTF8SMTPSA id r22sm2894463pjp.7.2021.08.25.09.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:36:01 -0700 (PDT)
Message-ID: <2f03630a-0339-1eb6-9b26-170927c4ad86@gmail.com>
Date:   Wed, 25 Aug 2021 18:35:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v4 09/12] [RFC] firmware: arm_scmi: Make smc transport use
 common completions
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-10-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210824135941.38656-10-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> When a completion irq is available use it and delegate command completion
> handling to the core SCMI completion mechanism.
> 
> If no completion irq is available revert to polling, using the core common
> polling machinery.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
