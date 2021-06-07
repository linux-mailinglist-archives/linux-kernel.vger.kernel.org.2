Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9CC39D35C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 05:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFGDUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 23:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230169AbhFGDUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623035925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABnq2QuOpr7byvnRGusIkVvj+20PbgeaIPvM27YKhg4=;
        b=NYm6lC/x5w+kG1yUkFR90+hzVOMxnCkewRQicenItQsa2e5MtntXQ2aq5+AeY8MguVe0bs
        5DGG+DtAaxOapbqTQoebSL2HpXHRq9Ji+SsuwUZ4p6LlbykKOAuG7XU0TIcR7VO9ny38Uo
        dTymUwE3t6A3I/OVwheVwARLq4pmbc0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-Zc2mFRReOM6qUMBE4y2WgQ-1; Sun, 06 Jun 2021 23:18:44 -0400
X-MC-Unique: Zc2mFRReOM6qUMBE4y2WgQ-1
Received: by mail-pj1-f69.google.com with SMTP id om12-20020a17090b3a8cb029016a4ee7d56fso10486679pjb.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 20:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ABnq2QuOpr7byvnRGusIkVvj+20PbgeaIPvM27YKhg4=;
        b=B3DLqXjEkcWYK2hP9ydWn/Q5Y4TOVgzh3Qr6e7dKg21jLht9qTRYkEeRDkVb4GilPR
         61lJiczBK36YwZYGWGgf1nD13aFWjAzCLy4BgJJdcO0JnRdjYpcLppzqkDJPg0aFPHJo
         vpN4MuEpf3Q2e2ArAILlpjvp/bbNblS7UPMdAbwtkSV43x+cony0XCFzTWRwwUQaRnwQ
         Fr6TnO8+eoo+uYi9E4vURCfG9Dg/vue1IUHn1PbM81TxL13eXgLfjWKHSbwOBRobwWqz
         NlFgdun/AO8AZFH9pRkS8oSqNnatT6T3n4njnIQsu76slJw8flm5frzl8sUm1pcloew/
         /CVA==
X-Gm-Message-State: AOAM531FU+DEBmo6Mz5SlqmdjApkVIV9bl9hmltWTs6YV4ztBSpdaA36
        m2MBWr+Cltzigg52JXIgHXveUqqYj/tzq4gipruEI9rWEbuozA410n6r9+gw8Wx8NJQik1rUK2D
        j1WveWumdKQ0Qs0UCIIwPOtFb
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr18291776pjb.52.1623035922897;
        Sun, 06 Jun 2021 20:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxyhCGMAJgmD0wCDBmip4ixPdmhcn5mWCmYZELjB4tRm0TDYopxIzBxkopd2Rpl9Ugu+p2EA==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr18291758pjb.52.1623035922656;
        Sun, 06 Jun 2021 20:18:42 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w10sm6719572pfg.196.2021.06.06.20.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 20:18:42 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <6a9426d7-ed55-e006-9c4c-6b7c78142e39@redhat.com>
 <20210603130927.GZ1002214@nvidia.com>
 <65614634-1db4-7119-1a90-64ba5c6e9042@redhat.com>
 <20210604115805.GG1002214@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <895671cc-5ef8-bc1a-734c-e9e2fdf03652@redhat.com>
Date:   Mon, 7 Jun 2021 11:18:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210604115805.GG1002214@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/4 ÏÂÎç7:58, Jason Gunthorpe Ð´µÀ:
> On Fri, Jun 04, 2021 at 09:11:03AM +0800, Jason Wang wrote:
>>> nor do any virtio drivers implement the required platform specific
>>> cache flushing to make no-snoop TLPs work.
>> I don't get why virtio drivers needs to do that. I think DMA API should hide
>> those arch/platform specific stuffs from us.
> It is not arch/platform stuff. If the device uses no-snoop then a
> very platform specific recovery is required in the device driver.
>
> It is not part of the normal DMA API, it is side APIs like
> flush_agp_cache() or wbinvd() that are used by GPU drivers only.


Yes and virtio doesn't support AGP.


>
> If drivers/virtio doesn't explicitly call these things it doesn't
> support no-snoop - hence no VDPA device can ever use no-snoop.


Note that no drivers call these things doesn't meant it was not 
supported by the spec.

Actually, spec doesn't forbid the non coherent DMA, anyway we can raise 
a new thread in the virtio mailing list to discuss about that.

But consider virtio has already supported GPU, crypto and sound device, 
and the devices like codec and video are being proposed. It doesn't help 
if we mandate coherent DMA now.

Thanks


>
> Since VIRTIO_F_ACCESS_PLATFORM doesn't trigger wbinvd on x86 it has
> nothing to do with no-snoop.
>
> Jason
>

