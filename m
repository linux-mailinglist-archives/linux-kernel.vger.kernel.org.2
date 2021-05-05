Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5ED373F05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 17:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhEEPzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 11:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhEEPzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 11:55:19 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F7C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 08:54:23 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 76so1937324qkn.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 08:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sT5gh+1EXZtOxYM3WBIR7U/7xjEHkvX592kGUagqFYc=;
        b=aRbgNk1AAtCgn3aq1pldMwpcsbLLO0vsA9yDCYjTSKGDjhuIZGtGBhKlW5hu2kUzU2
         VyxCj0mryiV8DsfB5b12qFz7DnauvSNwG5QkejFlCxMOzJcV9Og+67chd5p/plYHT+Z+
         mL6Yh1T/OFD98MRBkPTueajHVg9CJBxWMeMSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sT5gh+1EXZtOxYM3WBIR7U/7xjEHkvX592kGUagqFYc=;
        b=mIAFm5lJlnBUiXGkn512UkLRIbXdK2d1HTHrCCHmUoOlufTKP3MqkZRYvshgZht9aK
         bFuOSxaRjFTbDCAIx1MavJhY96MktmiGHGrvtVctM6wXI3B+oK2ffi98GnUGaPcHZF7r
         7Nz0qkjUti+AF1iR8unDnT/jIoCDU7FPeRksmZFxSMIzK8879kSQAgk5fJZ9oDqQQgCu
         7vx1+hSrWFVRfLcxyyeYkPD1eSXw/B2Q6WW1yBH/sJauwi4geu7fygsV1fESX1CeA+50
         htCvzLKB33JHbiWbm+ncjmFUIXsPKwinYT1NjNx+shOjfTCXK46SmXWWsnOtQfDkavfa
         ZyHw==
X-Gm-Message-State: AOAM5301KA/BHeArS0S4hIMlt6LPwYqeYUSRpFv/LQ38kFLxfXM9p7Bq
        MzpdI50sTBfWVvHAv+zx4fPITA==
X-Google-Smtp-Source: ABdhPJya3vgRQ++iqwOA71h8RVcWf478k1iK9HmfiaeS+ST9LB9GXXDX5dCIG8VVdfCIZL4c5M4X7w==
X-Received: by 2002:a05:620a:15ca:: with SMTP id o10mr2987351qkm.448.1620230062521;
        Wed, 05 May 2021 08:54:22 -0700 (PDT)
Received: from [192.168.151.33] (50-232-25-43-static.hfc.comcastbusiness.net. [50.232.25.43])
        by smtp.gmail.com with ESMTPSA id k126sm7664937qkb.30.2021.05.05.08.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 08:54:22 -0700 (PDT)
Subject: Re: [PATCH v2] media: em28xx: Fix possible memory leak of em28xx
 struct
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210504183249.6307-1-igormtorrente@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <21f59c86-f1ae-5913-cde9-078fe4f6f752@linuxfoundation.org>
Date:   Wed, 5 May 2021 11:54:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210504183249.6307-1-igormtorrente@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/21 2:32 PM, Igor Matheus Andrade Torrente wrote:
> The em28xx struct kref isn't being decreased after an error in the
> em28xx_ir_init, leading to a possible memory leak.
> 
> A kref_put and em28xx_shutdown_buttons is added to the error handler code.
> 
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
> ---

Hi Igor,

Please look at Hans's response and comments to your v1 patch. v4l core
addresses the lifetime issues now and this driver could be updated to
use them instead if fixing the problems in this driver's resource
lifetime mgmt code.

Please follow his review comments to address the issue based on his 
suggestions.

thanks,
-- Shuah
