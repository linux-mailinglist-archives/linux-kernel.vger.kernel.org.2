Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2836F5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 08:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhD3GeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 02:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3GeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 02:34:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38642C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 23:33:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g10so13368502edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hcHFf3gTv35FziNzw1N04IYNOd/IGcKHr18KAtXIQ9o=;
        b=usj7svzaCDGTwJB0q0lWBcA+tj83ZyqEzAHyZGF5Zyy83y55/HrRdLq5GVdYfsx4wr
         jYbP0sNATPeVyQQHiTlV7as4n+rVCzzGjebAFu9cVhWdonhJhM4hlnA5xrT8I9QF2NbB
         quRJ/vVEJfKXyzvZ04KsKBeiYBS0ymMIw5po9gzlOsJNr+ovBXQoXTp50d+fi20bW3vW
         kM51jeugJcJEjgPQ296F6uAn+i/qtNrYl+OepAGGfLMQAEb4A1FtshSJCWGGT+tscBJu
         /n2NZeEBbBkGZmsIlpo844MwjKktSM/ZhEnWYsW+3AcbFq750D2ldUve9fsfNKXvcm8z
         0uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hcHFf3gTv35FziNzw1N04IYNOd/IGcKHr18KAtXIQ9o=;
        b=Az7NYs0SazZv/JX39sXkQ7TnOSKOoX9qOWC174bNkkUif9F2VRGa7IL+s8v3hyXZfF
         HzWRTHXVs6+t9wJtFS82V6OKH6O8E4STq6UJGn16dwmhPP1QSaywUPdaPwgl0gAdkJRh
         XNtZh8/oAV7Jp8Lc/Az/IGlrn9ABc71coIlX7kcqPHvvC8bYdd3HGjot5GGUXoXAD97X
         L1dE+7YIQmSSbBy/O1MyM53ygH7mgKpsQ2oF7tfKSBPSr+EasjJzzceqTkUNYxH9PXuo
         ZG+WotFW+Xiyj/KF1Sj87InpNW/hLfuy6kkpib6Uo9RHxqYsFCjYqoJFIMVh7HRA8S5t
         D5oQ==
X-Gm-Message-State: AOAM532xkd/fa771cXF4m5HXANARYf10eiPsof7UqnfbQMQhDLAmAZSJ
        9xdf1hjn9D/Ibz+r9guX8ub+3hjMWqMroz42
X-Google-Smtp-Source: ABdhPJzAmUUN7GjJhZmwW37mLPD9iFm+VR7zgvyhZMlyNVNhniWDubfvf4dujehgfL7wlO7m54TkKg==
X-Received: by 2002:a50:ed0a:: with SMTP id j10mr3770520eds.22.1619764400647;
        Thu, 29 Apr 2021 23:33:20 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::45a? ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id o6sm539810edw.24.2021.04.29.23.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 23:33:20 -0700 (PDT)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.13-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ffad0699-7966-f601-3d88-8ad1157bf2b8@monstr.eu>
 <CAHk-=whyvvZO3M9=4AP7Ci9ge2wQAjvdDrkr36bYt=Ux_rx_wA@mail.gmail.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <b965ccc0-29a7-bb82-ec23-776f00ed67dc@monstr.eu>
Date:   Fri, 30 Apr 2021 08:33:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whyvvZO3M9=4AP7Ci9ge2wQAjvdDrkr36bYt=Ux_rx_wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/21 8:40 PM, Linus Torvalds wrote:
> On Thu, Apr 29, 2021 at 12:52 AM Michal Simek <monstr@monstr.eu> wrote:
>>
>> please pull these patches to your tree. There is no new feature added
>> but it just about cleaning up some code and moving to generic syscall
>> solution used by other architectures.
> 
> Hmm. This ended up being based on the v5.12-rc1-dontuse tag.
> 
> I guess it doesn't matter all that much, but it would have been good
> to try to avoid that.

Ah. My bad. I didn't realize that it shouldn't be really used.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

