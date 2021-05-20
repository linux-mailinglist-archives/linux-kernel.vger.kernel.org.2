Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2504389E63
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhETG4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbhETG4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621493683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tEv83ZtFMHbXTaEtn+9i7YCHaEzdnQPBIaLpxqVr78=;
        b=aNwwmVaOOt0LMpB+kdAX+Vl4pm7ZsABBOLww3gCG7isUZy60nqG+/YGU80k//OJ6Lm6mCp
        80OkdJAzCNBLKfhSQtwmUsGF0NEEmVb0peY5aqQT6dOSLhkgoeqsu+yYHHpy1GaFIzpgI2
        govukGnE4GKe/7rm3Axo+pFln26+Mlk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-vKAB4UWmN6C0olnK9bgCSg-1; Thu, 20 May 2021 02:54:42 -0400
X-MC-Unique: vKAB4UWmN6C0olnK9bgCSg-1
Received: by mail-ej1-f70.google.com with SMTP id la2-20020a170906ad82b02903d4bcc8de3bso4578300ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9tEv83ZtFMHbXTaEtn+9i7YCHaEzdnQPBIaLpxqVr78=;
        b=rcF4n8tm6L2JLhryLrt+OZaCq94YbF1uTjqydWkYR3Zdr3DKW1rKW27WG9UDAX3xuQ
         gxnwbSI/Jye7rOIq1lKTPkLJ4SrFEhmROW4r2DXveYF/UGuAlewXZXyc2DfskH9WCglL
         dPiQAMpwnTVAyB7IB/bdOQ6ZKUqDe3ULt7b2cweIChe8lqB6S0JCxoc0hpvmII7mLGo6
         7W0+8Nwgj43hdnPgyAwQvaBEkvvCIXT3TngrrrYFgHP7OvWgKASh8sDIkUaFaLjXnb4v
         2thLn+Ke3VpRym/b0Xb5XW3OmUxfzjHXFs3pG22zW3VAmhU6fNPyf3FhUdSohe4/BEd4
         htjQ==
X-Gm-Message-State: AOAM530Ck85HO/Xwgpg5mKR/5QwqFUMT4SXirzedPJLK1+O/MfL0DtKD
        8qto9zhKkTv+bQzd6k8uYjkLGYdRgId3YzrbrFEh4UM90n72Fvjn6iQe4H7Sxf/KViFM/ceCWO+
        RH80t/B7PPuAbiWI+K1RLjzt0
X-Received: by 2002:a17:906:fa93:: with SMTP id lt19mr3200253ejb.14.1621493681154;
        Wed, 19 May 2021 23:54:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf06tuHryELST2SZKhY8gB1gHwWH7k04TmUp1Y+F+oS5yedzBZh3TNtH22ORIqKZW/RO+wHQ==
X-Received: by 2002:a17:906:fa93:: with SMTP id lt19mr3200227ejb.14.1621493680938;
        Wed, 19 May 2021 23:54:40 -0700 (PDT)
Received: from x1.bristot.me (host-87-19-51-73.retail.telecomitalia.it. [87.19.51.73])
        by smtp.gmail.com with ESMTPSA id hz10sm909238ejc.40.2021.05.19.23.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 23:54:40 -0700 (PDT)
Subject: Re: [RFC PATCH 01/16] rv: Add Runtime Verification (RV) interface
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1621414942.git.bristot@redhat.com>
 <ad69b06e9e3a5ec9ad2a49d290b719a96dcc471e.1621414942.git.bristot@redhat.com>
 <90c917eb-f0a8-3ef5-b63d-d88c1f6919a1@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <f834d8e7-1027-9573-63ff-eedc49884b78@redhat.com>
Date:   Thu, 20 May 2021 08:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <90c917eb-f0a8-3ef5-b63d-d88c1f6919a1@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 8:10 PM, Randy Dunlap wrote:
> On 5/19/21 4:36 AM, Daniel Bristot de Oliveira wrote:
>> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
>> new file mode 100644
>> index 000000000000..e8e65cfc7959
>> --- /dev/null
>> +++ b/kernel/trace/rv/Kconfig
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +menuconfig RV
>> +	bool "Runtime Verification"
>> +	depends on TRACING
>> +	default y if DEBUG_KERNEL
> 
> No need for default y. There are other reasons to use DEBUG_KERNEL
> without wanting RV turned on.

yes, you are right, I will remove it.

>> +	help
>> +	  Enable the kernel runtime verification infrastructure. RV is a
>> +	  lightweight (yet rigorous) method that complements classical
>> +	  exhaustive verification techniques (such as model checking and
>> +	  theorem proving). RV works by analyzing the trace of the system's
>> +	  actual execution, comparing it against a formal specification of
>> +	  the system behavior.
> 
> And in the cover/patch 00:
> tlrd:
> should be
> tl;dr:
> or at least
> tldr:
> :)

Ack!

Thanks!
-- Daniel

