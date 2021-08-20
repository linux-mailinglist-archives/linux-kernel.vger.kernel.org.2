Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE543F34EE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhHTUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbhHTUD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:03:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D0CC061575;
        Fri, 20 Aug 2021 13:03:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n5so8047535pjt.4;
        Fri, 20 Aug 2021 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xttFianAmqntTt9y9P8CARsBxqzMMvy7ycSER0i/iEM=;
        b=Cs7zs2GEBI2TtvHqqAY5q8nIbq0mpHsdj7ejJbpx3j7cTwSV0k+ZcxEjP0gjad2/WQ
         8HAUP+wRAqJRHVBbrt8a2i33syumtByWDd+QepHIAjUc66Ros6/djv6ybZgmNe4MX9vI
         fx8snDZ1t4GVrRjdbjfrO7iLEMud5WFIjwQKJT7PaqFRQYZTIu2k74H3urFQ9PyRv0qB
         ofYh4S1TVGIvxT8D/jga7JoIshv8UREXbcrq00NDG6mioT9foVVb645OKjuPcODQ1461
         nNCyLQDz0TIDt6qgAjBZO/w/20V22dfBFQmbWGbpP2eLyWjWOvPIH3ot+hYBLtsBPlxR
         BqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xttFianAmqntTt9y9P8CARsBxqzMMvy7ycSER0i/iEM=;
        b=QSOgsVU2yImsXYXGmgKQFs7TMJdKTIhqfWCWz4UrtNeXQx0w//Uu5LyLAl/q9pWX69
         0av7fGllRO+h1QautvLCg3fpFrgJ0+BT0Og3sGLEYS3ehMAZsuYbe4sGp5nx8tFKephJ
         jp1qra7KtdiN2scP/xQhhH2Mut66DY7wzxMnpjPKjuciuS4VTs8XjOCP0T2464O34vHc
         xWry8lLluEnwXMh/sQ2hlcIQL54AIbqSx/JWs8E1VS/LNNQtyaAgK3ech4cZzs9hOaZc
         3M9XrgXd9g4CzbyNP5DsJwIyyH4ufB0MK6SV32ddH0VYIPwJSG4A9NjVV6ot9FFseFXf
         gsxA==
X-Gm-Message-State: AOAM532tM1G6OwhMONXVej4QUq/S4kb7iZarSY6fosLsjomEjBZdBrxH
        xuixzCvU2vJZbWdYplIFCrYjLvW2toxwxg==
X-Google-Smtp-Source: ABdhPJzNrXDsexiR0gCnSs3/r+vkGwC4lvVw0fXDScRPTuDwTGTdX3W/+k3of9gAtWWdMOfXygaTXA==
X-Received: by 2002:a17:902:c202:b029:12d:65b0:fd3b with SMTP id 2-20020a170902c202b029012d65b0fd3bmr17604102pll.25.1629489798283;
        Fri, 20 Aug 2021 13:03:18 -0700 (PDT)
Received: from [10.230.32.55] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id d15sm6426116pfh.34.2021.08.20.13.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 13:03:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] usb: bdc: Fix a resource leak in the error handling
 path of 'bdc_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alcooperx@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <0c5910979f39225d5d8fe68c9ab1c147c68ddee1.1629314734.git.christophe.jaillet@wanadoo.fr>
 <f8a4a6897deb0c8cb2e576580790303550f15fcd.1629314734.git.christophe.jaillet@wanadoo.fr>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c56617ff-5d74-9b07-4bcc-25f3dd2aca64@gmail.com>
Date:   Fri, 20 Aug 2021 22:03:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f8a4a6897deb0c8cb2e576580790303550f15fcd.1629314734.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2021 9:32 PM, Christophe JAILLET wrote:
> If an error occurs after a successful 'clk_prepare_enable()' call, it must
> be undone by a corresponding 'clk_disable_unprepare()' call.
> This call is already present in the remove function.
> 
> Add this call in the error handling path and reorder the code so that the
> 'clk_prepare_enable()' call happens later in the function.
> The goal is to have as much managed resources functions as possible
> before the 'clk_prepare_enable()' call in order to keep the error handling
> path simple.
> 
> While at it, remove the now unneeded 'clk' variable.
> 
> Fixes: c87dca047849 ("usb: bdc: Add clock enable for new chips with a separate BDC clock")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
> Review with care.
> I don't like shuffling code like that because of possible side effect.
> Moving the code related to this clk looks fine to me, but who knows...

There are no register accesses until bdc_phy_init() gets called, so this 
looks fine to me. Al knows this code better than I do though, so it 
would be better to wait for his Acked-by tag.
-- 
Florian
