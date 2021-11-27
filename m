Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050FC45FD4B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 08:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352337AbhK0Hr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 02:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbhK0HpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 02:45:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C8AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 23:42:11 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o29so9868922wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 23:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GHe52lQPyJJcrRcFsdf3wAXpXuwv3FGQUmnMtxuk+G8=;
        b=VtzAsDXfjoTowTHm486eEv9oZ9SXtBKqpfKgoqiNZme6gClmEXTZlx0imx26pQU/CM
         mKGePUUh0MrmiqlYQaKxBmCnSZphG9e8vD4qxJ6n6VTJvz6rrDuNPXFx2SiaxJ7wxKTQ
         1LZ2qfN573++Zi687lfrfcYsKkPNJCQCBn/KJBnDCe81zBdNIYRRfx4QHYDisbx1ej9z
         qPOQjV+mBnaJABor2lRBgfMp6RiF8Iem/Iyh4Dm8IjZBG9Ape6HPVVmlBfrCDIZ+brt0
         Hxc7m7zPYXuFz4FkZQ56wC+0NbeAPb95CsmEvGAgnzRgOzkKL4tO8E9XoEnNLEvgu2o4
         gnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GHe52lQPyJJcrRcFsdf3wAXpXuwv3FGQUmnMtxuk+G8=;
        b=OEcD8gaRXOREMm5WMLLGnPmgpWPqoVtAiqed2wUtcupaYFFJZIPIUiYLa6TdwcrPtb
         nvFVcldloAk3A2I3elJaq6ABh7LFZZjoO34VJ9A8ZqxfUX/PUQ4Y4VN8se6ACWKx2oVi
         SiPBW6GsMMOV9EOh+t2UizIEPPwMeb/ptRQ507umDzWlFO4pPxC9m1ek46QUAvFifnH9
         zBstEOcIuSNo+Erd6sTEF9TNlffvoWBYMfyk45gIkhL551HecMcQlsKT6mWT64LTsdOz
         Y2agxBnD0lQHgICBy2+u1RR+GjjfhEUQhEvkGhzgz/p7Vi5+pHNfaGMuFCAtETDltD0d
         O/Ug==
X-Gm-Message-State: AOAM5316dg0Zne4becR3svMKd23FTt71CiJWh8w/5LC3ynY/H3y8Wzt6
        JkF89UostJD7OgjNXsOc01A=
X-Google-Smtp-Source: ABdhPJwnSybSh98WNe17wf1KvZPFIpkFdLAQ4eiNBL5u+yTAlgICK9BbKyCsUh07uTdCHK68QJZyDQ==
X-Received: by 2002:a1c:287:: with SMTP id 129mr21683083wmc.49.1637998929855;
        Fri, 26 Nov 2021 23:42:09 -0800 (PST)
Received: from ?IPV6:2a02:8108:96c0:3b88::ac86? ([2a02:8108:96c0:3b88::ac86])
        by smtp.gmail.com with ESMTPSA id w17sm7860730wrp.79.2021.11.26.23.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 23:42:09 -0800 (PST)
Message-ID: <c4ea42f1-bacb-e7d2-1a97-ba8dd3853ffe@gmail.com>
Date:   Sat, 27 Nov 2021 08:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] staging: r8188eu: use a delayed worker for led updates
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211125162513.25039-1-martin@kaiser.cx>
 <20211126114135.18228-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211126114135.18228-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/21 12:41, Martin Kaiser wrote:
> The led layer uses a combination of timer and worker for periodic led
> updates, e.g. for blinking. The reason seems to be that blocking
> operations like a usb read are not allowed in a timer handler.
> 
> Replace the combination of timer and worker with a delayed worker.
> 
> Convert the timeout defines from milliseconds to jiffies to make them
> usable as delays for the delayed worker. Shorten the names of the defines
> and rename the work item to make checkpatch happy.
> 
> Other layers may call SwLedControlMode1 to update the led state. Such
> an update may result in cancelling the delayed worker. SwLedControlMode1
> might be called in interrupt context, we must use cancel_delayed_work to
> cancel the worker. cancel_delayed_work_sync waits until the worker is
> finished, this is not allowed in interrupt context.
> 
> DeInitLed871x is called when the driver is removed or when the system
> goes into standby. We may use cancel_delayed_work_sync here to cancel
> the delayed worker.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>   - do not block if we cancel a delayed worker in interrupt context
> 

Hi Martin,

v2 works for me without any sleeping/scheduling while atomic bugs.

Thanks,
Michael
