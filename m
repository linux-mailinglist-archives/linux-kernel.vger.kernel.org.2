Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297CC3E4F45
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhHIWa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233565AbhHIWa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628548236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjH3lVoue/JL4btoApF2k0x+vF5e5YSb7pGpRSYghz4=;
        b=S4Z9kfVRVKSrl58elQHd88VMjyS448HjrxXXSeitZg8Z7R0cd2WmNamwFQgQd0JnfjkPSY
        R04IsLlwaKNM1hLJpPNP49B31IzVE2wdkzgTkVcXZOM/lsGLpMGuuW2Ul6fOXj3TRecM2Y
        DylNkmBCSvgEQ11HFDtug3UoTEjXCZQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-EYYXHZfXPiGnEdhhT4YxpQ-1; Mon, 09 Aug 2021 18:30:35 -0400
X-MC-Unique: EYYXHZfXPiGnEdhhT4YxpQ-1
Received: by mail-qt1-f199.google.com with SMTP id r13-20020ac85c8d0000b029028efef0404cso6518062qta.14
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 15:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BjH3lVoue/JL4btoApF2k0x+vF5e5YSb7pGpRSYghz4=;
        b=SGZomgxAB7bxwk45iqsELwek8foy9lCQho1e9fJd0Q9vWKF77KwTS6sAsYBl3h0ImP
         H2k73npY1WxIf/dMCdembjb+UocD15GJ8X2q3snWoBtZMAucwhBxpul/D8lzfT7CA22+
         qmqyHidhGNDyC48MSj7rUeDNkRs5Bi1WYHRz3GBAzOV//MusNV0BLdtQNq6hsxV2b20d
         h8k997vZVIkRj6ksfULOHFeML81wBGI2ghmPTirQ+zOFX5rDSxn2/q2598dWDcEPakXp
         TtzxxdB+mE6Kxby3pHgVbERj4wl8CZSoXOZPXNMWJ+2Y1qj1YXn52FcvbVqCg5UG/RTT
         07bA==
X-Gm-Message-State: AOAM530tEc4VOg5b1eHzt757s925ZjW+5Nky7eYbPw+nfpEb42g3Uh/b
        hOXiWhfIrPBG8qrgp9PH/vskBFZRYU1aCnZMN1lSt2CBZrxM4iedLFDosS6HmoI+H1H0WkDFKOM
        zyuqS5h278Q8RIirg0icpx+jha7NtR/obatw754Xr9fWOrSrkjwG2mcIyNsA+k6Ve+nt/FDiD06
        oK
X-Received: by 2002:ad4:5f09:: with SMTP id fo9mr14663292qvb.35.1628548235207;
        Mon, 09 Aug 2021 15:30:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys63neYYC0CsWGSSBTnSkVTM1U47S3lEOoT7cddDJABMx3HwrVAydq7pk663/OgQKN+d7p4Q==
X-Received: by 2002:ad4:5f09:: with SMTP id fo9mr14663273qvb.35.1628548234963;
        Mon, 09 Aug 2021 15:30:34 -0700 (PDT)
Received: from jtoppins.rdu.csb ([107.15.110.69])
        by smtp.gmail.com with ESMTPSA id v19sm5439662qta.60.2021.08.09.15.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 15:30:34 -0700 (PDT)
Subject: Re: [PATCH] netlink: NL_SET_ERR_MSG - remove local static array
To:     Joe Perches <joe@perches.com>, netdev <netdev@vger.kernel.org>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1f99c69f4e640accaf7459065e6625e73ec0f8d4.camel@perches.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
Message-ID: <c32a4a3c-c7df-cb8d-ecb4-7c1738cfd15c@redhat.com>
Date:   Mon, 9 Aug 2021 18:30:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1f99c69f4e640accaf7459065e6625e73ec0f8d4.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/21 1:04 PM, Joe Perches wrote:
> The want was to have some separate object section for netlink messages
> so all netlink messages could be specifically listed by some tool but
> the effect is duplicating static const char arrays in the object code.
> 
> It seems unused presently so change the macro to avoid the local static
> declarations until such time as these actually are wanted and used.
> 
> This reduces object size ~8KB in an x86-64 defconfig without modules.
> 
> $ size vmlinux.o*
>     text	   data	    bss	    dec	    hex	filename
> 20110471	3460344	 741760	24312575	172faff	vmlinux.o.new
> 20119444	3460344	 741760	24321548	1731e0c	vmlinux.o.old
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Seems reasonable.

Acked-by: Jonathan Toppins <jtoppins@redhat.com>

