Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7C34001A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349563AbhICPBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349488AbhICPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:01:35 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46937C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 08:00:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r6so5463467ilt.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jfZB8OkBcB081S0FD25QcCEM0bi7QUTw/fueJBK6u9s=;
        b=yL+oNzXd4MUz0/xLQGpCuc+BzqS+ueBGFvD3CGRREXLaw4+gGCh72XFoFiXNLLftQW
         MndRazWQaNRu1MubbxbFmgzQjiVfH38fYT4wCNyapaf7PmO5p53xVqV7nctONfWLEOWD
         nHB4/tbNzjXYyytiJr+/UXTpD2ctUsAiDgmsIYCUH2VGle9Gp78vi3OwCfs939eiUGBB
         pKKKmGdyiAegLyqOLnwIUKG0oRXqr0InBhp4Cly9igwARfn/VXLOCi0zGttp3HkMWaUx
         VuSFOYuuPOGl6RcmP7yyh1aeb6p68021H9fyQin8P0M+iVEJ+iT72QrnQkGY4h5QgXWQ
         pdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jfZB8OkBcB081S0FD25QcCEM0bi7QUTw/fueJBK6u9s=;
        b=FAb/JYUtKhcnbK2PqVxW3jwXeH2BJ72X4Ij4vhsZR1OhnyE5JGesWPIvqWmAgrUekt
         +uk1gnzlD7GQ+mKaxJmFN3qpDxLd5Co9/vgjawVSFUPnDVzkwTZtKsydqjJK4YjWttXW
         CFotvMygFlrTpGfO73OXejNmrKal+sLVsARuAf/5NDcYIRn9HUj/vXoe4ElOy2KarDSR
         M9HYFAR2zCAgSkMsKJEeP1m0qz2ERkjtokekoPk+MNNq7XGkN9giejtvx/WObgBBNz15
         Xd5y6oQADIxolAGyfN/66Ou8cjirpgocnUyAR4Z25kd62OaogCciHg/YLZozNFFePI9K
         P6yQ==
X-Gm-Message-State: AOAM5323k4XEjCXmraBVwpwQGWrnUJ2vkpgemV1zG12AYndkvcNTDGQu
        omVfzcBYTClQZ3L71gvHhdlZFA==
X-Google-Smtp-Source: ABdhPJznCE4y8jicDtqhI2aZI28qn0fp+MtSC/RUF33c/nbiU3sTUCjsHmQrIsQmH8NW9NqR8+9T/g==
X-Received: by 2002:a92:cb04:: with SMTP id s4mr2881154ilo.130.1630681234607;
        Fri, 03 Sep 2021 08:00:34 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l15sm3003669iow.4.2021.09.03.08.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 08:00:34 -0700 (PDT)
Subject: Re: Bug: d0e936adbd22 crashes at boot
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, inux-pm@vger.kernel.org
References: <942f4041-e4e7-1b08-3301-008ab37ff5b8@kernel.dk>
 <c56cde110210bec6537fe69b495334c6c70c814e.camel@linux.intel.com>
 <3ac87893-55ba-f2d4-bb1e-382868f12d4c@kernel.dk>
 <7f115f0476618d34b24ddec772acbbd7c0c4a572.camel@linux.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <767fe00f-bf31-1eb0-09cc-1be91c633bb4@kernel.dk>
Date:   Fri, 3 Sep 2021 09:00:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7f115f0476618d34b24ddec772acbbd7c0c4a572.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/21 8:38 AM, Srinivas Pandruvada wrote:
> On Fri, 2021-09-03 at 08:15 -0600, Jens Axboe wrote:
>> On 9/3/21 8:13 AM, Srinivas Pandruvada wrote:
>>> Hi Axboe,
>>>
>>> Thanks for reporting.
>>> On Fri, 2021-09-03 at 07:36 -0600, Jens Axboe wrote:
>>>> Hi,
>>>>
>>>> Booting Linus's tree causes a crash on my laptop, an x1 gen9. This
>>>> was
>>>> a bit
>>>> difficult to pin down as it crashes before the display is up, but I
>>>> managed
>>>> to narrow it down to:
>>>>
>>>> commit d0e936adbd2250cb03f2e840c6651d18edc22ace
>>>> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>>> Date:   Thu Aug 19 19:40:06 2021 -0700
>>>>
>>>>     cpufreq: intel_pstate: Process HWP Guaranteed change
>>>> notification
>>>>
>>>> which crashes with a NULL pointer deref in notify_hwp_interrupt() -
>>>>>
>>>> queue_delayed_work_on().
>>>>
>>>> Reverting this change makes the laptop boot fine again.
>>>>
>>> Does this change fixes your issue?
>>
>> I would assume so, as it's crashing on cpudata == NULL :-)
>>
>> But why is it NULL? Happy to test patches, but the below doesn't look
>> like
>> a real fix and more of a work-around.
> 
> This platform is sending an HWP interrupt on a CPU which we didn't yet
> bring it up for pstate control. So somehow firmware decided to send
> very early during boot, which previously we would have ignored it
> 
> Actually try this, with more prevention

I can give this a whirl.

> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index b4ffe6c8a0d0..6ee88d7640ea 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1645,12 +1645,24 @@ void notify_hwp_interrupt(void)
>         if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
>                 return;
>  
> -       rdmsrl(MSR_HWP_STATUS, value);
> +       rdmsrl_safe(MSR_HWP_STATUS, &value);
>         if (!(value & 0x01))
>                 return;
>  
> +       /*
> +        * After hwp_active is set and all_cpu_data is allocated, there
> +        * is small window.
> +        */
> +       if (!all_cpu_data) {
> +               wrmsrl_safe(MSR_HWP_STATUS, 0);
> +               return;
> +       }

What synchronizes the all_cpu_data setup and the interrupt? Can the
interrupt come in while it's still being setup?

-- 
Jens Axboe

