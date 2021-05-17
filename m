Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBEF3836F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244253AbhEQPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:37:40 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:34808 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244743AbhEQPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:21:54 -0400
Received: by mail-oo1-f43.google.com with SMTP id i8-20020a4aa1080000b0290201edd785e7so1549551ool.1;
        Mon, 17 May 2021 08:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N4dWQYSQXTefYnASUcNPf7Bqx2VgkqGi3aDq62T1WRQ=;
        b=CWn9CYuMVtISKdveqwHVh05sO0zcOzK6tLlMJKQ7zKg0UsxIlZSqjJuxcJOXxOb2aP
         70rhjNsUouAi9ie5DqnbZ89RjQhscLtdvJEmL+78VZ4MQXvmrJAuWgHzH/uPn0DV9grK
         LBdBlrmLijzmwcws2nxR2Wzt2To+qNnHpV4N08GFundvNa1cNDxnTmFKcBQ9lx1CAVm0
         7eodMJmw1hyi3uuvr3TRxdRSJDBhat3AFkl6rpCpjCPH0g//qqlEZCBDPIjkVM9B71pc
         sCZzi+FXohRXMC0FWDBZ2hku4s+3Od9SpLVZYEUNf2mXvJ4xLk/Zz53qAwGRbt36fCG+
         4b1A==
X-Gm-Message-State: AOAM532Noib8m+pMm5XXrkInUAhZBuDlSIRjJ/Aj5kkK/z81re1d58V1
        T2EAekYtEuj7WYB+naf+Lg==
X-Google-Smtp-Source: ABdhPJxQ35h5V+JsehBjssDjfQqYbvjizuWcs802DSqpMdJzKcmHCrSVtTGhWXHv+PDwVEJKIn0aFw==
X-Received: by 2002:a4a:cb15:: with SMTP id r21mr361460ooq.38.1621264838026;
        Mon, 17 May 2021 08:20:38 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k20sm3236478otb.15.2021.05.17.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:20:37 -0700 (PDT)
Received: (nullmailer pid 2588318 invoked by uid 1000);
        Mon, 17 May 2021 15:20:35 -0000
Date:   Mon, 17 May 2021 10:20:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Schlatterbeck <rsc@runtux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
Message-ID: <20210517152035.GA2581887@robh.at.kernel.org>
References: <20210106113730.k5qveshjgcd57kgx@runtux.com>
 <20210106113929.fizyg6fcsmsntkiy@runtux.com>
 <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com>
 <CAMuHMdUW3U6DVkHp3xiHFzvRUDJ1FwTNCnBWp5LCuDGxhds9wg@mail.gmail.com>
 <CANiq72mCFwYnbynQgwNGTt0mzo_rMrnQfpinz6DrPttFxUpyNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mCFwYnbynQgwNGTt0mzo_rMrnQfpinz6DrPttFxUpyNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 05:49:02PM +0200, Miguel Ojeda wrote:
> On Wed, May 12, 2021 at 5:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Seems like so far no one has picked this up?

Because DT patchwork never saw it.

> 
> Queuing it then.

Now it warns in linux-next:

Documentation/devicetree/bindings/auxdisplay/hit,hd44780.example.dts:52.18-62.11: Warning (unit_address_vs_reg): /example-1/i2c@2000: node has a unit name, but no reg or ranges property
