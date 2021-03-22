Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE421344B70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhCVQdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:33:16 -0400
Received: from foss.arm.com ([217.140.110.172]:34914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCVQcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:32:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EA3D1042;
        Mon, 22 Mar 2021 09:32:52 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58F993F719;
        Mon, 22 Mar 2021 09:32:51 -0700 (PDT)
Date:   Mon, 22 Mar 2021 16:32:48 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20210322163248.id7qplbk6och6kuw@e107158-lin>
References: <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
 <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
 <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
 <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
 <20210314220217.4mexdide7sqjfved@e107158-lin>
 <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
 <20210322110106.2bed3d50@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322110106.2bed3d50@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/21 11:01, Steven Rostedt wrote:
> On Sun, 21 Mar 2021 19:06:11 +0000
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >  struct dyn_arch_ftrace {
> > -#ifdef CONFIG_ARM_MODULE_PLTS
> >  	struct module *mod;
> > -#endif
> >  };
> >  
> 
> I know you want to reduce the "ifdefery", but please note that the
> dyn_arch_ftrace is defined once for every function that can be traced. If
> you have 40,000 functions that can be traced, that pointer is created
> 40,000 times. Thus, you really only want fields in the struct
> dyn_arch_ftrace if you really need them, otherwise, that's a lot of memory
> that is wasted.

Yes you're right. I was a bit optimistic on CONFIG_DYNAMIC_FTRACE will imply
CONFIG_ARM_MODULE_PLTS is enabled too.

It only has an impact on reducing ifdefery when calling

	ftrace_call_replace_mod(rec->arch.mod, ...)

Should be easy to wrap rec->arch.mod with its own accessor that will return
NULL if !CONFIG_ARM_MODULE_PLTS or just ifdef the functions.

Up to Alexander to pick what he prefers :-)

Thanks

--
Qais Yousef
