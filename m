Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F3B3E93BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhHKOcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232430AbhHKObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628692284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMsaF6YNRWgvZkKD/Bb4KAtHQ1t58EnxtwdMzN8DDjs=;
        b=Dca7aWaOz0y7CbKcv2EqKUYKyiheKTiWygl50xldfM+zU/szWNF+Wtu6X1bqNkD4MNLwkF
        BQoEGJeyo3mQTZWkojtw2/8fIyLgtDw8i1YI/TRvV0fm9NWa+6Dw05alpURNLwdVD5a518
        zqC3xRMlzFH3wYzHH6WZ8oYaF8BVJyA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-DJBc0_cVNWCotEWjmskx0Q-1; Wed, 11 Aug 2021 10:31:23 -0400
X-MC-Unique: DJBc0_cVNWCotEWjmskx0Q-1
Received: by mail-qv1-f72.google.com with SMTP id u6-20020ad448660000b02903500bf28866so1350436qvy.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 07:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IMsaF6YNRWgvZkKD/Bb4KAtHQ1t58EnxtwdMzN8DDjs=;
        b=fW8KDFLxm5AocWMUiXFIntZrYIdfUSFMjJNtWsFwaFaK4RGlrWPoXckWPjQWTmQUXw
         PtBXs5aJeH63Pf7HR1I1HORXhyk89nZqamstu6G5F2oeOwJbPKYckKpE9vfCUSsJQXdV
         8a5dBurAi8+IRJU82GPJ3JrCn8f4vqjbszFSCy5B3aI8g7mAqc1Jz+48q9YqNVI8TEf9
         8tyC6pL0owvfUB0cevkdw6T5siF0Z9BOnEICTexKbYag15akE6z3ibtcTmHm2tcF0pcb
         EF/S5MtG1j+SEHvtPB32GRzLXQYsyhfCqqcfLAG8aYO4gLkQnP0sQeC9ZRMBl26+PYON
         wFlQ==
X-Gm-Message-State: AOAM532e6M1QUmslbv1Zbz5jPg2zK3vvMmDHmgBKVpEgm92xA8Z9AUyV
        UE0OtdDeKGDsg1e1Pn/GSt80x7znzvUvjigPK05sZnWfnRof9dREomQJuS9eL5tpLOCnADx247s
        NbLOU2199j3IFAiGTBL0jMBUpXXieYQnW21QTcv42NxX8ekKa0lmXUobYoZ0e8NG1IfFDeW094H
        wy
X-Received: by 2002:ac8:7207:: with SMTP id a7mr30353247qtp.32.1628692282737;
        Wed, 11 Aug 2021 07:31:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRN7N9t97BDNGO5cfSC1+itLxk34dUt1bOU5m035sou0qCpLmrUNFjMm8hxm8bwlwn0p2haw==
X-Received: by 2002:ac8:7207:: with SMTP id a7mr30353215qtp.32.1628692282500;
        Wed, 11 Aug 2021 07:31:22 -0700 (PDT)
Received: from jtoppins.rdu.csb ([107.15.110.69])
        by smtp.gmail.com with ESMTPSA id q11sm12219443qkm.56.2021.08.11.07.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 07:31:22 -0700 (PDT)
Subject: Re: [PATCH net-next v2 2/2] bonding: combine netlink and console
 error messages
To:     Joe Perches <joe@perches.com>, Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, leon@kernel.org,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <cover.1628650079.git.jtoppins@redhat.com>
 <e6b78ce8f5904a5411a809cf4205d745f8af98cb.1628650079.git.jtoppins@redhat.com>
 <d5e1aada694465fd62f57695e264259815e60746.camel@perches.com>
 <20210811054917.722bd988@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <c296dd2f66e97ad38d5456c0fab4e0ff99b14634.camel@perches.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
Message-ID: <5100eeab-dd01-d739-95f0-0a0267652bae@redhat.com>
Date:   Wed, 11 Aug 2021 10:31:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c296dd2f66e97ad38d5456c0fab4e0ff99b14634.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 9:23 AM, Joe Perches wrote:
> On Wed, 2021-08-11 at 05:49 -0700, Jakub Kicinski wrote:
>> On Tue, 10 Aug 2021 20:27:01 -0700 Joe Perches wrote:
>>>> +#define BOND_NL_ERR(bond_dev, extack, errmsg) do {		\
>>>> +	if (extack)						\
>>>> +		NL_SET_ERR_MSG(extack, errmsg);			\
>>>> +	else							\
>>>> +		netdev_err(bond_dev, "Error: %s\n", errmsg);	\
>>>> +} while (0)
>>>> +
>>>> +#define SLAVE_NL_ERR(bond_dev, slave_dev, extack, errmsg) do {		\
>>>> +	if (extack)							\
>>>> +		NL_SET_ERR_MSG(extack, errmsg);				\
>>>> +	else								\
>>>> +		slave_err(bond_dev, slave_dev, "Error: %s\n", errmsg);	\
>>>> +} while (0)
>>>
>>> Ideally both of these would be static functions and not macros.
>>
>> That may break our ability for NL_SET_ERR_MSG to place strings
>> back in a static buffer, no?
> 
> Not really.
> 
> The most common way to place things in a particular section is to
> use __section("whatever")
> 
> It's pretty trivial to mark these errmsg strings as above.

I am unable to convert these to functions at this time, due to how 
NL_SET_ERR_MSG is expanded. This is with either a param list prototype 
of, "const char *errmsg" or "const char errmsg[]".

$ make C=1 drivers/net/bonding/bonding.ko
   CALL    scripts/checksyscalls.sh
   CALL    scripts/atomic/check-atomics.sh
   DESCEND objtool
   DESCEND bpf/resolve_btfids
   CC [M]  drivers/net/bonding/bond_main.o
In file included from ./include/uapi/linux/neighbour.h:6,
                  from ./include/linux/netdevice.h:45,
                  from ./include/net/inet_sock.h:19,
                  from ./include/net/ip.h:28,
                  from drivers/net/bonding/bond_main.c:42:
drivers/net/bonding/bond_main.c: In function ‘bond_nl_err’:
drivers/net/bonding/bond_main.c:1733:26: error: invalid initializer
    NL_SET_ERR_MSG(extack, errmsg);
                           ^~~~~~
./include/linux/netlink.h:92:30: note: in definition of macro 
‘NL_SET_ERR_MSG’
   static const char __msg[] = msg;  \
                               ^~~
drivers/net/bonding/bond_main.c: In function ‘slave_nl_err’:
drivers/net/bonding/bond_main.c:1744:26: error: invalid initializer
    NL_SET_ERR_MSG(extack, errmsg);
                           ^~~~~~
./include/linux/netlink.h:92:30: note: in definition of macro 
‘NL_SET_ERR_MSG’
   static const char __msg[] = msg;  \
                               ^~~
make[3]: *** [scripts/Makefile.build:271: 
drivers/net/bonding/bond_main.o] Error 1
make[2]: *** [scripts/Makefile.build:514: drivers/net/bonding] Error 2
make[1]: *** [scripts/Makefile.build:514: drivers/net] Error 2
make: *** [Makefile:1841: drivers] Error 2


