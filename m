Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1729395619
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhEaHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:32:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60476 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhEaHcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:32:01 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lncNR-0002F0-9Y
        for linux-kernel@vger.kernel.org; Mon, 31 May 2021 07:30:21 +0000
Received: by mail-wm1-f70.google.com with SMTP id x20-20020a1c7c140000b029018f49a7efb7so4427550wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cAlI26tnTTG5mkLy5nypjSlUByQ/kCeC+Y7Gnr7Dwj8=;
        b=ToGP+OwEVeVRbFs2prekf1N7ZFddaBgJ6lnbvD4rRW0hGO+KilaHoU29zHXveMOyPe
         2gOM09tFu12rsuot3a2ZzZfSvcw4k2zk1tXjugw6uWQYqpwE7h/xvI4pcwrddkNXvK49
         F906lYIbldBn9JzENr5sn1fMydrj9IXDzIrIRzGQk61OZpEYofXTi0kevPLnMMtA9ics
         FRuif54prNHv01H/uPUg/1LrHQYJ/athdIdlMvOj1xILkXlquoildBoMUo0y0VpJqEqg
         yCL1tir3h0tI6nPeJ+xP2TJjnvdwGySNgYqj08t7CwaucdWkCt/pvCD+h5OSUqwnE4Lb
         JoEw==
X-Gm-Message-State: AOAM531cxvu+qRXZd9KGi1BNI8Lb9d5FaS5TIZLzoDRB1ZATDWXbLsMg
        2b5lt/9voMOFHL0X8CuNOmDt8VcXuu8wOnXfjSVvRNWzSC2/VbZxmugj4u9jUQl/4tun6JirjXH
        A492hZb3NGMLc9GHAz68t5X33dOFnCrSGcgwxNOC9OA==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr19400395wmh.102.1622446221039;
        Mon, 31 May 2021 00:30:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGn2RwHbI3WaJdd8bqimsKztQEfvYoe5ivVyqd/sUnbSsNPwopPg2sBXTTyFD3lrJGA4eoOw==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr19400386wmh.102.1622446220937;
        Mon, 31 May 2021 00:30:20 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id v15sm22303365wmj.39.2021.05.31.00.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 00:30:20 -0700 (PDT)
Subject: Re: [PATCH 01/11] nfc: fdp: drop ftrace-like debugging messages
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210528145330.125055-1-krzysztof.kozlowski@canonical.com>
 <20210528151340.7ea69c15@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4f44c25c-c296-ba3e-7c6d-bc1016574231@canonical.com>
Date:   Mon, 31 May 2021 09:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210528151340.7ea69c15@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2021 00:13, Jakub Kicinski wrote:
> On Fri, 28 May 2021 10:53:20 -0400 Krzysztof Kozlowski wrote:
>> Now that the kernel has ftrace, any debugging calls that just do "made
>> it to this function!" and "leaving this function!" can be removed.
>> Better to use standard debugging tools.
>>
>> This allows also to remove several local variables and entire
>> fdp_nci_recv_frame() function (whose purpose was only to log).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Hi! Would you mind reposting these 11 fixes? build bots don't
> understand series dependencies and the last patch here depends 
> on the previous clean up set.

Sure, no problem.


Best regards,
Krzysztof
