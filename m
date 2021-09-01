Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD233FE257
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhIAS3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhIAS3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:29:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF14C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 11:28:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id D25A71F43FDB
Subject: Re: Question on commit dc7109aaa233 ("futex: Validate waiter
 correctly in futex_proxy_trylock_atomic()")
To:     Thomas Gleixner <tglx@linutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Colin King <colin.king@canonical.com>
References: <CAKXUXMzqmN1dYpbYSCXWN9VwHn8+MXj3P=G09qD6=atwrcJ8WA@mail.gmail.com>
 <87a6kyfr4r.ffs@tglx>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <f9689421-a801-fd8d-b0bd-29280bebe78d@collabora.com>
Date:   Wed, 1 Sep 2021 15:28:16 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87a6kyfr4r.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Às 20:29 de 30/08/21, Thomas Gleixner escreveu:
> Lukas,
> 
> On Fri, Aug 20 2021 at 13:17, Lukas Bulwahn wrote:
>> Did you intend to return -EINVAL here? So:
>>
>> +       if (!top_waiter->rt_waiter || top_waiter->pi_state)
>> +               return -EINVAL;
> 
> Duh, yes.
> 
>> Static analysis tools are as foolish as they are... but every dog has its day...
> 
> IOW: Even a blind hen sometimes finds a grain of corn :)
> 
> Care to send a patch?
> 

A patch was already proposed with this fix:
https://lore.kernel.org/lkml/20210818131840.34262-1-colin.king@canonical.com/
