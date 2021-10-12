Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE942A6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhJLOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236953AbhJLOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634048015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzTrRfXXNk8+PLvonfcHlML3JOVXOT6Q8/EMkco8wbY=;
        b=cBByThrrnAx8WOGUenhiJhoN74tVjE692iUz0mOnoXDuciyMQ9ofIh8I5LIHd6NP4rHVUk
        SpjqukgZnU61OJw200pSmQAVyAtAlJQtbPnXZaYORIAzQxucmBjPenoE/Zus0r8Uz0ik4M
        4s6haU2bFhvCtdDFmUJiap779dkhjPw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-HV-7YYE1M925D2QiQjtaaw-1; Tue, 12 Oct 2021 10:13:33 -0400
X-MC-Unique: HV-7YYE1M925D2QiQjtaaw-1
Received: by mail-wr1-f69.google.com with SMTP id h11-20020adfa4cb000000b00160c791a550so15655578wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BzTrRfXXNk8+PLvonfcHlML3JOVXOT6Q8/EMkco8wbY=;
        b=Zav7gTDh4ZaghDFHWVbkTirAvpMwqolJaHAMHjEY4iguvDmqAj0wFM5Hw8AEFgdq1V
         +wDsU/R0gFzFLbrMJn4s9JjETORS66YpkFOVRiIWz+BGuLficNqvR82u61F/SqxGjdn+
         ruLg4jrKY6Fcci3UvUEZ/5QCP6fGCTbNlDZzPT24AJ+kPEeovDG6k4IyuLSni+EpM4tY
         vXKPa/+cijlqDqZ6NhzHCnecIAs9VQXhSLFZ0zWxo5W3s3L4LJ62lVjBiGsHYfL1schV
         45lHx8hk7jwds3Vhp+AN2JUQ29IJe6Kv+gPzFaZqdyPs9xmEBg/4GkSmM8baSk+AU7Mw
         C6tg==
X-Gm-Message-State: AOAM533hBbQmGAUz9LgZYdEyIlInEBFkYS7kTV7EN0zOvlIqT3i8YMpT
        5EXSb4a4hNSLnDQoJGoJwB0FcAuePGS8rvpPCorX87tskgsdYLF1M+LsDVUi8GvIdfMod1BG7Mt
        pvJuJPsCf2X4f/6hP3Eee1cff
X-Received: by 2002:adf:9b97:: with SMTP id d23mr31775892wrc.53.1634048012782;
        Tue, 12 Oct 2021 07:13:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDOcPDg93RfEOergksAHpsDa13Q8GcPCVdb5DKzHu8nWEQyeen+YOwraUjsQmj973pkAC+qw==
X-Received: by 2002:adf:9b97:: with SMTP id d23mr31775866wrc.53.1634048012603;
        Tue, 12 Oct 2021 07:13:32 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6a12.dip0.t-ipconnect.de. [91.12.106.18])
        by smtp.gmail.com with ESMTPSA id b19sm2797722wmb.1.2021.10.12.07.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 07:13:31 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] mm: use pidfd_get_task()
To:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Minchan Kim <minchan@kernel.org>
References: <20211011133245.1703103-1-brauner@kernel.org>
 <20211011133245.1703103-3-brauner@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b91f642b-2b64-a60c-89e2-0317164c7b70@redhat.com>
Date:   Tue, 12 Oct 2021 16:13:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211011133245.1703103-3-brauner@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.21 15:32, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Instead of duplicating the same code in two places use the newly added
> pidfd_get_task() helper. This fixes an (unimportant for now) bug where
> PIDTYPE_PID is used whereas PIDTYPE_TGID should have been used.

What would have been the effect of the BUG? Is it worth Fixes: or better 
even separating out the fix?

> 
> Link: https://lore.kernel.org/r/20211004125050.1153693-3-christian.brauner@ubuntu.com
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Matthew Bobrowski <repnop@google.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Matthew Bobrowski <repnop@google.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> unchanged

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

