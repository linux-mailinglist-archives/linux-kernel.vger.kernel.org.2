Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B238B7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhETTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhETTpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:45:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E47A611AD;
        Thu, 20 May 2021 19:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621539827;
        bh=73nbHnhpJNgAbifU9hXlRY1DATQcRHcdWdwBjdW6tk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gMHxwv0ugV/o17GM1VJva4HUo4kFiuY3Y4kXoFU9oncZZDo9SfeimMJKfYct1HjQr
         6WDdFrWqPYe/vnZ31b2MizdizExI36Q9lYEhhA+ySkckTUCadw8qNbXrbamIjLfXwi
         ANpHHGA7AiD+54RJ+bJzW55tdvi+oXaVTdFgORcMQxBMvRhf9JLpj54EFghXcLbQNg
         b8vqKTsjmVZ5lY8maMJIu9ibMyUb8OKxUO6AJxeebNUn95FOdXhpsu+IvQgg2cx8H9
         fcpjZSmxTfBIFsuh2RHydYD9/3c86rTQz9yvkdEYor2cDQVgKKW628p0V4y+VTRMXw
         o1y7PYcp/0kTQ==
Received: by mail-ej1-f45.google.com with SMTP id z12so25656335ejw.0;
        Thu, 20 May 2021 12:43:47 -0700 (PDT)
X-Gm-Message-State: AOAM5300He4RLh1UbDZOdEIKYqR33Lld/vD5/lqlokcWnSNlbtsChU28
        WBZvxiX/WjbfJlE3mu91MBvWNTrk9oxqH9z4Tw==
X-Google-Smtp-Source: ABdhPJxK+MDKBXNCLITq63R0druO7RKK0WX1t1gie3ckEZF4lT+iXiBdCn2YfACqb3jR32XZ+WZ1d9hisRFtqcMJLkk=
X-Received: by 2002:a17:906:1d0a:: with SMTP id n10mr6189266ejh.341.1621539825668;
 Thu, 20 May 2021 12:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <1621284311.383362.3157708.nullmailer@robh.at.kernel.org> <20210519112041.olwl35irvcbjxrka@bogus>
In-Reply-To: <20210519112041.olwl35irvcbjxrka@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 May 2021 14:43:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK-LpDQWh9RsLsGPEQ53n6s0+Q7ioVikSm1jZuoCWAgnA@mail.gmail.com>
Message-ID: <CAL_JsqK-LpDQWh9RsLsGPEQ53n6s0+Q7ioVikSm1jZuoCWAgnA@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 6:20 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Rob,
>
> On Mon, May 17, 2021 at 03:45:11PM -0500, Rob Herring wrote:
>
> [...]
>
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml:0:0: /example-0/performance-controller@12340000: failed to match any schema with compatible: ['qcom,cpufreq-hw']
> >
> > See https://patchwork.ozlabs.org/patch/1479615
>
> IIUC, such errors due to the fact that the compatible used in the example
> is not in any yaml schema(as it is still in the old txt format). I also
> assume such errors are allowed until the transition is complete and I
> need not fix anything as part of this patch ?

Not allowed because I can't turn this check on by default until we get
rid of the existing 80 or so. But it is a new check and Viresh already
applied, so oh well.

BTW, one of the 80 is 'operating-points-v2' compatible. Hint, hint.

Rob
