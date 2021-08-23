Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6ED3F5122
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhHWTSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230377AbhHWTSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629746243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfa5vNFo38/k45EAS0ocbtPh3eTQnzy51Lm4DUgg6zo=;
        b=HlL4pxQMbi67rgNJmLejbMFnK0Pvz2ZVsWrNA0+x3WyBAzZMKRBHgZrcwiRkupkNHgPbfz
        AVI+HVyRuh6mbdqE2oBtk9Vn4B92SrtVLIPydvloxyeb0wtIzku9v6QVBjpaODAIzKBJMd
        58i6/Xa6ANkpPszuifySne/Bx+pVDGw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-sva_QisuMzycRUGAYAwfKw-1; Mon, 23 Aug 2021 15:17:22 -0400
X-MC-Unique: sva_QisuMzycRUGAYAwfKw-1
Received: by mail-wr1-f70.google.com with SMTP id r11-20020a5d4e4b000000b001575c5ed4b4so455022wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hfa5vNFo38/k45EAS0ocbtPh3eTQnzy51Lm4DUgg6zo=;
        b=KgZ+bqJEXpxrYKDtGxFZuidPbADsuT46+VVzlnCScErVqWayR987wuC+aOjYYWCIrR
         i+T8xvguuIOTFWqYJHFLi4DcROK3KE4Cc8SP9apuEZ/Z4Og/0FsjjNffE8+usMbf7Es7
         7orbxkb8F29JBpM9HICuv70CA9y+Iv5Vhdwqw/guCk+j3Jd8sypg0KazDaVdv66NDOzf
         eSezRAse1cLjclclYJ3yRffj3t7MTM+Spj19Q9BwEPMQ0SGv9veipOIyPRrK8AS4uDW8
         GyXEeAwwmSD6Wh/hTAjt21F2CyDaHhxdWVHthql+J1UeQ3JoUMJOe9ADXG1s+zP2eDr9
         Z8iA==
X-Gm-Message-State: AOAM532W5oP3z2cwRFAhdIp/lxIQZdyPKJ3XVnrbOWFrze3qzy0d7G44
        w5rcLPYKC17E/8Ux42eN8VgR4e6h8FAq8KohqYat3/tKqKUUeM39IWPKC0SfaijNjs6aOxmlMq5
        R99pp1dl0n+aeU/kY0LBLvj+g
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr14808691wrq.377.1629746241194;
        Mon, 23 Aug 2021 12:17:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCCa98KM7/EeqgBJubHh9aDYEDS2dcPiXFmf/SLIfXyxzg0Qtn0czsk3yMiJSWGjR9BG9PAg==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr14808679wrq.377.1629746241045;
        Mon, 23 Aug 2021 12:17:21 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60c6.dip0.t-ipconnect.de. [91.12.96.198])
        by smtp.gmail.com with ESMTPSA id q22sm58557wmj.32.2021.08.23.12.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 12:17:20 -0700 (PDT)
Subject: Re: [PATCH V1] hugetlbfs: Extend the definition of hugepages
 parameter to support node allocation
To:     yaozhenguo <yaozhenguo1@gmail.com>, mike.kravetz@oracle.com,
        corbet@lwn.net, akpm@linux-foundation.org
Cc:     yaozhenguo@jd.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
References: <20210823130154.75070-1-yaozhenguo1@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <be7017ea-0728-b342-0c78-f88256024dfb@redhat.com>
Date:   Mon, 23 Aug 2021 21:17:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823130154.75070-1-yaozhenguo1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.21 15:01, yaozhenguo wrote:
> We can specify the number of hugepages to allocate at boot. But the
> hugepages is balanced in all nodes at present. In some scenarios,
> we only need hugepags in one node. For example: DPDK needs hugepages
> which is in the same node as NIC. if DPDK needs four hugepags of 1G
> size in node1 and system has 16 numa nodes. We must reserve 64 hugepags
> in kernel cmdline. But, only four hugepages is used. The others should
> be free after boot.If the system memory is low(for example: 64G), it will
> be an impossible task. So, extend hugepages kernel parameter to specify
> node number of hugepages to allocate at boot.
> For example add following parameter:
> 
> hugepagesz=1G hugepages=0:1,1:3
> 
> It will allocate 1 hugepags in node0 and 3 hugepages in node1.

I like this format.


-- 
Thanks,

David / dhildenb

