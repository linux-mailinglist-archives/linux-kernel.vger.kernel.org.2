Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3335EF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348376AbhDNIUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231825AbhDNIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618388415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BLl1W6zArQenlPXQjJdbyqEKbkXadZaxmjn+SStX0jE=;
        b=FgdMBoahrwyvUOFqIpgN+trHWRBuXf83bDZ/7i0o6Tpk7p44GV5C9Qq7VPrYgZxU0Ac8lV
        zAdX9eCv9o+ayyjlJ2W1qE4akaoHlVHw1+HOwmzPMBgkhSY7ncvf30LVqk3EYF6JcMBhTm
        QFXUUft3LphNtHodj+z3TQUpkuWKeeE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-7yOpF3DNM9S6AeoT-F62pg-1; Wed, 14 Apr 2021 04:20:14 -0400
X-MC-Unique: 7yOpF3DNM9S6AeoT-F62pg-1
Received: by mail-wr1-f70.google.com with SMTP id j16-20020adfd2100000b02901022328749eso714669wrh.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 01:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BLl1W6zArQenlPXQjJdbyqEKbkXadZaxmjn+SStX0jE=;
        b=jdjdQlBPm8nkclQH282k/taJPOPOrki8zu+WdCdgX2Ja4SAZYQuYby8qB3g/NB4e8o
         TNjKmwqW7FaPS9h7JgoQep7lcU5crMZ7tU2G1JFLJrep7unO4/KK7xjO/fF7edpJT5hs
         Wpm6XT7SBUFsrLmOrPE0vBHT3PcruPucKIVPbS/4YKPdK+K18UCEo47L7y04xDs+2zI/
         8Eg4vwhhOgs4EEydc51rjwIdkSKm0bSxnQvWd8HnvrptHx6L7I5pjkL4YR53NiiOfOT2
         bAVCrjnV0WKbnMjBbXopmf2YQoa2+JZonNL/HauF+wg7ilM/Y+0iuPAkg5B+BBSK7J5V
         dbAg==
X-Gm-Message-State: AOAM531FUwNxyZtDd4YtVlZBpPBzvAonTuBWYzf9Hwqe1PvvajLphHIf
        HjB/UvT1F4i+5U8qICen29VcoG9jk7Ur6GHn+ifalGWdsq4kQhkHt5PCcgNwSrL6fxGA3kamTD0
        0RW0WmPP/vlRXdIEuQxsFMoj6
X-Received: by 2002:adf:f081:: with SMTP id n1mr23126407wro.137.1618388412878;
        Wed, 14 Apr 2021 01:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxji2ZwHQ1jQIMNUiTrG2alVhGAtKpmBIuOmzOrODkPO9qH+K9aH6mfNqa8TgAhE29R1H9lRA==
X-Received: by 2002:adf:f081:: with SMTP id n1mr23126383wro.137.1618388412680;
        Wed, 14 Apr 2021 01:20:12 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id s8sm22337947wrn.97.2021.04.14.01.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 01:20:12 -0700 (PDT)
Subject: Re: [PATCH 02/10] mm/numa: automatically generate node migration
 order
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Wei Xu <weixugc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183219.DC1928FA@viggo.jf.intel.com>
 <CAAPL-u8Jk-i-9-iSnU7_nb-k2ZMqdRk5c88d-M6Bi1rfv4kSLQ@mail.gmail.com>
 <20210414080849.GA20886@linux>
 <926bd5f9-bf05-2e01-26da-da3f66439d3b@redhat.com>
 <20210414081444.GC20886@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2c812afa-4c23-3fd5-2e6a-016127a8e488@redhat.com>
Date:   Wed, 14 Apr 2021 10:20:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210414081444.GC20886@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.21 10:14, Oscar Salvador wrote:
> On Wed, Apr 14, 2021 at 10:12:29AM +0200, David Hildenbrand wrote:
>> My guest best is that fast class is something like HBM (High Bandwidth

haha, whatever happened in that sentence: s/guest best/best guess/

>> Memory), medium class is ordinary RAM, slow class is PMEM.
> 
> I see, thanks for the hint David ;-)
> 


-- 
Thanks,

David / dhildenb

