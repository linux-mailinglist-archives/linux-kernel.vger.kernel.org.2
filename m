Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8553F7A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240886AbhHYQba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhHYQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:31:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE483C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:30:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b9so10282583plx.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9o4/lhXj53HVrFMmmxcMuI8W2T6ZHUGbZ9ml9X67reY=;
        b=sh5Gvg4q+ulN5UDkn8pGbV4CnaIezY8BC8mMlcpUKqPGTelqOVw6emE5dGeOVJrzb0
         /CVdbkAYhxr10BEOafT3/z0TWLW8ph6en/aWvIi7YxNa3CmlJ4YSnM3h5r9V/mMtDnQ0
         SM9hM5LAUUk9MtlRByNYwSKuhiqkqtm2K1fk0sObChaorbEt3mxz0P5C9rPcexqmDUeU
         1xazzkDcHW/xXwBKSaSV+zLX/kIfBRe7B4kRa68cITXfPijDBNa89VI4hrs9UM5EipiZ
         xays/lpQl6fCK6ji+91qGf0mug3A7MMfPyyuVNieyJ3/mYhYX5rGOudY9eRhDEafpT8w
         7Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9o4/lhXj53HVrFMmmxcMuI8W2T6ZHUGbZ9ml9X67reY=;
        b=BTb7GQfjggO5zWHfqNGZi7pBp4luUzGCajkyHXwOJ4DHFZIKLAzsJlrbO5kD19+Wvh
         9uaEXcEZ5hVRqpdtyhXqj1XvMDfjqG2kGoF2j0IwDs4sQGWcuyumcISug+VhsHhLA+cC
         G4q2I43xCi/ncym2ENd+b4D0PtAuPPPPWIL3iSDbcuDbLXGDS9JG83jmd3tme9/EfNYC
         /OsgUp4mg3zsra6ZoeVnNdFI8IBxwdFu2C2FM5EcmPXiKn8h9JkWqeC4e88yMFg1/NzY
         KdJ83mVLI2M/AvRokklj3y3fj9oDYQHMykmjbCANj0HyV4L1oE5rdk9xYcEyljvsqhUe
         uCfw==
X-Gm-Message-State: AOAM5336pdGWcuttJGtNw0aR9RqybNWDtaEotD/ZDcb/oruakj51Qhc6
        k+bezY5gMHcnXAieuGjzR4g=
X-Google-Smtp-Source: ABdhPJxZPb01VRk4XggiJ4QiswyhS6P9lqlF0RCdEtfwwmGm3gT2DYGvSIPc4O4o6gbtb+74dPveLg==
X-Received: by 2002:a17:90a:9292:: with SMTP id n18mr11471481pjo.120.1629909042758;
        Wed, 25 Aug 2021 09:30:42 -0700 (PDT)
Received: from [10.230.31.46] ([192.19.223.252])
        by smtp.gmail.com with UTF8SMTPSA id n1sm493439pgt.63.2021.08.25.09.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:30:42 -0700 (PDT)
Message-ID: <c108fd89-2b72-33a2-d6b9-13a20773bbe2@gmail.com>
Date:   Wed, 25 Aug 2021 18:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v4 04/12] include: trace: Add new scmi_xfer_response_wait
 event
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-5-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210824135941.38656-5-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> Having a new step to trace SCMI stack while it waits for synchronous
> responses is useful to analyze system performance when changing waiting
> mode between polling and interrupt completion.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
