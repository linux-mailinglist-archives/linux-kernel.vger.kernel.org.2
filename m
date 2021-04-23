Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82C9369224
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbhDWMco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:32:43 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1616C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 05:32:05 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q25so5276543iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 05:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0EBpDjScxB7j1uSQSZp0keJbRYRhRbNUYseRJ/TKQe0=;
        b=OG4WPzQqUeeHW6/hN0p9nT64l9h9yJCf/rjFJ8ya7H7VJ8pv8Wp8ZL7pwBUcR2Xpiz
         gqvtcAnDOPVVxuciPdaGRxLsi541lLGojB3DJPVzzY811kqRdjbAqSksb9Z5j8WhTwoO
         Q185z+or9HV6hoqpujWey4QeN7SaioQzgSEDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0EBpDjScxB7j1uSQSZp0keJbRYRhRbNUYseRJ/TKQe0=;
        b=PabD8y2vsCeC/ITfXyTj10XQFu4o1ra1k9BsS4i4bmYrLAVhvsCWDhHGW3gdlK3met
         hnqPT7yUyolt6k7b78KXFxuGSr+eL8OQQarz2DHQmYS8XfQtiTaHkn5W4eG4R6nN+qXJ
         VvHNyzkIcgFHi7mlxZ51EUbkceV3UqHTA/nQmAqhVIACwF3qqJCkc2LUkxp3zZuL07Fj
         5FfW0wWtvrmyYAfV89KqiKnokcKpuCPd7H7TlgTygSQw0A75A6JAlbb3HYG5DjyhgA8E
         olvHfmGBRi8cj5iGNVM6YXUMKUDLJ1wc0QXwuA7cymzRYx9cMw+RZr0DbeEWB17/bCgG
         gMjQ==
X-Gm-Message-State: AOAM532QH2hCDaaM/bjuveaJAA16+tToKCSpfGzpNbAU07Mrgcq+y89x
        FsA4KY206gFQNKKFofZPEd6D4wJOKZnVtQ==
X-Google-Smtp-Source: ABdhPJz9o6HHK/fE8nEk5ebDfD+sYfVaxCZvF02IJUH8cEB2/9EbDJ53/AtKsnRPZ/fgCDmFZ0byZg==
X-Received: by 2002:a05:6602:22c9:: with SMTP id e9mr3125050ioe.73.1619181125133;
        Fri, 23 Apr 2021 05:32:05 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id b8sm2814986iob.30.2021.04.23.05.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 05:32:04 -0700 (PDT)
Subject: Re: [PATCH net-next v4 1/3] docs: networking: Add documentation for
 MAPv5
To:     Sharath Chandra Vurukala <sharathv@codeaurora.org>,
        davem@davemloft.net, kuba@kernel.org, elder@kernel.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619121731-17782-1-git-send-email-sharathv@codeaurora.org>
 <1619121731-17782-2-git-send-email-sharathv@codeaurora.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <cb52178a-166b-3d8d-37bc-db229eb07d4e@ieee.org>
Date:   Fri, 23 Apr 2021 07:32:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1619121731-17782-2-git-send-email-sharathv@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/21 3:02 PM, Sharath Chandra Vurukala wrote:
> Adding documentation explaining the new MAPv4/v5 packet formats
> and the corresponding checksum offload headers.
> 
> Signed-off-by: Sharath Chandra Vurukala <sharathv@codeaurora.org>


Thank you for updating this document, and in particular
for adding documentation for QMAPv4.

While I might suggest minor changes here or there to
wording, I think the document does a good enough job
of describing RMNet data structures.

My main interest right now is enabling inline checksum
offload functionality, so for now I'm content to just
acknowledge this patch.

Acked-by: Alex Elder <elder@linaro.org>

