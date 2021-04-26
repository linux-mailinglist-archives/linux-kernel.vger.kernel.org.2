Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9536BADC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhDZUvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbhDZUvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:51:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3522C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:51:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t13so3636512pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GfZ28xG1LoClNjK9zORUC9bqP2NN8/wKouX+5z7Zo3w=;
        b=nSVH7aR/RecH79NB0jviClRfAsEHJIzCJct6w8QuVjmr6UlrPkEw2ZkQltf2Rvx8Jn
         C7xrthGzou1ajumcguOKAac7+7Uh8HcIDH/uQHaeuwIDgRfvL7Jo/N77f64djYMA9Tnk
         Az32x98ssHNtHC5vtgFcr9QB7wF8wzzF5PhbTpxOLVAtTlHA4QbRK061d8gc9b31tjjm
         9Q2FqIQpCWUlwLQybC27vJ6ckTpL5neu8dT5sJz/IKjx26a5RrxCJ7IiBe+aFSzDx3N/
         bWmH7oHGiBijbu6Q7eJPf4y3/1g9dWHfe4Drre8I8cVPzM1cmsz6iAeIULZqWf0QmTaZ
         BUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GfZ28xG1LoClNjK9zORUC9bqP2NN8/wKouX+5z7Zo3w=;
        b=rpk+eU03fyFTWH7nANX933WydLW6HRk7sm7flR0zMIIXN6U6x7X9wDehbvGXR77XqV
         3thuMWrO8mSmiJkavUd08Oa2rVtFCVUsoLFE8Nshzi2juzVjNFGbFB4y+Dk/sHo8kJea
         p597g2UW5BGqJuyVYqbO9e2jBUPcnEQwYRf2+oxKTka3GEsdaItBzT+Dfhp77Z9DcoFK
         AIegL8dz5eHlk81M5Wq21oruLUUvN4EkeH0arwHofdV8zj07ePfL7GhRlj3Zd53iRF+b
         UjADDnUanxGhfuFWRCTfKgKpmb3i9IaohY3aQEa9iLNn/SJujGkXHzRp7yK3XOFcfozJ
         DaUA==
X-Gm-Message-State: AOAM531POAXvSiFzoajeNMfRkxmHZ1gGd4rPgWrYjDVsfWOHD1yy0BxP
        v/9wRJxJ/SqAd9g1As9blqbOmcA9IT8=
X-Google-Smtp-Source: ABdhPJzjIhO9W+LdO4/ewPWbIQ5HTKm3AOI79j8wnZu9/osCbntT+BcVCuevfmIwIa3fEKZfELDv9w==
X-Received: by 2002:a17:902:7804:b029:eb:66b0:73a7 with SMTP id p4-20020a1709027804b02900eb66b073a7mr20481216pll.68.1619470268744;
        Mon, 26 Apr 2021 13:51:08 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id kk9sm448916pjb.23.2021.04.26.13.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 13:51:07 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] Revert "Revert "driver core: Set fw_devlink=on by
 default""
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
References: <20210302211133.2244281-1-saravanak@google.com>
 <20210302211133.2244281-4-saravanak@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <60989b90-7f8a-5306-e7d7-c5461bc9ac68@gmail.com>
Date:   Mon, 26 Apr 2021 13:51:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302211133.2244281-4-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

Adding Sudeep and Christian, Al and Jim.

On 3/2/21 1:11 PM, Saravana Kannan wrote:
> This reverts commit 3e4c982f1ce75faf5314477b8da296d2d00919df.
> 
> Since all reported issues due to fw_devlink=on should be addressed by
> this series, revert the revert. fw_devlink=on Take II.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This change breaks booting on SCMI-based platforms such as ARCH_BRCMSTB.
If I revert this change or boot with fw_devlink=permissive, then our
systems boot again. From a quick look, the SCMI clock provider was never
probed which means that our UART driver never got a chance to get its
clock and we have no console -> timeout.

Al, AFAICT you had started to analyze this before in the context of
SCMI, do you mind sharing what you had found?

Saravana, is there any debugging output that we can help provide?

Thank you!
-- 
Florian
