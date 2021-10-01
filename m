Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C3441E83E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhJAHXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJAHXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:23:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE32DC061778
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 00:21:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 205-20020a1c01d6000000b0030cd17ffcf8so10402888wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 00:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oGVJ8Db4ndTtDl7THEZBAMsW6oUl3MtjYtP7sF7htnw=;
        b=XhtNwD3CwZuB0so8qwSUi+w305O0vhcUtNwcUYaBQriykLrYDjaMP5695ULxPRlisY
         epSgHhe9YSu19Au/80pveinEBHPRRJ1FBgXZYBD+UHYv9AY5S5eI4ItwEajQKqVQMPvW
         /D0M6bAAks0GJm9Z8JZXyGgS5akUN0Iy/vSTQ2sEQqoCbSSM3ToRG1Em/dAUyPqsvNyO
         k4nm0aiTvM7ZSLoL0x58UQ5jsotSxmF/asOZOZH2gqAf2vd05XEq+9K9tBcjQofe/16N
         fjhalOmweZt8sNPY5mB4J+sg5K1TAzD+VDO7yMOpW/HhXGVn0Eml4thRm2hX1s7fTkLa
         wdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oGVJ8Db4ndTtDl7THEZBAMsW6oUl3MtjYtP7sF7htnw=;
        b=PLEldGhfP+Pu1hW7Gk151ybSPI4UwLdESyOA9dFdmGYukOqKIUfElWa+P887BStIyN
         FqTjJSIuws/SWQR6UksueavKDiC5Ucwa3uDvCRBFoYkEQ9dO3/E6QLuaD/gf1z49IuXY
         rfgEoN1as5LRlBINV8kTO2bDXiaAJorJHxw1phEZal0IgirT4uXjTZRvVXjYGPYMLVOO
         XybYmI79fQH5cijMJbRC5r/l8FTgocNNbY0FJ6xtqbuNQ69w3y8KjpW4awHgDsbjWYtM
         eSKAmoOaEvR/WWr+C8ufxxasW9KT4DYwkRe8gchp01BWoh6svBOKVNjSgFwyhzNSiuFH
         Crow==
X-Gm-Message-State: AOAM5337pq789HE4g0EAxJJ9GBWexqzFXsCsvwamQHwUV3IlYhz3L4NL
        w6DrzYnTh/woFS4QTumEwaksT2AG+OyzRg==
X-Google-Smtp-Source: ABdhPJxVEkZ+oO+BtHmQxEUjZjhyEFvymn77IKGUwhGwMhRJIOQnBnkoG2GTksUV/YH3jNWwRk6gUA==
X-Received: by 2002:a1c:7e53:: with SMTP id z80mr2952224wmc.152.1633072891177;
        Fri, 01 Oct 2021 00:21:31 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:8942:595a:24f3:3f9e? ([2a01:e0a:410:bb00:8942:595a:24f3:3f9e])
        by smtp.gmail.com with ESMTPSA id n15sm5095346wrg.58.2021.10.01.00.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 00:21:30 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v6] net: openvswitch: IPv6: Add IPv6 extension
 header support
To:     Cpp Code <cpp.code.lv@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, pshelar@ovn.org,
        "David S. Miller" <davem@davemloft.net>,
        ovs dev <dev@openvswitch.org>, linux-kernel@vger.kernel.org
References: <20210928194727.1635106-1-cpp.code.lv@gmail.com>
 <20210928174853.06fe8e66@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <d1e5b178-47f5-9791-73e9-0c1f805b0fca@6wind.com>
 <20210929061909.59c94eff@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAASuNyVe8z1R6xyCfSAxZbcrL3dej1n8TXXkqS-e8QvA6eWd+w@mail.gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <b091ef39-dc29-8362-4d31-0a9cc498e8ea@6wind.com>
Date:   Fri, 1 Oct 2021 09:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAASuNyVe8z1R6xyCfSAxZbcrL3dej1n8TXXkqS-e8QvA6eWd+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/09/2021 à 18:11, Cpp Code a écrit :
> On Wed, Sep 29, 2021 at 6:19 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Wed, 29 Sep 2021 08:19:05 +0200 Nicolas Dichtel wrote:
>>>> /* Insert a kernel only KEY_ATTR */
>>>> #define OVS_KEY_ATTR_TUNNEL_INFO    __OVS_KEY_ATTR_MAX
>>>> #undef OVS_KEY_ATTR_MAX
>>>> #define OVS_KEY_ATTR_MAX            __OVS_KEY_ATTR_MAX
>>> Following the other thread [1], this will break if a new app runs over an old
>>> kernel.
>>
>> Good point.
>>
>>> Why not simply expose this attribute to userspace and throw an error if a
>>> userspace app uses it?
>>
>> Does it matter if it's exposed or not? Either way the parsing policy
>> for attrs coming from user space should have a reject for the value.
>> (I say that not having looked at the code, so maybe I shouldn't...)
> 
> To remove some confusion, there are some architectural nuances if we
> want to extend code without large refactor.
> The ovs_key_attr is defined only in kernel side. Userspace side is
> generated from this file. As well the code can be built without kernel
> modules.
> The code inside OVS repository and net-next is not identical, but I
> try to keep some consistency.
I didn't get why OVS_KEY_ATTR_TUNNEL_INFO cannot be exposed to userspace.

> 
> JFYI This is the file responsible for generating userspace part:
> https://github.com/openvswitch/ovs/blob/master/build-aux/extract-odp-netlink-h
> This is the how corresponding file for ovs_key_attr looks inside OVS:
> https://github.com/openvswitch/ovs/blob/master/datapath/linux/compat/include/linux/openvswitch.h
> one can see there are more values than in net-next version.
There are still some '#ifdef __KERNEL__'. The standard 'make headers_install'
filters them. Why not using this standard mechanism?

In this file, there are two attributes (OVS_KEY_ATTR_PACKET_TYPE and
OVS_KEY_ATTR_ND_EXTENSIONS) that doesn't exist in the kernel.
This will also breaks if an old app runs over a new kernel. I don't see how it
is possible to keep the compat between {old|new} {kernel|app}.


Regards,
Nicolas
