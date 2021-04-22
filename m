Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9121F3687C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbhDVUPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbhDVUPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:15:01 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F2C061756
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:14:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f21so10699679ioh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cvCS96FY4AJz7K/5a4aRGifUPl+rI1zPuDuUotH2+vw=;
        b=aRr2O/q4Om9qYJP+ZXJmjABPgwFTM4XkcLEdCSJSDbW9YoWbhvT9njtpuiiOXIP6zq
         Yi/8E4QU3uUduuNkOMAHNiC2ef0o5JaXv5YPvIh3kJn7Mf75tpuw7wsaMB5Z0jeuVLrn
         WYi4jEsaeFffzRoOoj+uB/iGI1EmfY0ruSEXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cvCS96FY4AJz7K/5a4aRGifUPl+rI1zPuDuUotH2+vw=;
        b=a5wvNdEX6XSBfLEYv9SdpfoxaivAtquzjiFDtyYuL3WKtxDuxR1fFghHUM57cqd0Yf
         pj1Ya1sR1nD5MalmzrVKx2TDUPTNWCFxkMfzvDg7vVFj4VnX1nNXv6nChF/pzRWdonVD
         GZv0ta1AsSsbC8iDtMnd9seFfU0KQ/oMFQmOC8V1oD5eigm51o+u5BJg4WmzExub1ZSJ
         cotGXeBizuOdFbzSj674X3XOKTuTEy3Hlkh3B/eo35hd1VTS3848aWUr5ddbEAotIbBa
         bqSYviVAE4Ee5gaHkJcZ3ltlkvgLpq+uNjQYYNjBJnrE0lfcLwCKlPPCpz1E9oOkOH5I
         9Ncg==
X-Gm-Message-State: AOAM533TcvOwWk/a+tzqV7pAToDnSCsgSSd+ovPfGZO5U/VAHrVF0Xxg
        z7GOI0mHErSEVu0FqqNRTYRUZsDzt4Luaw==
X-Google-Smtp-Source: ABdhPJzovPGKD9dCyvzDQpCaUbpywpWKhJxNNjgyb0I8xDv+9NsIcq3kFQpCHjN9cbxAx0IUgDKvOg==
X-Received: by 2002:a6b:7202:: with SMTP id n2mr588343ioc.86.1619122465386;
        Thu, 22 Apr 2021 13:14:25 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id f8sm1550930ilr.20.2021.04.22.13.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 13:14:24 -0700 (PDT)
Subject: Re: [PATCH net-next v4 0/3] net: qualcomm: rmnet: Enable Mapv5
To:     Sharath Chandra Vurukala <sharathv@codeaurora.org>,
        davem@davemloft.net, kuba@kernel.org, elder@kernel.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619121731-17782-1-git-send-email-sharathv@codeaurora.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <ed00501e-d558-a47f-5444-b1a5a895d6db@ieee.org>
Date:   Thu, 22 Apr 2021 15:14:23 -0500
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

Was this supposed to be version 5?

I already reviewed version 4.

Please post version 5.  I am going to ignore this series.

					-Alex

> 
>    A new checksum header format is used as part of MAPv5.For RX checksum offload,
>    the checksum is verified by the HW and the validity is marked in the checksum
>    header of MAPv5. For TX, the required metadata is filled up so hardware can
>    compute the checksum.
> 
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

