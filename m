Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE8F42CDF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhJMWbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhJMWbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:31:09 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F9C061793
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:28:53 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d125so1508068iof.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gz64+vYHPLtSBAm/KwcXxNftl9YbUcrmy/XqpMc+/88=;
        b=R1SpNvUaR1q6a24Tf+b31iX13OqxUaw6Q2zCnUE5ZbRAGF861QeUtDOZOe00+zVMA1
         p5D6QG436JIJC0QT7UFj+O3EozTLS+NSxKZSpRmADglMOyI1w8FIXk7fR4bQCWdXlOkX
         JRU+9PTAt9idlMc8UV1LJzYNy8Iy7hQ0n+jXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gz64+vYHPLtSBAm/KwcXxNftl9YbUcrmy/XqpMc+/88=;
        b=5Ku6zaWLFi+t00QFA0Sh3eWAOdCo7UEfxVyNdz9oU1kkQMh8EnxqzAgtT+ANn1tRWA
         NbxP7o2xhQXp/WUJk0XMraiOKKqjwHYAQ4lq/YI3o+I7tl7jeJ5YRNZmtoyYTgelh2ie
         0k982HU9x0wZkUuTx1HFCFFUvWCcpmkOLWFnThb/mlE0MzNHi9cH18PFoXbXavVENqcj
         Ol8/UQE3ljJalLChxv+kb3f678Zd9BXHYEryebbv9vYVHXm9Ly/C0uFf1xJa+fdfOloI
         ll0ZCSdbFimkf8pgXvi/knQtuRjD561FdQvikR+3ayprW1RimQ1yN7FiE1cy2gyzAEMo
         8X+g==
X-Gm-Message-State: AOAM532Y9tvHtQzblpGeMGnosg7sD5ayve7aUD1acvaB3ZK0+a4FozyQ
        z/YGUDwsGkD+tnayO8caJF2fRQ==
X-Google-Smtp-Source: ABdhPJzBwOyn54v3qdKEkj/dzlUwt2FlKRYDiKWJSvmjA162z1EKqXBNvOMjABmFBECrCLNjKYwGLg==
X-Received: by 2002:a6b:c309:: with SMTP id t9mr1572261iof.50.1634164132869;
        Wed, 13 Oct 2021 15:28:52 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y7sm367526ioj.38.2021.10.13.15.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 15:28:39 -0700 (PDT)
Subject: Re: [RFC PATCH 01/17] net: ipa: Correct ipa_status_opcode enumeration
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, elder@kernel.org
Cc:     Vladimir Lypak <vladimir.lypak@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
References: <20210920030811.57273-1-sireeshkodali1@gmail.com>
 <20210920030811.57273-2-sireeshkodali1@gmail.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <132dbed4-0dc9-a198-218f-90d44deb5d03@ieee.org>
Date:   Wed, 13 Oct 2021 17:28:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920030811.57273-2-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/21 10:07 PM, Sireesh Kodali wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> The values in the enumaration were defined as bitmasks (base 2 exponents of
> actual opcodes). Meanwhile, it's used not as bitmask
> ipa_endpoint_status_skip and ipa_status_formet_packet functions (compared
> directly with opcode from status packet). This commit converts these values
> to actual hardware constansts.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>   drivers/net/ipa/ipa_endpoint.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
> index 5528d97110d5..29227de6661f 100644
> --- a/drivers/net/ipa/ipa_endpoint.c
> +++ b/drivers/net/ipa/ipa_endpoint.c
> @@ -41,10 +41,10 @@
>   
>   /** enum ipa_status_opcode - status element opcode hardware values */
>   enum ipa_status_opcode {
> -	IPA_STATUS_OPCODE_PACKET		= 0x01,
> -	IPA_STATUS_OPCODE_DROPPED_PACKET	= 0x04,
> -	IPA_STATUS_OPCODE_SUSPENDED_PACKET	= 0x08,
> -	IPA_STATUS_OPCODE_PACKET_2ND_PASS	= 0x40,
> +	IPA_STATUS_OPCODE_PACKET		= 0,
> +	IPA_STATUS_OPCODE_DROPPED_PACKET	= 2,
> +	IPA_STATUS_OPCODE_SUSPENDED_PACKET	= 3,
> +	IPA_STATUS_OPCODE_PACKET_2ND_PASS	= 6,

I haven't looked at how these symbols are used (whether you
changed it at all), but I'm pretty sure this is wrong.

The downstream tends to define "soft" symbols that must
be mapped to their hardware equivalent values.  So for
example you might find a function ipa_pkt_status_parse()
that translates between the hardware status structure
and the abstracted "soft" status structure.  In that
function you see, for example, that hardware status
opcode 0x1 is translated to IPAHAL_PKT_STATUS_OPCODE_PACKET,
which downstream is defined to have value 0.

In many places the upstream code eliminates that layer
of indirection where possible.  So enumerated constants
are assigned specific values that match what the hardware
uses.

					-Alex

>   };
>   
>   /** enum ipa_status_exception - status element exception type */
> 

