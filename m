Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37333370E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhCKLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbhCKLNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:13:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF93EC061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:13:34 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo12535275wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=onK3msdJv5R6kQra+OvE3/ov8PzIbV+7IMlX9zMKU0o=;
        b=BUcWSGO2iVS3VR+tkLs44lgdMSDPO+iedkmSt0n4V/hPlWf5gucTftw8p3ubk1VPby
         x+ZmdLSfXmilFTsxq9nXq7q1bIEwoI8TqlNsGmNfFCSdMKrDVAdoM851B/RB80Qnx8F5
         7Em++3kjsR/44QW0JQyWqTqNZQD9uSztxbLpriyEfDRWJ3bEad6baTyFQ3LnWK/ns6KY
         RSj3rnz5COmnGC1li7RtRnG34VMWKJz46gj1h2LvUcPHkPGasvoeFSCvpOUoqBC4yC0F
         oSEUpSjAGlmn0f/l7p9CC4K87BZoPB5OpJZ9d4IYM1XiYi0TW/GYIcAdmci8mfXLwqfd
         GbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=onK3msdJv5R6kQra+OvE3/ov8PzIbV+7IMlX9zMKU0o=;
        b=A8AcEAf0p1Eg5LBefR2nU7viy37n1s8x9Yfce1xK2E8IhcbLSRBM6ANWiyhD+l3KtW
         eVlmt2OZGcRm6C07K5Jr3FtQcJG+RYUgw2MTpxxXl8DSadLowZabG+30jUF2wmPNniMB
         g3iNz7CYotdhBV1zP2dQLuh0997MZ/x1ahcvI9MT7mOO/ozxg71sBz+WIxqiFVoNEQ/6
         ZzGwc3jYk/nxlADAX5CQPR96/iStS9YL5CMcSKGd3w2ZFaaYCmjol9A3S1Mj6bjLrFDb
         1BjaUB0/R4wuJXTLLK4g2GHX7biFazJpp3VfkvTFqIVn5smh/B85wE6GYPfrVA430a97
         WUkg==
X-Gm-Message-State: AOAM5316TLdr7WVcBflErHE514DAsienCxDIZZD8ER35cfD3h2VPzhUG
        N7nqi8Ez4JuMtvzsAiMs1GgCnzAMtLBy9A==
X-Google-Smtp-Source: ABdhPJzLui+97bNbwf3bHAfKS2yY0rLbo4z3as7RbJM8Hxt6Nd57DRxDNoIOJ3POTPDFFfo/QdlBjw==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr7786598wml.22.1615461212745;
        Thu, 11 Mar 2021 03:13:32 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:84cf:7f4d:d470:dfd4? ([2a01:e34:ed2f:f020:84cf:7f4d:d470:dfd4])
        by smtp.googlemail.com with ESMTPSA id z2sm3213264wrv.47.2021.03.11.03.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 03:13:32 -0800 (PST)
Subject: Re: [PATCH] thermal: Fix spelling mistake "disabed" -> "disabled"
To:     Colin King <colin.king@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210311093054.5338-1-colin.king@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <86800f7b-76e4-9f65-7c93-095b9d742a80@linaro.org>
Date:   Thu, 11 Mar 2021 12:13:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311093054.5338-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2021 10:30, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a comment, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
