Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D61E341910
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhCSKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhCSKAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616148003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z9NHyRhgulIGjTxavfwdbehfo97XHhlZ7b5ibqnnTSQ=;
        b=Jd3sev0FhwE2QcTNnrQTDj5Svcaznv0Q9CNhNdU6NM/wGIJFsoM0rwom54nXMpiEXvKDFR
        IGrdaBg5wjac9J/cDS3Ru0OX5WZLZqdbJgI3hzEffnyBwvIhs1D07GxwSmpC5Zbrdwh6NC
        j1lL4DcWRETRPD53oWjojNXTHYYPAxU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-eb30eu5FN9ycwMvnhqym0Q-1; Fri, 19 Mar 2021 06:00:01 -0400
X-MC-Unique: eb30eu5FN9ycwMvnhqym0Q-1
Received: by mail-ej1-f70.google.com with SMTP id bg7so12031730ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=z9NHyRhgulIGjTxavfwdbehfo97XHhlZ7b5ibqnnTSQ=;
        b=M98ycaV8UMpj9cCkkAax5Gu0xjzIVJQ9cMIvQ3FEDYkGkM7dmxzVxme6L1o1e+bTZr
         e0SaiwewuiUSFdPNoqcTw9AqNlpt9qdtu3GjVuqG6dWBEu5oL9dYjPM89eDKrT7Mt/fM
         q1xH6Q1158sNpk7R6OyrH/FtkAWcBcaK1lM2SwUI1d16p4LDA16hVVqG/6ixU+YeJ3/t
         BoVy3rYn5CEMiRpdxeiT+LHrwqqghxl7ate1K211pTm4dD80imAe2Kge546YQpTBFunp
         zubaSIfFgljwm9AHQcpXPQLOknM8mBCIia7yGbKZaPqXb5d+xPqJQI58nHIHC3fp3mUQ
         2aAg==
X-Gm-Message-State: AOAM532uuzsV3L7up3wXk+gcZNS53Et5Gg+KbpugEZmyDmq2fibfLv+c
        11QO5N8s9YDkYvwnXkqQ6ar2dcRNsiM9++kbUzRVox/QSfnVVxah/H97HVI6Ezi86pKTgP6dzA7
        JiZTFh1CUEq4Eimi/ZrnJaxy5JF636Qke33W+XEDrRZpL0plEXfMbSreunX/brs4TOTXBOX1gqu
        Jc
X-Received: by 2002:aa7:d74d:: with SMTP id a13mr8820209eds.199.1616148000279;
        Fri, 19 Mar 2021 03:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAS/HdGn0Yh/Ft6QREhR0IjIVyXmQNGEJPV3Su1xB99AwmryiuvsT2fN6xEuLrsbdvyWCFdQ==
X-Received: by 2002:aa7:d74d:: with SMTP id a13mr8820191eds.199.1616148000020;
        Fri, 19 Mar 2021 03:00:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id t12sm3912558edy.56.2021.03.19.02.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 02:59:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] genirq/matrix: WARN_ON_ONCE() when
 cm->allocated/m->total_allocated go negative
In-Reply-To: <87mtv06z13.fsf@nanos.tec.linutronix.de>
References: <20210219113101.967508-1-vkuznets@redhat.com>
 <20210219113101.967508-3-vkuznets@redhat.com>
 <87eegdy0qh.fsf@nanos.tec.linutronix.de>
 <87eegc7v0g.fsf@vitty.brq.redhat.com>
 <87mtv06z13.fsf@nanos.tec.linutronix.de>
Date:   Fri, 19 Mar 2021 10:59:58 +0100
Message-ID: <87k0q3zco1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Thu, Mar 18 2021 at 08:58, Vitaly Kuznetsov wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>> There is a way more useful way to handle this. In such a case the bit is
>>> NOT set in the alloc map. So:
>>>
>>>     if (!WARN_ON_ONCE(test_and_clear_bit(bit, cm->alloc_map)))
>>>     	   return;
>>>
>>> would have caught the problem at hand nicely and let the machine survive
>>> while just throwing warns and continuing is broken to begin with.
>>
>> Thanks, I like the idea. I didn't do that probably because the problem
>> which triggered me to write these patches wasn't fatal, it was just
>> causing CPU0 offlining to fail.
>
> Can you whip up a patch for that?
>

Sure, will do!

-- 
Vitaly

