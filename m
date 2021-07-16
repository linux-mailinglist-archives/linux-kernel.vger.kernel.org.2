Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DF73CBAA1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhGPQmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49976 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229462AbhGPQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626453549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfFDg9q6aorg0RQSfedZUmEwab8tw9m3yBJRoyB2sWQ=;
        b=h7PPjKdrJgYgIXWo+1RnLqidGV9wpUO0UqhRZz3nXDdbrJ93M0icJ02CGK9Ttt/dsG6rjr
        qlCYLdzPaYoc+cy2wLEIPiwbEoX2izxc/unx1PU/axMx13PZh9jWKMv9d3U7ja/nAT10Nl
        s99gL+wcJyhnepZk1RT1khUo+zXROTs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-4_6b6AXQO02Lfe6E29Ikcw-1; Fri, 16 Jul 2021 12:39:06 -0400
X-MC-Unique: 4_6b6AXQO02Lfe6E29Ikcw-1
Received: by mail-wr1-f69.google.com with SMTP id i12-20020adffc0c0000b0290140ab4d8389so5069668wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bfFDg9q6aorg0RQSfedZUmEwab8tw9m3yBJRoyB2sWQ=;
        b=ZAnQBBqywYxpdo8xkU8yAbUAKrBvK0tAfoTnbIsLFvKQjSuC8riqKNRV8CAVPB1z4X
         cMqrapF5V4g1I93x3iUayDGsYtYm+FsLhDKHBLX9c9UvPpgFIUIZwnQ3oANt9g2i3+Vu
         TDvgEaS3wVW9+zmUGV1Od7dzh/nS0isSLTDrLWiFmxEUs7mAxRSDPzj5+WH8uCuDcVy5
         6pecExvTuwZL8OE9uMbK+f7w8KRRhGnG6jY43+TTC2ASP/wxWmmwpes1n+DWfMbIGpFc
         AGlJqdZFrSPgiQqraaiJ6T8FXtqv+gLnqeL3D0RSvGU9d+b1paKvEC8gMlEA/eAG+cyw
         onhA==
X-Gm-Message-State: AOAM532g7VsTk9prhsY0aESVTUbAMPtVCuqEgvRr5iIWCHJJZg9vf6WV
        aQNJto8HLkKP4FpqDzCkPJgdEiZdvijq6+a7oBiWCmZPXjDWUrggjgdWUxGuHbw85uqgd3jrBzw
        ObptotKTqpoQRBHnK/inr9v/J
X-Received: by 2002:a1c:9d16:: with SMTP id g22mr11555739wme.152.1626453519010;
        Fri, 16 Jul 2021 09:38:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9ueXaD17QbsLneBcu5Hsmm2YlNP9Iq3SyEf3ZOmNOxARnIwKF329PUqOcbOS2aNMk4L2NYg==
X-Received: by 2002:a1c:9d16:: with SMTP id g22mr11555730wme.152.1626453518848;
        Fri, 16 Jul 2021 09:38:38 -0700 (PDT)
Received: from [192.168.1.37] (140.red-81-33-92.dynamicip.rima-tde.net. [81.33.92.140])
        by smtp.gmail.com with ESMTPSA id d67sm11434212wmd.9.2021.07.16.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:38:38 -0700 (PDT)
Message-ID: <95fb6503b1513cff1df54a043d9e3df530ddd63a.camel@redhat.com>
Subject: Re: [PATCH] timers: Fix get_next_timer_interrupt() with no timers
 pending
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     He Zhe <zhe.he@windriver.com>, anna-maria@linutronix.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Date:   Fri, 16 Jul 2021 18:38:37 +0200
In-Reply-To: <20210710005243.GA23956@lothringen>
References: <20200723151641.12236-1-frederic@kernel.org>
         <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
         <20210708153620.GA6716@lothringen>
         <c7a5015a-2b93-17d2-29bc-cd03e40cc09c@windriver.com>
         <20210709084303.GA17239@lothringen>
         <11e85cd8-40ac-09fe-e1fe-0eafa351072c@windriver.com>
         <f520c8b87f56fcda0158853c5127f0488918503e.camel@redhat.com>
         <4409fa71931446d9cabd849431ee0098c9b31292.camel@redhat.com>
         <20210710005243.GA23956@lothringen>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-07-10 at 02:52 +0200, Frederic Weisbecker wrote:
> I guess later we can turn this .timers_pending into
> .timers_count and that would spare us the costly call to
> __next_timer_interrupt() up to the last level after the last
> timer is dequeued.

I've been looking into this. AFAIU there is no limit to the number of timers
one might enqueue, so there is no fool proof way of selecting .timers_count's
size. That said, 'struct timer_list' size is 40 bytes (as per pahole), so in
order to overflow an u32 .timers_count you'd need to allocate ~160GB in 'struct
timer_list' which I think is safe to assume will never happen.

Also, I measured the costy call to __next_timer_interrupt() it's slightly less
than 1us on my test machine. Not a that big in the grand scheme of things, but
it's in the irq exit code path, so I think it's worth the extra complexity in
the timer code.

Any thoughs?

-- 
Nicolás Sáenz

