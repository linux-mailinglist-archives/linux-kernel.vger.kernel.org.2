Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B023A78EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFOIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhFOIVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623745143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lUHU/FeufYPOJef4vAaf4rAQWCgf5JOq7XHb8rD0r8U=;
        b=RD8f6/uvRDZ+7TPX12FlVnBqhm90sfafqhr10IRp7UxBxZ4HNb9AALiLVipU+ct1MAvkbn
        W927nGdlBuV1isp4ecye/OcSJUZrsBrNsE1/ADMihWIbIZeCDIYOXXHsOG69IwFu/Yhwan
        5CgYjq8OubpLEb8a9VBfFTk36SACOwg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-JmCvlXrRO7eVq4sG698g6w-1; Tue, 15 Jun 2021 04:19:00 -0400
X-MC-Unique: JmCvlXrRO7eVq4sG698g6w-1
Received: by mail-ej1-f69.google.com with SMTP id b10-20020a170906194ab02903ea7d084cd3so4191551eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 01:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lUHU/FeufYPOJef4vAaf4rAQWCgf5JOq7XHb8rD0r8U=;
        b=t+FN5d5cQ3t4aIrfEoFVURDhoTEO3dlj1NxDNhc+Gt8VWngPLHCpWnm3Co349/H1Uz
         tTo+0fnyxuEoZB8OBDqntGdPlbmn1Oe4JlU2nBelnbGCUv4skgzP+wON7M5ZOfdPU3L3
         1MJIJiR5hIX9hbRdzHhygidSWQdJL2IjdH8UQPGAljaaIY40Iczxr1sdg0mUCt23hHPy
         Y4pCNlL7tWkz6JfsNFjCFQ/Kn+FvtwnX+XLqW+2jlqOCggPmiPw3C1wjsmAq0Tqdl7o6
         Y/En9XP+r2Yz62bvI9YBpFBvHnY6GEVzbPOFWdeOsN3wTWcVHkwQz1RrPyUaYFSWGn6r
         X+/w==
X-Gm-Message-State: AOAM533brdwRo8ZOwVnUMdXkoUbD9ZvainAtw92sBZFDjtiiVTtdiLR1
        El/z8GUNc34CXjyco/Saz3LfX8gacZpmuHbZtgLivEJ9k1m0LU3LHA17/nY/o/ykYHSvUhBREKi
        gnthj9EJe23zYjE+gl4P5KCJH
X-Received: by 2002:a17:906:35db:: with SMTP id p27mr19543455ejb.391.1623745139659;
        Tue, 15 Jun 2021 01:18:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL08lPdhsZYwa0GsII/2uIA5zCZTp4Q+MeQlcbHWnd4zLygHPOy9p6Q1WvQWxzfYUJl8UHkQ==
X-Received: by 2002:a17:906:35db:: with SMTP id p27mr19543442ejb.391.1623745139512;
        Tue, 15 Jun 2021 01:18:59 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id w8sm3342630edc.39.2021.06.15.01.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 01:18:59 -0700 (PDT)
Subject: Re: [PATCH V3 9/9] tracing: Add timerlat tracer
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
 <b650672b9973887ef1420bc1e76b97940b6522d6.1621024265.git.bristot@redhat.com>
 <20210607213639.68aad064@gandalf.local.home>
 <6bc850eb-14c8-6898-847c-d9f0e67d60f8@redhat.com>
 <20210611164855.252f35fb@gandalf.local.home>
 <80f74da1-a9a7-2af9-dd4f-c22f312214df@redhat.com>
 <20210612190948.4fa93611@rorschach.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <81f6e5bb-1c6d-7c8d-cf83-f7e47c53fd88@redhat.com>
Date:   Tue, 15 Jun 2021 10:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210612190948.4fa93611@rorschach.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/21 1:09 AM, Steven Rostedt wrote:
> On Sat, 12 Jun 2021 10:47:16 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> Thinking only about the instrumentation/events, what they are tracking is the
>> execution time. So how about naming them as:
>>
>> exec_time:thread
>> exec_time:irq
> I guess. I should go and look at your other code.
> 

I have the v4 with all (including hotplug) execpt this name change. But as there
are a lot of changes already, I will send it now, and keep thinking about this...

-- Daniel

