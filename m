Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C514F3F52DD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 23:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhHWV2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:27:54 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34977C061575;
        Mon, 23 Aug 2021 14:27:10 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l3so15064803qtk.10;
        Mon, 23 Aug 2021 14:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mzao6RuAglEKi/SgknU3aXAdpZlFoN4tyrKHzoyQmS4=;
        b=iLRFkiHnmBAd+rrKkKPLw23RV2oYx1GpNhi/57J+sVV1+em72NdBjS/g3v7QRRMSo2
         NZn3wibCfHChZ+7pB/MM4cuBGjVfnyWh/hOsXmBUYnQLCTu4wlkpxUYEOcq1JnG144iD
         Io27CPUP1OF8i2s+F/NmeegT/e3EivXRHsw4SQ6RTHpbmmwjzF3FqT2VzZ1TqAZcl9aN
         gQmTCYzxFj4OCTgzh5p6eX7BK6v6wyJtr+1N5BL0Fl7OmDtL1gigtWPVYuFtsLxudUDX
         LpqQ3lf/73RX4apxodDj7yV9zUFxu1SvbUfhr3EbG+rKthdY/y1EUaE76u2jnyFOntmH
         PzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mzao6RuAglEKi/SgknU3aXAdpZlFoN4tyrKHzoyQmS4=;
        b=TofQKWqjB0qmZn+ke8sremdDkWOTdcHYlXeBgGbgf88RwIvFkKcknyHgZs03PEWWzL
         eWu93PLF+TPSMc6VFLC7oFHYrQsAK5AjnVR7ktQ+VFGPuNTgqTKJ43RxrZTZMAKrc9VX
         PNP+p/QWdHEgb4OODqzZM0ysFkoYqrGaJYlLabFNQSnGlFjLzwyQbvpMWHxjfvdOmX7f
         mVEGp4+D5sn8O7MlxTdG/i8zkDopMmZ7n1Kv3O3uw2Yerbltco/ImzZpTClFaKUhhF+U
         oc+yOqFbFYjvJrrHmHmrG06TG5/MFQvxiTFzGF9boNyaDQSz3WUyNVq1QMxq1wk/9tht
         kiZw==
X-Gm-Message-State: AOAM533xg0koWfe8ySnDEd/TuilNiJrcAa92hBYwXTEH7RF0Cj6SnGHf
        FOywtpJWLmI3sulTKWFlT7Y=
X-Google-Smtp-Source: ABdhPJx9GHDIH2tI5fYhVEw+ly+vaEjasLOSuEw5umnvQGYuTCqN6pBHgEK/pugTBALYHPCx/j/xkA==
X-Received: by 2002:ac8:73cb:: with SMTP id v11mr5994903qtp.292.1629754029427;
        Mon, 23 Aug 2021 14:27:09 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id f2sm7116054qth.11.2021.08.23.14.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 14:27:08 -0700 (PDT)
Subject: Re: [PATCH] of: Don't allow __of_attached_node_sysfs() without
 CONFIG_SYSFS
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-team@android.com
References: <20210820144722.169226-1-maz@kernel.org>
 <a67743f9-869b-28df-d714-db15da4ebe06@gmail.com>
 <YSPtI//SJh1CpHRP@robh.at.kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <bcb2e89f-9768-8435-35d9-d02140628b9a@gmail.com>
Date:   Mon, 23 Aug 2021 16:27:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSPtI//SJh1CpHRP@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 1:46 PM, Rob Herring wrote:
> On Sun, Aug 22, 2021 at 11:01:15PM -0500, Frank Rowand wrote:
>> Hi Marc,
>>
>> On 8/20/21 9:47 AM, Marc Zyngier wrote:
>>> Trying to boot without SYSFS, but with OF_DYNAMIC quickly
>>> results in a crash:
>>>
>>> [    0.088460] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
>>> [...]
>>> [    0.103927] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3 #4179
>>> [    0.105810] Hardware name: linux,dummy-virt (DT)
>>> [  0.107147] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>>> [    0.108876] pc : kernfs_find_and_get_ns+0x3c/0x7c
>>> [    0.110244] lr : kernfs_find_and_get_ns+0x3c/0x7c
>>> [...]
>>> [    0.134087] Call trace:
>>> [    0.134800]  kernfs_find_and_get_ns+0x3c/0x7c
>>> [    0.136054]  safe_name+0x4c/0xd0
>>> [    0.136994]  __of_attach_node_sysfs+0xf8/0x124
>>> [    0.138287]  of_core_init+0x90/0xfc
>>> [    0.139296]  driver_init+0x30/0x4c
>>> [    0.140283]  kernel_init_freeable+0x160/0x1b8
>>> [    0.141543]  kernel_init+0x30/0x140
>>> [    0.142561]  ret_from_fork+0x10/0x18
>>>
>>> While not having sysfs isn't a very common option these days,
>>> it is still expected that such configuration would work.
>>>
>>> Paper over it by bailing out from __of_attach_node_sysfs() if
>>> CONFIG_SYSFS isn't enabled.
>>
>> CONFIG_SYSFS should be automatically selected when CONFIG_OF_DYNAMIC
>> is enabled, and it should not be possible to disable CONFIG_SYSFS
>> in this case.
> 
> That used to be true, but isn't now.

OK.  I agree with you, but when I investigated the original patch
email I came to a different conclusion because of the way that I
used make menuconfig to debug the situation.

It is true when I start with a .config created from 'make qcom_defconfig',
then select OF_UNITTEST, which is the only way I can see OF_DYNAMIC.  It
is the "if OF_UNITTEST" that means SYSFS can not be disabled.

If I start with the .config that Marc supplied, then make menuconfig
still does not show the OC_DYNAMIC option, but leaves it set since
it was already set.  In this case SYSFS remains disabled because
OF_UNITTEST is also disabled.

Using '/OF_DYNAMIC' from within make menuconfig, to get more info
about OF_DYNAMIC tells me that the prompt for OF_DYNAMIC is visible
if OF && OF_UNITTEST.  This is due to the "if OF_UNITTEST" in line 58
of drivers/of/Kconfig in the OF_DYNAMIC specification.

Thus I can't figure out how to use make menuconfig to set OF_DYNAMIC
without setting OF_UNITTEST.  I tried setting OF_UNITTEST, then setting
OF_DYNAMIC, saving the changes, then another make menuconfig to
disable OF_UNITTEST, which then has the side effect of unsetting
OF_DYNAMIC.

Would you accept a patch that removes the "if OF_UNITTEST" from
the Kconfig entry for OF_DYNAMIC?

-Frank

> 
> Rob
> 

