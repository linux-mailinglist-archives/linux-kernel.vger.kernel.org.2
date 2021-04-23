Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FBF369222
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbhDWMcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:32:39 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E90C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 05:32:02 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f21so12617899ioh.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HKActNop4gfNe3Hlyu9iK5cONXIFZVN6yVZQhfm5rPQ=;
        b=ECve+nuTRjnE8hpecoqXVT13cPTOKj/FXQ9pOX79XUhj2sscUJtt2GHZD0DHbHMxJZ
         bVWjOrPy3PHryAtGSTzpEQ0HTSEHtKEPcaxBY8y8PyTi6x1OIZVWx2Ws/k+y82Ngxhg2
         YiS1cFOXUlDzSJAlS+L1XVsKXNeCvi7s+D12rsTqgwSMRyPi/CiNESh5Ox+xCqKBUkQu
         I1CdO6H9Hmu/cxbqZcjgoaZD66Tha8Qkx/826mx62TQLqYYsh+qiqGxGzlASSv0ATQnx
         dIgyhwWESaaFL5XZ0pM0VxKMc9D7TwcG8VfIcKCbCzD8d2/oOxs6xYL+IoH0cCnSKN/b
         ihlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HKActNop4gfNe3Hlyu9iK5cONXIFZVN6yVZQhfm5rPQ=;
        b=UncTD3nj6yUN2zwOdApVc4h7E+cS9yj8yvUmpw3+V4mJm+gHlJCy4TgjVcGPPhri9a
         McQWHkC3eaR3Plawb/CdtLb24UuJ0G8AHsk66jBTsAosDAik6PKq5rNvdw4dDi/WhKAa
         o/DRcMBVwK65FEsp3iPx4mxaqz8HLImIaqEndQH69dUSL6Z2cJiXEWA3ED+vcRRDJCl6
         BmSyfWNHiKhu72nc0N8rcz3K/Cnsuwp7E5iykiT0NXciwhzpgypT63+APFT22VhkcPMB
         mUEA5Jo+xPd1bDQLtaYLJqqehZVSW7+6QWCFcs/qrgg1vhKzTeYrWLaCh8l39+Qc445F
         czvA==
X-Gm-Message-State: AOAM531lhfytofuEIgAbqqzXKj0vs1ZjVck2EibPBFGdT8ycoWBA+puR
        0ztyxBgIvVmlOmOhAGfqGVmabTpAVcSk2Q==
X-Google-Smtp-Source: ABdhPJywguvpb/+jI3NnQ7APn2skk4sAEhoqPEZGt45r/b0cDl7LRNFSWZV1Su8m2+ZtjAnTAYc6qw==
X-Received: by 2002:a6b:f602:: with SMTP id n2mr3169787ioh.174.1619181120360;
        Fri, 23 Apr 2021 05:32:00 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id b8sm2814913iob.30.2021.04.23.05.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 05:31:59 -0700 (PDT)
Subject: Re: [PATCH net-next v4 0/3] net: qualcomm: rmnet: Enable Mapv5
To:     Sharath Chandra Vurukala <sharathv@codeaurora.org>,
        davem@davemloft.net, kuba@kernel.org, elder@kernel.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619121731-17782-1-git-send-email-sharathv@codeaurora.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <0cbcc4aa-8457-f17a-6d73-a99699bd5a2c@linaro.org>
Date:   Fri, 23 Apr 2021 07:31:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1619121731-17782-1-git-send-email-sharathv@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/21 3:02 PM, Sharath Chandra Vurukala wrote:
> This series introduces the MAPv5 packet format.
> 
>    Patch 0 documents the MAPv4/v5.
>    Patch 1 introduces the MAPv5 and the Inline checksum offload for RX/Ingress.
>    Patch 2 introduces the MAPv5 and the Inline checksum offload for TX/Egress.
> 
>    A new checksum header format is used as part of MAPv5.For RX checksum offload,
>    the checksum is verified by the HW and the validity is marked in the checksum
>    header of MAPv5. For TX, the required metadata is filled up so hardware can
>    compute the checksum.

It turns out many of review comments from last week were
ignored without explanation.  So I will repeat some of them
this time.

I see one thing that I think might be a bug in the third
patch, but maybe I'm mistaken, and you can explain why.

I tested the code you supplied me last week, and with a
bug fix applied I found they worked for:
   IPA v3.5.1, IPv4 in loopback, checksum enabled and not
   IPA v4.2, IPv6 using LTE, checksum enabled and not
Both of the above tested ICMP, UDP, and TCP.  I will retest
with this series.

I did not test with IPA v4.5+, which is unfortunately
the main user of this new code.  I will try to do so
with your updated code, and if all testing passes I'll
send a message with "Tested-by" for you to add to your
patches.

					-Alex

>    v1->v2:
>    - Fixed the compilation errors, warnings reported by kernel test robot.
>    - Checksum header definition is expanded to support big, little endian
>            formats as mentioned by Jakub.
> 
>    v2->v3:
>    - Fixed compilation errors reported by kernel bot for big endian flavor.
> 
>    v3->v4:
>    - Made changes to use masks instead of C bit-fields as suggested by Jakub/Alex.
> 
> Sharath Chandra Vurukala (3):
>    docs: networking: Add documentation for MAPv5
>    net: ethernet: rmnet: Support for ingress MAPv5 checksum offload
>    net: ethernet: rmnet: Add support for MAPv5 egress packets
> 
>   .../device_drivers/cellular/qualcomm/rmnet.rst     | 126 +++++++++++++++--
>   drivers/net/ethernet/qualcomm/rmnet/rmnet_config.h |   4 +-
>   .../net/ethernet/qualcomm/rmnet/rmnet_handlers.c   |  29 ++--
>   drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h    |  11 +-
>   .../net/ethernet/qualcomm/rmnet/rmnet_map_data.c   | 151 ++++++++++++++++++++-
>   drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c    |   3 +-
>   include/linux/if_rmnet.h                           |  27 +++-
>   include/uapi/linux/if_link.h                       |   2 +
>   8 files changed, 318 insertions(+), 35 deletions(-)
> 

