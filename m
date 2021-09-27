Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91909419186
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhI0Jbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233587AbhI0Jbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632735002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWU6LItq51baPXVuLDc5jK1prHfIfkcvrhdiTiZxj7o=;
        b=P5AAElLOkr0l5OCmYo9PNeAizRa8p0YkXjZ+WnLcsSFKzwExQUH2TtTobYbsa7tJfNW+05
        X1QanW23AJnvnJwJs70WuSTqAv7tCqDJXN+11KntnKYDVJcoWv40IWdcQC+rZNhDFO9X7F
        v3pUsQnNyi1UPtfh2c9CnxDFgLfBWDw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-kw0kEm4kPJGailDJ1ygnjA-1; Mon, 27 Sep 2021 05:30:01 -0400
X-MC-Unique: kw0kEm4kPJGailDJ1ygnjA-1
Received: by mail-wr1-f72.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so13790025wrg.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XWU6LItq51baPXVuLDc5jK1prHfIfkcvrhdiTiZxj7o=;
        b=RJtcCMlDyAn3CBL2OOySOgDLPivFxa/hZg2LPfKKSpJTI8ASn8Pgrq0XU/6o6IdOIU
         GssVyLMAwOMjJBQkDFhbFkZcJXfmf/o6/T8YIic18YGItWWuTm4tJraqfX77Rb1H5urp
         0t2I84f/KVc0VIF/AWI6dXbiq4ldMcpdbEMx8faHhwugh0uIRq6aS8k8dDR2tpS/JCvt
         taLLWC5tkt8Og1nWrkJr/nxNWLLLeeptRDmpQAFHXxmlGTHq6CezJ5CnayfgEvp6cdLZ
         Oi5pTyBAzC/7+//68ubl5uSdYt6tLExXHubPdGR4YZzu0g23VNU4qwuDrCm2AnXwvpi7
         OIEQ==
X-Gm-Message-State: AOAM532TzAgVG2rGR3j7xmH7WwTMd/EQPh3Wh8M73CC9HKnNOBb+e3/h
        tL101HyN70Ctt8TaTIJgUqosy1eAr01eEvfnLZ2RP7fZDYakq+5I3MJjZ5v6PkfxssKXLYSeV6c
        svLSP5Qd+JHb0Lcmpg3WK6dml
X-Received: by 2002:a1c:770d:: with SMTP id t13mr14635415wmi.77.1632735000384;
        Mon, 27 Sep 2021 02:30:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX3uZ2loauTr5/1uotPAb+EY7Am8KFfali0Ndl/Pc4T0QwvgN0lkMZnZhhs/tOsWnMJO0fvA==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr14635402wmi.77.1632735000231;
        Mon, 27 Sep 2021 02:30:00 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id k26sm12161337wms.39.2021.09.27.02.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 02:29:59 -0700 (PDT)
Subject: Re: [RFC PATCH] userfaultfd: support control over mm of remote PIDs
To:     Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>
References: <20210926170637.245699-1-namit@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <83827672-0996-4c25-9991-697ad443b6b3@redhat.com>
Date:   Mon, 27 Sep 2021 11:29:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210926170637.245699-1-namit@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.09.21 19:06, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Non-cooperative mode is useful but only for forked processes.
> Userfaultfd can be useful to monitor, debug and manage memory of remote
> processes.
> 
> To support this mode, add a new flag, UFFD_REMOTE_PID, and an optional
> second argument to the userfaultfd syscall. When the flag is set, the
> second argument is assumed to be the PID of the process that is to be
> monitored. Otherwise the flag is ignored.
> 
> The syscall enforces that the caller has CAP_SYS_PTRACE to prevent
> misuse of this feature.

What supposed to happen if the target process intents to use uffd itself?

-- 
Thanks,

David / dhildenb

