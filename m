Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492273C5AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhGLKWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhGLKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626085145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MwdGC81H0zJey0lxKkxUMTB5Syojv6Uq7jiYCQF+Ng=;
        b=FY6kw/wyhllAUepBVfCOABGF5xZaVCvUGsK1wxXIJEdBdvl+Gb5JB1JX6EmOMIh6MDU+b3
        rvG9PigghHCdQ3ygMzCntfyCYkYIckjeViNkTVFbMYJKdB1fuqTUOgUghaLw0yY06ZULnP
        EVJhBZzRQkVu8TmYndCqLusjW5Wf0GU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-KbAtn6oyOwy7p0Lu5KnaEw-1; Mon, 12 Jul 2021 06:19:02 -0400
X-MC-Unique: KbAtn6oyOwy7p0Lu5KnaEw-1
Received: by mail-wm1-f70.google.com with SMTP id f16-20020a1c6a100000b0290210c73f067aso2805778wmc.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 03:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+MwdGC81H0zJey0lxKkxUMTB5Syojv6Uq7jiYCQF+Ng=;
        b=IDs1XUmdA73ISZJmwpIEGwTVUpKMrx9qjPUXzVKXnfrVMwM2iMeki+5Q+rafFV7J6L
         vs4POKa0Zg2RvPjaWfUqL7JE1kp0oHqY4SCLqcjqVI0nLReOE7y3wS72GC4WF55kUwnT
         sw8YqBzRThTOy7QABL3mBTJOhgC+Fxtf2O9GkNWDps8w/466ZvIrXNF7MgwI8vIgx53M
         5MyAkfdmXiG7ABBNYx163vsCnGeBDHxYZRwRhe83VY39csYtnsjH36M9plkVS7G2S0mH
         Ef9RiTH8wiqyCWeNDPEZbA3dct/gQWGh1CEYIHhtYjm2ErZBdaiiOCq6yjqs4poERr/E
         nX8w==
X-Gm-Message-State: AOAM530i/lwN9qtcK3LjHNeFBhA3lUpK7TUbtaFIlgNPXKQS/xMyUVqJ
        YFXC0H4D5YIR0umQi1rtmeU9ZNYuPe1I5NI/GXWfSrvwy/OZInj7CmXpFUiM5lORzE7PaXuNLT+
        B9tB7VEX8enqwvJsN1l/7B4Iy
X-Received: by 2002:a05:600c:2142:: with SMTP id v2mr33075145wml.121.1626085141291;
        Mon, 12 Jul 2021 03:19:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/P7K4IsMraQ1ucaqyCIqWXC5+/GhIVwlhSqY/9Iw/MfoQTh2Y7FrZBgITaS+lcdqR5VBnxg==
X-Received: by 2002:a05:600c:2142:: with SMTP id v2mr33075127wml.121.1626085141140;
        Mon, 12 Jul 2021 03:19:01 -0700 (PDT)
Received: from [192.168.1.136] ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id y19sm727912wma.21.2021.07.12.03.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 03:19:00 -0700 (PDT)
Message-ID: <b079157aede9b8ebb0cb58a6fdabb7d4d2a84e74.camel@redhat.com>
Subject: Re: [PATCH] timers: Fix get_next_timer_interrupt() with no timers
 pending
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     He Zhe <zhe.he@windriver.com>, anna-maria@linutronix.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Date:   Mon, 12 Jul 2021 12:19:00 +0200
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
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-07-10 at 02:52 +0200, Frederic Weisbecker wrote:
> Very good catch.
> 
> And the fix looks good:
> 
>     Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

> 
> I guess later we can turn this .timers_pending into
> .timers_count and that would spare us the costly call to
> __next_timer_interrupt() up to the last level after the last
> timer is dequeued.

Sound like something manageable. I'll probably have a go at it in the future.

-- 
Nicolás Sáenz

