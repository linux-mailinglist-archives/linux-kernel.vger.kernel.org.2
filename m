Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41A7388CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbhESLWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:22:10 -0400
Received: from foss.arm.com ([217.140.110.172]:60700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350009AbhESLWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:22:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BFDE101E;
        Wed, 19 May 2021 04:20:49 -0700 (PDT)
Received: from bogus (unknown [10.57.72.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B17BC3F719;
        Wed, 19 May 2021 04:20:47 -0700 (PDT)
Date:   Wed, 19 May 2021 12:20:41 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20210519112041.olwl35irvcbjxrka@bogus>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
 <1621284311.383362.3157708.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621284311.383362.3157708.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, May 17, 2021 at 03:45:11PM -0500, Rob Herring wrote:

[...]

> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml:0:0: /example-0/performance-controller@12340000: failed to match any schema with compatible: ['qcom,cpufreq-hw']
>
> See https://patchwork.ozlabs.org/patch/1479615

IIUC, such errors due to the fact that the compatible used in the example
is not in any yaml schema(as it is still in the old txt format). I also
assume such errors are allowed until the transition is complete and I
need not fix anything as part of this patch ?

--
Regards,
Sudeep
