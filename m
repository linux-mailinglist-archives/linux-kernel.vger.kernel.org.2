Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187B0344878
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhCVPB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230407AbhCVPBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:01:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9BEE619AA;
        Mon, 22 Mar 2021 15:01:07 +0000 (UTC)
Date:   Mon, 22 Mar 2021 11:01:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
Message-ID: <20210322110106.2bed3d50@gandalf.local.home>
In-Reply-To: <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
References: <20210127110944.41813-3-alexander.sverdlin@nokia.com>
        <20210307172650.uztx3sk5abybbp3f@e107158-lin.cambridge.arm.com>
        <0c122390-6e76-f773-86e9-8c085f4384f2@nokia.com>
        <20210309174201.n53za7mw33dqyleh@e107158-lin.cambridge.arm.com>
        <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
        <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
        <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
        <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
        <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
        <20210314220217.4mexdide7sqjfved@e107158-lin>
        <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2021 19:06:11 +0000
Qais Yousef <qais.yousef@arm.com> wrote:

>  #ifdef CONFIG_DYNAMIC_FTRACE
>  struct dyn_arch_ftrace {
> -#ifdef CONFIG_ARM_MODULE_PLTS
>  	struct module *mod;
> -#endif
>  };
>  

I know you want to reduce the "ifdefery", but please note that the
dyn_arch_ftrace is defined once for every function that can be traced. If
you have 40,000 functions that can be traced, that pointer is created
40,000 times. Thus, you really only want fields in the struct
dyn_arch_ftrace if you really need them, otherwise, that's a lot of memory
that is wasted.

-- Steve
