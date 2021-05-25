Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAE138F808
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhEYCWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhEYCWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:22:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651E0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:20:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t11so15965218pjm.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WlxmHn/xu2IsuMaLK2b6KBTeuoToruDs/pi+LCh1UJg=;
        b=F7CoFXAwPE+Q5jb74pbkaCUYvoyhreuge0xROce3N6Zp0lbI+xFVUt4yocuRuZ2Uif
         Usb+p+3s0eVpwxPp8B9tp492k1MoYQ7/gViNhFbMidjm4lw85xSvX/vuGOIUy6Fx9rLn
         +8VoCgtKZ24jCjCCYLMkaIOI57uqqXiZLBPwNG26ZRNxAjdc8E3MG+Hr/Hr93a3qlyJt
         ePx0aPZ2QqyktYYjNUBDsScIIE/tvELPF2u/Iu/Cjh0Xk7MyErNMzapa7FAIq8XjYDzh
         5tgnxVl9YQL769tsfyWjSe82HHKIc6vDAxdy4+ILUFYeeOQfY3hnth6eZ/mZshLof03l
         kunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WlxmHn/xu2IsuMaLK2b6KBTeuoToruDs/pi+LCh1UJg=;
        b=BW5eT9F5sBH4AAniicfJZv2QQuZYj2KBhb+DdWGKpsn17B1wpEx8Yb9H+dO1NJqdXc
         EqtL+EVNw9a+41llPDp9e1kbjjIkrZITm0GO50oKft40HJKS7mbZh8Ywry39NhM0qXEC
         6j1toxa1wDT4R3SytVw95/XnF1cUVsQfE8UctcTar5VLhH2UJWki7NGu8Dm+yof4YoOh
         HOOt5/sxovkESTac/AnZt5orF+596lfGWTa4ri3/B20or68m1jYa8WpuZBj2ilcVDMDB
         ybK1LJV5XULfi1XuKLUqDndL7E+sr9h/Dg5tgRhliz/H/Sg3TqV6gACW3odNxrgJGlXR
         SBAw==
X-Gm-Message-State: AOAM530/G2sczIi0bvm9jp8z9v3RkR2qpAAf7CtzD4+lUKqTIExc2Sp0
        MlpedyvxeAqJKyYVDMTS27Y=
X-Google-Smtp-Source: ABdhPJypdJ6+4eRjkQZEO2ax0dnfvadsbY+CO4lFR+mennL1wAuD9dHnEEf6zkaPLqFZyhibqdZWdQ==
X-Received: by 2002:a17:90a:a087:: with SMTP id r7mr2370985pjp.84.1621909253976;
        Mon, 24 May 2021 19:20:53 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a26sm11990695pff.149.2021.05.24.19.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 19:20:53 -0700 (PDT)
Subject: Re: [PATCH 4/4] firmware: arm_scmi: Introduce delegated xfers support
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210524231503.34924-1-cristian.marussi@arm.com>
 <20210524231503.34924-5-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <659c2f2c-e236-1a70-44be-c5f6871868e7@gmail.com>
Date:   Mon, 24 May 2021 19:20:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210524231503.34924-5-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2021 4:15 PM, Cristian Marussi wrote:
> Introduce optional support for delegated xfers allocation.
> 
> An SCMI transport can optionally declare to support delegated xfers and
> then use a few helper functions exposed by the core SCMI transport layer to
> query the core for existing in-flight transfers matching a provided message
> header or alternatively and transparently obtain a brand new xfer to handle
> a freshly received notification message.
> In both cases the obtained xfer is uniquely mapped into a specific xfer
> through the means of the message header acting as key.
> 
> In this way such a transport can properly store its own transport specific
> payload into the xfer uniquely associated to the message header before
> even calling into the core scmi_rx_callback() in the usual way, so that
> the transport specific message envelope structures can be freed early
> and there is no more need to keep track of their status till the core
> fully processes the xfer to completion or times out.
> 
> The scmi_rx_callbak() does not need to be modified to carry additional
> transport-specific ancillary data related to such message envelopes since
> an unique natural association is established between the xfer and the
> related message header.
> 
> Existing transports that do not need anything of the above will continue
> to work as before without any change.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

It would be better to see this in the context of its planned user, but
that looked reasonable enough.
-- 
Florian
