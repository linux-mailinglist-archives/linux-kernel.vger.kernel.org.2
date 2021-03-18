Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3413833FE49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCREna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhCREm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:42:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC92DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 21:42:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o10so2427369lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 21:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msXXhCgotnNx5R1ekgpEdanlM1n8vZRT/9MUQhFnYrM=;
        b=qevjmpNOsuA+UZn6QXmDaNLGQj2F/0zX+Eb0ZuI64k73jbyDB9LSwMWHWK+LR7PwAx
         IaCXfMAE9TJZn0pEu1xy1/Y0RbGqiInY5xtlkqpfGRTBcYqfv2ykshWDF5ubVOsY3N6q
         1KB7pgiAG8O7NpjSHTLpBGKUEjiC5LnXldFLCI5mvQQERwehM15MegelpbfInvxMYcQ+
         prn62arr4EyEh7AvsbfDA/XDnrXDdkRbTMN0+nWxT6XBjqLilFW2FK/rM1nN9QmgXfx4
         edFHi+M9cIk6F1v7DDMoxCqmXhteyhqrnUY658HvDGZh+fsadLVEIj2VwkBZ8tmbYKfO
         TklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msXXhCgotnNx5R1ekgpEdanlM1n8vZRT/9MUQhFnYrM=;
        b=k8MEeiT9m4BUXPNSOmdX296SG4uUK5EC4p9SYD/SSEXmyo62goe6BsfCPAzKHYvv71
         xC07nms3cXECAmFUK8G0/znfU9duwCfEVBAwRoxCNHujcIh4xarS0CA0sU8YJ0g2pWFj
         X2F1AVY9m6vdqiuEqYOFOfAw3+2ATdjpQsYabX7rSoWCRNgXQjaljC7hEpj9u9kNrpGU
         EJyxL7DYq/FYKlkaj+8LAyB6VfHuh66ZdG0+H4RzgS5WTZmwUU8jYPGFNXuBNW/h96rg
         Wkua/EKC4Qy+w8Ago9qU/IPOu87XJqKKCGGVn+4VSuVX+I0hk3BnMmsXKJzdRKNuAYAZ
         HKSg==
X-Gm-Message-State: AOAM531nW4YRFPnxmIk8zFs1LdyN+BH92XV45v3jBb+Cm5xB7cwX+FOn
        kULEmPThWJebA3QWruUzRLiBSV7kv1GO/OI/zq6DiQ==
X-Google-Smtp-Source: ABdhPJxL366X0PcOWwBYiM9OUz6HQ+Oh0k3kNYJ493Dt7DF5f1wo+hpFNW9SERuigBJ8Ii6H/rAhw99zUn9CjEMJTHI=
X-Received: by 2002:a19:6109:: with SMTP id v9mr4329738lfb.546.1616042575136;
 Wed, 17 Mar 2021 21:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210315142345.GB4401@xsang-OptiPlex-9020> <CAFA6WYNMHAqqmNfncmJm3+BUYCktXouRtV_udSxQb7eifPmX+Q@mail.gmail.com>
 <20210317030101.GB22345@xsang-OptiPlex-9020> <CAFA6WYMb-C2L7DmGnhWgxjuuvP=qxPA4-s4q+knxH+iWXypHmw@mail.gmail.com>
 <YFHAsgNhe8c3ZHQN@hirez.programming.kicks-ass.net> <YFHE9CjanDAD4l5M@hirez.programming.kicks-ass.net>
 <YFHFjarVo7HAP7pg@hirez.programming.kicks-ass.net> <CAFA6WYNs-rQLUGPMwc-p0q_KRvR16rm-x55gDqw828c7-C1qeA@mail.gmail.com>
 <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net> <CAFA6WYNr8SR=20LKJD0+AyrVXLY2CqQPqRE_60EestYv9L5AcA@mail.gmail.com>
 <YFJ66nW0vabAgGqm@kernel.org>
In-Reply-To: <YFJ66nW0vabAgGqm@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 18 Mar 2021 10:12:43 +0530
Message-ID: <CAFA6WYOM=y_8x=ziehOMKMFh1Va0_W6nmXfYtxKE28fM0BumPQ@mail.gmail.com>
Subject: Re: [PATCH] objtool,static_call: Don't emit static_call_site for .exit.text
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oliver Sang <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jbaron@akamai.com,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 at 03:26, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, Mar 17, 2021 at 07:07:07PM +0530, Sumit Garg wrote:
> > On Wed, 17 Mar 2021 at 18:16, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Mar 17, 2021 at 05:25:48PM +0530, Sumit Garg wrote:
> > > > Thanks Peter for this fix. It does work for me on qemu for x86. Can
> > > > you turn this into a proper fix patch? BTW, feel free to add:
> > >
> > > Per the below, the original patch ought to be fixed as well, to not use
> > > static_call() in __exit.
> >
> > Okay, fair enough.
> >
> > Jarkko,
> >
> > Can you please incorporate the following change to the original patch as well?
>
> Can you roll-out a proper patch of this?

Okay, I will post a separate patch for this.

-Sumit

>
> /Jarkko