> ---
>   .../device_drivers/cellular/qualcomm/rmnet.rst     | 126 +++++++++++++++++++--
>   1 file changed, 114 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> index 70643b5..4118384 100644
> --- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> +++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
> @@ -27,34 +27,136 @@ these MAP frames and send them to appropriate PDN's.
>   2. Packet format
>   ================
>   
> -a. MAP packet (data / control)
> +a. MAP packet v1 (data / control)
>   
> -MAP header has the same endianness of the IP packet.
> +MAP header fields are in big endian format.
>   
>   Packet format::
>   
> -  Bit             0             1           2-7      8 - 15           16 - 31
> +  Bit             0             1           2-7      8-15           16-31
>     Function   Command / Data   Reserved     Pad   Multiplexer ID    Payload length
> -  Bit            32 - x
> -  Function     Raw  Bytes
> +
> +  Bit            32-x
> +  Function      Raw bytes
>   
>   Command (1)/ Data (0) bit value is to indicate if the packet is a MAP command
> -or data packet. Control packet is used for transport level flow control. Data
> +or data packet. Command packet is used for transport level flow control. Data
>   packets are standard IP packets.
>   
> -Reserved bits are usually zeroed out and to be ignored by receiver.
> +Reserved bits must be zero when sent and ignored when received.
>   
> -Padding is number of bytes to be added for 4 byte alignment if required by
> -hardware.
> +Padding is the number of bytes to be appended to the payload to
> +ensure 4 byte alignment.
>   
>   Multiplexer ID is to indicate the PDN on which data has to be sent.
>   
>   Payload length includes the padding length but does not include MAP header
>   length.
>   
> -b. MAP packet (command specific)::
> +b. Map packet v4 (data / control)
> +
> +MAP header fields are in big endian format.
> +
> +Packet format::
> +
> +  Bit             0             1           2-7      8-15           16-31
> +  Function   Command / Data   Reserved     Pad   Multiplexer ID    Payload length
> +
> +  Bit            32-(x-33)      (x-32)-x
> +  Function      Raw bytes      Checksum offload header
> +
> +Command (1)/ Data (0) bit value is to indicate if the packet is a MAP command
> +or data packet. Command packet is used for transport level flow control. Data
> +packets are standard IP packets.
> +
> +Reserved bits must be zero when sent and ignored when received.
> +
> +Padding is the number of bytes to be appended to the payload to
> +ensure 4 byte alignment.
> +
> +Multiplexer ID is to indicate the PDN on which data has to be sent.
> +
> +Payload length includes the padding length but does not include MAP header
> +length.
> +
> +Checksum offload header, has the information about the checksum processing done
> +by the hardware.Checksum offload header fields are in big endian format.
> +
> +Packet format::
> +
> +  Bit             0-14        15              16-31
> +  Function      Reserved   Valid     Checksum start offset
> +
> +  Bit                31-47                    48-64
> +  Function      Checksum length           Checksum value
> +
> +Reserved bits must be zero when sent and ignored when received.
> +
> +Valid bit indicates whether the partial checksum is calculated and is valid.
> +Set to 1, if its is valid. Set to 0 otherwise.
> +
> +Padding is the number of bytes to be appended to the payload to
> +ensure 4 byte alignment.
> +
> +Checksum start offset, Indicates the offset in bytes from the beginning of the
> +IP header, from which modem computed checksum.
> +
> +Checksum length is the Length in bytes starting from CKSUM_START_OFFSET,
> +over which checksum is computed.
> +
> +Checksum value, indicates the checksum computed.
> +
> +c. MAP packet v5 (data / control)
> +
> +MAP header fields are in big endian format.
> +
> +Packet format::
> +
> +  Bit             0             1         2-7      8-15           16-31
> +  Function   Command / Data  Next header  Pad   Multiplexer ID   Payload length
> +
> +  Bit            32-x
> +  Function      Raw bytes
> +
> +Command (1)/ Data (0) bit value is to indicate if the packet is a MAP command
> +or data packet. Command packet is used for transport level flow control. Data
> +packets are standard IP packets.
> +
> +Next header is used to indicate the presence of another header, currently is
> +limited to checksum header.
> +
> +Padding is the number of bytes to be appended to the payload to
> +ensure 4 byte alignment.
> +
> +Multiplexer ID is to indicate the PDN on which data has to be sent.
> +
> +Payload length includes the padding length but does not include MAP header
> +length.
> +
> +d. Checksum offload header v5
> +
> +Checksum offload header fields are in big endian format.
> +
> +  Bit            0 - 6          7               8-15              16-31
> +  Function     Header Type    Next Header     Checksum Valid    Reserved
> +
> +Header Type is to indicate the type of header, this usually is set to CHECKSUM
> +
> +Header types
> += ==========================================
> +0 Reserved
> +1 Reserved
> +2 checksum header
> +
> +Checksum Valid is to indicate whether the header checksum is valid. Value of 1
> +implies that checksum is calculated on this packet and is valid, value of 0
> +indicates that the calculated packet checksum is invalid.
> +
> +Reserved bits must be zero when sent and ignored when received.
> +
> +e. MAP packet v1/v5 (command specific)::
>   
> -    Bit             0             1           2-7      8 - 15           16 - 31
> +    Bit             0             1         2-7      8 - 15           16 - 31
>       Function   Command         Reserved     Pad   Multiplexer ID    Payload length
>       Bit          32 - 39        40 - 45    46 - 47       48 - 63
>       Function   Command name    Reserved   Command Type   Reserved
> @@ -74,7 +176,7 @@ Command types
>   3 is for error during processing of commands
>   = ==========================================
>   
> -c. Aggregation
> +f. Aggregation
>   
>   Aggregation is multiple MAP packets (can be data or command) delivered to
>   rmnet in a single linear skb. rmnet will process the individual
> 

