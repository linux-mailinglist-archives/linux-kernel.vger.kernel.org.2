Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF22367478
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 22:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbhDUU4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 16:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235454AbhDUU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 16:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619038571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLlgzpQfoJCT71FvpVLvkR2QOJhpT2lBE6Z4JwewyNU=;
        b=e/o/mH2sJnxLeGOLXyx3qCcEduX1Qm2cOaI7Eq1H0RcCqame8RGwOTLxBI7DA0euSdOVFG
        tPL1okFM18/w220jJ8pl+U0i21fePCJAPeUCx1t0U+my88X+fC8QQeag8MJSs3WYS+aeyW
        y+2dx63S3X3oHXEVFW8hmlLrQ9zBazc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-ElGX7O9OMZKMw-WKaKCQpA-1; Wed, 21 Apr 2021 16:56:09 -0400
X-MC-Unique: ElGX7O9OMZKMw-WKaKCQpA-1
Received: by mail-wr1-f71.google.com with SMTP id 91-20020adf92e40000b029010470a9ebc4so12075022wrn.14
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 13:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mLlgzpQfoJCT71FvpVLvkR2QOJhpT2lBE6Z4JwewyNU=;
        b=dioKK/WynLKJSjBDCJQs8mecq4XduS4JaqDsl6glLHiTPJwrO8+2zUJUB3eyxk1CJ3
         WkPAabvTlI/UTEBfUjMCZM6njCep+Snmiy7NGDcjKC8q0+9w+PbpioDLqJa5Obi7pbI5
         J7wuVZS3MsDHpzhreLdSQ2CghtMhbRyxu/1FSKDXVbq6esh3E2gS2X1I6lTJg4dZkAjr
         uzIx5sGRXF01O9fTWyasloV8zPT4AgV+mFZ9RoMPM2FSGu5CmfxvCVF94uCwcM1T9Hd+
         GP6JLsGR39aj/LEtR/09DqneczbXC5sUtFq0CGp9KlbUhe6aV/OlOkUL4PwFfOZRFEiy
         3QEQ==
X-Gm-Message-State: AOAM533K7R4ycc4JFfmfyWtfWrqakuAYFqBzU4jc/09OKXPg9NXWaPvr
        K37+zexzWzWRfCqkzGUTRYfEoSf540jUpDI1omHP3TuPsUS5FlORSJY2ybUY1LWVOK5wa4twRrl
        l5gb2DXD8AuGsmnnuei1a+EsI
X-Received: by 2002:a1c:a746:: with SMTP id q67mr11645562wme.22.1619038568064;
        Wed, 21 Apr 2021 13:56:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyAkMIsdPwBFrOs8dqR12pB+jB+9nIPAFo91LjQiaTCWUoiuM0bx8GTcXqhSrcq5U0A4EeYg==
X-Received: by 2002:a1c:a746:: with SMTP id q67mr11645539wme.22.1619038567860;
        Wed, 21 Apr 2021 13:56:07 -0700 (PDT)
Received: from [192.168.3.132] (p4ff237c9.dip0.t-ipconnect.de. [79.242.55.201])
        by smtp.gmail.com with ESMTPSA id y145sm2910099wmc.24.2021.04.21.13.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 13:56:07 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] perf/binfmt/mm: remove in-tree usage of
 MAP_EXECUTABLE
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.tang@intel.com>,
        Don Zickus <dzickus@redhat.com>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20210421093453.6904-1-david@redhat.com>
 <m1eef3qx2i.fsf@fess.ebiederm.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <866b3f40-9416-0246-cf0a-6f46e9abd9bf@redhat.com>
Date:   Wed, 21 Apr 2021 22:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <m1eef3qx2i.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.21 21:03, Eric W. Biederman wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> Stumbling over the history of MAP_EXECUTABLE, I noticed that we still
>> have some in-tree users that we can get rid of.
>>
>> A good fit for the whole series could be Andrew's tree.
> 
> In general this looks like a good cleanup.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> As far as I can see we can go after MAP_DENYWRITE the same way.
> Today deny_write_access in open_exec is what causes -ETXTBSY
> when attempting to write to file that is current executing.
> 
> Do you have any plans to look at that?

I did have a look and thought about ripping out MAP_DENYWRITE; I'm still 
in the process of connecting the pieces.

Some VM_DENYWRITE e.g., in mm/khugepaged.c still gives me a headache , 
and I'll have to double-check whether it would be okay to just fallback 
on checking the actual vm->file.

-- 
Thanks,

David / dhildenb

