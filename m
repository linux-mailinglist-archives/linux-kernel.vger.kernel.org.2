Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11C039BD40
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFDQf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230271AbhFDQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622824448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kIUlKsEkB8hDD6ar4W2K+QutlaqaTEGtyyTDuNX2ow=;
        b=fCF3NkxwYjEnpf6EzX1G2DLOE4smtm8+mrS93dnZ33W0fuE83LoA8pgREFKUDpZaeMyu61
        KYHcjK63YrMHfuwXJDX2sWUGEveYPwMJw1xTPMDkwRtAHivnMlPbx6px0A8QFEiQ4gDYsS
        bhfhAfUTRi2NvYG3dcdHGHn38xujGRo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-603-f9DS73XoMEGuIiThkU1jcQ-1; Fri, 04 Jun 2021 12:34:05 -0400
X-MC-Unique: f9DS73XoMEGuIiThkU1jcQ-1
Received: by mail-ed1-f72.google.com with SMTP id h18-20020a05640250d2b029038cc3938914so5249212edb.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8kIUlKsEkB8hDD6ar4W2K+QutlaqaTEGtyyTDuNX2ow=;
        b=cShbrU4lwoFV/b6/w4jytKwX4roBrZnn4L9HIRr6FGsauABoNlfrhHYU03AHNPGlFN
         jZSGsBmWhkMo8lJZKqMuoHT+sQwmzjP96CqmJQLZIs210NcEPpdFKJeRkx+GsdtOyeL9
         nMjbe4tSIYb7K+Uh0vtkPzOX70NxwXDZvV2+xbQ54aosu/TTUGGG2em1nuWII5N6EOLe
         jwgcaSQ7snqQGYWUAClKoVpCggVoCz8hq21nV+fad99RRKMBV5+XTihm0vAWED5GXoK+
         gZBNactYlLuE+gNO8v8bHgNukkujWfPe0L+P9x5+sgRrc8h5GtU5WdtjSuFd6LZjN3IQ
         dotQ==
X-Gm-Message-State: AOAM531NKHIgZFusm3XUbc6CIQovUusPgaK+eJPJsmW1/82aUSRW6JmF
        WfytDYdhxcqor2DImzAzOEafkGLXhsPmoj4ZaZU4cdhxk/l48fxR9iEM0kXTmv8zFh1TxrFaaHK
        KUawhnsTYPiP9OYNMl69vI1MI
X-Received: by 2002:aa7:cdc5:: with SMTP id h5mr5493878edw.217.1622824444186;
        Fri, 04 Jun 2021 09:34:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEqFu5jZGNEyz4FJgde/k5Dn5+5CvsIniJDV73KDBS0u5RA0kL/8Cfa6je0uzzQFZkqwIOeA==
X-Received: by 2002:aa7:cdc5:: with SMTP id h5mr5493863edw.217.1622824444052;
        Fri, 04 Jun 2021 09:34:04 -0700 (PDT)
Received: from x1.bristot.me (host-79-24-6-4.retail.telecomitalia.it. [79.24.6.4])
        by smtp.gmail.com with ESMTPSA id n4sm2929890eja.121.2021.06.04.09.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 09:34:03 -0700 (PDT)
Subject: Re: [PATCH V3 5/9] tracing/trace: Add a generic function to
 read/write u64 values from tracefs
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
 <c585e3316f49c9e33acc79452588fc26ce11dfa4.1621024265.git.bristot@redhat.com>
 <20210603172244.6d2a6059@gandalf.local.home>
 <a5e96ac9-f188-a9df-3eac-624002031e21@redhat.com>
 <20210604121802.192caa07@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <59726959-bc86-8760-580d-3d4ceee45dad@redhat.com>
Date:   Fri, 4 Jun 2021 18:34:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210604121802.192caa07@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 6:18 PM, Steven Rostedt wrote:
> On Fri, 4 Jun 2021 18:05:06 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>>
>> The reason for this patch is that hwlat, osnoise, and timerlat have "u64 config"
>> options that are read/write via tracefs "files." In the previous version, I had
>> multiple functions doing basically the same thing:
>>
>> A write function that:
>> 	read a u64 from user-space
>> 	get a lock,
>> 	check for min/max acceptable values
>> 		save the value
>> 	release the lock.
>>
>> and a read function that:
>> 	write the config value to the "read" buffer.
>>
>> And so, I tried to come up with a way to avoid code duplication.
>>
>> question: are only the names that are bad? (I agree that they are bad) or do you
>> think that the overall idea is bad? :-)
>>
>> Suggestions?
> 
> I don't think the overall idea is bad, if it is what I think you are
> doing. I just don't believe you articulated what you are doing.

I see!

> It has nothing to do with 64 bit reads and writes, but instead has to
> do with reading and writing values that depend on each other for what
> is acceptable.

yeah, that is a better (starting point for an) explanation.

> Perhaps have it called trace_min_max_write() and trace_min_max_read(),
> and document what it is used for.

I will do that!

-- Daniel

> -- Steve
> 

