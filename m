Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8DB40BD42
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhIOBnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhIOBne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:43:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFA0C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:42:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1so1003588pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DysTSQ9MR7/MaAx/pRLkL6jfnSsn9VkFolBRT1eG9zQ=;
        b=AUOBu9K/jEuUJpiOvBO7L4C+bbOipNOOARov/eL8Z8HmZLjQB0lvKMIx8yyUHXVGGy
         0tQNsA+x6B0PTYIZ9wYWNWA7v/b7ulJoZGujv/TE11jiCkXu1ZmJ7HtyCSrOlT9cXzBe
         ITmyz/eQmg86aCpAbXeQM+37NEH3DR82ha8zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DysTSQ9MR7/MaAx/pRLkL6jfnSsn9VkFolBRT1eG9zQ=;
        b=byB+C5IkHVzn7yaypAWBFTsgbx0pMQRIzG00hW3hq7nUYUOt73mJggRuOM1hDLm5Uw
         VNBQrZJ4M8RUD0tfGZ9lXvi4Y7H1Y651wx/NGf4rcjY9im/4Ddk4zypmYyKrYBxQ4xIO
         j9QD/Xr1UcnhSjuL26E7ZppLl7WS17yCl82QHFW5Y5zqvqr4CK8FhREkdeCGYON9ajmo
         gqemXt7yQq8nJfsA6dj/F9668qEDHJjQqLkOXjVl+yZS0jIKcVHnIDPUuOMU4wb3jWjd
         /yyW8EybUchvNkPiTqUPaDBgd2R6mkQhqQNRRcnpWtKbCi+VRMxhzqCtskPb0i5JfQkH
         8Qsg==
X-Gm-Message-State: AOAM5302DQrJcqWTs5w7yU2ZsUPQOrjKyFn6dKufh6SjNBpkqiXIwMGC
        cLewa5FnrqPTQ/eqIRKu8eLGrQ==
X-Google-Smtp-Source: ABdhPJzG8S5razlemYl4/wsU1GAIJmc3xfvr4CWPNLXu1XAJ2sAk+M1QRs67/BUASP5QiGulz3r2FQ==
X-Received: by 2002:a17:90b:1c87:: with SMTP id oo7mr5396576pjb.163.1631670135635;
        Tue, 14 Sep 2021 18:42:15 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:e3e3:41c9:dd51:5a4f])
        by smtp.gmail.com with ESMTPSA id 23sm3195056pfp.206.2021.09.14.18.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 18:42:14 -0700 (PDT)
Date:   Wed, 15 Sep 2021 10:42:10 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Suleiman Souhlal <suleiman@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] KVM: do not shrink halt_poll_ns below grow_start
Message-ID: <YUFPcphBWO8bz7Lk@google.com>
References: <20210902031100.252080-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902031100.252080-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/09/02 12:11), Sergey Senozhatsky wrote:
> grow_halt_poll_ns() ignores values between 0 and
> halt_poll_ns_grow_start (10000 by default). However,
> when we shrink halt_poll_ns we may fall way below
> halt_poll_ns_grow_start and endup with halt_poll_ns
> values that don't make a lot of sense: like 1 or 9,
> or 19.
> 
> VCPU1 trace (halt_poll_ns_shrink equals 2):
> 
> VCPU1 grow 10000
> VCPU1 shrink 5000
> VCPU1 shrink 2500
> VCPU1 shrink 1250
> VCPU1 shrink 625
> VCPU1 shrink 312
> VCPU1 shrink 156
> VCPU1 shrink 78
> VCPU1 shrink 39
> VCPU1 shrink 19
> VCPU1 shrink 9
> VCPU1 shrink 4
> 
> Mirror what grow_halt_poll_ns() does and set halt_poll_ns
> to 0 as soon as new shrink-ed halt_poll_ns value falls
> below halt_poll_ns_grow_start.

Gentle ping.

	-ss
