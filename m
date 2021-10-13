Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF542C952
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJMTHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234649AbhJMTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634151940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Eiv40w3h1hcVei6B4W9Y1LVqxQiJmLHN86qfNssdwM=;
        b=fBk95QVvTKSn7D8NZUtoxSN2r5cmkBzbM9mgw1TM+E3wPKvLNEreSnfEvNSYq55gaEhJv1
        pNpaJS4bkBFoD09Zj+QyQ2JARVgX6h8TNmroZKPzqG01np2yili1axD6TxGzuGLfcaIT3o
        r9OebhEF+HcxJeQ8V17nNIEALAOR5T4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-sCSz0iVYO6WRaTK6KClOqQ-1; Wed, 13 Oct 2021 15:05:36 -0400
X-MC-Unique: sCSz0iVYO6WRaTK6KClOqQ-1
Received: by mail-ed1-f72.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so98792edj.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Eiv40w3h1hcVei6B4W9Y1LVqxQiJmLHN86qfNssdwM=;
        b=g8FBT81q5gkOAwZu4p2QJXoHVi50cn04xxs1jwhNBOxhzktRdNLRdCnNwK03whCKmL
         vdoV5arXaDBGwU4FiQI+D5UVx3MLdPbH5XePiP2z5IYwkWCXeyS0dQS511aHUuSMsbS0
         YT1ItGHQx6pqy84lwDpEeyqSFSDdhCqSI+i7mwKj9RZ+zafpB7YWAww2NHObuSKKcxyL
         vrAkjYrNDdFLrN61wPOX/QcMCGkopkynBHkw8HYtSWcE7TaG8beRRZvqBbL0kvDXNAKB
         V85QWY7MD5VnKuuZbpchOS8rq8bPkArEs+s1SH09iBvxV0kBQt7gEIHETOwAl/AYgB+T
         6Npw==
X-Gm-Message-State: AOAM5312V49xAY9PfAxRlVuJc5c/9yBgFOMfHldR1TqZ34rg8xrpJLL3
        yI6CZXtzLKVxwIL+jHWaBZeoOV/VrpAmv9VVB9aUqRtz8AKzGSYFvc1tdPgf0MkURaLmqyI+Yf2
        ZIkCTsZ+yc3OZqbTLoTud31Qw
X-Received: by 2002:a50:bf02:: with SMTP id f2mr1749035edk.226.1634151935667;
        Wed, 13 Oct 2021 12:05:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmcKV0CYPqwd/mDtR926wvJB++ZYNsP6Vx3CrliwDx64dKP6XU/wrZXnneZ49I7EzdutDhVQ==
X-Received: by 2002:a50:bf02:: with SMTP id f2mr1748397edk.226.1634151931214;
        Wed, 13 Oct 2021 12:05:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r22sm278778ejd.109.2021.10.13.12.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 12:05:30 -0700 (PDT)
Message-ID: <f430d53f-59cf-a658-a207-1f04adb32c56@redhat.com>
Date:   Wed, 13 Oct 2021 21:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: kvm crash in 5.14.1?
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Stephen <stephenackerman16@gmail.com>
Cc:     djwong@kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, seanjc@google.com, rppt@kernel.org,
        James.Bottomley@hansenpartnership.com, akpm@linux-foundation.org,
        david@redhat.com, hagen@jauu.net
References: <85e40141-3c17-1dff-1ed0-b016c5d778b6@gmail.com>
 <2cd8af17-8631-44b5-8580-371527beeb38@gmail.com>
 <YWcs3XRLdrvyRz31@eldamar.lan>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YWcs3XRLdrvyRz31@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/21 21:00, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Sat, Oct 09, 2021 at 12:00:39PM -0700, Stephen wrote:
>>> I'll try to report back if I see a crash; or in roughly a week if the
>> system seems to have stabilized.
>>
>> Just wanted to provide a follow-up here and say that I've run on both
>> v5.14.8 and v5.14.9 with this patch and everything seems to be good; no
>> further crashes or problems.
> 
> In Debian we got a report as well related to this issue (cf.
> https://bugs.debian.org/996175). Do you know did the patch felt
> through the cracks?

Yeah, it's not a KVM patch so the mm maintainers didn't see it.  I'll 
handle it tomorrow.

Paolo

