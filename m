Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C472A376579
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhEGMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 08:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237043AbhEGMtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 08:49:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE5046143F;
        Fri,  7 May 2021 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620391728;
        bh=vaBF2uHP43lFyzQwMbdbFEMpn4rQ8hW21O3qLxQS5Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iI9XS9nv67rnDiBHeuSryQolG8PeQYxzxPdHrDmq9vP05gI46DB/f/n6kIMO4DKod
         vNmA1K1fye00nnZ7EeAGHG0zy4LL5wwZHhgQGl9NSocHP7jXvQLU3T7gVQlsQRYpI0
         Cw7gF01oC9+5IXOOEHSwvRdTj7aeTIeJ43wNVsPiKZHrExqmi/URQk7bj5nncex8cj
         tyTkktZVOyTlwVjzIDxVkjHr3wpfMgP8qSmTPsOxFcVzXIOXe0CneIRKrBng1uzmCt
         znJocDSdswSCf7hNwkhIuFVXrOdC0KRrW4UTjyGOKndKUia6Rq92b5Sj1k4IVNPDZH
         iy+EbcMxByCHg==
Date:   Fri, 7 May 2021 14:48:42 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: module: treat exit sections the same as init
 sections when !CONFIG_MODULE_UNLOAD
Message-ID: <YJU3KrZzSRYNH6Zt@gunter>
References: <20210507121322.6441-1-jeyu@kernel.org>
 <20210507123054.GD1336@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210507123054.GD1336@shell.armlinux.org.uk>
X-OS:   Linux gunter 5.11.16-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Russell King - ARM Linux admin [07/05/21 13:30 +0100]:
>On Fri, May 07, 2021 at 02:13:22PM +0200, Jessica Yu wrote:
>> Dynamic code patching (alternatives, jump_label and static_call) can
>> have sites in __exit code, even if __exit is never executed. Therefore
>> __exit must be present at runtime, at least for as long as __init code is.
>...
>> Previously, the module loader never loaded the exit sections in the first
>> place when CONFIG_MODULE_UNLOAD=n. Commit 33121347fb1c ("module: treat exit
>> sections the same as init sections when !CONFIG_MODULE_UNLOAD") addressed
>> the issue by having the module loader load the exit sections and then making
>> __exit identify as __init for !MODULE_UNLOAD. Then, since they are treated
>> like init sections, they will be also discarded after init.
>>
>> That commit satisfied the above requirements for jump_labels and
>> static_calls by modifying the checks in the core module_init_section()
>> function in kernel/module.c to include exit sections. However, ARM
>> overrides these and implements their own module_{init,exit}_section()
>> functions. Add a similar check for exit sections to ARM's
>> module_init_section() function so that all arches are on the same page.
>
>Shouldn't the module core code itself be doing:
>
>	module_init_section(name) || module_exit_section(name)
>
>itself when CONFIG_MODULE_UNLOAD is not set, rather than pushing this
>logic down into every module_init_section() implementation?

Yeah, that sounds better. Originally, I had wanted to keep the #ifndef
in one place to keep the churn to a minimum.

But seeing that we have to patch up ARM too, it's probably the less
ugly option now. Let me cook up an alternative patch and resend.

Thanks,

Jessica
