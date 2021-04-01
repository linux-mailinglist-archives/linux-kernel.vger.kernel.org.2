Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8C3513D2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhDAKn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233780AbhDAKn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617273836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06eBF4o9d28G+6vg65LbOreOw6UgB9u15+hd9KC5gTQ=;
        b=YMwEcccAYCXnRB+WD0F3+sU2GzRgz+Ltzlt4r02UdXsJK5MfgWyhLgYtttyapbuMO8Q2qi
        Q5ZVdsOC5lZvDx1/ayypE6tAqOjKOvcZ6CAjE7gwhuenNTEBXA5/NugBRkO59LW8Wk4ZcI
        6uH1QYmHbggOdIegu+DachoVesuKvjU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-zASO8NqRMmehQ8Pdq_u5YA-1; Thu, 01 Apr 2021 06:43:55 -0400
X-MC-Unique: zASO8NqRMmehQ8Pdq_u5YA-1
Received: by mail-ej1-f69.google.com with SMTP id t21so2038490ejf.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 03:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=06eBF4o9d28G+6vg65LbOreOw6UgB9u15+hd9KC5gTQ=;
        b=D6D/QCO+VbMKi+a2+MWJtN9DZpxk3cZlNS053Gtjc5Hs4wpHaZKxPg0yw/YB9ZYmS0
         yi8GiV/DOLdrYYoz23kkI3qN2o4k5+AahlXJbL0CqYPnUux4KmlcuDOSAVoL+vHBOiMr
         1g1u097eW9rFVxwL2ivdgWLrFQ4Nu9yrQSL72J+Co0FLk3O/89dJEOEwiGngvN+eUkoa
         Df6QPaBoZ6PXVBl0qQ4dQwXa926WVOv+WUhFkK921XeSYK2lFy3TgO311xVGlrT5x95R
         lAfXyMF8NYMEOPoBiEaKEWR5lKuW//o4dAP8K2xblPqIL0wtlV8VePO89P3jfw4wh4qx
         sTow==
X-Gm-Message-State: AOAM532aa+RmjZcwVObb/RKNpHtpUvmcl4dgRFFtyZO/FEBBXX29Axiq
        PFdzZ716p8f3SevBl9ueM41z0CDdcejqOnowH51/4NhXexJYP7c/PrXMprbOYCl356J/64+m8jw
        tgxmZ9Y2rnoGzOc37oD1nkNOP
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr9100003edc.94.1617273834230;
        Thu, 01 Apr 2021 03:43:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaEuHHzciANwnLmu0x2hIKZoVzKLp+pSGWi/TjhOef41m8Xy6dIdyT4us53vS/TpmgrvFbJw==
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr9099988edc.94.1617273834091;
        Thu, 01 Apr 2021 03:43:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id la15sm2574423ejb.46.2021.04.01.03.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 03:43:53 -0700 (PDT)
Subject: Re: [PATCH 00/13] More parallel operations for the TDP MMU
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210331210841.3996155-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <880ebe32-2ea5-6369-be2c-ce5d93746292@redhat.com>
Date:   Thu, 1 Apr 2021 12:43:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210331210841.3996155-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/21 23:08, Ben Gardon wrote:
> Now that the TDP MMU is able to handle page faults in parallel, it's a
> relatively small change to expand to other operations. This series allows
> zapping a range of GFNs, reclaiming collapsible SPTEs (when disabling
> dirty logging), and enabling dirty logging to all happen under the MMU
> lock in read mode.
> 
> This is partly a cleanup + rewrite of the last few patches of the parallel
> page faults series. I've incorporated feedback from Sean and Paolo, but
> the patches have changed so much that I'm sending this as a separate
> series.
> 
> Ran kvm-unit-tests + selftests on an SMP kernel + Intel Skylake, with the
> TDP MMU enabled and disabled. This series introduces no new failures or
> warnings.
> 
> I know this will conflict horribly with the patches from Sean's series
> which were just queued, and I'll send a v2 to fix those conflicts +
> address any feedback on this v1.

Mostly looks good (the only substantial remark is from Sean's reply to 
patch 7); I've made a couple adjustments to the patches I had queued to 
ease the fixing of conflicts.  The patches should hit kvm/queue later 
today, right after I send my 5.11 pull request to Linus.

I have also just sent a completely unrelated remark on the existing page 
fault function, which was prompted by reviewing these patches.  If you 
agree, I can take care of the change or you can include it in v2, as you 
prefer (I don't expect conflicts).

Paolo

