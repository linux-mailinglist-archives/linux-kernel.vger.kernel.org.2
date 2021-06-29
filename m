Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69B3B6D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 06:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhF2EPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 00:15:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229562AbhF2EPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 00:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624939992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7N6S5aXlTsxjRnLUAwuT1GGB2dsJH/gvDpQ3UzIqM0M=;
        b=SzUh/i8W2tjOYdKVVA/eEfddfMy1StTwJiTZYSj8HAtZ68CiWJ874FtLqq+cdtz+G0LEXY
        vkI1Z7GBb5PCxfQwmWZ6uZGDH2stkTWWqiZT4Su5U3MaKm7lK7PwFtdxziuC9eW84yu2Z9
        hfBlLce79yj+OthZpYL/4Tk8tdmefIw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-8pK7UFR_MRmNSv6HWDvWBA-1; Tue, 29 Jun 2021 00:13:08 -0400
X-MC-Unique: 8pK7UFR_MRmNSv6HWDvWBA-1
Received: by mail-pj1-f71.google.com with SMTP id go14-20020a17090b03ceb02901709d30a8a1so1389930pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 21:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7N6S5aXlTsxjRnLUAwuT1GGB2dsJH/gvDpQ3UzIqM0M=;
        b=nYAnkZF3F74MdaZ5NhJfxvBxv/heVqdNaXkW11m4o0CHIxQzE5SnMdLwv6h0B3AoqV
         nMMRGGDbExq8aVu6u7lHrGMcjKV/VSesp2rK1m2Bs4/v3bSxfMmtiyEYu1bQG/Iknp0p
         whaUhriUMZONUeA8BGSomuFtqvPcfUO+Bz7W1oLL1fkqXtSsz8ODvEkoqFwURYhNFhrZ
         xlLEVAzw2d1hkfTgm0ZIFqCBnGPvfBnc1M+IoRdb+XKy8YY1bkoWkio2s0E11C2fo7yn
         4b0AkRrZd3mVOhMaIBI1JACbipR2p5iZNJ/C5U0RNDsEaH1p6oBUYKfW7AFU/Y/q7VLa
         jV2w==
X-Gm-Message-State: AOAM530XlFkrpdKltuOHFEJ/2n+60jGibgSeOaAsy6GgHe/wOC3viAhN
        8saQ/WHCmRwCuc/jK111S+wTBLwTIGSDuJz9mPuNPQw++8y/idk3JrF6rCo1JX0/5sEQ6NNNNeO
        VpIfniTYq8TJCwkwe1W040Ywg
X-Received: by 2002:a65:478d:: with SMTP id e13mr26587079pgs.37.1624939987923;
        Mon, 28 Jun 2021 21:13:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTnV+jCJcWth5Gh1PanbNwyDV44mMvsm0eLCzSFKGOg12/3H6rwksZzo35n3QJumwiuRcZHQ==
X-Received: by 2002:a65:478d:: with SMTP id e13mr26587053pgs.37.1624939987713;
        Mon, 28 Jun 2021 21:13:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k13sm1525904pgh.82.2021.06.28.21.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 21:13:07 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To:     Yongji Xie <elohimes@gmail.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, sgarzare@redhat.com,
        parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, songmuchun@bytedance.com,
        linux-fsdevel@vger.kernel.org
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
 <CAONzpcbjr2zKOAQrWa46Tv=oR1fYkcKLcqqm_tSgO7RkU20yBA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d5321870-ef29-48e2-fdf6-32d99a5fa3b9@redhat.com>
Date:   Tue, 29 Jun 2021 12:12:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAONzpcbjr2zKOAQrWa46Tv=oR1fYkcKLcqqm_tSgO7RkU20yBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/28 下午6:32, Yongji Xie 写道:
>> The large barrier is bounce-buffer mapping: SPDK requires hugepages
>> for NVMe over PCIe and RDMA, so take some preallcoated hugepages to
>> map as bounce buffer is necessary. Or it's hard to avoid an extra
>> memcpy from bounce-buffer to hugepage.
>> If you can add an option to map hugepages as bounce-buffer,
>> then SPDK could also be a potential user of vduse.
>>
> I think we can support registering user space memory for bounce-buffer
> use like XDP does. But this needs to pin the pages, so I didn't
> consider it in this initial version.
>

Note that userspace should be unaware of the existence of the bounce buffer.

So we need to think carefully of mmap() vs umem registering.

Thanks

