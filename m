Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49753F7A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbhHYQdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbhHYQdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:33:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B62C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:32:19 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n18so216803pgm.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1c/E6S94RHlOGKT1GFeAHquF3lWu1k2W+Vl//G6kIy0=;
        b=k9HbZk87d66ZL3ED0i9Az4AYP03EEqqtjy+NuP4yGCi8QAr2uN5sE2WB5Hj5yh1TAl
         NCNTtbkWL9U8MayMY7zDtoBOYiT94j+1dNyjDrSTaF87+MzeLHCcxTOmeTrE0Vw6li8M
         jDtYTEywhOW48r8G2KQS2/kpKsKXHbWpBCi/twmYCCUNKjT+5OfBXvGIKUSO8oMZoBqC
         iENMCyF87HAeHc/RB4glNvXQ9tDjQiJUcHRXQJHjfBrOgtr6J9nw/u5ytP6SQIyy2rh7
         sWEoyZRJmDeQen0Q3MZn0SW1s7VWUycCk2fGyL/2tL7cnyZ2cowncG5JzyIou03XXe0I
         422w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1c/E6S94RHlOGKT1GFeAHquF3lWu1k2W+Vl//G6kIy0=;
        b=dkwdmOAMzzmqRivQV0AsK+TtjfhOhjS4tHYeHF+2PGmu0/PDznlDwF+VYQOZaewg2Z
         YRtlf4bplNw1E9cy+OPr8N8uTGyZP/kRMIdTt4I3AWZ6b5UWvT2MILLKeX9OkIoV6+la
         v4PMnRcZJLdr64e23iQVSTEryTe/2kvml0A7FKf9DxaqbrupjPgi74bxy0EVKQfD9y8E
         QIYIQOzFuW3m2osukDhMjps4Ek/aiAD7u3bNWyWapDzSqsD75NIV3Ec7RQG3IpxDdVE0
         khm37SWysuY3Dz4x5snl4BMm4h0V/x4Bfqy0sXIIPvOHYKER8e81HEARsCPKXEo9XWq+
         EphA==
X-Gm-Message-State: AOAM5330OiV46zuaH/GTMEhVPSkz9Z5WqEUAAyGY7w7Ahmfr/Lj84pKa
        zU4FYc3NAYUELtic6VODvN8=
X-Google-Smtp-Source: ABdhPJwYS2g9JJYQkz/Tm+krYp9Rf9RJqwcyAAHTZHmclqbWOtbPPcbV9uRN4wOVl6hcFk4aR2fYPQ==
X-Received: by 2002:a65:6553:: with SMTP id a19mr43039094pgw.8.1629909139020;
        Wed, 25 Aug 2021 09:32:19 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with UTF8SMTPSA id y7sm272866pff.206.2021.08.25.09.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 09:32:18 -0700 (PDT)
Message-ID: <aa60f50e-0250-dd4b-69d3-4f42f14166e3@gmail.com>
Date:   Wed, 25 Aug 2021 18:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: [PATCH v4 06/12] firmware: arm_scmi: Add is_transport_atomic()
 handle method
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210824135941.38656-1-cristian.marussi@arm.com>
 <20210824135941.38656-7-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20210824135941.38656-7-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 3:59 PM, Cristian Marussi wrote:
> Add a method to check if the underlying transport configured for an SCMI
> instance is configured to support atomic transaction of SCMI commands.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
