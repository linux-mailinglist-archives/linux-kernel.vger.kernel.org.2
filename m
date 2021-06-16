Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5C3A8EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 04:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhFPCHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 22:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhFPCHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:07:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 19:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=S3MsV0eKh6X1735R+naF9CPADpchYXgFvvBssJYZGHI=; b=rZHkHP2TskfZeH7yW+iJjVriOd
        dtrQt3SpOBNhHiv5HdcgGnWqMSTOSnxMH64WN0BAfvvrphImKMWvcEcJ5u+IewFJwGBCrSwsl79NF
        CLh3PVxJ0nsIsaWjrzoQwfBXcrq4Ykul9AsfUtoHG0OYViBUskVliTi7ZJFld7EzRIp5jHQ9vDRYw
        WkVxqUS+tkQiJM7b/TZlhssOUKxK3wkSz5XQfLqduMHMTxvtBOgdnBPRRafRBaG+OyD22x5xQaK/o
        8y5zpuaK9tLhJ8prGUz70x7a0hUAtwyzFHNhnAYZkrWHc0Rb8Sf8Cd+vCQUzcphIdJ4q7Cgh2auAC
        KMMKyJBQ==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltKvn-004Qvm-5b; Wed, 16 Jun 2021 02:05:27 +0000
Subject: Re: [PATCH v7 1/5] string_helpers: Escape double quotes in
 escape_special
To:     Chris Down <chris@chrisdown.name>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
References: <cover.1623775748.git.chris@chrisdown.name>
 <af144c5b75e41ce417386253ba2694456bc04118.1623775748.git.chris@chrisdown.name>
 <CAHp75Vc-edpD5kz0EPsO7Q=zOPHWFckZzc17imO85dQy-PpOgg@mail.gmail.com>
 <YMk/IKA4okfYSh57@chrisdown.name>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <796701ff-18f9-a637-fca4-808ae36b336f@infradead.org>
Date:   Tue, 15 Jun 2021 19:05:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YMk/IKA4okfYSh57@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 5:00 PM, Chris Down wrote:
> Andy Shevchenko writes:
>>> I've checked uses of ESCAPE_SPECIAL and %pE across the codebase, and I'm
>>
>> checked the uses
> 
> Hmm, what's wrong with using the zero article for "checked uses"? I mean, I don't have any strong resistance, but I don't see anything wrong with it either, and it matches how I'd naturally speak.
> 
> Agreed on the others, though, hopefully they can be massaged in :-)

Ack, I don't see anything wrong with it either.
