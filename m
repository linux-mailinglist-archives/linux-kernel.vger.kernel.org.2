Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5185037FB39
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhEMQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbhEMQIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:08:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E7C061756
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=xEFVCLX7oEk1Wo8Bzc+Xn0yM1lRRGXKF9g6bs1YJzFs=; b=kQKdj44vfiwNddBWqh1xtBxau1
        Z17i+wewEuEgBCdjGXgz6Jk+51D9t/lYd9M7K3x7umEBVVd3oNOhsxjIj9SImyqdaMcMHtv0rXOVb
        v/rEHRZSp/X55ZDxxCKPcnfNK2qUscG9msX+MZldtGMYdh5DoETa+44/LYNw3ZakY1geS2ZxHL2dn
        rDWbSmkVHk9EaDrIsZAA1R7PhhKyItsE+SAJSxP3NcwnhJWyJGh6RkkPiuXFrfBFMcgp3jRB4o4CL
        d6FDHKr73TJ2YQuVMebjPHstqwRtaHOEcA5dbgO71loxkKknHhEwCZkaeTur4BxNButGjNiOKuEOL
        hr+cMsAg==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.253])
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhDsB-00BNHR-Vt; Thu, 13 May 2021 16:07:40 +0000
Subject: Re: [PATCH v2] init: Print out unknown kernel parameters
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@suse.de>
References: <20210511211009.42259-1-ahalaney@redhat.com>
 <cbd3c07e-9dae-44b2-761e-653bd8d0e930@infradead.org>
 <20210513130050.6czigy6cpz34ovz7@halaneylaptop>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d77f6819-9d3b-8d50-16cb-fff1a62dc67d@infradead.org>
Date:   Thu, 13 May 2021 09:06:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210513130050.6czigy6cpz34ovz7@halaneylaptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 6:00 AM, Andrew Halaney wrote:
> On Wed, May 12, 2021 at 04:00:21PM -0700, Randy Dunlap wrote:
>> On 5/11/21 2:10 PM, Andrew Halaney wrote:
>>> It is easy to foobar setting a kernel parameter on the command line
>>> without realizing it, there's not much output that you can use to
>>> assess what the kernel did with that parameter by default.
>>>
>>> Make it a little more explicit which parameters on the command line
>>> _looked_ like a valid parameter for the kernel, but did not match
>>> anything and ultimately got tossed to init. This is very similar to the
>>> unknown parameter message received when loading a module.
>>>
>>> This assumes the parameters are processed in a normal fashion, some
>>> parameters (dyndbg= for example) don't register their
>>> parameter with the rest of the kernel's parameters, and therefore
>>> always show up in this list (and are also given to init - like the
>>> rest of this list).
>>>
>>> Another example is BOOT_IMAGE= is highlighted as an offender, which it
>>> technically is, but is passed by LILO and GRUB so most systems will see
>>> that complaint.
>>>
>>> An example output where "foobared" and "unrecognized" are intentionally
>>> invalid parameters:
>>>
>>>   Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.12-dirty debug log_buf_len=4M foobared unrecognized=foo
>>>   Unknown command line parameters: foobared BOOT_IMAGE=/boot/vmlinuz-5.12-dirty unrecognized=foo
>>
>> Hi Andrew,
>> What order is the list of unknown command line parameters listed in?
> 
> Hi Randy,
> 
> That's a good question considering that they are out of order in my
> example output compared to the command line. The order is parameters
> without an "=val", then those with an "=val", and within those groups
> they should be ordered as they are on the command line.
> 
> This is because I'm using the processing work done by
> unknown_bootoption(), which stores them in two separate lists to pass to
> init later (for arguments and environment). I am "stealing" from those
> here:
> 
> 	for (p = &argv_init[1]; *p; p++)
> 		end += sprintf(end, " %s", *p);
> 	for (p = &envp_init[2]; *p; p++)
> 		end += sprintf(end, " %s", *p);
> 
> hence the differing output order from the command line. I didn't
> see much value in trying to duplicate that processing logic to get them in
> a single list in the order of the command line itself. I debated looking
> at the command line and searching each of the offending lists for that
> entry to get them in the order of the command line but decided to keep
> it simple here since it was achieving what I wanted.

Thanks for explaining. That's what I was looking for.

-- 
~Randy

