Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B80381929
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhEONtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 09:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhEONt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 09:49:29 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88291C061573;
        Sat, 15 May 2021 06:48:15 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 5so1058468qvk.0;
        Sat, 15 May 2021 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gSN+oBo25nm5oFQGDCy11Y2eXGQsHW25HeP+shJpfo8=;
        b=oYKPMiaAx537Yp9eJbDh+ERk8pULEoGG86qE6MLNja3T46bmHPBDfWVPELSH6Wdx3L
         9Qe/U4m1VbsaAXKclUaGLiJyc3T/bO6aUqO+n9paq0b3A5E5e4OpsLSCsKfehgFpmRj3
         vFOHUWB4a2OcKCoXZE4gf7hLbHPHKLiN2TyeWFoWQwqmw07dnbkkwx2TI6UJFTSA8lNB
         F0YKgNhHwD97r1vx9kwkSO3hCPgNG4A+OUublqEPOCa8wvOqbavvi+1Fg540hxBQBurd
         jtV/ddzRGsYBgR2K5XuxuUihaPgzpIN8YTGrsf9TM58DJIqSZr0yt6OlqO9uh3iFTrpk
         oPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gSN+oBo25nm5oFQGDCy11Y2eXGQsHW25HeP+shJpfo8=;
        b=ShlQ2sM39Jxf4hALAvlonWQBnoggTc5ZHjaC8LK7cmWgY7TO5hZ2OqEuITUqth6fBP
         9oPkd3wNp//QdK6X4wg/a1dp6gLRhLeo6GOR5mxHaxgeS7cgBIKnxRYl8VfI0NFU48yY
         geuJovjFyv9LNebOE2QqXcopE2y1/IVWSnAELpgYp3/ajgVgjiSfRUICiMMHxjLEKpgB
         GJaz7z9l4BQTaQLZM63Y9m9Zdqpew7umKsApqOpUWuzDhIw9qAfKPl/AoV/LgQb9YeAE
         rAf4c2a2pYptmbRzZd/ETKdM2crmLgp4RCRGAi3KRd/qn22GQs1zhfy4okqFdPy9oj5j
         gJnw==
X-Gm-Message-State: AOAM533lF/qufo/zrNNDrN5djbQ2p36MnBqARBZ+U4DXjtSW5KgPjZZC
        E5hyP7/toyfKbJ/pyiD4UoslxkXVIr0=
X-Google-Smtp-Source: ABdhPJwSn+TpD4N5hpql5WCz9M5hicsg93h0hglPYykKof6p+9Rib8QS/9uUJldEIzAgaZdKhS6zhw==
X-Received: by 2002:ad4:5a52:: with SMTP id ej18mr6885311qvb.31.1621086494701;
        Sat, 15 May 2021 06:48:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h10sm6955465qkh.47.2021.05.15.06.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 May 2021 06:48:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: hwmon: (w83781d) Unused attribute group w83781d_group_other
To:     Evgeny Novikov <novikov@ispras.ru>,
        Jean Delvare <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ldv-project-org <ldv-project@linuxtesting.org>
References: <141331621085123@mail.yandex.ru>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ed3df026-3d47-45bf-dd1b-c0f2dc5cd02a@roeck-us.net>
Date:   Sat, 15 May 2021 06:48:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <141331621085123@mail.yandex.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/21 6:29 AM, Evgeny Novikov wrote:
> Driver drivers/hwmon/w83781d.ko declares and removes attribute group
> w83781d_group_other, but it does not create it ever. Is it better to remove
> it completely or to do something else?

Do nothing. The group is only used to remove the attributes.
The attributes are created one by one, not using the group.
This is WAI.

Oh, there _is_ something you can do: Fix the Linux Driver Verification
project scripts to no longer result in those false positives.

Guenter
