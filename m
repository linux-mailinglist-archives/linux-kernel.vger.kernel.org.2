Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB238E3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbhEXKHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:07:00 -0400
Received: from foss.arm.com ([217.140.110.172]:40448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232422AbhEXKGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:06:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71CA131B;
        Mon, 24 May 2021 03:05:19 -0700 (PDT)
Received: from bogus (unknown [10.57.72.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137013F719;
        Mon, 24 May 2021 03:05:17 -0700 (PDT)
Date:   Mon, 24 May 2021 11:05:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20210524100456.iqh2rqefrjd25ems@bogus>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <1621284311.383362.3157708.nullmailer@robh.at.kernel.org>
 <20210519112041.olwl35irvcbjxrka@bogus>
 <CAL_JsqK-LpDQWh9RsLsGPEQ53n6s0+Q7ioVikSm1jZuoCWAgnA@mail.gmail.com>
 <20210521040834.3rzsjkveoyugfotl@vireshk-i7>
 <20210521152431.wspnsji3z7pmmdlf@bogus>
 <20210524091715.wb6c4m3sicbypkaa@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210524091715.wb6c4m3sicbypkaa@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 02:47:15PM +0530, Viresh Kumar wrote:
> On 21-05-21, 16:24, Sudeep Holla wrote:
> > On Fri, May 21, 2021 at 09:38:34AM +0530, Viresh Kumar wrote:
> > > On 20-05-21, 14:43, Rob Herring wrote:
> > > > Not allowed because I can't turn this check on by default until we get
> > > > rid of the existing 80 or so. But it is a new check and Viresh already
> > > > applied, so oh well.
> > >
> > > I can always drop it :)
> > >
> > 
> > While I really don't care(evident by rate at which I worked on this 😉)
> > I think Hector Yuan won't be happy to wait I guess. As a quick fix, you
> > can update "qcom,cpufreq-hw" to "mediatek,cpufreq-hw". You will still
> > get warning with this patch + update alone, but once you have Hector's
> > mediatek cpufreq driver applied, the warnings must disappear.
> > 
> > What do you think ?
> 
> I guess you can send a fix later then.

Sure 😄

-- 
Regards,
Sudeep
