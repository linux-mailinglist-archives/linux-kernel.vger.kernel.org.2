Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7D380B18
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhENOIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhENOIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:08:07 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE77C061574;
        Fri, 14 May 2021 07:06:55 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id w7so9184426ilg.13;
        Fri, 14 May 2021 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=R4gCuqdbZR815nXx2XVEAAsDO0qJ8mZy8Tzf13PeXRw=;
        b=IETsefp/ddaBv67PB9DwzcBjShhaX873XycpoRKkMCKFRHECqeDTtDzXPsmph0KL/0
         0EW7sCQ5V7cAmGYnLtPzplJ+8EhLBdwC2joA93USf76Bxa/HyWuVhzRtjCXUyx7wvWcj
         B2weCbs7gGz0br63woBP633R7m2JHQ2VUnq9+nrdA96L7KVmuT1U9iuzxI/1mfEc+ri+
         WgPxdLhDpQwuubRZ6I1SUEdnlbt394yfkm3EF3KwjEB9A0CW8JKyUIhVjlsQMZkQtWQb
         QBliIPfHpcgfUkeFkcO43fbqNllnV6uBY3BFGpj+DcDdaUlDpQMWV2PCTRqNruPwZRH1
         sFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R4gCuqdbZR815nXx2XVEAAsDO0qJ8mZy8Tzf13PeXRw=;
        b=iJNOSg8e2MysewddYd3RwgzwzSNTtVUcSiIiBSqSa5CxCv8wREva4uyAzhu+1VxxpZ
         VOxzDsmCKGiR9GhLUSen+74hu357VBxJDNJfvGkGL53jIZR5+ttxZb0YlECN8PLERYXM
         4t/j8zsLAw9/n+4wtghu1M1V0jdTWSqDWWxT8QyQrL50PEwdE2vTom9qcFqaVURSKChD
         a/yrq552hfzKAXkTm5tLeZeEzZ982mk+RQiZJpVtyVzcrsh6WCqdDJpoopp9u33+BSzH
         dxZZEfpdtgdcqf92I2HvfzlVqtb2zGR881LEwJymLBeDGHiq73xg3e3KdchTuj6kqyTv
         7/ag==
X-Gm-Message-State: AOAM533PQmvLdyDr/8m6zIpvvf5urjL4rtFyuZIrijjEA/CCY9b32V2W
        vygedoDXjEOIcghvOrpGU8Y=
X-Google-Smtp-Source: ABdhPJylsAg5N0IK+T5+EJrrTV3WwEBwg+lAI3XbJ38wuYsMOY+RKBJs4s+/eBw/u02YpGo+A49tZA==
X-Received: by 2002:a05:6e02:f42:: with SMTP id y2mr29468885ilj.216.1621001215109;
        Fri, 14 May 2021 07:06:55 -0700 (PDT)
Received: from [192.168.99.80] (142-79-211-230.starry-inc.net. [142.79.211.230])
        by smtp.gmail.com with ESMTPSA id t7sm3068586ilq.34.2021.05.14.07.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 07:06:54 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Support xen-driven USB3 debug capability
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        xen-devel@lists.xenproject.org, Lee Jones <lee.jones@linaro.org>,
        Jann Horn <jannh@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Mladek <pmladek@suse.com>,
        Sumit Garg <sumit.garg@linaro.org>
References: <cover.1620950220.git.connojdavis@gmail.com>
 <YJ4cqntf7YdZCOPk@kroah.com>
From:   Connor Davis <connojdavis@gmail.com>
Message-ID: <e2d96a91-3f0f-d2b3-9a1a-16caaf82c24a@gmail.com>
Date:   Fri, 14 May 2021 08:07:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJ4cqntf7YdZCOPk@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/14/21 12:46 AM, Greg Kroah-Hartman wrote:
> On Thu, May 13, 2021 at 06:56:47PM -0600, Connor Davis wrote:
>> Hi all,
>>
>> This goal of this series is to allow the USB3 debug capability (DbC) to be
>> safely used by xen while linux runs as dom0.
> Patch 2/4 does not seem to be showing up anywhere, did it get lost?

Yep, just added you, sorry about that


Thanks,

Connor

> thanks,
>
> greg k-h
