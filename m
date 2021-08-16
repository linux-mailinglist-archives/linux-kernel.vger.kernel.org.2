Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42DE3ED918
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhHPOn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232385AbhHPOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629124975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBjVhanhpPaELALnY4MK4iEI3I/01CLjAVhRTcYSG4c=;
        b=IGJySoAqqTcFU38OzDHjpxbVWU1FYzAb8hyeSR2Z8O0y7jgD3n3gQxO3HeiioAyZFj4zr3
        SiyXuEYzgmv/bWAc66Jj+zQ3TUVKGjWU6+TJ5kEvhbfS/CXo4rQuXuEZX/tMGP3KbCFb3b
        FaIKorQgd6q2TwyMpAdwWfOf6Ewo6lc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-QREYLxHDMwqxh6m4jgeChA-1; Mon, 16 Aug 2021 10:42:54 -0400
X-MC-Unique: QREYLxHDMwqxh6m4jgeChA-1
Received: by mail-ej1-f71.google.com with SMTP id kf21-20020a17090776d5b02905af6ad96f02so4804634ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 07:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nBjVhanhpPaELALnY4MK4iEI3I/01CLjAVhRTcYSG4c=;
        b=HB5zlMEQyW6nEn5O9W85ReWn9wUMttEM8DOCg6rH7RlGzW8jBs1F8X/F/gnp0Vyc4s
         hXNtQ8d0z1bWKlgPL4Qi5Jmi1z4R6pfXTKrR/3geEO6S9JzQld9o1YRboPWbu0Te1190
         FNkBztmdEcNMvRnqsgiOFqfoqqgCOqXx40nmnExx+w+g0nAygXVPxD/+kSMNs3AqAI+H
         Q309eWewKpIu7CLcashcElit0UMZEx6p2TIvW4MYa/Jsb4TtaGvKWpgbXdNXxf07+Pya
         Fjy8DGy6dYJ3uSpQTofPTKwhsRS5Hhy/KnqZkgj/A4fngvRyTkS2sX2Ei0zCRe6jD+QU
         EFuA==
X-Gm-Message-State: AOAM533oYxqKp3bxz670YRQddcAG10/Gbb7eFsLGSbmwStEu4oxbo3SJ
        mTfoLXPhGM/GdBdSUvUudHDcIXBZHuqH7Q/eIgGAnaD91xVyXSLYvsHsXc4RM9WxFHy12MTBzHF
        kEpEUFL7lEmNUohvYCd1lU4pm
X-Received: by 2002:a05:6402:160b:: with SMTP id f11mr20500840edv.22.1629124973286;
        Mon, 16 Aug 2021 07:42:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVydQu2ZZL8nay/QmYJOkUzzTDg+npyKfPQRtLDYljZgpQCgh3DS2o+mWGh/B5NzSGHdyJSw==
X-Received: by 2002:a05:6402:160b:: with SMTP id f11mr20500826edv.22.1629124973158;
        Mon, 16 Aug 2021 07:42:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id s3sm3780822ejm.49.2021.08.16.07.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 07:42:52 -0700 (PDT)
Subject: Re: [PATCH 4.14.y] KVM: nSVM: always intercept VMLOAD/VMSAVE when
 nested (CVE-2021-3656)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20210816140240.11399-8-pbonzini@redhat.com>
 <YRp1kmNV1i3Hds/U@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9311b2e8-0107-89e1-26e6-95ba02d08479@redhat.com>
Date:   Mon, 16 Aug 2021 16:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRp1kmNV1i3Hds/U@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/21 16:26, Greg KH wrote:
>>
>> [ upstream commit c7dfa4009965a9b2d7b329ee970eb8da0d32f0bc ]
> 
> This is not a commit in Linus's tree:(

Not yet, that was remarked further down in the message.  I sent the 
stable patches at the same time as the embargo lifted.

Paolo

