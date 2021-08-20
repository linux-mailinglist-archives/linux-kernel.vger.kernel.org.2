Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154CA3F3627
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhHTVtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTVtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:49:15 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80319C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:48:37 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso17150179oth.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uQKi4/vuKFJC0aZ1s1RapsLjw0OVYHWADnRHmAJ7H0g=;
        b=Ha+KwaWjGgExCoG2BcX7nWrrxMVE4KxgnPfZnqTPp2/3rFCXTSiYIUlTFamvw5j6IZ
         NalIl7OLrbufah5ZsVMj+RN5MGli/Ftl50NArjJFblE2UgMvosT2BnAA2FYLCPs39DFR
         cqgzoeFKbpKekBMCVP4dzb34Cd8Xi255uM629VoLEVXaI5RKMO+WV7Mt4CuZOsuMp5sU
         nm+hONKOJqRq9oawZo2NJ6LqHFvlc992HlY6oz9sY6K9d+EO8N5jqHTd7t+gINoJxjU4
         KJQKEkzA2hnLznJ99q/h/O4QInAqi5/xv7hiDpX89g+MSZNBQU3HWYNimPAcPweFqWeh
         6C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uQKi4/vuKFJC0aZ1s1RapsLjw0OVYHWADnRHmAJ7H0g=;
        b=Bn2/cF1bwPgqaMBKHoVWsdY3Yx97n5BEf7kxfb0oQWkmem037QKqU0/U3pYvvIkHsq
         V5piFaHkoJXmVe+Wyfe9n3EwCUaFcWu7iuILYnd7Ufcd5mI5V2fsfScXdjbWIkbJ9/nm
         2aOLI5XrSVtvNDMxp4oaPbUNzkSjo0US8I/Z463/nso7US3rn45nt09S4aDw6nnwXu4m
         wO6FcIpRklPnoTgLJMIzl6CV9oWKZChr+0g3xizmIXRu4ARaKt7K9+bWZbU8vhfdSYqE
         jDEhYJ4znE4UqSRpkKXA1eLXqAm+iZ+iQHcCb0Pk7zPdklacxCJX0h/pjgJtoDSyeJj6
         SoxA==
X-Gm-Message-State: AOAM530ftd+9wkHA+KrtElSjaZhETf4KxVL996OFAjN3U0kJps2ZHvjU
        yYLrc4SATAqZLM94AnsBKTN4lRPVCXA=
X-Google-Smtp-Source: ABdhPJzvMBcvlbD9DXb9/TKtcncPe7cGL+TACYfSCut/A9knV4nredJ1IM+j2ZAxOOLqrngHSMm1aw==
X-Received: by 2002:a05:6830:14d5:: with SMTP id t21mr18050927otq.271.1629496116713;
        Fri, 20 Aug 2021 14:48:36 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-1023.res6.spectrum.com. [2603:8090:2005:39b3::1023])
        by smtp.gmail.com with ESMTPSA id g8sm1150346otk.34.2021.08.20.14.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 14:48:36 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH v2 3/5] staging: r8188eu: incorrect type in
 csum_ipv6_magic
To:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1629360917.git.aakashhemadri123@gmail.com>
 <8bc15e51751c26fd19428f3b4976b7495feecd34.1629360917.git.aakashhemadri123@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <740b5e42-f2b1-313d-cd7b-9e17b1c40042@lwfinger.net>
Date:   Fri, 20 Aug 2021 16:48:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8bc15e51751c26fd19428f3b4976b7495feecd34.1629360917.git.aakashhemadri123@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/21 3:17 AM, Aakash Hemadri wrote:
> Fix sparse warning:
>> rtw_br_ext.c:771:84:    got restricted __be16 [usertype] payload_len
>> rtw_br_ext.c:773:110: warning: incorrect type in argument 2
>      (different base types)
>> rtw_br_ext.c:773:110:    expected int len
>> rtw_br_ext.c:773:110:    got restricted __be16 [usertype] payload_len
> 
> csum_ipv6_magic and csum_partial expect int len not __be16, use ntohs()
> 
> Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> index 6a0462ce6230..d4acf02ca64f 100644
> --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> @@ -615,9 +615,9 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
>   						struct icmp6hdr  *hdr = (struct icmp6hdr *)(skb->data + ETH_HLEN + sizeof(*iph));
>   						hdr->icmp6_cksum = 0;
>   						hdr->icmp6_cksum = csum_ipv6_magic(&iph->saddr, &iph->daddr,
> -										iph->payload_len,
> +										ntohs(iph->payload_len),
>   										IPPROTO_ICMPV6,
> -										csum_partial((__u8 *)hdr, iph->payload_len, 0));
> +										csum_partial((__u8 *)hdr, ntohs(iph->payload_len), 0));
>   					}
>   				}
>   			}
> 

This patch is correct. Again, I like be16_to_cpu() better than ntohs(), but that 
is not a deal breaker. The kernel is split on the usage.

Larry

