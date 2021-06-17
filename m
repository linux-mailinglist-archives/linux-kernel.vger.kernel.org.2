Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660963AB772
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbhFQPaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhFQPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:30:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02120C061574;
        Thu, 17 Jun 2021 08:27:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id k8so9528043lja.4;
        Thu, 17 Jun 2021 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c2e7kNsCGT85GsTUjiDwru6wY3UfFbgVKt2c+k6Ksis=;
        b=mBmvA+aak/sfdxRTB9RvZIlo/zFa91SejUS4yQcpOmO3tp7YtLqdS2sl0orVa571cL
         SJKYU6AV1aK/4MxsHa10IjnmZdMbLme1oHAKUDJLvo9AYwc0lLlgYzY0JIYMGvd5ZnE6
         CrULLpNUBIx+hYI11Cyj8LEyHeb9r/mknWzC4Fw5JH+sK85wQQuY4nrM/AktlzRAls5G
         EpuMyhcJe2JgAKeS4umdjFk2pqi487kmiZltL5ynwBMhh7ptZzU6TEkJQl5lo0ZXNb/q
         N5lS4Y7wBTA+RpwJEylf55acqMAgFziIG+Ao0wtxXzJ+XD9Wv1t9YEY3PlTCexZgyZuk
         gSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2e7kNsCGT85GsTUjiDwru6wY3UfFbgVKt2c+k6Ksis=;
        b=LDWpClSWp6FwSVfLCOce5tSuKvSGD7aa8Uch4oEfy8hdNWnxeikbHJj8A+zmxYWujN
         7c2fHE6i+Z02PlRMR5BAHyqA9XEvzpkPQqPMi9hLnr6yRPWagKdT6MQiI+YEp421eOul
         akKEWCHWefD7VgJNHWxxFZoT9HUF8InkviKZaTERFpYw9gU6AkHfZVGJUbdF54BMniLV
         hkHETP4p863gRnlhcFJGHvsxcfX4UpjA7/3lsLGW+ck/pJsrk1xGlGCb2qoKjXp/yz7g
         /xurYxldwUXVoXTwKHILuec4wop8Mo7qOmjvi6rZtugRjlv5PkT/7hz/8tm0Wf/w1bxi
         vzFQ==
X-Gm-Message-State: AOAM532ljFyzkNq4KyWV6Cndv2g6Ci1dZ8ttp+KAUwwXkJJuaAl+Amlk
        8+wJPLLbuEuZi5QGI0a3Z2NNiF/DtAw=
X-Google-Smtp-Source: ABdhPJwxXY0YliY/v8QKwNZZ13AJaFFOGuYA0LobGWU/S5Or2aVdHYPIjW0s6+zlecbCVNV/m4QTQg==
X-Received: by 2002:a05:651c:3dc:: with SMTP id f28mr5180858ljp.294.1623943671133;
        Thu, 17 Jun 2021 08:27:51 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id o14sm610933lfg.34.2021.06.17.08.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 08:27:50 -0700 (PDT)
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20210616190708.1220-1-digetx@gmail.com>
 <20210617001243.GA3211292@roeck-us.net>
 <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
 <20210617131205.GA59767@roeck-us.net>
 <de7682c2-ae34-c594-d237-330ea33cbc78@gmail.com>
 <20210617141300.GA1366442@roeck-us.net>
 <bc3e3595-fe10-c7ae-9560-0c7676facba2@gmail.com>
 <20210617151236.GB2676642@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b97e3a75-f1aa-95a4-187d-97dc95e57e2b@gmail.com>
Date:   Thu, 17 Jun 2021 18:27:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617151236.GB2676642@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2021 18:12, Guenter Roeck пишет:
>> For now I see that the rising edge isn't needed, the TEMP_ALERT goes
>> HIGH by itself when temperature backs to normal. But I will try to
>> double check.
>>
> The point is that a sysfs event should be sent to userspace on both
> edges, not only when an alarm is raised. But, you are correct,
> IRQ_TYPE_EDGE_RISING is currently not needed since sysfs events
> are not generated.

Ok, thank you for the clarification.

>>> Anyway, the tegra30 dts files in the upstream kernel either use
>>> IRQ_TYPE_LEVEL_LOW or no interrupts for nct1008. The Nexus 7 dts file
>>> in the upstream kernel has no interrupt configured (and coincidentally
>>> it was you who added that entry). Where do you see IRQ_TYPE_LEVEL_HIGH ?
>> I have a patch that will add the interrupt property, it's stashed
>> locally for the next kernel release.
>>
>> IIUC, it's not only the Tegra30 dts, but all the TegraXXX boards that
>> use IRQ_TYPE_LEVEL_LOW are in the same position.
> I still don't see a IRQ_TYPE_LEVEL_HIGH, though.

Could you please clarify why you're looking for HIGH and not for LOW?
The TEMP_ALERT is active-low.
