Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A01387CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350411AbhERPwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbhERPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:52:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D77C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:50:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621353041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eP07YdamiVewjEJZjJGc2aSYnYn1bdpViTbROQEztfQ=;
        b=HZ1RtICuIpM7SKiBXx4HewwfB26nMvXOAq9DqupedB15l/qGTIXkj0ICI/+ELb6soR3PCi
        sdg2xF0dpQPuLTQ++RThICIz/jz8VTnjcwOntCDXRZWFBXozsVu5FDu8p2GuppUz/7rmxw
        hPqyO53+z3keyIy9V+6aiy/SrGgLH/wAK7lkaR1KIzCzg7RKVi67pihG5euMCvGeJgSKHR
        oXsAfipf9PTpemtJKktEQCAeA7E468uUZeRP2fgZH5KU7XtvvbPDIy1PQ4omHINjc7Vxfg
        NRSNDVuwK23bSdzwbGyx40WSjIOsyfA/Z+OxCcDF2C8cjYqpmf1mTLeiTpfdcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621353041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eP07YdamiVewjEJZjJGc2aSYnYn1bdpViTbROQEztfQ=;
        b=gEXLIIaGoPPMOGB30zLe5eCEQ4YA0uLM1Vu2BcGQsnVpY1q6dknz+r9lVQrulzg9KQyXRD
        BewiZkNRLCUdflCw==
To:     John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [patch 5/8] perf/arm-dsu: Use irq_set_affinity()
In-Reply-To: <4fe8eb68-c940-dd4b-6781-6cdaf052f4f5@huawei.com>
References: <20210518091725.046774792@linutronix.de> <20210518093118.505110632@linutronix.de> <4fe8eb68-c940-dd4b-6781-6cdaf052f4f5@huawei.com>
Date:   Tue, 18 May 2021 17:50:40 +0200
Message-ID: <877djwdorz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18 2021 at 12:31, John Garry wrote:
> On 18/05/2021 10:17, Thomas Gleixner wrote:
>>   
>> @@ -769,7 +769,6 @@ static int dsu_pmu_device_probe(struct p
>>   	if (rc) {
>
> nit: I think that someone will send a patch to remove these {} later...
>
>>   		cpuhp_state_remove_instance(dsu_pmu_cpuhp_state,
>>   						 &dsu_pmu->cpuhp_node);
>> -		irq_set_affinity_hint(dsu_pmu->irq, NULL);
>>   	}

which should be rejected because

		cpuhp_state_remove_instance(dsu_pmu_cpuhp_state,
  					    &dsu_pmu->cpuhp_node);

is _NOT_ a one line statement.

	if (foo)
		cpuhp_state_remove_instance(state, &node);

is fine, but

	if (foo)
		cpuhp_state_remove_instance(dsu_pmu_cpuhp_state,
  					    &dsu_pmu->cpuhp_node);

breaks the expectation of a single line following the condition which
confuses my brain based OCR. :)

So I left the brackets there on purpose.

Thanks,

        tglx
