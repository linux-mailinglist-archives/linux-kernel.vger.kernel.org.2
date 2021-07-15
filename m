Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035AE3CA033
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhGOOGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 10:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhGOOGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:06:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F6C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:03:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so6127960wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2WsNhg8rfzlYQA7icIiNW7dz15gmr8Kr8gn8mV6ZBqk=;
        b=Sedwnxw+rSX8nJTUL9a4CGnb5fHYZfC0Y6MTnyhDW01fcnLklNE0zYQVuPxmZMBGEm
         ENP0JTSLENkYkTsUox94U6Ovkt4cUqk1l4YOi9IrEPwolg3kbcYoatbWGPd/nQ74EdPh
         byuqKlV0m1tt5uPFDCfh7vN/0GLMw4fQekAdBAgw7i0khkZZOXbnGZsRJ6XE6BdlKCFT
         RuemuBmQ9WE7IOZ/CrPB4u6Q9Uy/KO5AqjQRimJPKNnPle70ngRdLT+WvXWJ8PIUw2uR
         7RP7Homp2F0duBN6QlhjTh/WHOf5IGy4vlmgsAv+daAFB3NhKauS66LHME3sVYjeh1oc
         piwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2WsNhg8rfzlYQA7icIiNW7dz15gmr8Kr8gn8mV6ZBqk=;
        b=Cpe5xcbEHPK8TmIgp6cETVt9qwFIs3hNESJ0YyhJGSrfZonU9jfL3hHz0G4r0ebqEQ
         YfLWgGYcr8/JoNKAODennSzHCLhbmpKWFqbBV6W45VBLifoWIQo3FtLQxOfwDa4RFrEO
         4xjqcCfjf4sdXOSSuRXktqy8R9Q4K4aLIAl8nR/pDR0uq2BbDa3xYQBAJzk7dA5l2Y9d
         z1GqQOsIRUCjuhpK3tKsCMe/vFUatF9Ta808KTxKnZiXglSREygRzACx3/EfL/wWCx0b
         uWoX2oB8tVHCr8aqsLLzRCQXk7B3dqDqKf7Gw5kajaIo4xl9SQW//gK8nVwGTstOhcw2
         CHpg==
X-Gm-Message-State: AOAM532Os9XvL5xfvigBsJo60/oFGdz+ItaSAY1MS95b8jeUixIgnJSE
        JMgeTDjJXynpe2srAXvooIsdaQ==
X-Google-Smtp-Source: ABdhPJyYgmZ4hUFoY/29/oPUjjMZSBa/jj3D79n9EYtV3h1wK6zTeAxwVrARG9H7V15gDgaBDB6WeQ==
X-Received: by 2002:a1c:7701:: with SMTP id t1mr4848290wmi.139.1626357795083;
        Thu, 15 Jul 2021 07:03:15 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:2869:dbdd:92c7:6be2? ([2a01:e34:ed2f:f020:2869:dbdd:92c7:6be2])
        by smtp.googlemail.com with ESMTPSA id n20sm5151440wmk.12.2021.07.15.07.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 07:03:14 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] units: Add the HZ macros
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Christian Eggers <ceggers@arri.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
 <YOxvAwb1Ho9iTxWg@smile.fi.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d61fbdb3-470f-af09-112c-a28a610630ae@linaro.org>
Date:   Thu, 15 Jul 2021 16:03:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOxvAwb1Ho9iTxWg@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2021 18:34, Andy Shevchenko wrote:
> On Wed, Feb 24, 2021 at 03:42:11PM +0100, Daniel Lezcano wrote:
>> The macros for the unit conversion for frequency are duplicated in
>> different places.
>>
>> Provide these macros in the 'units' header, so they can be reused.
> 
> Any progress on this? Are you planning to resubmit?

Yes, I'll resubmit a new series.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
