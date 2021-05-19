Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD54388A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344775AbhESJLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:11:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344651AbhESJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:09:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621415310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04wT/sTmSp1ikyf1L5OfZ+skGbD5PvVo+vjU9E9c32o=;
        b=1erirEu9RjrTwVPHhRABtU8cisDkbUtDAAB+Q7SGY9CpTc2DxYpZvwIGe8eo6L0kUjdZyn
        atqWZE0VHBqooZZihvo2NBzH3Kx+FCitb++1wCMNftcjSrlEpZLFU6OBK6fiSB4tM30XGR
        8d0FFAll9qtXxhho1TNaB49Xaiyp8/vID7B9f3FaYmNxq9pF64kI00YXUaU3sbK6J+4K7m
        ycyOXW3/uNLExVacu5NvyeM3G5BLkqUYV1HU9WftUfh9dqoSh4S7N+iupOq8rQWb2CgVLo
        Jr4DMzGS3HPb/kjJlqwk8IIsuA5ZnmcB376AxkGvTBW8xnVscqohIwbcoWaGkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621415310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=04wT/sTmSp1ikyf1L5OfZ+skGbD5PvVo+vjU9E9c32o=;
        b=dS7h4PVA+7M7u/h4M+xsVaHz1E8bpG7ZPUEjFcXOiCWYmGjNpDzRoMSwiMTt4PCyuW1qww
        qB9gOwhjmFdCPmDw==
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [patch 0/8] genirq, perf: Cleanup the abuse of irq_set_affinity_hint()
In-Reply-To: <874kf0doq7.ffs@nanos.tec.linutronix.de>
References: <20210518091725.046774792@linutronix.de> <20210518104849.GB7770@willie-the-truck> <874kf0doq7.ffs@nanos.tec.linutronix.de>
Date:   Wed, 19 May 2021 11:08:30 +0200
Message-ID: <87v97fccq9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18 2021 at 17:51, Thomas Gleixner wrote:
> Sure. I'll send you a tag to pull ...

Here you go:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-export-set-affinity

Thanks,

        tglx
