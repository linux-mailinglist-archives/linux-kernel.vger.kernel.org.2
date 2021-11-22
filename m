Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808774594B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 19:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhKVSan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 13:30:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhKVSal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 13:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637605654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDRcJmmTQIcR4UulcHG6TvvXnMtpK6oUXm2NkwCOl2c=;
        b=AcmnVNZoaHz/xqx8x+bX1rkDH1JTcjL2sNweAB4U1ljvu9m2WNczFmPWZawwmNYmHi9+Jk
        vfPoMVL6eh1232OfcKuUpEfAQiFcR8pFyMiCz+clSNjAO2eHyf8qJ7WAXWf8lgwZBC/7s5
        giYz5ZKi6j8oEoxxakRoxQax97tUCCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-96T9D6tIPbCxFCdHkAWHUQ-1; Mon, 22 Nov 2021 13:27:29 -0500
X-MC-Unique: 96T9D6tIPbCxFCdHkAWHUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A8A819253C9;
        Mon, 22 Nov 2021 18:27:27 +0000 (UTC)
Received: from [10.22.34.132] (unknown [10.22.34.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B28A1981F;
        Mon, 22 Nov 2021 18:27:26 +0000 (UTC)
Message-ID: <e0a41ba0-59d6-d320-02b0-37534f9e66a5@redhat.com>
Date:   Mon, 22 Nov 2021 13:27:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 3/4] clocksource: Dynamically increase
 watchdog_max_skew
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20211118191439.1000012-1-longman@redhat.com>
 <20211118191439.1000012-4-longman@redhat.com>
 <20211122050224.GH34844@shbuild999.sh.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211122050224.GH34844@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/21 00:02, Feng Tang wrote:
> On Thu, Nov 18, 2021 at 02:14:38PM -0500, Waiman Long wrote:
>> It is possible that a long-lasting intensive workload running on
>> a system may cause the clock skew test to be skipped for extended
>> period of time. One way to avoid this is to dynamically increase the
>> watchdog_max_skew used in the clock skew test.
>>
>> However, we also don't want watchdog_max_skew to be continuously increased
>> without bound. So we limit the increase up to 10*WATCHDOG_MAX_SKEW. If
>> that happens, there is something wrong the current watchdog and we are
>> going to mark it as unstable and select a new watchdog, if possible.
>   
> For reselecting watchdog, in these cases, I think it's the extreme system
> stress causing the MMIO read of hpet to be slow (plus some lock), fallback
> to other watchdog whose read is MMIO or ioport may not help much. I tried
> this patch, and when "acpi_pm" timer is used instead of "hpet", similar
> thing can still happen.

Yes, I am aware of that. Switching to acpi_pm, did not reduce the 
consecutive read delay. However, the current limit for this watchdog 
fallback is when the delay exceed 5*WATCHDOG_MAX_SKEW. With a default of 
100us, that mean 500us which is a really large delay that maybe there is 
something wrong with the hpet timer. Of course, the selection of this 
limit is kind of arbitrary. If you have concern about that, we can leave 
this patch out.

Cheers,
Longman

