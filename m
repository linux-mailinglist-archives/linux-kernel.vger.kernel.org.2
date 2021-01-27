Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD66C305BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhA0MmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:42:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237068AbhA0MdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611750696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgQSgW3ijk3bfBjv9KOVXpYx518XkO0noyOhJ5F3E3A=;
        b=C+9rPgGxN6h89CQ9cH133XONXa273qZWAs1tl4QcQd1+Tb6VWzLN09Aitm0mzQ8ew9Gy1u
        mr0U2v07I4WVdaVVTlZy3OzBOD7J7tqDavHy3U1vHdqIt/z1ozxEOwXtwvS4qICJ7E89n6
        pQEmBeO3agQXD9/+z+ohrRrnrZD+vDc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-0PL812tAM1G95JRW1IOSfQ-1; Wed, 27 Jan 2021 07:31:33 -0500
X-MC-Unique: 0PL812tAM1G95JRW1IOSfQ-1
Received: by mail-ed1-f71.google.com with SMTP id n8so1255015edo.19
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dgQSgW3ijk3bfBjv9KOVXpYx518XkO0noyOhJ5F3E3A=;
        b=am3wXkcZauK5+672CDsUTUKiMyx6yuS9YzdxnS/4n0/DOw52FNjJfIH2+u3d+GZ/q8
         U2oK1Uqm5aXokprWc/sr0GBGcNf4LGViuKD5tgGTqG1YwhAaxl1dznU/Y2YqPG6dfWRh
         pDipytMK6c3K5wb6gbJ8FT12386zjYt5N3NCHaJVPX+qEjSWRR1zldpo9HDUaRnCy/1n
         zBEX/9JHZGwUKbnzaR6akYDDiV2mLUJi3+tESOa7XG3zrKiKyDnzS97UBmhjywGXnXLI
         kkJ7hKl9/xum3eR6Ft9tPXiZwzJXFwe7Viif4NlonhxukRdmnXKZJnZy9+26PmjcA/J0
         EV2Q==
X-Gm-Message-State: AOAM5333Rsko/qFB4LmYhLfic8JyyjQ8KylEnPBsFY3lUvq1cjPw3+cv
        RDOHZnLNF+y9UfYRbtYdEGE4k3ezA3wTPPYJxzgaivhDn6Kw4DHiIa0nvKIMEOObWxTzvRDjdAF
        OZtOlRNJJyuj6ul64B0a9/9whH9+GqUpxpBqzBPaR6fZ+DMbVUr9OZD4mf/0gNNHczdDJ2i7i6b
        Nc
X-Received: by 2002:a17:907:abc:: with SMTP id bz28mr6574931ejc.395.1611750691991;
        Wed, 27 Jan 2021 04:31:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzc1oAB7j1wPAy0H1JqWaCELA6b6i1a9cpil4PF64M6jRO8hfU1/lDcvxu5D+D2AA/JEXdYfQ==
X-Received: by 2002:a17:907:abc:: with SMTP id bz28mr6574901ejc.395.1611750691764;
        Wed, 27 Jan 2021 04:31:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s18sm1250961edw.66.2021.01.27.04.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 04:31:30 -0800 (PST)
Subject: Re: [RESEND PATCH 2/2] KVM: X86: Expose bus lock debug exception to
 guest
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        kernel test robot <lkp@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kbuild-all@lists.01.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210108064924.1677-3-chenyi.qiang@intel.com>
 <202101090218.oqYcWXa4-lkp@intel.com>
 <cfc345ea-980d-821d-f3a6-cea1f8e7ba03@redhat.com>
 <3c38f1be-47c3-e8f8-ee72-9642e99ac93f@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc5dfd66-e9bb-cb1b-fbb7-d3ecefeac52b@redhat.com>
Date:   Wed, 27 Jan 2021 13:31:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3c38f1be-47c3-e8f8-ee72-9642e99ac93f@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/21 01:57, Chenyi Qiang wrote:
>>
>> What is the status of the patch to introduce 
>> X86_FEATURE_BUS_LOCK_DETECT (I saw 
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2389369.html)? 
>>
>>
>> Paolo
> 
> Fenghua sent the v4 patch and pinged x86 maintainers, but still no 
> feedback.
> https://lore.kernel.org/lkml/YA8bkmYjShKwmyXx@otcwcpicx3.sc.intel.com/

Ok, please include it when you repost.  Thanks!

Paolo

