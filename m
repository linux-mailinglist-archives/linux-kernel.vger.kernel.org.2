Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39234A06B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 05:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhCZEKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 00:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhCZEKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 00:10:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB85C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 21:10:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso1106392pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RYXNKKSLKbuWAE9mYRQ16nqU5xlOECMHxPCnTaOHxLA=;
        b=VhVRhXmudo1xSUd+HwCzGEeQ7XnkFREVP09rDN8krT+xdi6sAKoA6kAy0sP/9KDwof
         zOuOWzhio/jmFWbZGrpG0S7P6v5MrM/fWgSvCmeqssHPmWegQu2OZb3qLSBwLtHVca4B
         N5UuQ+UIOvdtgQEWR/6nYTOaqA98G/YzGh2HYvZISVbD8hxyZDEtFm85wDyhOBNNJiAX
         y7Bj+7Kjw7LJdmDSWrXSBbgFQKsUwl+zqHgXGvGkl9lLr2W22Iwz328t8gin+xAa7wNz
         vtTFfdCtFr6OtN1tkpxl9COJekLYXWkXxEhMBq8lB3SxThJmgjHm58Fe45tcHQpKSLU3
         dWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RYXNKKSLKbuWAE9mYRQ16nqU5xlOECMHxPCnTaOHxLA=;
        b=XD2rQs2r2D/8dah3wRCrqCr3jahTL69typaJ//y2SgRjHbp8s/IqKhLPdocp3l2fqz
         cekLe0vl4zM6TEr5d49R9Mcqy/CpN7R90jjmFgr1q10aiuWXOUeEQQu/qiQNr48HnVY0
         C6/u2bYnNiMc8fo5EyOCDXeyl0Ak4Df5kDaRyEyHQE1n2BiP9QVtYOy9kWVNgUbo+RoN
         GSqtmhx3RTreUaAIwScHen0cVdk4BxdSTZKRdTVYsJKrc1FTlEGREPHrSEOxkDPqwNok
         MOBRwvC4A/N9bLLaeD2UEzbjsz+KWrmLTQOfnTw95wlUaep2FYruL7wGHqj0qA0F57Pr
         Kqog==
X-Gm-Message-State: AOAM532OvUtn2FEkPtTaXMCZD+w8NgCSPrDElQQ4BXFuaQ1VOPOwK1lx
        9GMYvLS/avHipmIXB8rAQTI=
X-Google-Smtp-Source: ABdhPJy7ST4lP1rI4edPczlpoN3VdcUwMu5DN0FQV8EsXtdCmSxKf0sehHprvKyf2Zx5cyoN9TCyQg==
X-Received: by 2002:a17:902:ed0a:b029:e4:3589:e4f9 with SMTP id b10-20020a170902ed0ab02900e43589e4f9mr13598893pld.36.1616731801465;
        Thu, 25 Mar 2021 21:10:01 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r9sm6804827pgg.12.2021.03.25.21.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 21:10:00 -0700 (PDT)
Subject: Re: [PATCH v7 00/38] SCMI vendor protocols and modularization
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        etienne.carriere@linaro.org, thara.gopinath@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20210316124903.35011-1-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6bf4921a-12ad-a3b5-3dcc-d5463dd36729@gmail.com>
Date:   Thu, 25 Mar 2021 21:09:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316124903.35011-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2021 5:48 AM, Cristian Marussi wrote:
> Hi all,
> 
> The current SCMI implementation does not provide an interface to easily
> develop and include a custom vendor protocol implementation as prescribed
> by the SCMI standard, also because, there is not currently any custom
> protocol in the upstream to justify the development of a custom interface
> and its maintenance.
> 
> Moreover the current interface exposes protocol operations to the SCMI
> driver users attaching per-protocol operations directly to the handle
> structure, which, in this way, tends to grow indefinitely for each new
> protocol addition.
> 
> Beside this, protocols private data are also exposed via handle *_priv
> pointers, making such private data accessible also to the SCMI drivers
> even if neither really needed nor advisable.
> 
> This series wants to address this by simplifying the SCMI protocols
> interface and reducing it, roughly, to these common generic operations:
> 
> 	- handle->devm_protocol_get()
> 	- handle->devm_protocol_put()
> 	- handle->notify_ops->*
> 
> All protocols' private data pointers are removed from handle too and made
> accessible only to the protocols code through dedicated internal helpers.
> 
> The concept of protocol handle is also introduced in the SCMI protocol code
> to represent a protocol instance initialized against a specific SCMI
> instance (handle), so that all the new protocol code uses such protocol
> handles wherever previously SCMI handle was used: this enable tighter
> control of what is exposed to the protocol code vs the SCMI drivers.
> 
> Moreover protocol initialization is moved away from device probe and now
> happens on demand when the first user shows up (first .protocol_get), while
> de-initialization is performed once the last user of the protocol, even in
> terms of registered notifications callback, is gone, with the SCMI core
> taking care to perform all the needed underlying resource accounting.
> 
> This way any new future standard or custom protocol implementation will
> expose a common unified interface which does not need to be extended
> endlessly: no need to maintain a custom interface only for vendor protos.
> SCMI drivers written on top of standard or custom protocols will use this
> same common interface to access any protocol operations.
> 
> All existent upstream SCMI drivers are converted to this new interface.
> 
> In order to make this migration painless and to avoid the need of a big
> un-mergeable jumbo patch touching all over the protocols and drivers (like
> it was in v2), since v3 the migration process has been heavily split with a
> bit of transient code added along the way (to preserve bisectability) and
> finally removed towards the ends of the series.
> Protocols and SCMI drivers migration to the new interface happens along
> patches 10->30.
> 
> Leveraging this new centralized and common initialization flow we took
> care also to refactor and simplify protocol-events registration and remove
> *notify_priv from the handle interface making it accessible only to the
> notification core.
> 
> Patch 37 builds on top of this new interface and introduces a mechanism to
> define an SCMI protocol as a full blown module (possibly loadable) while
> leaving the core dealing with proper resource accounting.
> Standard protocols are still kept as builtins in this series, though.
> 
> Finally, patch 38 introduces dynamic SCMI devices creation to avoid having
> to update the static module device table in the core each time a new driver
> is added.
> 
> The whole SCMI stack can still be built alternatively as a module, with all
> the standard protocols included in scmi-module.ko in such a case.
> 
> On top of this series an example SCMI Custom protocol 0x99 and related
> SCMI Custom Dummy driver has been built and it is available at [1] as a
> series of DEBUG patches on top this same series.
> 
> The series is currently based on sudeep/for-next/scmi [2] on top of:
> 
> commit 908a4f778dc7 ("Merge branch 'ib-iio-scmi-5.12-rc2-take3' of
> 	 git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into
> 	 for-next/scmi")
> 
> Any feedback welcome.

You copied me on each round and thanks for doing that, I did not have
time to go look at each change, but sensors, clocks and cpufreq still
worked on ARCH_BRCMSTB with both 32-bit and 64-bit kernels, so:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
