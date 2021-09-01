Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FF3FDD1B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbhIANQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbhIANQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:16:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A8C0613A3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 06:15:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g138so1847177wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZJ1ShBvERXE8NJcgrC2YbDFePHvYv0jlDQrPsvc3VFw=;
        b=AHjEXIzMKU5DvTRjxziioS6maD1NUDuXDvmVF0dw8SY3s00PkZTgAKCFQaG5VV17/4
         jlBUpgu30gQhBLIErVIKTjzKdrgMudqaUu5lskTMWmdNjkftzM5Ml0QYeI+keYQduNwH
         0kabGRBE1NphoreJmQnqulLGzggh0GQevtL9udRevrGFVIzo8n+MzBihg3Pf80XFlwCl
         ieAW9kpVT2cp1ZY6tN2E7HVryMGV+35KIxePcjxrODr36UBWLhRXKM5yCkSTUGa7ltml
         DEBkbUla2lw/eTK0ZHPm+FwjKw+X0kuZKYU5n5Z+pE3SaRyWbPWobfISDWhd+hjA30m2
         83PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZJ1ShBvERXE8NJcgrC2YbDFePHvYv0jlDQrPsvc3VFw=;
        b=igaxQcvi+BvVTP1TVtsxq9hx9v06RQ0swXxQZLSiZ9Ka4EPymvOCcdUDD5b6zNp9Hv
         VabMk7zjzFelFjEg8BiMdZRn807Kmqz0aPXkNir6Stium72bwLApuil6RqFhhwDzWNT2
         PyU5LM5d44HQh7m2BUVMmUclA/xOS0FPff5BSpEP98DwXp2zt1sPpOIThBhpMsCXMo2+
         PEIj+0RyvQ1+a4r9KgqK+zOIaUACVEFhC4XtJr+vxZnpP0N729Pz02l3Rl1hTBQo8kb0
         sakuhQ5zqAuh2usqpwRnVZLcPJ1wp2ddxYtof/dIO3YgHZ8yo943kXe5UHKoUai6H0c9
         QNCQ==
X-Gm-Message-State: AOAM531vIyWd5nNIFqQIi3oOnNpT8Gkj/iF4gyYS9MMV7uMy2KfL0ytA
        NZosPRvhhiGPx2x8uLFSRnPBZlJ1PxsUjg==
X-Google-Smtp-Source: ABdhPJwpXNc7JmkOl6sW/c8wpqPEEZ+cnPv41Ub2/rO70HdAAVP2nx/GEepEFJiZL/4Eujp/OVxH4g==
X-Received: by 2002:a1c:28b:: with SMTP id 133mr9641042wmc.138.1630502114478;
        Wed, 01 Sep 2021 06:15:14 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:7c9e:cf18:6a35:10e2? ([2a00:1098:3142:14:7c9e:cf18:6a35:10e2])
        by smtp.gmail.com with ESMTPSA id t14sm21321972wrw.59.2021.09.01.06.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 06:15:13 -0700 (PDT)
Subject: Re: [PATCH] xhci: guard accesses to ep_state in xhci_endpoint_reset()
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Bell <jonathan@raspberrypi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210831160259.2392459-1-phil@raspberrypi.com>
 <3830571c-566c-ef13-bc08-60206a634253@linux.intel.com>
From:   Phil Elwell <phil@raspberrypi.com>
Message-ID: <f2fa6738-29f1-3434-70f2-7fba0b1b2567@raspberrypi.com>
Date:   Wed, 1 Sep 2021 14:15:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <3830571c-566c-ef13-bc08-60206a634253@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 01/09/2021 10:21, Mathias Nyman wrote:
> On 31.8.2021 19.02, Phil Elwell wrote:
>> From: Jonathan Bell <jonathan@raspberrypi.com>
>>
>> See https://github.com/raspberrypi/linux/issues/3981
> 
> Thanks, so in a nutshell the issue looks something like:
> 
> [827586.220071] xhci_hcd 0000:01:00.0: WARN Cannot submit Set TR Deq Ptr
> [827586.220087] xhci_hcd 0000:01:00.0: A Set TR Deq Ptr command is pending.
> [827723.160680] INFO: task usb-storage:93 blocked for more than 122 seconds.
> 
> The blocked task is probably because xhci driver failed to give back the
> URB after failing to submit a "Set TR Deq Ptr" command. This part should
> be fixed in:
> https://lore.kernel.org/r/20210820123503.2605901-4-mathias.nyman@linux.intel.com
> which is currently in usb-next, and should be in 5.15-rc1 and future 5.12+ stable.
> 
>>
>> Two read-modify-write cycles on ep->ep_state are not guarded by
>> xhci->lock. Fix these.
>>
> 
> This is probably one cause for the "Warn Cannot submit Set TR Deq Ptr A Set TR
> Deq Ptr command is pending" message.
> Another possibility is that with UAS and streams we have several transfer rings
> per endpoint, meaning that if two TDs on separate stream rings on the same
> endpoint both stall, or are cancelled we could see this message.
> 
> The SET_DEQ_PENDING flag in ep->ep_state should probably be per ring, not per
> endpoint. Then we also need a "rings_with_pending_set_deq" counter per endpoint
> to keep track when all set_tr_deq commands complete, and we can restart the endpoint

Jonathan, the author of the patch, may give some detailed feedback on these 
statements when he has a moment - "Well, sort of... it's complicated" was the 
summary.

> Anyway, my patch linked above together with this patch should make these errors
> a lot more harmless.

Yes, I think that's true. We have a downstream patch to warn about a pending
Set TR Deq Ptr command but proceed anyway, allowing systems to recover, but with 
the additional spin lock usage our users are reporting no failures _and_ no
warnings.

> Let me know if you can trigger the issue with both these patches applied.

We've not tried your patch yet.

> I'll add your patch to the queue as well.

Many thanks,

Phil
