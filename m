Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0443685F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhDVRb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbhDVRbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:31:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD1DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:30:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so3551620wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4QXov8+7rUzewmTRTWrRhYMtm+anFxfbv41xdyEG7qc=;
        b=m0sj4q5/CBU/FR+dyA/rciylWzJVhQUZpC91BvnlIorWPdHSzb+xYmv56yIujbvxdF
         kfN3BKtn2lAoFD4yut3Bf2C/pyDs5AtJ8JR5QeSDeiSdQvyW8eZdvCo07HDw7cypZxhX
         9nI1yy+DirOIiAMmEMfEe3S9XhmLM2y5GXjaSG6xaAi1dFYgKPwolbY1R+Q/yjXC/psB
         KIm5nZtAuLr1pksmYZhSlF7EQli6Ig5un+fKD6a+yYGfYzSfPCSY2QRhM/cNMWlNYUDH
         cmPgL25fhBAX9WbKbJcp1APp4qcN4C5gvlC5BT0ZBHEhaNXPRYJzaSXvN29lM+5hD7Tt
         zQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4QXov8+7rUzewmTRTWrRhYMtm+anFxfbv41xdyEG7qc=;
        b=ZeF8D34ZqZ4iKycOjubNCLmnCdIQ30JAW21aOsqTNPeK+THKHELbIJa5VDySADuTna
         8EwkqdKannIOE1no2vAIWL9WOcodULgbsd2IqGg1+TYa1JIqTMvDssOi4mgzP0tD1NNg
         4GIWk/DaNrqyp6xDoCogcuycnK8aXCDdXElMGjbrZFi99WKjaNhtNIBJ7xNhWnsMMbUO
         Eh5Z5TMZjGIl85GuE1lJAGVd0AclKMQ7dNP0WstX4FEpDXpwVXMyXIPfzwe5s6bhgQWG
         OTB+jasAX1wrh3xrf3lDhMgBmMSbywvbShzgm0Y1+gbNyNjNspu+QU5ApuBAozFYAccn
         C7MA==
X-Gm-Message-State: AOAM531LGa1KrHUqPqV5uBUhXRb5KHwWjcUOh2hvUJgL8gx0TyfsEPCT
        Nlkk+RHaBX3mtr1FuOSzAz00zP0M/7yYbZ01
X-Google-Smtp-Source: ABdhPJxPIeB3GZzGT/Ve4oEY86nOXitLuw8ZGplll19/S+crpbfoPhgyW3s8+6UwI295EDTsIgIhsw==
X-Received: by 2002:a1c:1f92:: with SMTP id f140mr4891204wmf.108.1619112626744;
        Thu, 22 Apr 2021 10:30:26 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9? ([2a01:e34:ed2f:f020:2191:9b4c:c38f:a1a9])
        by smtp.googlemail.com with ESMTPSA id i12sm4683767wrm.77.2021.04.22.10.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 10:30:26 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Improve IPA mechanisms in low temperature state
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com
References: <20210422114308.29684-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <423f5f3a-aa3c-dbcd-6783-3bfe04f9781f@linaro.org>
Date:   Thu, 22 Apr 2021 19:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210422114308.29684-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2021 13:43, Lukasz Luba wrote:
> Hi all,
> 
> This v4 patch set aims to address the issues present in IPA when the
> temperature is below the first trip point and cooling devices are not
> throttled.
> The last patch 1/3 is co-developed by Daniel, who presented the code
> during v2 review. I have created a helper function based on his idea,
> which can now be used inside IPA governor lock protected code. 
> The patch 2/3 adds a basic check of cooling devices power to keep the
> internal statistics fresh. This allows to avoid issue when the statistics
> cover very long period, because they were not maintained.
> The patch 3/3 addresses an issue described in bugzilla [1], which is:
> unnecessary updating cooling devices when their state has not changed
> because they are not throttled. This update triggers sending an event,
> which should be avoided. Thus, patch 2/3 adds a tracking mechanism if
> the update was triggered and makes sure it will be done only once when
> the temperature continue to stay below first trip point.
> 
> changelog:
> v4:
> - reordered the patches, patch 3/3 from v3 is now 1/3 
> v3:
> - new patch 3/3 co-developed with Daniel
> v2:
> - patch 2/2 uses now simple 'update' bool flag and information from
>   'tz->last_temperature'
> - patch 1/2 has small change in the comment
> - re-based on top of today's thermal/next branch
> 
> Regards,
> Lukasz Luba
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=212501
> 
> Lukasz Luba (3):
>   thermal: create a helper __thermal_cdev_update() without a lock
>   thermal: power_allocator: maintain the device statistics from going
>     stale
>   thermal: power_allocator: update once cooling devices when temp is low
> 
>  drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++----
>  drivers/thermal/thermal_core.h        |  1 +
>  drivers/thermal/thermal_helpers.c     | 27 +++++++++++++++++----------
>  3 files changed, 35 insertions(+), 14 deletions(-)

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
