Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327CF3A13FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhFIMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235239AbhFIMQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623240863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77QSgyc+8Sk7HYHiam0rcRrsIJ/0Q1AlHtkTPqxgLeg=;
        b=bSIvSOkFQQ7PtsrX3Gf3TxNZqT9oPtSlH0Yj6O+PiJunau0JHpJvsYX/aohW8JUsL1MrsJ
        dmDhyiXlGHt3DPiAOYWqRQitJ5y+Ry+K/dbu2GyD/QWYtYYqxLLTbesiJQU021wWXg84fc
        TtVgH5vynchPGCoaDpL6NVkV0noO7FA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-FMqXuvopPRi4ewhoR1J_mA-1; Wed, 09 Jun 2021 08:14:20 -0400
X-MC-Unique: FMqXuvopPRi4ewhoR1J_mA-1
Received: by mail-ed1-f72.google.com with SMTP id v8-20020a0564023488b0290393873961f6so4900473edc.17
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 05:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=77QSgyc+8Sk7HYHiam0rcRrsIJ/0Q1AlHtkTPqxgLeg=;
        b=L2yu92Fu9RLlu2zd754eNhVhvpxKGrH+mvdBGaAhfoR6WjQVunmEtNU8TDfwoKkWW/
         ShrzhPef3uuCRLh3PO2zIsW5iVgMPaUzpbvFL/Bz77BV8sOQOWSRGgG2nFXQiCsMM1/N
         bLT9HACu9i30BVT+EaZXbeppEHdg4TWggVgtdeUF0sVI928uk9VYkRTyzlqzUmzIl62j
         198W72C71l2yQzm1hfyduAMSNEYq/xKUEbs3NL/yEt3+iDLDZx3mEOV9WSIXwEQBO01w
         uUcWsXx2JhbtfNpeQw+TQ3GhSeHSIDuX/dxYy9wXwhladwAA09vO/KEIE9JmYaZ32Y2/
         TPqg==
X-Gm-Message-State: AOAM530GUhUQyEteV9U7Ez4wsF4Niw79pS6OwqjWNAsS6R28PGgIO0/Y
        w9GCxH2DjO1RcBEVsXEApTdM1DvS1Ez77YyzShl0eMWShcqNiSaXvqNvlP8WjhQhQxtJ2vwELpL
        b85eYVfNM4T4vGr1TCr/N+7Vg
X-Received: by 2002:a05:6402:3082:: with SMTP id de2mr17956651edb.214.1623240859104;
        Wed, 09 Jun 2021 05:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgQ3/5uZSB81cgZ2oYq3QcOkGNys6k5P1fZOknM8dVYLnNp0EXgn9LjvtdDU4a96tdwdbEbw==
X-Received: by 2002:a05:6402:3082:: with SMTP id de2mr17956632edb.214.1623240858901;
        Wed, 09 Jun 2021 05:14:18 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id gv11sm1054485ejb.13.2021.06.09.05.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 05:14:18 -0700 (PDT)
Subject: Re: [PATCH V3 8/9] tracing: Add osnoise tracer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1621024265.git.bristot@redhat.com>
 <bd09a2be9cd0cecee86374dbb49235dd2ef9d750.1621024265.git.bristot@redhat.com>
 <20210604172803.527aa070@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <06d72b7d-4beb-1dff-b537-e7449abf3d4e@redhat.com>
Date:   Wed, 9 Jun 2021 14:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604172803.527aa070@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 11:28 PM, Steven Rostedt wrote:
>> +#ifdef CONFIG_X86_LOCAL_APIC
> I wonder if we should move this into a separate file, making the
> __trace_irq_entry() a more name space safe name and have it call that.
> I have a bit of a distaste for arch specific code in a generic file.
> 

I am placing the intel specific file in:

arch/x86/kernel/trace_osnoise.c

and the kernel/trace/trace_osnoise.h looks like this:

#ifdef CONFIG_X86_LOCAL_APIC
int osnoise_arch_register(void);
int osnoise_arch_unregister(void);
#else /* CONFIG_X86_LOCAL_APIC */
#define osnoise_arch_register() do {} while (0)
#define osnoise_arch_unregister() do {} while (0)
#endif /* CONFIG_X86_LOCAL_APIC */

This can be used by other archs as well...

sound reasonable?

-- Daniel


>> +/**
>> + * trace_intel_irq_entry - record intel specific IRQ entry
>> + */
>> +void trace_intel_irq_entry(void *data, int vector)
>> +{
>> +	__trace_irq_entry(vector);
>> +}
>> +


