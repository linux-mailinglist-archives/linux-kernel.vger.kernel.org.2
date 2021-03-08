Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3487C330A43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCHJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhCHJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:26:29 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD27C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:26:29 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u18so4556797plc.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 01:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Mw3YhMxze+L33OOW35Ho/s9cEaxtf/agG+UY/pcXArs=;
        b=hvV1hCXVhbql3sIE2x5KITH12j1TCohVZgr541DF/zxzZs2XPgdAnRxc1thDIHgSZe
         qceBGfqVr+ZsnSdEZ86dXUHxCuQDbEkO48qvc0su5Gbh/clbE+H7nacjp1B/9A2WoYxI
         kw4c7sMRYnTG6M+NmT8Ede+uMewZm+3JWNrX3RbQBVNhDMCGX2Cg5M0bZH4jUuDHIidw
         6Vm8xT/Rz966POOGXHJtVx0LPi1o+9ARnIL0PvPvzNy/LSy8qfZgW8jnpdte51XWxBwj
         VUv5NxzXNBeC6lVx6N0mAnKIO9/Vui7BTPJVVuJ3o8j7KCpD7R/k+LNfdEEY6rgRuGGr
         vgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Mw3YhMxze+L33OOW35Ho/s9cEaxtf/agG+UY/pcXArs=;
        b=kWpAHapVlZoMD4fGlCVZYOpHhusY0q24lVCf+RH+gVLXyFarDMHx/8ttWeFmKL6YhP
         gb2kTo6eD8OOHJIU/0XL8hFuvJ5/27XMOK2wRTDTeVUrTuBj2eK5CYVbmp+VSgj099uF
         adFbBu+v9360obCE2464JxCw+hPyFL5WcqsBVV7Yfg4Eya0LW52vZ0eIpSIjHe7n2dxY
         N1XRTqqqp/OBuX+iHrU3jza7PmfBSsfHpoZx4sYOLkfg9qjXTZvN+dtB2XPWCyoVHLvE
         jGUP9cO+CN2KzRwm58zP1NuYLfV8NrNH8Ld/oTVuZquIDT8ziTSdkSKTdC24/NAPl7ox
         hQ0w==
X-Gm-Message-State: AOAM532pbvS2yBOiv0aobFldCxFA6jv1UlUUVr3n0+/u/zhShrN7JKBS
        JBqV465m8l0aGxQBP2Xk5guyb8gMIod880KT
X-Google-Smtp-Source: ABdhPJxlPBadOVC2V3yLEF0pVBVAi7/notfNs+wqE4D5BV1pj3tj1U1TpfdDJMHmyTZN9iHH8zrjVg==
X-Received: by 2002:a17:90a:8408:: with SMTP id j8mr22411294pjn.1.1615195582670;
        Mon, 08 Mar 2021 01:26:22 -0800 (PST)
Received: from [10.187.0.14] ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id k13sm10095045pfg.3.2021.03.08.01.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 01:26:22 -0800 (PST)
Subject: Re: [PATCH] gpu: drm: i915: fix error return code of
 igt_buddy_alloc_smoke()
To:     Chris Wilson <chris@chris-wilson.co.uk>, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, lkml@SDF.ORG,
        matthew.auld@intel.com, rodrigo.vivi@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20210308085952.8153-1-baijiaju1990@gmail.com>
 <161519509650.8241.14778072091965189208@build.alporthouse.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <d01ccf05-abbf-7f65-396d-31735d9b31f1@gmail.com>
Date:   Mon, 8 Mar 2021 17:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <161519509650.8241.14778072091965189208@build.alporthouse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/8 17:18, Chris Wilson wrote:
> Quoting Jia-Ju Bai (2021-03-08 08:59:52)
>> When i915_random_order() returns NULL to order, no error return code of
>> igt_buddy_alloc_smoke() is assigned.
>> To fix this bug, err is assigned with -EINVAL in this case.
> It would not be EINVAL since that is used for a reference failure, but
> in this case the idea was to return 0 as no testing was done and the
> ENOMEM was raised before testing began i.e. not an internal and
> unexpected driver allocation failure.
> -Chris

Okay, thanks for your reply :)


Best wishes,
Jia-Ju Bai
