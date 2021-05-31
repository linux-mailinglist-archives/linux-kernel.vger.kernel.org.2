Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CFA39598F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhEaLTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhEaLTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:19:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F661C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:18:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t15so3157673eju.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=77N0TwRUxI7ToWDCDOZD3ONLOxIP5ZchUURudLrl0w0=;
        b=RgQZVMzYa95lKgylWOWH2WemD/iXSkXhJysUUJ4EU++xttwgX+ztLlEaq9tIsJtt0T
         mND90Z/5WlNlntQ4NmoOXuB1cnLfeOL2FwGp3WGjZyZtOzK7vsHMZtRWFCV8UAqv66+t
         tkwlbs3wJ4rPKLWO02WgYkE+/ln9Xv9DA1UpWz/Sd9NEqL8cDjjIAlxBxeqMgwqRH3U5
         AJPnTtd0z6ZPAcTYJqCOoCR2E3yhGyxZdONf9Ya3nhLLeLVjHulijbkgJbolCk30U0pB
         mOpQyP1j7DHX5Q6cuuh/TkX+rMr5XIEMMZ4+ah09yJUMYht0ytso8Xo/UfugSuPTuWeA
         Lx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=77N0TwRUxI7ToWDCDOZD3ONLOxIP5ZchUURudLrl0w0=;
        b=ZSCurELVebG556CqIzCO4o7D+cu17f5xUZj595cmRb6m0q4AFlyBWyuAVxXk4IaSfD
         69vpNRliQKatNa9JeMbE5ntvfWtyZn3ms55YOdwd2/bhNUYszobOJct+MxcJstdrHnhx
         n9jCe9jP2BNku4XWMTfTEEVpNvXlwElpjNov+nc3GvCMUDPjMs4KVpXmIEjagpHyYKlX
         U1hCUiIMrhULi+2lsUjBcKAGgZFZfyWFomGlJAbKYzlvldYECaWEtK+umGIr3YiDp9xw
         xhlbHoDK2nKyqvuty4LPIVjGBFtiGc5HG1oNqoGkRlQu31VlC42m58Ms93dD5ZEfTR5Y
         B+GQ==
X-Gm-Message-State: AOAM530QM7DnlreWomN+nlY4tTg0xE5fgyrlx82Z1RKcc16GiwAp8J+3
        HbHshn+xVzi5V5BedQzhmAe9b36LIPrHmQIa
X-Google-Smtp-Source: ABdhPJyXBriaJvAS+hQ6OlK526Gslrgwlgszmd4ikiQN+zDPSbViZbWXSmu9OaixPcyKMBvOPeCQFQ==
X-Received: by 2002:a17:906:f9d1:: with SMTP id lj17mr1719852ejb.345.1622459886715;
        Mon, 31 May 2021 04:18:06 -0700 (PDT)
Received: from [192.168.1.28] (hst-221-34.medicom.bg. [84.238.221.34])
        by smtp.googlemail.com with ESMTPSA id n13sm5812647ejk.97.2021.05.31.04.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 04:18:06 -0700 (PDT)
Subject: Re: [PATCH 2/7] media: venus: core: Add sc7280 DT compatible and
 resource data
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
References: <1621417008-6117-1-git-send-email-dikshita@codeaurora.org>
 <1621417008-6117-3-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <ebca15e9-6416-6e92-6b08-b60e19c3e26b@linaro.org>
Date:   Mon, 31 May 2021 14:18:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1621417008-6117-3-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 12:36 PM, Dikshita Agarwal wrote:
> Adds a sm7280 compatible binding to the venus core.
> 
> Co-developed-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 52 ++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan
