Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D126399862
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 05:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFCDGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 23:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhFCDGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 23:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622689502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5v7V01P50/MU+rNJexPycRVWZFkh/NJWCZ7iWh6s3/0=;
        b=cKwVvm0s4nZB2o7Kzha8Ftdw0syW9rTGdhGi5elytnrskj4S8nLChHHRX5uaWpx2z5sw13
        A/PSyZPk2NH8MV3kzphkE+QDIRaJC/5190fJLUaxRUOlnEeudju8L38iIasn6fwpe18Bs5
        NwHB+OMgI+YtlzPGdCI4YavABczcXOU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-dy1vEuVTMIedjhGpftVO5A-1; Wed, 02 Jun 2021 23:02:32 -0400
X-MC-Unique: dy1vEuVTMIedjhGpftVO5A-1
Received: by mail-pl1-f197.google.com with SMTP id d10-20020a170902cecab02900f342ad66bdso2000903plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 20:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5v7V01P50/MU+rNJexPycRVWZFkh/NJWCZ7iWh6s3/0=;
        b=mHrGupKEZEuFfzdWCDL+21zVL+bQlETqWiujb/kjDjY3NJxRDhFafBaGk0I479E8R9
         M2dfjoAiMaSt64Rni3IKYSTV7u+XFWjItM/tMNZtoaWYZfxckjyHJ+w5UBGN9hXilgqh
         /AAqNKRp0Q2jb4SXU9LdAL784h1HNiHNflByxPEYLIwWOJglauNIFymzvqsH/xVdl6Fx
         hwKRh4GB4HqCpwo/hPnr0ZOIM3tJqrvlat9PzAe4+ObuXMsrtx7Eak8p6GlSWou19K2Y
         NLMrZBODpAGi2FozHAYMHn8NX8rI0DeMJ9LuakVIgGSk1VcnVmmXN2JhHeaCAyXtypOp
         x/MA==
X-Gm-Message-State: AOAM533YL6ReKHeScP+27uBieBUQpE04xn0a2cV/556cQMBbVRMd7YZR
        A2nqhszpiJmVL9PCT0rQtpso+vVxWAFUtMqhGdfD4jlEIzGQ/F4Ys7vvgz9lvx/RKeaFy0BbEIc
        M8xm5QgTwJISX+Etx3sNKB8kA0p6GnBNbwVeEmnV+J5DwT9kbEoLs3I7mmCuJYYcsCBF3j5hLTf
        CL
X-Received: by 2002:a17:90a:e54e:: with SMTP id ei14mr4156609pjb.53.1622689350969;
        Wed, 02 Jun 2021 20:02:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwhDfm3DFenSc3jf0+IF7vZ3fiL+QyQZqc2ItshCLLfoqd1jKoY3Jfm/f4//A4m6OHVAGWYQ==
X-Received: by 2002:a17:90a:e54e:: with SMTP id ei14mr4156577pjb.53.1622689350622;
        Wed, 02 Jun 2021 20:02:30 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q191sm791649pfq.108.2021.06.02.20.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 20:02:30 -0700 (PDT)
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
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9b10bb24-eb27-510e-cf0d-7818ab9166ef@redhat.com>
Date:   Thu, 3 Jun 2021 11:02:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <5a2d0d70-fa6b-f08d-f222-5c00cf5f9d44@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 上午10:56, Andi Kleen 写道:
>
>>
>> I agree, but I want to know why indirect descriptor needs to be 
>> disabled. The table can't be wrote by the device since it's not 
>> coherent swiotlb mapping.
>
> I had all kinds of problems with uninitialized entries in the indirect 
> table. So I gave up on it and concluded it would be too difficult to 
> secure.
>
>
> -Andi
>
>

Ok, but what I meant is this, if we don't read from the descriptor ring, 
and validate all the other metadata supplied by the device (used id and 
len). Then there should be no way for the device to suppress the dma 
flags to write to the indirect descriptor table.

Or do you have an example how it can do that?

Thanks

