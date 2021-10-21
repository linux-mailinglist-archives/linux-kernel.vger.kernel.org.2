Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3DC436663
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhJUPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJUPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:38:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30CAC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:35:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so153082wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cRpGK/g49wxUwOFNFNgC1ZpXjc7zVeRaaLHFmakaj88=;
        b=W94qybwxYPxtDxHiuP9gh7wyoSMVyCjlahEoNHUkbqsWm2tMOZgeGwngLOp+QrI+NF
         kGqBklujx44Q4mkzUzqy7/II27WAmY+zch/dx+cAqUVuIf0olBqJNlo3JG9dduuUlb3n
         6RksA6tfJycp2jz1M1h54iSy3llxdieAkyHuqKx4I2sV48Dh9TXjcIeYmUxEKw/co/Il
         O4G8pYn/zArV1KAB13DWa93Asy/75VRxn5EXqheKJ+6LZOqCEfSX3SuMGekH+dGljVXe
         XziB9Jv736gtq+0zpqENqkKbrz/nnAzoH6h5LstpjKb7o2ayEAefOmeUnpJtER5/pV8l
         mcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cRpGK/g49wxUwOFNFNgC1ZpXjc7zVeRaaLHFmakaj88=;
        b=CiLzRDZ6RybIVMs5HGVU4SQQ427kcM4e2HDJd+nE+c7qrwsvDHS95URXb4RdYa3HGY
         c+5zeSs5KSgnuZkxkj5VmBvugtO0VsAan3ANoLiZ93KubDnkGbfbyYHCur4uvb7C5Asx
         VNxYmujVU0opSgrmTQGLwrxBwytOQmraKvaXqWX2ZYfO1Fvtki825oIUAtOoBhRd1KuR
         LNap0bFnIDxlDPmREN1u000+0s/EsBPcf3zFnFv2Rj4JlxBBVKGk2BsKn++Gi8ywFBqi
         TYHLtEkLVQIK9d9CzeF7H27srnVhTQV9FCRX6pXqqAkLZERtVhDQ28l53wbX7yNCeULf
         OXZA==
X-Gm-Message-State: AOAM533sivGDPp+BNDBorFfVzCHbE+Nbe4N6HP8HRrd315I/JtpQ9Shg
        FDHKQFf8g8vgw5ZGltFFJE2nRHH2A2ued0QK
X-Google-Smtp-Source: ABdhPJy3AUkdmWTo1rqIT3WvF9MkIasrd9aA5kpDPlr48ELb0jtDtWR2JY9fEa7BhBOJx7MUhUVO6A==
X-Received: by 2002:adf:bb88:: with SMTP id q8mr8178064wrg.390.1634830550013;
        Thu, 21 Oct 2021 08:35:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4116:c86c:e3ac:c3c0? ([2a01:e34:ed2f:f020:4116:c86c:e3ac:c3c0])
        by smtp.googlemail.com with ESMTPSA id k17sm9376830wmj.0.2021.10.21.08.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:35:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] thermal/core: Make the userspace governor
 deprecated
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20211019163506.2831454-1-daniel.lezcano@linaro.org>
 <6372f16d-7d2d-cb1e-be86-23b21b41816b@linaro.org>
 <942b9998-9858-7776-97b7-b5ac1c637a2e@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <85afffa8-ec50-1278-74ed-9baf5aa642d6@linaro.org>
Date:   Thu, 21 Oct 2021 17:35:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <942b9998-9858-7776-97b7-b5ac1c637a2e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2021 17:30, Lukasz Luba wrote:


[ ... ]

>>
> 
> 
> You can add:
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 

Thanks Lukasz


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
