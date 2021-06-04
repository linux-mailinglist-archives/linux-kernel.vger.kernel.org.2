Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F3939AFA9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFDBbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:31:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhFDBbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622770158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/MGaP9q9f0JKQhqX62iqN0ZP08JFP5du6nrkmNfcZI=;
        b=K/HQSMU4LBVYpz00V1PPKjKhDMrTDf3NbQeokcJY/KZ1gwFMnyQsSZVRHXvKCYQMHwRpwM
        HxrpXfWZjLstkN++epmqAL2GWEw0KWUuwsCvIJhLeLCREABiej2cCjKpeeHsjE4VSxWC2J
        lBZ/h+FnIFWli49CMH7Eq7lm5nEu4RM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-MnbzckLPPbuGOkyxFAEofA-1; Thu, 03 Jun 2021 21:29:17 -0400
X-MC-Unique: MnbzckLPPbuGOkyxFAEofA-1
Received: by mail-pf1-f199.google.com with SMTP id r15-20020a62e40f0000b02902ec871096d3so180435pfh.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 18:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T/MGaP9q9f0JKQhqX62iqN0ZP08JFP5du6nrkmNfcZI=;
        b=P20IH17Ua4mdJwhkkT2YWsPf15azeyB7AHmk67WrCd3kff4S8RZXq+Mj+y6EVMK18j
         2c9rGV2A7QMJkhF0x/yhf11CQsHrGsSG+2BAWDcJ5aUhoa7f4NXoQpLmcvK1yEEjya5d
         WaZKmQJ1LEB8xKcBlyqMNQfsOal6TdE1bsSue9Mcbb+onUx6tvCBaPbZ6+gP4fYAAFhT
         HUPZsIEIVFpy4PbbCMxs4acWWHKVtxh95e0RuIZyuyhg+p+BcQL6rJ3dw+UGZXp7B8bH
         1uIwzg6o8ohmTfZ7wN+Ljl6TQttHytEN4BJnjivWmHbm+ru6vV12Iok4ZhZSWkZ0n2I3
         I3OQ==
X-Gm-Message-State: AOAM5318iYES0gPYEfEMr6xTQ2il1kHSLl4kqKr3yGBJEQhjY4+ENKWE
        GQ+IfRZKogUiApS2o8299A/aADsWuJ5hbw7EUgBo1hnmcgXcZ6Yh3Utap7UBQBgAVEDCleRvUAg
        G+wjbLezhUPjyWtW42fJc3UXQWukplzPYWqsQcBS+xgfaMjA7I5mczG2Boeg5pfsK3luQQAJMfY
        RM
X-Received: by 2002:a17:90b:1b4f:: with SMTP id nv15mr14342939pjb.56.1622770156356;
        Thu, 03 Jun 2021 18:29:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwux6m9f0rUpQpP+RF5uS/fzFDKk5OPQIJa3aqTa1QYQjfa9K3fazTvsDkqAod+yFl7P/Fs/Q==
X-Received: by 2002:a17:90b:1b4f:: with SMTP id nv15mr14342903pjb.56.1622770155986;
        Thu, 03 Jun 2021 18:29:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h12sm289129pgn.54.2021.06.03.18.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 18:29:15 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4b071a9f-3683-b990-ddc2-450ac5a10388@redhat.com>
Date:   Fri, 4 Jun 2021 09:29:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/4 上午2:00, Andi Kleen 写道:
>
> On 6/3/2021 10:33 AM, Andy Lutomirski wrote:
>> On 6/2/21 5:41 PM, Andi Kleen wrote:
>>> Only allow split mode when in a protected guest. Followon
>>> patches harden the split mode code paths, and we don't want
>>> an malicious host to force anything else. Also disallow
>>> indirect mode for similar reasons.
>> I read this as "the virtio driver is buggy.  Let's disable most of the
>> buggy code in one special case in which we need a driver without bugs.
>> In all the other cases (e.g. hardware virtio device connected over
>> USB-C), driver bugs are still allowed."
>
> My understanding is most of the other modes (except for split with 
> separate descriptors) are obsolete and just there for compatibility. 
> As long as they're deprecated they won't harm anyone.
>
> -Andi
>

For "mode" do you packed vs split? If yes, it's not just for 
compatibility. Though packed virtqueue is designed to be more hardware 
friendly, most hardware vendors choose to start from split.

Thanks

