Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918F3389842
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhESUxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 16:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhESUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 16:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621457549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mGF6mu3N6cw5NakOo+0k02bj33F4s7r0hBwk7DGOXH0=;
        b=Hyv9Fkf2Z7x4nGu0GdbJHgKqKfbQfJw/G0/JBojkhl3jN/MLJ4LN/cSWC8r+SqKXn+ORTk
        RsYjZS18k0z0dSmfM2lhRvrbhTVjPEzeIhffpxMjm5cpR5w4jcIoSKl/Waf7mUtwIuXupY
        clgXfdthJvKXhfwusZmCysz3Bj7AnnA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-WSSVz2V7PU6dHzI9WJpMDg-1; Wed, 19 May 2021 16:52:25 -0400
X-MC-Unique: WSSVz2V7PU6dHzI9WJpMDg-1
Received: by mail-qk1-f200.google.com with SMTP id u9-20020a05620a4549b02902e956c2a3c8so10711523qkp.20
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 13:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mGF6mu3N6cw5NakOo+0k02bj33F4s7r0hBwk7DGOXH0=;
        b=gSmu2asgmXD3NMx9X699Z4N3ka9OgnV5JOdlKUou+qehBtlDQ/i+vhBfm1NlQgUSZf
         6/nKMEubkwc6t0N6FniMd+t0ITkSymLsL2xAlYBN4qyt7F2K3CpnK3Wrq2UdtK38ONVq
         vKoPgH4ceoy0p13jZgKpEi0rBIESL8mv/8clTlzkYJyCb5FoX9unim43/vkpNM2cVWFS
         utvd4gtIXiL+GcF52BNutyI0Jp8p6UCN6GCBhAmy9X+vI6VL8plw9b6HvmdU6VVRkmLp
         qdYwydtmpbYBvYq6z50f8AFp58JSK1EmWBk1G520T5fpucVT12HWmHslNvJBvGWxm9gz
         Y72w==
X-Gm-Message-State: AOAM530uszSeEXL0OSa5pbAvRIyRx6vPCpwTKgyWONMq1gdg1ev3V5xL
        Ea5hyIDHCODbArrtbH5KmQm0EiBWT+vArbl9zAhzxgvWAw+ULQgeeSuBoUYRlfja/khE+4sqJph
        i8ystwA6wczby6tgnM0IsEpDv
X-Received: by 2002:a37:4495:: with SMTP id r143mr1425155qka.255.1621457545338;
        Wed, 19 May 2021 13:52:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYDOSOizaY1G03/7QZSdxV4eVueTbgj0diH1o3Jpryc2V1p0hTi9xBJxWOyxeDtK3NIERaPg==
X-Received: by 2002:a37:4495:: with SMTP id r143mr1425134qka.255.1621457545091;
        Wed, 19 May 2021 13:52:25 -0700 (PDT)
Received: from treble ([68.52.236.68])
        by smtp.gmail.com with ESMTPSA id t6sm626894qkh.117.2021.05.19.13.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:52:24 -0700 (PDT)
Date:   Wed, 19 May 2021 15:52:22 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] objtool annotations: Avoid using inline asm operand
 modifiers
Message-ID: <20210519205222.sgx73r3sewh32wf3@treble>
References: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-1a26be.your-ad-here.call-01621428935-ext-2104@work.hours>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 03:03:02PM +0200, Vasily Gorbik wrote:
> Make objtool annotations arch assembler independent. Would be nice if this goes
> via objtool tree. I have further patches which depend on that.
> 
> Vasily Gorbik (2):
>   compiler.h: Avoid using inline asm operand modifiers
>   instrumentation.h: Avoid using inline asm operand modifiers
> 
>  include/linux/compiler.h        | 22 ++++++++++++++--------
>  include/linux/instrumentation.h | 20 ++++++++++++--------
>  2 files changed, 26 insertions(+), 16 deletions(-)

Thanks Vasily, looks good to me.  Running it through some testing.

-- 
Josh

