Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519C53539AE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 22:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhDDUMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 16:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhDDUMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 16:12:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA7AC0613E6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 13:12:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b9so1365310wrs.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oyHxbO3PUNNiO9rpGkiDw/KLrdxxFq2h9NV2xELqAZI=;
        b=qhRLFfFI3kt0wDjaLQK4K06CrUrjQt0wOzmG1OBXj+KCe2Kfbfa8Q3ZaCOv2U0jyLj
         q/yHkhYKUnyb1gMWQMvJfzK/D4W7Xl3Dxb3e7mvr0kQkuvXmha4bGVXYu2B5sxz9mXVi
         bOx45c1f88gJC6iBp7Jz1basoQ0DfxdFkVUpi10TGy6LcJrVdN9IlVuCbHayBPATqEcP
         Dla+HKiJdo+CLPrO1RwaWkZcuJ2C8CZ35ztcLJZhkVCY+jgGD6RrHztG3H6ZtJVhAdQr
         Ol2ob46wvz3NsyhLe46wBWrupVGMhWSXZq9QxH47LPpLd+pxuqnJa1Cne4+UnXNGLkIc
         OmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyHxbO3PUNNiO9rpGkiDw/KLrdxxFq2h9NV2xELqAZI=;
        b=HOdQHyB+o2BGuDlVAOHGc2Re/8+RlBLVdKzAM5G1UYha292QNBhFH2yh3gPLaRqA4T
         8idJ8ZvUrPP/J3G9WBwXYpxobvBQFNRCE3O+z9I8pAlP7TatOlgrdKq+M1oyx0U3BNg4
         ZWcMFvKu/jawde6xwI0N4NXEj/l26Z1o5VevoK2LhJSpcfjPPlhCeiiK7uv2h7BXPbl/
         WKAMmIBkpIMNXBiLs09gZOt0IgsscYMTmUWzv51LmBpyvGRtgwm/IdFbQ/M+9Yby0+XY
         om2NM/sLP9OTLff0UWfPJPh58UgIkkuHJ9aT4JmRfiZXEiUoEjIHI3vNg5S9GmOV78yZ
         R7eA==
X-Gm-Message-State: AOAM532Vt4yCba4fewTkgaGzYvsbCOgwtmMve6VZtfwzWJ7XQ+HgAr8c
        puE9ry3QsTjw7CUrJXEnbXzxn8/7Nd1UGw==
X-Google-Smtp-Source: ABdhPJyhO8r8scHjRFIav4WlBDVzxSBbX4cqENuJU1BEdQ9L9gMjYA4KXNY7MjY0BqyrkKCwGCJHrw==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr26758160wrw.196.1617567135377;
        Sun, 04 Apr 2021 13:12:15 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f? ([2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f])
        by smtp.googlemail.com with ESMTPSA id 21sm21237319wme.6.2021.04.04.13.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 13:12:14 -0700 (PDT)
Subject: Re: [PATCH][next] thermal/drivers/devfreq_cooling: Fix error return
 if kasprintf returns NULL
To:     Colin King <colin.king@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210325172148.485259-1-colin.king@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <101b8460-6488-88f7-9ccc-3af2c694cb48@linaro.org>
Date:   Sun, 4 Apr 2021 22:12:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210325172148.485259-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Colin,


On 25/03/2021 18:21, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when kasprintf fails and returns NULL, the error return -ENOMEM
> is being assigned to cdev instead of err causing the return via the label
> remove_qos_re to return the incorrect error code. Fix this by explicitly
> setting err before taking the error return path.
> 
> Addresses-Coverity: ("Unused valued")
> Fixes: f8d354e821b2 ("thermal/drivers/devfreq_cooling: Use device name instead of auto-numbering")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks for your patch. It was already fixed after being reported by
kbuild-test.

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
