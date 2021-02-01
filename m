Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80630AA87
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhBAPIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231362AbhBAPHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612191952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eX0gXpFl1l7y74u4JDLx1FBGVKaeL4IiU69Igj0W6ks=;
        b=AfUYgW7fSy9qPxC7A9FEMKlAune3MyYz9iDyeQB+UIGAsL76qPn0RYx0AzwIlv66t+Xl9c
        +8ilnTKLn6p6OGVUhsGD7E/SQfLfqzfwCIse530I9hshgzFSFukJiCeWIXkXmwPDrDN46K
        sec1aJZCx2HA2eOfr9pKn3Cr0aN2p10=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-yud86Dn9PMe73lY42Rctww-1; Mon, 01 Feb 2021 10:05:50 -0500
X-MC-Unique: yud86Dn9PMe73lY42Rctww-1
Received: by mail-ej1-f70.google.com with SMTP id f26so8391607ejy.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eX0gXpFl1l7y74u4JDLx1FBGVKaeL4IiU69Igj0W6ks=;
        b=mvwYVggukSLqB6UhGUFxr1R6in/vhNQMN/PUgKRZLZuAasRPGSLkYvqIdS+bwIBDkx
         Oex0BeHvURDzMRZAKHJO7NjL/0K844gmXHxxXjALwDVt12tdoFVhUkpS9uG2x5pibf6L
         RkSPh9GhuwxRAMeY4HET1Nw/t0hFeQIaVU8UM+LTr736fKL8swxumlptC72cj1JciHZX
         GwPdpWr5Ubk4LflTF0PL4MUNLtCnS3fq4SV8+YZDDSDk16drQCmvcLWnDe9q1CYgTi1l
         pDjv/nKcZqIV2iGtjNHBdn2A06dgH7cRQttCpPMP0XODhnFTQuyDXvHsdIAB6aGsohHK
         phVQ==
X-Gm-Message-State: AOAM53357vu6x1MF0jYjStI3vefPQzuIJfrbE/DeKISY/7rGxvuIItq6
        EpJ9N/TCT+BoPfJ1DlryW90IXeM4WzPYwb5QSu7vTdaK2cg7tjy2ye/WpGhHmVI5dK/YqImE/YP
        PU4En4lSlsqgeD+K4hv7i529k
X-Received: by 2002:a17:907:f81:: with SMTP id kb1mr11875719ejc.466.1612191948309;
        Mon, 01 Feb 2021 07:05:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzK0jclynZ+MrcrVdO9SPTLfEAUH3rSPQUqH1OjcPu4PcBednTnIh0NLUi+4F/vqxS1P/HaPQ==
X-Received: by 2002:a17:907:f81:: with SMTP id kb1mr11875699ejc.466.1612191948164;
        Mon, 01 Feb 2021 07:05:48 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id y1sm3026899edq.26.2021.02.01.07.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 07:05:47 -0800 (PST)
Subject: Re: [PATCH v3 0/3] common SVDM version and VDO from dt
To:     Kyle Tso <kyletso@google.com>, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210201133421.408508-1-kyletso@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a2f8cdd1-7180-a0af-fadf-b0eae2e117ae@redhat.com>
Date:   Mon, 1 Feb 2021 16:05:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201133421.408508-1-kyletso@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/1/21 2:34 PM, Kyle Tso wrote:
> patch v2:
> https://lore.kernel.org/linux-devicetree/20210131151832.215931-1-kyletso@google.com/
> 
> Changes since v2:
> =================
> usb: typec: Determine common SVDM Versions
> - rename the variable and the functions (remove the text "common")
> - remove the macro
> 
> dt-bindings: connector: Add SVDM VDO properties
> - no change
> 
> usb: typec: tcpm: Get Sink VDO from fwnode
> - use fwnode_property_count_u32 instead to get the count
> - revise the error handling
> 
> Kyle Tso (3):
>   usb: typec: Determine common SVDM Versions
>   dt-bindings: connector: Add SVDM VDO properties
>   usb: typec: tcpm: Get Sink VDO from fwnode

I wanted to point out that I have a somewhat related series "pending".

I put quotes around pending because it has been reviewed quite a while
ago and have not managed to make the time to post a new version since then.

My series is somewhat/mostly orthogonal, but I think it is good
to keep it in mind since it also is about specifying VDOs, but then
for alternate-modes, see:

https://lore.kernel.org/linux-usb/20200714113617.10470-1-hdegoede@redhat.com/

And I think there might be some overlap with the last patch in this series,
although that does not call typec_port_register_altmode(). 

Regards,

Hans




p.s.

I was actually planning on replying to an earlier version of
this series, *after* I posted a new version of my own series,
but I'm swamped so it looks like I will not get around to posting
a new version of my own series anytime soon.

