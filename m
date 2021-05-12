Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3944A37BCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhELMhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232712AbhELMhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620822994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hKC4IaCSYPlrbzbaq3gMe1FmeU8nmyn1fevXiQm7ywM=;
        b=L2LrDqnckUHxQNYwFPx6TcnOlcYQDd3aYTxyNemCiL/N3cmpXvraHz1+Y8swHCKUuihh9p
        rYzSg9iC5hRaozs5/5PQ7lUoR73wV8dc7tuYUvaqYKrWj4D6mY9rr/mj7sIxlDZf1JL8XF
        ebMHSnU0QWUUohqJ7J4B5cnYbdlxnyE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-FFiQOd23OxmQ1HHx5hnFJA-1; Wed, 12 May 2021 08:36:32 -0400
X-MC-Unique: FFiQOd23OxmQ1HHx5hnFJA-1
Received: by mail-ed1-f69.google.com with SMTP id r19-20020a05640251d3b02903888eb31cafso12753787edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 05:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKC4IaCSYPlrbzbaq3gMe1FmeU8nmyn1fevXiQm7ywM=;
        b=rm2RxG3ifG0j4X7O7bTMcEQirFcOgNNzpo6IcE1By82SEUKNVT+OxDOPWB+C++iwDj
         DIE8dP1URzgCFc0qpFyEo20HmwpON+p+T8ySGm5XBlrnAl8akxPpWSIndfpI6zbJ/2Eq
         MizbOIFgQTXAk+TrhwzA6s8cHxiOzE6NfUgTXFBfiPMOPIDrOiD9CP8zZIH1MwwKhrYG
         iV0hV1fTfvRqQTCSMeF3s7bCriEEkjaQRkyq9sSbG5VM1T7ZQ1cVFXYv7bH8PYvu1DAm
         zo0PPPo9o0YN9EZqLsljNAyZqF2uf7rRjJQz2Q+Xvjke1d9PLEIO+JgeSeUOFLOaveeT
         jssA==
X-Gm-Message-State: AOAM532W5w9CmMzeP0R2YlkwWLhLcCeU+dpfue/h2jeb43rifi2tXqpm
        iUutBNpqHU7qI4vU6P244PLfgfa+/vugZB4wL3BUs0qqF10Hsu+3aoQJ05YkR1cPXwcw3wrWhG+
        BRSHvpxmv8ZUpgHjYzkHH9MyI
X-Received: by 2002:a17:907:294f:: with SMTP id et15mr38025957ejc.324.1620822991259;
        Wed, 12 May 2021 05:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI+sK4A/63Au0UyVacztSMMHC9tbq67r5t3DiyzezLC5J2IG9ItNWv9phy9/7QpwSi02Ws+w==
X-Received: by 2002:a17:907:294f:: with SMTP id et15mr38025937ejc.324.1620822991033;
        Wed, 12 May 2021 05:36:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p2sm13795120ejo.108.2021.05.12.05.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 05:36:30 -0700 (PDT)
Subject: Re: 5.13 i915/PAT regression on Brasswell, adding nopat to the kernel
 commandline worksaround this
To:     Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     intel-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
References: <b6b61cf0-5874-f4c0-1fcc-4b3848451c31@redhat.com>
 <YJu4tzXmCJbKp7Fm@hirez.programming.kicks-ass.net>
 <20210512115736.GA10444@lst.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3b178f66-fde6-888a-9a49-ab0d13e944b3@redhat.com>
Date:   Wed, 12 May 2021 14:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512115736.GA10444@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/12/21 1:57 PM, Christoph Hellwig wrote:
> On Wed, May 12, 2021 at 01:15:03PM +0200, Peter Zijlstra wrote:
>> IIRC it's because of 74ffa5a3e685 ("mm: add remap_pfn_range_notrack"),
>> which added a sanity check to make sure expectations were met. It turns
>> out they were not.
>>
>> The bug is not new, the warning is. AFAIK the i915 team is aware, but
>> other than that I've not followed.
> 
> 
> The actual culprit is b12d691ea5e0 ("i915: fix remap_io_sg to verify the
> pgprot"), but otherwise agreed.  Someone the i915 maintainers all seem
> to be on vacation as the previous report did not manage to trigger any
> kind of reply.

I can confirm that reverting that commit restores i915 functionality with
5.13-rc1 on the Braswell machine on which I have been testing this.

Regards,

Hans

