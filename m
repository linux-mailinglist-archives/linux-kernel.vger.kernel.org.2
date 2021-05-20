Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9584F389E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhETHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229978AbhETHBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621493996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tTt0yqJ9Uuqn/Hl6Y9lCb2xD8OagO3z0wq6RCCJxaE8=;
        b=TsCTQQ8of+UmG3j0w0qaVw5Z+EcrvN2jSmNzSdROepqS7ivlnt/pjwvVkV6SygYbVb6Lbv
        rcDM9C/9SMOyMm0K7HH4ayyOdfMgd99mPjDT4aNV5JSnWR16z1uko+QO3q9KQ14tb+bWA2
        g19uZqdXp7G7mcgQRXvent+7qixvvac=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-sJe7w-hyMbClIZCylrI_Wg-1; Thu, 20 May 2021 02:59:54 -0400
X-MC-Unique: sJe7w-hyMbClIZCylrI_Wg-1
Received: by mail-ej1-f69.google.com with SMTP id p25-20020a1709061419b0290378364a6464so4570816ejc.15
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tTt0yqJ9Uuqn/Hl6Y9lCb2xD8OagO3z0wq6RCCJxaE8=;
        b=m/rnyvYIGwmxtiLayrzGooGQ7ksspsedmwDj+nx0hnD9LhwPM2lUm6+XNMafXvScSW
         8QTNLZB4/1yLIy1DO4Fq7+xi75/l8vPXP+Wd+IeUG9EKGmo0TLOpnNHNEmM1ln+3DoSC
         rVSwOxQZz9M2tjcgRnAU70CXQSb1BINc4YXeKgrwQducocZ/FVKdMPqa/3Cq4sffY3jV
         /R4vGaKUQsV0DMxXJt0rhIgfdmQOADkw3Rz9ihoXLFYZ6MAw9bz6Ac7Tso6CJswy5QRW
         vEUm82RSsGPJsTkbwD29jRpHR4iSgifEPYW1hH1HEFYTcacsMtE+bzkUcZUhCrdxtt4q
         jl0g==
X-Gm-Message-State: AOAM5322V5S+FPxkdWwtv5A2C/bvxTGF6X4PKG7klATxLy2g8YM7+D9q
        Owylt9LRB+lNNJgBZXQv61DKHWN5elnreck+MQER7fOgW3hsoCJQhxg7Kzmf2GFiA7pUSFoCqoE
        q7eJlLXsaZtB0whah8vjRHvXH
X-Received: by 2002:a17:906:8049:: with SMTP id x9mr3257622ejw.13.1621493993376;
        Wed, 19 May 2021 23:59:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSmeoy86tL2ypRryKosg1cECWYyRfXifspBYC5kwT1/oAUUEdCisRAIm4266Z3PKhVhAG7hQ==
X-Received: by 2002:a17:906:8049:: with SMTP id x9mr3257608ejw.13.1621493993253;
        Wed, 19 May 2021 23:59:53 -0700 (PDT)
Received: from x1.bristot.me (host-87-19-51-73.retail.telecomitalia.it. [87.19.51.73])
        by smtp.gmail.com with ESMTPSA id c22sm994014edy.59.2021.05.19.23.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 23:59:52 -0700 (PDT)
Subject: Re: [RFC PATCH 11/16] rv/monitors: wwnr instrumentation and
 Makefile/Kconfig entries
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
 <879c2e3f03baefcda72e5923d9a16f340edeccca.1621414942.git.bristot@redhat.com>
 <6bbb99e6-e940-0bd1-70e4-f96f8bdd5e17@infradead.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <0d295099-94db-c294-df84-0bd94a3c00bc@redhat.com>
Date:   Thu, 20 May 2021 08:59:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6bbb99e6-e940-0bd1-70e4-f96f8bdd5e17@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 8:16 PM, Randy Dunlap wrote:
> On 5/19/21 4:36 AM, Daniel Bristot de Oliveira wrote:
>> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
>> index 4a1088c5ba68..612b36b97663 100644
>> --- a/kernel/trace/rv/Kconfig
>> +++ b/kernel/trace/rv/Kconfig
>> @@ -21,6 +21,13 @@ config RV_MON_WIP
>>  	  Enable WIP sample monitor, this is a sample monitor that
>>  	  illustrates the usage of per-cpu monitors.
>>  
>> +config RV_MON_WWNR
>> +	tristate "WWNR monitor"
>> +	help
>> +	  Enable WWNR sample monitor, this is a sample monitor that
> 
> 	                     monitor. This is
> 
>> +	  illustrates the usage of per-task monitor. The model is
>> +	  broken on purpose: it serves to test reactors.
> 
> and please tell the user what WWNR means, either in the prompt
> or in the help text.
> 

yeah, I will do so.

(WWNR stands for "Wakeup while not running")

Thanks!
-- Daniel

