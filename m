Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5661A30F461
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhBDN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhBDN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:56:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42691C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:55:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m13so3556195wro.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hzfyw7cGPV/6uJGFEu+jTS7JZCswuKZE6330B5/rJRw=;
        b=HDJME6Og8gQPqE8NM81cSx+88PddfmG5gPVNemmtSq3Y8X8suM8zbGaTP9KZzoBKEM
         hRhB0B9ZL1ycoNLqPCiyb3kxYAewRT3Zq5kPQgOx2VQBidV7D8zZKbwvn4eXQYgE+YDY
         cvuHGM8Z9TPcylYKpwXnkfl9+Zu8Y4f/Q1T3aZC/pj2i6+R2T0ZYs2mh4zF/B+dPtN6O
         m7VrYgcxl3IA2oXP9JPvpq3FWQXG0VFueDmfqymKV7wuw+8083nvNMAL9JafODYTdfB3
         iRjYWt0m7/F8hiH9t/dlPsrbhaY4db1+rnd0tZOTNxlY5G8ERYfp8K25YHmHAZViut4v
         0mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hzfyw7cGPV/6uJGFEu+jTS7JZCswuKZE6330B5/rJRw=;
        b=ZNJccqGxKcsc0Oa5gdkmqNZOc/+peGWmkdBBkU3ylcC4AioBtcBrh4UKPb1DUXSdvH
         oHngm5lbOimhftEFvxsZ8B+5C9wAE4XQhkMrqy6mG+Qg93hBlmIqLq6a9fLkS87xw0/Q
         6KaRge+kiHAP03E50HHDE7EAc2gji1VDJqo2sQ3xM+TgWpXYHui02tvgXcD5AmRT953Q
         jRxzhaTGUZPhNCnLEAXwIKTcP//s8Mk3tHekETPG9n+ZzrIiPhWVqjM3J/7bs5n0sVA4
         5+239JnHeF35pidziAd5KFWYgKu3XKOihE9lGE9qjBeOYY4JQeXza4aP0UXVYTtm3zgD
         iWzA==
X-Gm-Message-State: AOAM530zJ8G1gC97nckapqi5C5TZtMZtHMZOysDM+fxTGELZ6TO0N9OJ
        tXZ90Vzaa5TUZ/9SWTdci2ZUYg==
X-Google-Smtp-Source: ABdhPJwVtEgqFoIpPqm9mOUpNe597hHfgmhLCj7nzFG8QdQDBA4AccFnlrQRCr4Ieq2ypY5AazLUsA==
X-Received: by 2002:a5d:53c3:: with SMTP id a3mr9212935wrw.43.1612446915658;
        Thu, 04 Feb 2021 05:55:15 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id x82sm856894wmg.31.2021.02.04.05.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 05:55:15 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:55:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 2/5] mfd: arizona: Replace arizona_of_get_type() with
 device_get_match_data()
Message-ID: <20210204135513.GI2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210120214957.140232-3-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021, Hans de Goede wrote:

> Replace the custom arizona_of_get_type() function with the generic
> device_get_match_data() helper. Besides being a nice cleanup this
> also makes it easier to add support for binding to ACPI enumerated
> devices.
> 
> While at it also fix a possible NULL pointer deref of the id
> argument to the probe functions (this could happen on e.g. manual
> driver binding through sysfs).
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - New patch in v2 of this patchset
> ---
>  drivers/mfd/arizona-core.c | 11 -----------
>  drivers/mfd/arizona-i2c.c  | 10 ++++++----
>  drivers/mfd/arizona-spi.c  | 10 ++++++----
>  drivers/mfd/arizona.h      |  9 ---------
>  4 files changed, 12 insertions(+), 28 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
