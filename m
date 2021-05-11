Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108937A256
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhEKIl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:41:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860BDC061574;
        Tue, 11 May 2021 01:40:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s8so19254212wrw.10;
        Tue, 11 May 2021 01:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8P8YUXV3r09GjsOJAGpWzwWQ5lBClxrJsUsHflmR2xo=;
        b=mgnOS45VL1Yx9S7uYp5mwYv5ODZAnRHFdlMb2+hrv/poajlBb6dNbpsxZhsPt553FQ
         IhzRFrYF4P9x2rO0lYEAd8BIceEo90NYhQ+XuT+e0MKspurfyKzYjclLSxIJ6M4JPjiZ
         +uEErshLiue6pcNllcIHF/gcLzJitGEXSv0+hOskks5rLeeSQ4nIIrvulcUFZLYTPZEC
         4iR+6eVufZmo0101C+GEZHbZIJxuVZpQcjlAvyxjV34VMIRWbiaN2XFKg8Xcm+dfEhBu
         ZurFMiStU7rGZiW8WYf5WNRzQ8qrJ91EGqCKqRgi4rHyxJgYWIXam6375DVgs0KcwBOU
         mGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8P8YUXV3r09GjsOJAGpWzwWQ5lBClxrJsUsHflmR2xo=;
        b=mafMTiPQ6ahv205r5DRsjoo7lTyaqYQPG1ed7G1PgDHP4hLwBq4hfa36x+Lz7IPZ3y
         BT+GSaJUNImWZqvN8AbYkVKKC0i+tW2DAN1u806HRtW46L7bZsyBvCj3na2kyk6e9f1X
         brmiKYoJf/pgNR6vEWBNgAHZDnAd4VQZOxTjdyPszYYDlEVPC9hUGA5eDR8lBrcalwft
         1W1OUpAxT8iHtz7O4bhr5ZiseRYy37QTdINDx+sWJaEd2NjMVj4rRY3CIO+URxOJAg3g
         ylS+JXv4fksWlMuH5dcAVWOBd0/7nZ8wD7M7nOULNmL4v93WP5FChEiXYW2CC7u9Yina
         TElQ==
X-Gm-Message-State: AOAM530VxfCdf5baDxx1xMHRA/9RxkzTCey/Yo7bd2vOqrbosttrma4L
        GzVCFLuiZ4zRpXfv5s28yAKPKnI0BRU=
X-Google-Smtp-Source: ABdhPJzY1DEmt2pk+Dq1qbAxjzlR+yzbp4ZE+RLk2SnmOiLw3v5a/i+hx7gpVFHpS765jKLjrBu/bQ==
X-Received: by 2002:a5d:6752:: with SMTP id l18mr35447424wrw.422.1620722414857;
        Tue, 11 May 2021 01:40:14 -0700 (PDT)
Received: from [192.168.2.202] (p5487be9d.dip0.t-ipconnect.de. [84.135.190.157])
        by smtp.gmail.com with ESMTPSA id y21sm2945643wmi.15.2021.05.11.01.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 01:40:14 -0700 (PDT)
Subject: Re: [PATCH] usb: xhci: Increase timeout for HC halt
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210511002933.1612871-1-luzmaximilian@gmail.com>
 <YJojglZqVE3vaUxX@kroah.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <1f912115-b46d-b1b2-54b4-f1b2bcd0ef8a@gmail.com>
Date:   Tue, 11 May 2021 10:40:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJojglZqVE3vaUxX@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 8:26 AM, Greg Kroah-Hartman wrote:
> On Tue, May 11, 2021 at 02:29:33AM +0200, Maximilian Luz wrote:
>> On some devices (specifically the SC8180x based Surface Pro X with
>> QCOM04A6) HC halt / xhci_halt() times out during boot. Manually binding
>> the xhci-hcd driver at some point later does not exhibit this behavior.
>> To work around this, double XHCI_MAX_HALT_USEC, which also resolves this
>> issue.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
>>   drivers/usb/host/xhci-ext-caps.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Should this go to stable kernels as well?

Ah sorry, didn't think about that since the device in question currently
requires a couple of other fixes to be usable. But I guess it would be good
to have this in stable.

Regards,
Max

