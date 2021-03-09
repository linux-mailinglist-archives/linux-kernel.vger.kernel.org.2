Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A53325CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhCIMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:51:39 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:40622 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhCIMvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:51:16 -0500
Received: by mail-lf1-f48.google.com with SMTP id x4so20155580lfu.7;
        Tue, 09 Mar 2021 04:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=4zPrx2tQtH5tgiawG5odTs7tWqGcK7t2C/1aTX2Fyxo=;
        b=JsBCDyrZMMDm/BCKYI8td1s9DADAIh1LDGzYUs3HOia6+1pbnAKx74cwXA8EAbpRJw
         xeeFvcNO5UiuEdHseO906F4iTYo5u4eTnIEObSTRLbL3QpgQWHlmTuv6lLoMpMQbjHSy
         8cj0EJutKofUqrM9x6frTcW2YPDEXAz2+CydzmCaVjvqeZnjvz/epirT7VJbsn+BZZ3R
         rVTLwDUCpS3/xNFSnGyNzh85ECHLl1DhV1W34QgF5YsqFgxnxcSUhyWsp9qMe6aZ4YRd
         iyhwfKQwpKxFrBT/uCO2+KwIj5B1ZJ1uLBq/czEDJaVkPKf8qLrEAKK7f/btniN3EkRe
         kgkw==
X-Gm-Message-State: AOAM531maqexZJXVCQNNvnmiUvz7vRJhzHKtCq9+KNoUHcS8YvNo1int
        wDmTaD6AOIiy4pzaMRCZLX4=
X-Google-Smtp-Source: ABdhPJz/4wjiqnuKB5OeDYokY4ebh24pt1Y2TMwXbkd9lcI3fmCkkXWqqy73R/FMZhzHf0Z1af0Cqg==
X-Received: by 2002:ac2:51dc:: with SMTP id u28mr1698983lfm.322.1615294274819;
        Tue, 09 Mar 2021 04:51:14 -0800 (PST)
Received: from dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id k5sm1914222ljh.130.2021.03.09.04.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:51:14 -0800 (PST)
Message-ID: <06c8e7339ebc3e1802aa1e9c213de9392671a8a5.camel@fi.rohmeurope.com>
Subject: Re: [PATCH v3 05/15] dt_bindings: mfd: Add ROHM BD71815 PMIC
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-power@fi.rohmeurope.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
In-Reply-To: <20210308173938.GA2679675@robh.at.kernel.org>
References: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
         <790da5fe60eb3bcd190830770866147bbb5f8143.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
         <20210308173938.GA2679675@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 09 Mar 2021 14:51:07 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On Mon, 2021-03-08 at 10:39 -0700, Rob Herring wrote:
> On Mon, 08 Mar 2021 12:40:50 +0200, Matti Vaittinen wrote:
> > Document DT bindings for ROHM BD71815.
> > 
> > BD71815 is a single-chip power management IC mainly for battery-
> > powered
> > portable devices. The IC integrates 5 bucks, 7 LDOs, a boost driver
> > for
> > LED, a battery charger with a Coulomb counter, a real-time clock, a
> > 32kHz
> > clock and two general-purpose outputs although only one is
> > documented by
> > the data-sheet.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/mfd/rohm,bd71815-pmic.yaml       | 201
> > ++++++++++++++++++
> >  1 file changed, 201 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:

I am sorry to bother but I've spent a while trying to reproduce this.
For some reason I can't trigger the error from

'make dt_binding_check' or
'make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/rohm,bd71815-
pmic.yaml'

even after I ran

'pip3 install dtschema --upgrade --user'.

I should also have yamllint installed.

> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Unknown file referenced: [Errno 2] No such file or directory:
> '/usr/local/lib/python3.8/dist-
> packages/dtschema/schemas/regulator/rohm,bd71815-regulator.yaml'

This bothers me slightly. The patch 04/15 should bring-in the
rohm,bd71815-regulator.yaml. Does this error indicate that file is
missing or is my $ref somehow invalid?

*** opinion follows - not sure if it just me but... ***

I know I should probably keep my mouth shut but... I am more and more
thinking that the yaml bindings are yet another 'excessive unit-test'
type solution. Tooling which should "force doing things correctly" is
eventually hindering development and causing the end result being sub-
optimal.

I mean that creating binding docs takes way too much time from someone
like me who is "yaml-illiterate". And when I eventually get yaml done -
the end result is far less descriptive for human eyes than the "good
old" free-text format would've been. I know one can add comments - but
I don't see much of them in the binding docs...


Best Regards
 -- Matti Vaittinen


