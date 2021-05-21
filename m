Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F1738CA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbhEUP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:26:05 -0400
Received: from foss.arm.com ([217.140.110.172]:49778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhEUP0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:26:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30CDD11B3;
        Fri, 21 May 2021 08:24:40 -0700 (PDT)
Received: from bogus (unknown [10.57.72.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51EF13F73B;
        Fri, 21 May 2021 08:24:38 -0700 (PDT)
Date:   Fri, 21 May 2021 16:24:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20210521152431.wspnsji3z7pmmdlf@bogus>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <1621284311.383362.3157708.nullmailer@robh.at.kernel.org>
 <20210519112041.olwl35irvcbjxrka@bogus>
 <CAL_JsqK-LpDQWh9RsLsGPEQ53n6s0+Q7ioVikSm1jZuoCWAgnA@mail.gmail.com>
 <20210521040834.3rzsjkveoyugfotl@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210521040834.3rzsjkveoyugfotl@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 09:38:34AM +0530, Viresh Kumar wrote:
> On 20-05-21, 14:43, Rob Herring wrote:
> > Not allowed because I can't turn this check on by default until we get
> > rid of the existing 80 or so. But it is a new check and Viresh already
> > applied, so oh well.
>
> I can always drop it :)
>

While I really don't care(evident by rate at which I worked on this 😉)
I think Hector Yuan won't be happy to wait I guess. As a quick fix, you
can update "qcom,cpufreq-hw" to "mediatek,cpufreq-hw". You will still
get warning with this patch + update alone, but once you have Hector's
mediatek cpufreq driver applied, the warnings must disappear.

What do you think ?

--
Regards,
Sudeep
