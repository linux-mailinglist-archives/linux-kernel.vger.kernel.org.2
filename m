Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5F381924
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhEONqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 09:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhEONp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 09:45:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0639BC061573;
        Sat, 15 May 2021 06:44:45 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j19so1666808qtp.7;
        Sat, 15 May 2021 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=miwRhWs+vrTjJmofc/5TY6Whmg9JKONSfLWUAA4JwUc=;
        b=cQk8s4RSnbP9NhPstGVPf0dDmfm89cUtZnN1+vOuD/GJimLQL5/c9pEIaSFwf+adhv
         w8lK2eIWaZV4Yydru9UMxAH5Hun4iI7ITCOSJNqT2NmFqXaEtJDZ+8VXWSXMxB9MLpnP
         wgC17bnAbNIUQUwN5cXgIUrY3nRA4jQQw+x+Tvcqsyv0UbrPqwg+K5avAIe48BCswsd7
         7cDBdxvlkqjGkRLV64hbV+53tkmCBOC9nNMhduVzwB2kMxtr76cLfTCnLcaOnLykz7d7
         0VOG0KW9lwOZrxJ/Ju2/AdrE1FkaHf69+F+Mqwr4PR03l4ZD/fmjz3TxHjgbEUAnKX7d
         RhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=miwRhWs+vrTjJmofc/5TY6Whmg9JKONSfLWUAA4JwUc=;
        b=RKsUBQvoTdYLbrEX4Ptf0skB61UZk5SXl11E9skLQCfTBaPh2m4yCuJOzjvZi0vlm0
         gPO/V2OguJSHN2RFiKpCAyJhgmhwdyqhmxHfOdZulJ/jNrDF7rknMPfDZIhKI+DEeZOZ
         BG3kT4ur2C0+P/8PCeNC9l0v3AEZbToZqcrzYve6m2NMtOGB/3lnvbDmXEktBbyV/Z9j
         01+4gYac2As1QcWvYfbQ95AQCqWz0WvNtZmsEaC8ggwT9TtnJRhSMiI1WM6IgchE0v0T
         fKRugGCT0BdDcJHDmeGZKauU0V2smENS/nj4rdRmS3MopDnL6xjI7Xv0g2mypHRM6zk5
         36yQ==
X-Gm-Message-State: AOAM5308dKajWUrcs07uoytegOXl0mrovsvYbjbD9OMYncBQ3tYrwv3o
        mJyyJDfYLaUW0gWiOCSJq3B8/U2aAvA=
X-Google-Smtp-Source: ABdhPJz6hR7n2wJuiyFOvLUdiQexbUP90d3eVuEpkF6kKEQEOKWDMtUaEVxX9fkMIRYZ+d6Y41j7IA==
X-Received: by 2002:a05:622a:b:: with SMTP id x11mr48519824qtw.272.1621086285160;
        Sat, 15 May 2021 06:44:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g5sm2244799qtv.56.2021.05.15.06.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 06:44:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: hwmon: (pcf8591) Unused attribute group pcf8591_attr_group_opt
To:     Evgeny Novikov <novikov@ispras.ru>,
        Jean Delvare <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
References: <141521621084257@mail.yandex.ru>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2d6122d1-e9fa-1e23-1e81-50c6ade08d2f@roeck-us.net>
Date:   Sat, 15 May 2021 06:44:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <141521621084257@mail.yandex.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/21 6:20 AM, Evgeny Novikov wrote:
> Driver drivers/hwmon/pcf8591.ko declares and removes attribute group
> pcf8591_attr_group_opt, but it does not create it ever. Is it better to remove
> it completely or to do something else?

Do nothing. Look closely at the file instead to see how the attributes
are created, and realize that the group is only used to simplify
attribute removal.

Yes, the code is a bit odd and unusual, but it is WAI.

Guenter
