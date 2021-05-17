Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6821383CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhEQTK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhEQTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:10:58 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529CBC061573;
        Mon, 17 May 2021 12:09:41 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id l129so6871115qke.8;
        Mon, 17 May 2021 12:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AaJatBQ6OYQTtgU7UHzX0hFSZvnFSb6xpuL4KTh9MtI=;
        b=R5DIbv1+g1uOPJzqmkjwdMYfT/EA9OdSUS2Cq07wjeKPJxIlSh8+YeVJyHSmqCJJYy
         pEJs8+DlEYM7KE9pgm8s/rIdd7NoaUIrAu9C4yP4JWgXnel5EerWloYlHSSI1ZpOjjeR
         B4F65zx0Qhar6SiLmlwFf810bxJZzOljBJbCHcm9fSy7a02lAtHreWo09K7N0X6poh8F
         Vy2zOuys0FTeShZQGct4UsMn8RjfPo+0m2FD1XuaskK/clfHMcJNiiiyOWYnIJfzIs+i
         YmWnChd92e+DMTzTOWl8EaLSKNA10EtEd9EJs/6UfpOZR2jKa4zMSxwd9QnolTBTvkk5
         tlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AaJatBQ6OYQTtgU7UHzX0hFSZvnFSb6xpuL4KTh9MtI=;
        b=NB+Gj/kLQUF9Z7qxfN0svByHgO5fZ96LzI5e55nEZMAW55X5VPOnDwmrNEOR3ciFMp
         /Wxe+fusvljdeR6cN0mQiz7UW8USXZBu9Bj6lxkpBPgctVSKNBQdpNd2DkkcUZR5LKuB
         0u9lCPZktqMTMbnkj63Aiu9xfR/dhmtdtjYD8pIgF0Tk9TOc1lPxppHlpmZZHOOSy8E4
         9xBuNxrz7z9Y2IdNJaguSbFA93qu+4Bm3FY/wj01WvmKK7bfB1YrH9y3oPgg1pGFlbEi
         ZXJsSzElrE2dXWQBJcf8Se2zJah0Wce2rxMWoWI1DTeDQ/qhBhIOhAd/rXdrYUptnyJo
         DpMQ==
X-Gm-Message-State: AOAM530atFFMciR8+NkUhy45QHGnHfr5jPZYPq1fNSOibJlMd4673BS0
        jh1hks90FxmKdXfFrbbCyYJYqRsE73o=
X-Google-Smtp-Source: ABdhPJzoO/fJ8E1N10zXVLOT/35WBvGZbzAE8Q7sKzEeLW27fmGGe/PpRnvMnGIcBI+cL8c/aLGrTw==
X-Received: by 2002:a05:620a:14b5:: with SMTP id x21mr1364351qkj.298.1621278580627;
        Mon, 17 May 2021 12:09:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p9sm12175630qtl.78.2021.05.17.12.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 12:09:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: (adt7462) Add settings for manual fan control.
To:     Ashwin H <ashwin@pensando.io>, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, snelson@pensando.io
References: <20210517182427.12904-1-ashwin@pensando.io>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e30343c0-2e8e-9412-08ed-f839e998248d@roeck-us.net>
Date:   Mon, 17 May 2021 12:09:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517182427.12904-1-ashwin@pensando.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/21 11:24 AM, Ashwin H wrote:
> ADT7462 can operate in manual mode for fan control.
> Currently if we want to read fan speed,
> there is a check if TACH measurement is enabled for a fan.
> (In fan_enabled function).
> There is no way to enable TACH measurement currently.
> This is addressed in this commit.
> 
> Along with the above support few more features are enabled
> - Support for setting fan presence.
> - Support for setting low and high frequency mode.
> - Support for setting easy config option.
> - Support for setting the duration of the fan startup timeout.
> - Once the setting is done, there is a setup complete bit in cfg1 register.
>    Settings this bit will start the monitoring of all selected channels.
>    Added support for that.
> 
> Based on this, below is the flow to set/get fan speed (example:pwm1)
> 
> echo 1 > pwm1_enable            #Set to manual mode
> echo 1 > pwm_freq_mode          #High freq mode (optional.newly added)
> echo 1 > fan1_presence          #Set fan 1 as present(newly added)
> echo 1 > fan1_tach_enable       #Start TACH measurement-fan1(newly added)
> echo 1 > setup_complete         #Mark as setup complete (newly added)

Please refrain from adding non-standard attributes. Several of the above
non-standard attributes can be expressed as standard attributes, which is
even less acceptable.

Also, please follow Documentation/process/submitting-patches.rst, which
clearly states

	Separate each **logical change** into a separate patch.

Guenter
