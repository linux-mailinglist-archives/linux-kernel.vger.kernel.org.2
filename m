Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BCA33949C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhCLRYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:24:35 -0500
Received: from foss.arm.com ([217.140.110.172]:57776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232217AbhCLRYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:24:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6F481FB;
        Fri, 12 Mar 2021 09:24:04 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAC013F7D7;
        Fri, 12 Mar 2021 09:24:03 -0800 (PST)
Date:   Fri, 12 Mar 2021 17:24:01 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
References: <20210127110944.41813-1-alexander.sverdlin@nokia.com>
 <20210127110944.41813-3-alexander.sverdlin@nokia.com>
 <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
 <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
 <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
 <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
 <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander

On 03/10/21 18:17, Alexander Sverdlin wrote:
> Hi!
> 
> On 10/03/2021 17:14, Florian Fainelli wrote:
> >>>>> I tried on 5.12-rc2 and 5.11 but couldn't reproduce the problem using your
> >>> I still can't reproduce on 5.12-rc2.
> >>>
> >>> I do have CONFIG_ARM_MODULE_PLTS=y. Do you need to do something else after
> >>> loading the module? I tried starting ftrace, but maybe there's a particular
> >>> combination required?
> >> You need to load a BIG module, so big that it has no place in the modules area
> >> any more and goes to vmalloc area.
> > You absolutely need a very big module maybe more than one. When I tested
> > this, I could use the two proprietary modules (*sigh*) that I needed to
> > exercise against and loading one but not the other was not enough to
> > make the second module loading spill into vmalloc space.
> 
> Here is what I use instead of these real world "proprietary" modules (which of course
> were the real trigger for the patch):
> 
> https://www.spinics.net/lists/arm-kernel/msg878599.html

I am testing with your module. I can't reproduce the problem you describe with
it as I stated.

I will try to spend more time on it on the weekend.

Thanks

--
Qais Yousef
