Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F063A9948
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhFPLbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbhFPLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:31:44 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3234C061768
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:29:37 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t40so2165236oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Z1ZFZRyBUAatyI9DAgfkD79GCfmHOfeRzXep8r1QClI=;
        b=FZPbHPS91cK05sahIJSlFQnw22w/94FmfLmbNBHX3QWBKmqp85anaKi2p5Sl5QNyNR
         3xeE7nGVM4CBcdr6MxeIx5vflTH6rsoX6ToxrLoAfEc8av8YfeYHtRV37pGO8QxWd5YH
         1uikowbFpzQyXO3dYGjWOjXeVW1slyTBs/S29T0CgSCUphatI6hlUNssZc6cawvK7kFX
         vKISdX/FbsVPkX0jlQLDwoZtZnrZS3qi12RfGpzU5psqd/Ks/GO78t1e+Kx5f6TlkVqB
         OZ/odUYExkDiRvVQqbH1O6Cgkn7djUMS/pRhsHdUuSMOqIyzvfK1iE/GAgygx9oYHwbu
         T8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Z1ZFZRyBUAatyI9DAgfkD79GCfmHOfeRzXep8r1QClI=;
        b=VntNo/7FXBsshBdUcjATV3QH6kV9m0KV8Pg+14FzLgcpT6ch3byaVSu1h0zmdh6VcL
         ihknKwHB0k7J9b9NtjjnqDFOoHtJp08VtCEorBJgBxwG1/mdr3aZeqOSQuWB7Q/GlhNa
         FUlLmT44XVoPb1kwkeTkxhvfCuXAyIK2yHqkqXbiwfUKbQ9OxvYnYG66OhcHqX5MG+Zx
         RXyylsIrafbUVdsv4ztAdMRmAFFViW+5iEFPzcCkN+gtQlqUq2xC5POF9IVdMqBdHUx0
         lhu0mYiWT7ewfXvdq2GFev4RhMRe5Fze8RfJBGRqwz2nSh/4xiGJmAZIfkZx7qSDZQXh
         LMUw==
X-Gm-Message-State: AOAM5325CMSWnBBHY/V9tkkB57bzhdFOZnCT77T4EcHE63jLgmURd86D
        CO2sCL6hP0szKzMrFnQFHmPzFD4eWm8c0Ty0Z3xhlnPkOHQhkg==
X-Google-Smtp-Source: ABdhPJy8O7G9/+Z3OtNWZOc2wLQoCcQCTHNRazTnbgep4x7xZPcFbU+PG5jTmK0oa7ukaI6nQZRnsGtoEqrxT2coZ9A=
X-Received: by 2002:aca:f5d6:: with SMTP id t205mr2874750oih.58.1623842977245;
 Wed, 16 Jun 2021 04:29:37 -0700 (PDT)
MIME-Version: 1.0
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Wed, 16 Jun 2021 19:29:26 +0800
Message-ID: <CAFiDJ5-ZO=BuSwBPPPecZhLyjyipTLenQxgCK=t52Pj7r659sQ@mail.gmail.com>
Subject: sched: Question about big and little cores system with SMP and EAS
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Would like to ask the experts here regarding the Symmetric
Multi-Processing mode (SMP) with Energy aware scheduler (EAS) support
on the big + little cores system.

Hardware system:
Big and little cores have almost the same ISA, but the big core has
some extension instructions that little core doesn't have.

With this hardware system, is it still possible to use SMP with EAS?
Any suggestions supporting this kind of hardware system in Linux?

Thanks in advance.

Regards
Ley Foon
