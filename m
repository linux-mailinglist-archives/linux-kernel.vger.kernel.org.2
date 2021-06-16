Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244E93A9CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhFPN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhFPN7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:59:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE595C061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 06:56:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso1773603wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6jq8C/Rzb7RK2Hf0fwCmGzYirCOKsKSvSsnVLF/bjjI=;
        b=ogT6xyY7Xr60NqygOvaMwXVkI5gxw+rnYPyDF2xJ5ui1FtYNkXdNpRtxtE408dylPq
         ZW1eJ7XZY6VpoZCdF8r+JHYjcoegt6YceNI2r0cCExQrhr8qvkRkGJfgM2KUpfSEUBNe
         EyYPW+nSMI1TwZ+e7ohumnZCi/WAaIQwoYUdcZcMYLzmxrrDeSgReiRz2WkMiHgfTS63
         cPFbRjrzw9mPaIcRtn6MSAhym67zmeAjj1sBpmqVaMiiQl5OPzKPeKNVOKRa3PCXQc5r
         ZUgFszZXHZrj7fN9BbUTnPHkeraUBgNwp3Puy7hThkSjRqhI+rmhLrgCl2K0lX+HOSh/
         PznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jq8C/Rzb7RK2Hf0fwCmGzYirCOKsKSvSsnVLF/bjjI=;
        b=K6uekd1D5gsDIqGL0xIKuHI3QQHcXB8SKZ/WBr30QFgggu3+J5dRE7eSxVlfjU/Qll
         SznTZ5ZTmqtfcPQcyBGsMVOuzdQxHvJjEP3RtHTJT2ufdOVLAY7WisecAMTRZrSUrP4o
         NPvufMWesz6jOcGQws7oVOAcLt8AYJlMlJ4fN2mA7CrHATpSYFOc62Fi0gtp3p/CTmM9
         iAY57I4/uLOKVrWCVTHtFyaH2i+wCICdzPQFlXgxCac0zQ+NyMPYcdiPMsyyapFsXHue
         pFjNn8EpYToLCzUo3D59cIphEjfXSSd2bmP0ckyhADH6uONQBhkxWjX5gH9ehFvzXkLJ
         g7lw==
X-Gm-Message-State: AOAM531JaCsElSmmz5mtBTGDq3PQcWy6MY7GGJYTwE1CQehILxFUG2zG
        GZgCaFfj+SqGTGhZlesMtvVLxQ==
X-Google-Smtp-Source: ABdhPJylV+0o2tUV9eg47KPQVPT7xd2Gd0qftElPiOFmH803O7vy0jRLa491ScW/tQ2uBGYDx1b6Mw==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr40730wmi.174.1623851810981;
        Wed, 16 Jun 2021 06:56:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:60a0:f51c:af6:2dab? ([2a01:e34:ed2f:f020:60a0:f51c:af6:2dab])
        by smtp.googlemail.com with ESMTPSA id u16sm2465865wru.56.2021.06.16.06.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 06:56:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] clocksource: Ingenic: Rename unreasonable array
 names.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, tglx@linutronix.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sihui.liu@ingenic.com,
        jun.jiang@ingenic.com, sernia.zhou@foxmail.com,
        paul@crapouillou.net
References: <1622824306-30987-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1622824306-30987-2-git-send-email-zhouyanjie@wanyeetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f9f63e49-41f4-4598-3554-ac53ba4dcd55@linaro.org>
Date:   Wed, 16 Jun 2021 15:56:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1622824306-30987-2-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2021 18:31, 周琰杰 (Zhou Yanjie) wrote:
> 1.Rename the "ingenic_ost_clk_info[]" to "x1000_ost_clk_info[]"
>   to facilitate the addition of OST support for X2000 SoC in a
>   later commit.
> 2.When the OST support for X2000 SoC is added, there will be two
>   compatible strings, so renaming "ingenic_ost_of_match[]" to
>   "ingenic_ost_of_matches[]" is more reasonable.
> 3.Remove the unnecessary comma in "ingenic_ost_of_matches[]" to
>   reduce code size as much as possible.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---

I have applied this patch but not the 2/2.

Thanks
  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
