Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35E8390021
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhEYLjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:39:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48806 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhEYLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:39:49 -0400
Received: from mail-ua1-f72.google.com ([209.85.222.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llVO7-0006Vx-6F
        for linux-kernel@vger.kernel.org; Tue, 25 May 2021 11:38:19 +0000
Received: by mail-ua1-f72.google.com with SMTP id o7-20020ab01e870000b029020d37e3e144so12923313uak.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 04:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZwbJzMdNKQ9pWB+s9p+++BmYWbMRl5a2xW6x+5P6p4=;
        b=CvhpCSDWSFSn2QZ9pASOZtIaFIQFfDzSM4mC5o1WpHpzTbGBqsacqPHOlObMJi/aJC
         91uA+6UrKS1+yUBKwV0fdeteNFh6XHzGcF+znh2DsDDl/w8fwcZN91+akQCi/Xl8YWvI
         8sF7doZK47laLp9vMiSVZQ9MwC7CjIH0Ke+mgSAlF8f2AAcEX8HtjCmSGML27LrU/Bin
         26C0DCxQTOFGRk4OumsRsz/yBUX1+aTkMp3zBNTc+lgSbvIQE+4IVsTdHrhpNp5fG2Fg
         51CMQF2nRHwJ6fGl9vINXTDj87T7pWngCn0gcO1KQj0DgIZ2WnWJHRCo4ZpqOdOCa+2p
         WVjg==
X-Gm-Message-State: AOAM531LmhtH2Qva6ZOVS5kwc3jUwIGPicvopAgiuX70s+RWTTxLugCF
        vu5AXZA44LEImqpY5zkKG9+wdDkAF24jRCcK5ExNQtMlUj6xzpKU+SHAFweE/PplNVJHqrADjT7
        kLv5oGjDSKR3DjTwnO4tDsIkuuLRKzoJedCHwUkP41g==
X-Received: by 2002:a05:6102:c51:: with SMTP id y17mr25390310vss.26.1621942698293;
        Tue, 25 May 2021 04:38:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOEzcON3XhO32bZ26xkZY6KWrQERAD0cR1oUrEsZ49BhW9FtyS4wfFrcDhfyuXV5mJmUftYQ==
X-Received: by 2002:a05:6102:c51:: with SMTP id y17mr25390303vss.26.1621942698166;
        Tue, 25 May 2021 04:38:18 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.1])
        by smtp.gmail.com with ESMTPSA id y129sm1549174vkg.9.2021.05.25.04.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 04:38:17 -0700 (PDT)
Subject: Re: [PATCH] NFC: st95hf: remove unnecessary assignment and label
To:     samirweng1979 <samirweng1979@163.com>, davem@davemloft.net,
        dinghao.liu@zju.edu.cn
Cc:     linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210525063801.11840-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <3fe26970-91ab-d598-92ff-e13d8d707d47@canonical.com>
Date:   Tue, 25 May 2021 07:38:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525063801.11840-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2021 02:38, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> In function st95hf_in_send_cmd, the variable rc is assigned then goto
> error label, which just return rc, so we use return to replace it. and

s/return/returns/
s/. and/. Since/ (don't start sentences with "and", neither with
lowercase letter).

> error label only used once in the function, so we remove error label.

With these fixes and subject prefix fix to "nfc" (lowercase):

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
