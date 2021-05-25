Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E838D390C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 00:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhEYW34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 18:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhEYW3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 18:29:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60DBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:28:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso13388233pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=x9qwPWMfCgzIMftuDjXnPzMh23kCj3dHIBBRGTms0Jo=;
        b=ZOOEBB7z57v74LWT0rNZOfqmfFcW5pA9QsVwvpzDGZbRTGYlmZoOgndvUubtpxN5NC
         pKV0T9ERitQWLHphZ1GgAZR1F5TyjDY2Tqschi0+V6EW9FpRqADKpsovbbGC8TVHsx4J
         NYOuO/JMdahwN7crgpiIjeuTRgZkoY2nLJEQH5KiESfwEDWK7TysKdTEEFJfV7xyC1eT
         VRJcb7VPI+X+I3CjTKt+fpj7vHEZmrU5oGu5VvGEXvQyDjt2N25IIYt7AH7Ukp3eHtAF
         LSpc4ZPk7wRGGRFbVWcxoQPA9INK0wQipRnc+vvS+E/z9zsWFddk/5gVPVXqvWh93M/I
         NqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x9qwPWMfCgzIMftuDjXnPzMh23kCj3dHIBBRGTms0Jo=;
        b=gfR+IXFGuyOUS4/eoY9l4Ae7jY48n94++RC02C+ebz2Adh4vpvopxxM53klMo/zyn5
         sCbPjiTA6rfqxDo2lxV99D7a6IyZhLWvE3nthcwJhchiOCQ0nqd7arFtjpd04cfG/0xH
         aWwaUEdUXJSK0DldsVxgT4Ik0TytwEttX+jDamYNCwH+bxQoM8YH1pI7S4YuNLP5M3bW
         bSwBl4cufxUF0m5E88lEAqjET9+zQI+recgRfW7uywcwcwBQmTg1xP+nphnz8cf4FBbA
         lM0ea3wOIPgnrk+28UoO9+pqwqXx4+nSP0mD8isiDDXtBp6nDRLWf38rpg/9DMKozrLJ
         dAjw==
X-Gm-Message-State: AOAM533WtPWvaa47jOaEuPdrufO/qu+JjIeSMPOT26Sk3C0hK5TwEElP
        fM+jCA8FVs6dKBXxYPSaDfrgNUbC0Y1KQg==
X-Google-Smtp-Source: ABdhPJyZvGUX1TrZ3jandii3/ind0Kb0sNnZcjf1q2lvaVZKJ+PwnwV1j+PSVr6J61G7cCYME+YScw==
X-Received: by 2002:a17:90a:fe02:: with SMTP id ck2mr32982813pjb.173.1621981702443;
        Tue, 25 May 2021 15:28:22 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w19sm13591843pfu.215.2021.05.25.15.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 15:28:21 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Add to traces the req pointer when available
To:     Olivier Langlois <olivier@trillion01.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <60ac946e.1c69fb81.5efc2.65deSMTPIN_ADDED_MISSING@mx.google.com>
 <439a2ab8-765d-9a77-5dfd-dde2bd6884c4@gmail.com>
 <2236ed83-81fd-cd87-8bdb-d3173060cc7c@gmail.com>
 <af1a868ed91466312786f11913cf06118139838e.camel@trillion01.com>
 <6133244fb6181420b27694abdfe3f42d43df8868.camel@trillion01.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5fb15014-94ba-e0ca-fa13-f9e898824185@kernel.dk>
Date:   Tue, 25 May 2021 16:28:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6133244fb6181420b27694abdfe3f42d43df8868.camel@trillion01.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 3:48 PM, Olivier Langlois wrote:
> On Tue, 2021-05-25 at 17:26 -0400, Olivier Langlois wrote:
>> but the pointers should be hashed by trace.
>>
>> That would be nice if someone more knowledgeable about the tracing
>> system could jump in and comment about the hash-ptr option and tell
>> when it is applied and when it is not...
> 
> My concern about hashing pointers directly in the io_uring code
> directly. It is that by doing so will make it impossible for a
> sufficiently priviledged user to get the raw pointer values without
> reverting back the pointer hashing stuff.
> 
> that would not be the right way to address the security concern if the
> tracing subsystem already hash them by default and is configurable to
> display raw pointers if desired.
> 
> My issue is that I haven't been able to see hashed pointers output from
> trace.

Just a quick guess, but does it rely on using %p to print the pointers?

-- 
Jens Axboe

