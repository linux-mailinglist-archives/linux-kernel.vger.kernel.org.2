Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4283395994
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhEaLVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhEaLVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:21:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC25C061763
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:19:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x8so10522883wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oUs1Ch1W6XuZQWHxuWCfWzh2D1v+wPWvtS2pC3Cph6A=;
        b=BKpTdykIchu0BdLJbPIdTBG6OPJWQ2NWxJJ2DgJrdAckZRlbfrgLtz/6OMc85nIjvp
         AF4mYrsSkzmCfALsXQP8dXGV+qP5M+l5PfiroKiH2S3p0g8POSXvnd7gn7Gx6rMpmFnQ
         G/GRUb1xk628c7JS5WTxh5Eec8eGO2IE9anVEiCI/TtT+JnRvx7hv39c+qsnvTWOb6f3
         3NI5Hw7oItV7eNbZ8w4QbvdCDXHwmHFTf3WkE/xKWTTOSyXhpVw63bwBPkPHeHUm2b72
         tcnLGyJ4P5YCigsik3A6O1BIsZMSyvBwO1/dxCco3c9U6uG0W+Dv1jUioYOwlFD7p+M7
         qtsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oUs1Ch1W6XuZQWHxuWCfWzh2D1v+wPWvtS2pC3Cph6A=;
        b=t9819G+7c2ZxVue89ry9YNro9mj6fXbvg5vREr82zOHoE5tr7aOGiMAWdb49s5W6AI
         8TtLZ25hCAQwBKDP1AqlRCnU7yI143H9lwcwHk9IaOyKpRnCKhUdZFrRApLen1TWTLGj
         ZFoNStfU2AvYF9bU34yWQqv8FyMIMX49+irvLivtco7mPbM5iUK1Ua2LhJ8rqW5D6qPs
         xnq3vpG/HRHBYQZF2AnL6QSZZMHrhFYyh7d2LKpKIrx1L90P7+OEQY7VaeePdDMbvuNG
         CXkS9qdPwbu7GCjf0+NnzMFdWfte2UgSiRrIYtIQR5ufAnmdU+M+5C2iQinJKAInI2Ij
         hdCA==
X-Gm-Message-State: AOAM532nIxfukabcV2Xx83XD9/cWTX0UjBeDgd+FfW57GzW0x8KgtGQn
        nTdJZb/f6ais0xOBj37SeHExPA==
X-Google-Smtp-Source: ABdhPJxAcE+HR6VWeHGocdXFdWS/JOouoXaV3UQ+Jkgsf/qphTpZhEYdJ9smPocSSlZVzrwnF7CpcA==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr22103935wri.260.1622459995349;
        Mon, 31 May 2021 04:19:55 -0700 (PDT)
Received: from [192.168.1.28] (hst-221-6.medicom.bg. [84.238.221.6])
        by smtp.googlemail.com with ESMTPSA id d9sm16708458wrx.11.2021.05.31.04.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 04:19:55 -0700 (PDT)
Subject: Re: [PATCH 4/7] media: venus: hfi: Skip AON register programming for
 V6 1pipe
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
References: <1621417008-6117-1-git-send-email-dikshita@codeaurora.org>
 <1621417008-6117-5-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <48d9044c-aa5f-db63-ebf8-df05714cb2bc@linaro.org>
Date:   Mon, 31 May 2021 14:19:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621417008-6117-5-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 12:36 PM, Dikshita Agarwal wrote:
> AON register programming is used to set NOC to low
> power mode during V6 power off sequence. However
> AON register memory map is not applicable to 1pipe,
> hence skipping AON register programming.
> 
> Co-developed-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> Co-developed-by: Vikash Garodia <vgarodia@codeaurora.org>
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan
