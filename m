Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF76456E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhKSLjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbhKSLjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:39:16 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A9C061574;
        Fri, 19 Nov 2021 03:36:14 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q25so21479232oiw.0;
        Fri, 19 Nov 2021 03:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+HQ+r21ViS1zY/XFw0FQwQ4LY4L5mHZUk1SHH1fhM4=;
        b=Cmd4vp3AW6JwSbZeWsnovSgI6by7+h5WUnQxr0lX6KC5HfvKCJMy0/JqJGfKrEh3pe
         8YDLeyqIaxnUg6RqyqjnBAmiboE8Ny7rBm7VgmFZ44N3eUk3pQKJwtFqV4xSIiayv+he
         oy4YNlaQktN6gMWzZtldPTF2gTbxihs1lR3QLl2+zUUkcfthMLD3nbiF+qQRwTGSvD7I
         r/9aot3UxWwpqB1BHHsxsmlpFvDgwfcnmK5nBww+lQKwv+gYoObheOXa1fsTgieCWEJZ
         upLP1PqkWcFpJU0h19nQnL3ieg1fFKyDOfHagap0sYsfJU61HI9m8I0J0wjLlgLJxATr
         Omwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+HQ+r21ViS1zY/XFw0FQwQ4LY4L5mHZUk1SHH1fhM4=;
        b=Y01LdbntErVSnBigVbg0s+GmaB7bL++V6tqL/vbS8Tzd9onTdATUPEJqLn7mUMMGVz
         pgK6UiQdI4s2Db82XMTXTZ1d9w62CVgHmzZZXEM6OzbmyJ3MySLR90uMI/vIdKlECyn1
         +0y2GK8U2dTHMan/IjcEfKs9KAUeU+FD6KeD5ZlQqaiblU8lzEmwgdlokLL/h90F/f8Q
         LhkryBYBVKtGvCfNyy1l3zVIPF17qWrpDwfY+HOo1TezafVaVuiK62X8cVR5/ephEBYC
         1wPHZJ7juXJKdZ4b1WklvVspqcw9ubGDaAmAi7iKjGNeR1+T3FJV+boLeB0K1oliYt2a
         reIw==
X-Gm-Message-State: AOAM531TFl54fXYTzzM/e9NYk73wG0wH2ldRbiVkqxM3uYoSRMZjJ7f9
        ekU+qaiNTvwiwKjIVJbvb/mnAwjh97g=
X-Google-Smtp-Source: ABdhPJw+qGmW9tHCSLtWT35tqWAeN1SpSRNcGUhcL81PWpTcBO1BUPc8XRgQBJED48X+HVElDSDpkg==
X-Received: by 2002:a05:6808:7db:: with SMTP id f27mr4345868oij.83.1637321773628;
        Fri, 19 Nov 2021 03:36:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12sm493987ote.75.2021.11.19.03.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 03:36:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v12 0/2] Update ASUS WMI supported boards
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     eugene.shalygin@gmail.com, andy.shevchenko@gmail.com,
        platform-driver-x86@vger.kernel.org, thomas@weissschuh.net,
        kernel@maidavale.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211116205744.381790-1-pauk.denis@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f0bf01fa-ccd8-3a6a-8fd2-4c785fa212ef@roeck-us.net>
Date:   Fri, 19 Nov 2021 03:36:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116205744.381790-1-pauk.denis@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 12:57 PM, Denis Pauk wrote:
> Add support by WMI interface provided by Asus for B550/X570 boards:
> * PRIME X570-PRO,
> * ROG CROSSHAIR VIII HERO
> * ROG CROSSHAIR VIII DARK HERO
> * ROG CROSSHAIR VIII FORMULA
> * ROG STRIX X570-E GAMING
> * ROG STRIX B550-I GAMING
> * ROG STRIX B550-E GAMING
> 
> Add support by WMI interface provided by Asus for X370/X470/
> B450/X399 boards:
> * ROG CROSSHAIR VI HERO,
> * PRIME X399-A,
> * PRIME X470-PRO,
> * ROG CROSSHAIR VI EXTREME,
> * ROG CROSSHAIR VI HERO (WI-FI AC),
> * ROG CROSSHAIR VII HERO,
> * ROG CROSSHAIR VII HERO (WI-FI),
> * ROG STRIX B450-E GAMING,
> * ROG STRIX B450-F GAMING,
> * ROG STRIX B450-I GAMING,
> * ROG STRIX X399-E GAMING,
> * ROG STRIX X470-F GAMING,
> * ROG STRIX X470-I GAMING,
> * ROG ZENITH EXTREME,
> * ROG ZENITH EXTREME ALPHA.
> 
> I have removed "ROG STRIX Z390-F GAMING" from list of supported boards in
> asus_wmi_sensors that I have added by mistake. I had misunderstood a
> comment in the [1] issue.
> 
> I have added separate records for each of modules in MAINTAINERS file.
> Before it was one shared recors for both of modules.
> 
> Could you please review?
> 

Series applied to hwmon-next.

Thanks,
Guenter
