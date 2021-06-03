Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58B93999A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 07:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhFCFBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 01:01:47 -0400
Received: from mout01.posteo.de ([185.67.36.65]:53373 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhFCFBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 01:01:46 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 189A6240029
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 07:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1622696401; bh=dL/KmPixUXTojIuJrQETWc69RpMTqw/20H+9c1u/B+c=;
        h=Date:From:To:Cc:Subject:From;
        b=DlTV5yurNw4NPJ+UTzdYP7y4eUgk4yNPiuDCgkXGPuaDwjYdRvRdN+Z4UOONqBDn1
         7zUVg0XGKmAkyYoaNr050xNMi24j7KXmqGWpiB9LO2MSUmAd+D0wsixokO7M0z7M3o
         CIwB116WuxVZqrSjdibGkuV0VffBo9MyB8Vw2eXH1UKv+9cQ0LkbMLDa6lE6xPviDi
         1wR3QMdFzkTcrxJduU+MhgTZ7O+KlEsKuU1RfMJz7pePq043+s3DUfoafIFxqWmlI4
         AR5zhVN+zBbDOhkVfdzJvepbR/LrbuiA4ki5Gvp/9N1gplw2WRjbDtlpaPZqjGpa/g
         V9PEx4UiT401w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FwYbz5RT2z9rxL;
        Thu,  3 Jun 2021 06:59:59 +0200 (CEST)
Date:   Thu,  3 Jun 2021 04:59:55 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210603065955.1bcbe0a8@monster.powergraphx.local>
In-Reply-To: <CAL_Jsq+z=VApY+5oXYaLzndfBf=EueiA_d+5=1GSjKqcLOPO-g@mail.gmail.com>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
        <b7a1f5532e0ae474473858055fd9bbabff9e1449.1615713499.git.wilken.gottwalt@posteo.net>
        <CAL_Jsq+z=VApY+5oXYaLzndfBf=EueiA_d+5=1GSjKqcLOPO-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 17:12:26 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Sun, Mar 14, 2021 at 4:30 AM Wilken Gottwalt
> <wilken.gottwalt@posteo.net> wrote:
> >
> > Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> > compatible series SoCs.
> 
> To repeat what I said on v5: please Cc DT patches to the DT list so
> checks run and they get in my queue.
> 
> Now this is breaking dt_binding_check in linux-next, so drop, revert or fix it.
>
> Error:
> Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.example.dts:22.28-29
> syntax error FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:402:
> Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.example.dt.yaml]
> Error 1
> 
> 
> You need to include the headers for the defines.

Oh sorry, I totally missed both of the issues. I will make a new patch set and
fix that and some more minor issues I found.

greetings,
Will
