Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E66739B060
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFDCbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhFDCbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622773796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gt8hnOglaRtAhIBG091MfWOvOxMu+M8wqRg4Wjd74ow=;
        b=QnMTKsb1Pd2ABhZVIYGLDuTQIBYbja9rF4vDsQwsvj5KVip1HlqMVMOgDuTkDcBHzZPFBd
        M1igUcXdD5HBfOvPL7BvFXPcOB+fc7ecR+BsD2BGp2qdpyipjEU1StJa+Ta44lULVTe23r
        xRbQwPAaELyzLqQ4abhIiO/P/K8DYUU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-8LQP2abtMXWrmwzs5rHbjg-1; Thu, 03 Jun 2021 22:29:55 -0400
X-MC-Unique: 8LQP2abtMXWrmwzs5rHbjg-1
Received: by mail-pj1-f71.google.com with SMTP id 15-20020a17090a0f0fb029016ad0f32fd0so3955104pjy.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 19:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gt8hnOglaRtAhIBG091MfWOvOxMu+M8wqRg4Wjd74ow=;
        b=RCLBVsP76XGIP6pHf9mS/jT/4K37Rl1ghQvSmsQK/QWaavWDyva/+hOq25N7oNEe0D
         4XLgwcifh44Jh9huQ/d0w+Vk4X1d4eDXYj9A83pSlEGWqvYAKgWbl+JJMLdGVaSj6m5g
         Y2JDBpivFug8Ln3DZph5nmyWZxEW+74psrFETqB2CGXpSJYygZqEhfUGYK3bMltBFBih
         PBQAo9HC2Wb58v8r8ml+ecrFbML8jM2Ma35qws1YexxP0GASFokPeQ2LI2ECk22FPytK
         7xZ9lQZMRwUgfsjpm+tZtwNZ9Rm1OO1GzcZa/sjKGu0nqyWKA/4AMrbRXcLXkxmhdS/T
         Aosg==
X-Gm-Message-State: AOAM530USJfDJpPNIeMKUUnOOX/we5yC//R+akCFTii9z9uy56XuNoe7
        z7oHOzbWuNXds3DYUkpfBi3lk1OZD/QdlpiyL/XknUXOLjjCcrRjRUabLQ4oXyUQnhVdqbD7GHf
        eYMDrDBj1DNn3Ky8HxP4VdjEp5nWrvcedw/8Sn64MTkCbhgc95vszoGPI8rwzF4dIgVou6KLsv0
        Ph
X-Received: by 2002:a17:90a:c20b:: with SMTP id e11mr14312040pjt.67.1622773793711;
        Thu, 03 Jun 2021 19:29:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXfTmOi+wnH/roCuXQXvi+QWyoA9G2ErBsIgSWukz95apd75Y4VLg30EaPsmmCzT9f8zvJ3w==
X-Received: by 2002:a17:90a:c20b:: with SMTP id e11mr14312013pjt.67.1622773793313;
        Thu, 03 Jun 2021 19:29:53 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s11sm325912pfm.95.2021.06.03.19.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 19:29:52 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andi Kleen <ak@linux.intel.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <28c8302b-6833-10b4-c0eb-67456e7c4069@redhat.com>
 <09e17c7f-ce51-1a46-72c4-12223bee4e3a@linux.intel.com>
 <1c08bc42-7448-351e-78bf-fcf68d2b2561@redhat.com>
 <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
 <9b10bb24-eb27-510e-cf0d-7818ab9166ef@redhat.com>
 <9d6bc785-9613-a2e8-f78f-4547747a331d@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <93f58cfd-be59-1ea6-e0d0-6840c14d6980@redhat.com>
Date:   Fri, 4 Jun 2021 10:29:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <9d6bc785-9613-a2e8-f78f-4547747a331d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 下午9:55, Andi Kleen 写道:
>
>> Ok, but what I meant is this, if we don't read from the descriptor 
>> ring, and validate all the other metadata supplied by the device 
>> (used id and len). Then there should be no way for the device to 
>> suppress the dma flags to write to the indirect descriptor table.
>>
>> Or do you have an example how it can do that?
>
> I don't. If you can validate everything it's probably ok
>
> The only drawback is even more code to audit and test.
>
> -Andi
>
>

Ok, then I'm going to post a formal series, please have a look and we 
can start from there.

Thanks

