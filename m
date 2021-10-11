Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1753C4291C0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhJKOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbhJKOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:30:06 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44854C0F26DB;
        Mon, 11 Oct 2021 07:03:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so21887497otb.1;
        Mon, 11 Oct 2021 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wk2Xx1j0bx+Uzm6+zVtoR+iElmlhVw742pfk98i7Meo=;
        b=NIfMYYCFLTpTDfun8Ee/OSUF2VGp2b9acMddBT4BLrYbUwCjhTE86XZtENHr/lLVwM
         kd2J7rrdc0BSeFP7HL+sHD+h07iwJIxe5DQzwZ39qLDVo8Li4bMdQZw003haCaUHgftQ
         D28MXSIIJhx88qEwJP3IXr2WB1sF1bfKfe6x2WQUvzNi5BdCKdwil4z3Y9k7zh5iJHup
         VhIY7pBucw7+jRgfqp8mnUspeUfAJ9U728A688VPbL4C7b9v1ZVybU7CsHmaxXl4J1wf
         5hrkVf5VSI2cxELQFCWjtpglLDcwzQOjVtVEJup4mR1g/J2QuC9mPvpaLd/DC8hET1SC
         wtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wk2Xx1j0bx+Uzm6+zVtoR+iElmlhVw742pfk98i7Meo=;
        b=CFquIv6loUTDt39gLkt4yVq70A4SRNZxihSunxL+59xaaiqWksUX8EY7nJKdsCwAxQ
         rZjZBeC9fUGdB3zJkmlRhn/X4ivqQoz2O49sb8p67nUu0qxXhDehKWlVso5TQx6B/Bds
         ZSCSq1TD1x20SLAlG3XCO4/VwZ3gbxhfy0rT3riu5f8ZomtpkhWiQ1AqTXsaSCXdi0OV
         Hyabibju1gYsBf4Pe6hSU2Kz1kHNA1HYrutz9DNstj/KQgUhZ/EiMovSIcIeHQpQkqRl
         5+i08mcMzMRrE+B/JFYc7YjqQ7XoHj6cCUwACjaDJTEXcVrqrH9GHgaUk72jxQ725VPn
         wx/w==
X-Gm-Message-State: AOAM533q88EnJg+2Hl8hU1XCnjp4wqihFOqrZumhtLNz8ncK5YlNmcAz
        HO/Hv5ohzI+Ma3DRS6R69VrWHbq+Vu0=
X-Google-Smtp-Source: ABdhPJzlP2rpo0wr+QhmeS/8Y69NkoGzg390wQEQY2P2xzrM4BpaVMOPatuwxi8Tt28gZt64LVoHyw==
X-Received: by 2002:a05:6830:2317:: with SMTP id u23mr19222391ote.385.1633961017772;
        Mon, 11 Oct 2021 07:03:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bc19sm1577028oob.29.2021.10.11.07.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 07:03:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v7 2/2] hwmon: (nct7802) Make temperature/voltage sensors
 configurable
To:     Oskar Senft <osk@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211011012212.91357-1-osk@google.com>
 <20211011012212.91357-2-osk@google.com>
 <98dcaa85-d04c-7a9c-1901-8786d361477c@roeck-us.net>
 <CABoTLcTERUpwPSc7fVUAMqs37XCZJhMFbFRT2oyTt_TodE6GnA@mail.gmail.com>
 <518a6ab3-80af-bbe9-69e5-55e6741bdcbe@roeck-us.net>
 <CABoTLcQtfoXCy+j9W6-NxAtWN13yTs322BFtCebbMCZr-cWzaA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <22086eb0-a25a-09c9-0f10-0702e412a6fc@roeck-us.net>
Date:   Mon, 11 Oct 2021 07:03:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CABoTLcQtfoXCy+j9W6-NxAtWN13yTs322BFtCebbMCZr-cWzaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 5:57 AM, Oskar Senft wrote:
> Hi Guenter
> 
> I appreciate your help with this!
> 
>> First, please don't top-post.
> Argh, I'm sorry - old habits! The Gmail web UI makes it too easy to do that :-/
> 
>> Second, no, submitting both patches was the right thing to do, but
>> you should not drop a Reviewed-by: tag if there was no change to
>> the patch.
> Got it, makes sense. How do I untangle this mess? Resubmit a v8, this
> time with the "Reviewed-by:" added back in? Or are you ok tagging the
> v7 again. I'm sorry!
> 

I'll tag again. No worries, just keep it in mind for next time.

Thanks,
Guenter

