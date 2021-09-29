Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF841BF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 08:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbhI2GUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 02:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244076AbhI2GUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 02:20:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9213BC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 23:19:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s21so2296754wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 23:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BA10AXdVIXU2So5ZYm/Sc6COKBVDhlynEdJznpSLYc0=;
        b=P58jKiTC5DWofHUmyGJiE6z8KtcI/RYagaHB2u6ORXaXHYvRQAWtyRXK9xqzdMLJd2
         GpmmXimZwC92p7FWPbAokJno3ohyES8lm5t5hLm3vHuCRUEH2HIgTVtBDREwfJkIoSqZ
         uwZC6EaUyRvec7FGtdjJDzrZFAag+kGRQZMemPwinzIoM5PhvW0QZ6GBLye73bk7KJo7
         Arq0oE9bgvkTtAAY0yBeQ4DH1Zy9sLJSG9HwEk1xvy8fbsoJeuxUAdCFeD7DtyybsvFO
         JtX6VFVg1EV58r4mJj28x7SEDkB0gvL/vLAGxCRptMBcXgE4/la8anZ79tj99MnZb1qQ
         1Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BA10AXdVIXU2So5ZYm/Sc6COKBVDhlynEdJznpSLYc0=;
        b=39xHLtfjkrhK4pRcz6LZui1JblhFt/VnOvUJiiRwH+wKSruNMARS1P5yIQedysSJq0
         F2l8SCopqTEhoqOl9C1HYWZ4HHzPZ4VAImwFdqSjMHZzqvB9dvMkYMJM7C7pXxtSZPnH
         V3K7gOiPMbLB672dFwJ0ZBuoZ16e6I+nhwPxGwqDoy/pG7kr8FyBVxYQrdsXUs2vHopJ
         F/aihGHvwr4avwyL4F8el+ikpf24A+xbsTUP4qR4BN3i123Pm8ItHvU1YEPsTZBKs4js
         BdJWn9sDG3HgNq3X871/cLgpUxB65/NH2XVWwa1FCRDdoY6kcTtp/vFwxID8OESWnS/p
         0HIA==
X-Gm-Message-State: AOAM530mFkd4D6lprhfMFz2oMUHmg+agUJaPEwu94qjfcLn77CvWPc37
        MbuCmjbN1S4tsfjJVtUtiQb3e3DP66YqCg==
X-Google-Smtp-Source: ABdhPJxdQ8lTmod/ogUQz0HFrzrN4lIxzwK/Iej9UoxbHgUzLzsnYWdON7874dyHHoqLzgqJjgWnPw==
X-Received: by 2002:adf:e603:: with SMTP id p3mr4562026wrm.357.1632896347151;
        Tue, 28 Sep 2021 23:19:07 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:e0fd:c68f:ea32:2084? ([2a01:e0a:410:bb00:e0fd:c68f:ea32:2084])
        by smtp.gmail.com with ESMTPSA id p3sm1152093wrn.47.2021.09.28.23.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 23:19:06 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v6] net: openvswitch: IPv6: Add IPv6 extension
 header support
To:     Jakub Kicinski <kuba@kernel.org>,
        Toms Atteka <cpp.code.lv@gmail.com>
Cc:     netdev@vger.kernel.org, pshelar@ovn.org, davem@davemloft.net,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <20210928194727.1635106-1-cpp.code.lv@gmail.com>
 <20210928174853.06fe8e66@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <d1e5b178-47f5-9791-73e9-0c1f805b0fca@6wind.com>
Date:   Wed, 29 Sep 2021 08:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928174853.06fe8e66@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/09/2021 à 02:48, Jakub Kicinski a écrit :
> On Tue, 28 Sep 2021 12:47:27 -0700 Toms Atteka wrote:
>> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
>> index a87b44cd5590..dc6eb5f6399f 100644
>> --- a/include/uapi/linux/openvswitch.h
>> +++ b/include/uapi/linux/openvswitch.h
>> @@ -346,6 +346,13 @@ enum ovs_key_attr {
>>  #ifdef __KERNEL__
>>  	OVS_KEY_ATTR_TUNNEL_INFO,  /* struct ip_tunnel_info */
>>  #endif
>> +
>> +#ifndef __KERNEL__
> 
> #else
> 
>> +	PADDING,  /* Padding so kernel and non kernel field count would match */
> 
> The name PADDING seems rather risky, collisions will be likely.
> OVS_KEY_ATTR_PADDING maybe?
> 
> But maybe we don't need to define this special value and bake it into
> the uAPI, why can't we add something like this to the kernel header
> (i.e. include/linux/openvswitch.h):
> 
> /* Insert a kernel only KEY_ATTR */
> #define OVS_KEY_ATTR_TUNNEL_INFO	__OVS_KEY_ATTR_MAX
> #undef OVS_KEY_ATTR_MAX
> #define OVS_KEY_ATTR_MAX		__OVS_KEY_ATTR_MAX
Following the other thread [1], this will break if a new app runs over an old
kernel.
Why not simply expose this attribute to userspace and throw an error if a
userspace app uses it?

[1]
https://lore.kernel.org/lkml/CAASuNyUWoZ1wToEUYbdehux=yVnWQ=suKDyRkQfRD-72DOLziw@mail.gmail.com/

> 
>> +#endif
