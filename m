Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A65433B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhJSQBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSQBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:01:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6200C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:59:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so3554489wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TrPkKI/PTQOY+KiTWvxkvriPYak1YRQZt1dLiDrFKEM=;
        b=vomS9y1WQIrU5vL3leRMaAFA04AJAdX6pRwkbNerk0ePSi7S8rEbj4lC6TaIZLE+op
         6/N/cP+m1ZOCIHqwQVCx4RHAsZlAnuNprphwxK6CjdDFlyTW/r72Kryv2N8fXCAG4Lm+
         9TpMbmcLznbTzgnJVbm3kLoXD10i6DLmjeWUZ/zgPJOHOUcU0BPH5Eh0Ai7yfMn4/HoG
         4VaThQ3PvaOUMxXoqGg2Qy49EKNMjfb+T/Fl3FNmBl/IiDo5G21kPswFyKEBzQ/uiJLC
         iUVnYJd10dJYUE5+3J9sEkVgwpl8+TsWy60h43VDHBN0kPgDt5KV7Qo3d2kKZRhPGL8i
         2/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TrPkKI/PTQOY+KiTWvxkvriPYak1YRQZt1dLiDrFKEM=;
        b=4BHX5wawwaThjdKZXYxBXWEALNTLTAO4ReVsp1k6HSQBNReFaoDEKCmJ6aJn7U/R/V
         fQQCVAuUESmMjCosyeNHq9aXrLCJzf+Hem6umye7BzGDjOZCQhgc4DWMoo6ImVOHYovw
         wg4heN/PU7b4jZs4tQzmZpwS4JNX3S7F6ROJY8sjT0IbnUtruIFaoXQ6ckoQKrA2fCaf
         S3cQ2frA5puQqW3ZnSIPrH3rBzV25J7hYssmKz+2AjlHqwH6DO2fsGDbbZgc4SwzLVFV
         syGje8Fe5oSbPPgpd61W9cc2bRCCP0SVzPC1E+FpH6Js5sYuU6NKdvMZ/mXUtFx+AVoi
         0AjQ==
X-Gm-Message-State: AOAM532Y7syqOZ5EyxyQJVq21H01U841ZMot3d6wxP132iHKktmIyCR1
        GQ8yRE+tI7Iv4g1Ze9tN3mBlNg==
X-Google-Smtp-Source: ABdhPJzEqFeFsW6w8uGlaAXHzzXDQJ/vOM1kPtnGLvkKUtgoFYLuZA+nEJj+ls0gvvR0HORl54YLig==
X-Received: by 2002:a1c:20cc:: with SMTP id g195mr1827307wmg.22.1634659165173;
        Tue, 19 Oct 2021 08:59:25 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4799:198d:b6ef:8da7? ([2a01:e34:ed2f:f020:4799:198d:b6ef:8da7])
        by smtp.googlemail.com with ESMTPSA id o6sm2871742wms.3.2021.10.19.08.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 08:59:24 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal/core: Make deprecated cooling device state
 change from userspace
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20211019150203.2805738-1-daniel.lezcano@linaro.org>
 <20211019150203.2805738-2-daniel.lezcano@linaro.org>
 <CAJZ5v0i1RCKs8nMCc0ROsM03beOPL941r+=NPbQpidiZJ2OA8A@mail.gmail.com>
 <CAJZ5v0hLVb=vbyxtraoBgPBWb8FkjzpPtH+10_AY4E8CDgc5sA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7a6ba739-a7f4-8553-187b-6c0f6dc9a208@linaro.org>
Date:   Tue, 19 Oct 2021 17:59:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hLVb=vbyxtraoBgPBWb8FkjzpPtH+10_AY4E8CDgc5sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2021 17:43, Rafael J. Wysocki wrote:
> On Tue, Oct 19, 2021 at 5:40 PM Rafael J. Wysocki <rafael@kernel.org>
> wrote:
>> 
>> On Tue, Oct 19, 2021 at 5:02 PM Daniel Lezcano 
>> <daniel.lezcano@linaro.org> wrote:
>>> 
>>> The cooling devices have their cooling device set_cur_state 
>>> read-writable all the time in the sysfs directory, thus allowing
>>> the userspace to act on it.
>>> 
>>> The thermal framework is wrongly used by userspace as a power
>>> capping framework by acting on the cooling device opaque state.
>>> This one then competes with the in-kernel governor decision.
>>> 
>>> We have seen in out-of-tree kernels, a big number of devices
>>> which are abusely declaring themselves as cooling device just to
>>> act on their power.
>>> 
>>> The role of the thermal framework is to protect the junction 
>>> temperature of the silicon. Letting the userspace to play with a 
>>> cooling device is invalid and potentially dangerous.
>>> 
>>> The powercap framework is the right framework to do power capping
>>> and moreover it deals with the aggregation via the dev pm qos.
>>> 
>>> As the userspace governor is marked deprecated and about to be 
>>> removed, there is no point to keep this file writable also in
>>> the future.
>>> 
>>> Emit a warning and deprecate the interface.
>>> 
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org> --- 
>>> drivers/thermal/thermal_sysfs.c | 2 ++ 1 file changed, 2
>>> insertions(+)
>>> 
>>> diff --git a/drivers/thermal/thermal_sysfs.c
>>> b/drivers/thermal/thermal_sysfs.c index
>>> 1c4aac8464a7..730f1361dbef 100644 ---
>>> a/drivers/thermal/thermal_sysfs.c +++
>>> b/drivers/thermal/thermal_sysfs.c @@ -610,6 +610,8 @@
>>> cur_state_store(struct device *dev, struct device_attribute
>>> *attr, unsigned long state; int result;
>>> 
>>> +       pr_warn_once("Setting cooling device state is
>>> deprecated\n");
>> 
>> Maybe dev_warn_once() even?  I guess it won\t hurt to print it
>> once per the affected device?

Actually, there is no difference except it will be prefixed by the
device name.

As the static variable to write once the message is local to the
function, not the dev, the warning will appear only once even if we use
dev, or cdev->device.

The other calls in the file are pr_warn. I suggest to stay consistent in
this case. Is that fine ?

>>> + if (sscanf(buf, "%ld\n", &state) != 1) return -EINVAL;
>>> 
>>> --
> 
> Also I think that changing the subject to something like "Deprecate 
> changing cooling device state from userspace" would help.

Ok


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
