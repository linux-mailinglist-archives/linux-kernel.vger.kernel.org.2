Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44923C85C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhGNOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhGNOKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:10:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7544A613C8;
        Wed, 14 Jul 2021 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626271678;
        bh=BkxQBD9MLVqjxyyjXklU15HeBi9VJ9pSdrBB/p1hUfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=phGWzMwPnlvCLqW4G83acYyfdHdUSI2lGLPycQhHMfVsVl3oyFoDMpd4zMX1SoXGh
         p7+IDYWumT4BpmE7IQPA0yh+sezbUilDcrXuR1EXhs9pghnNRxP4/pRQZWwnEyzBx2
         IwJGoemLA2XxBxGlyrtSGNdv9PIOWXlxluElKxZqAGt/nfUtrZPLXTPQvfM3eS5Abj
         kXdYPbd70FCcQZJ9hQALscgDdFDiubH24FOkDQNeZBI5SLfRhsKU5gVUzOsVXhmv0v
         3Go7W3nUda4wl6XHdGxZGzwGjuKm8tglJGT8R8YvXftiEInXDUMuwLk2nUQjXI4BKj
         JUDLkRxUFleeQ==
Received: by mail-ej1-f49.google.com with SMTP id dt7so3496822ejc.12;
        Wed, 14 Jul 2021 07:07:58 -0700 (PDT)
X-Gm-Message-State: AOAM532XYISf+vGK2sOAlfPii69+hEGd/QTo2vIlyYhDixSdxLlHMBiv
        nM/8qviTEVeu0UiHkCVQCEVNXW87li15jsZ6QQ==
X-Google-Smtp-Source: ABdhPJw50v3ovvDxjytHudq3XB7Q56opajiEV0Dz+ePy4AYPVhuqgelzFt9cFkSZWuNRe62kCNZY6QlUzRjJlMN+928=
X-Received: by 2002:a17:906:57d0:: with SMTP id u16mr12930014ejr.468.1626271677006;
 Wed, 14 Jul 2021 07:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210628061410.8009-1-shruthi.sanil@intel.com>
 <20210628061410.8009-2-shruthi.sanil@intel.com> <20210714024756.GA1355219@robh.at.kernel.org>
 <YO6ome7Opd6kjqua@smile.fi.intel.com>
In-Reply-To: <YO6ome7Opd6kjqua@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Jul 2021 08:07:44 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+4vEfL5ZQzREXU7Mo1AUx1ZbdHTmJDwauEL890O7S7qg@mail.gmail.com>
Message-ID: <CAL_Jsq+4vEfL5ZQzREXU7Mo1AUx1ZbdHTmJDwauEL890O7S7qg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     shruthi.sanil@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, kris.pan@linux.intel.com,
        Mark Gross <mgross@linux.intel.com>,
        srikanth.thokala@intel.com,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        mallikarjunappa.sangannavar@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 3:04 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jul 13, 2021 at 08:47:56PM -0600, Rob Herring wrote:
> > On Mon, Jun 28, 2021 at 11:44:09AM +0530, shruthi.sanil@intel.com wrote:
>
> > > +  The parent node represents the common general configuration details and
> > > +  the child nodes represents the counter and timers.
> >
> > I don't think all the child nodes are necessary. Are the counters and
> > timers configurable (say on another SoC)? If not, then a single node
> > here would suffice.
>
> If you may notice the children may have different properties that can't be
> known ahead, such as IRQ line. On some platforms it may be this mapping, on
> another it maybe different.

What I noticed is it's all the same clock and 1 interrupt for each
timer can be just a single 'interrupts' property with 8 entries.

Is there a platform that's different or that's a hypothetical? Because
hypothetically, every aspect of every IP could change. But we don't
try to parameterize everything in DT. It's a judgement call between
implying things from compatible and explicit DT properties.

> With all respect for the simplification I think we can't do it here.

You can. Any data in DT could be in the kernel. It's a question of
balance, not can or can't.

Rob
