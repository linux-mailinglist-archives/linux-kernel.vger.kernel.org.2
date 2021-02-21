Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D7B320DA5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 21:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhBUUii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 15:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhBUUih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 15:38:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EDEC061574;
        Sun, 21 Feb 2021 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=TodMQhTq+cGVVOCaD81EhvMNZtfQt3L+a/bV5YenmcA=; b=iErmknlTcb1M7IRQXgT7TBPyaO
        HSbSyds3TPXzWMgvu9MopiUz5HPxmmbw2d7UvJrSOLBQOzz9pEQNYJdtyaJuX1MbfBd5u059mn9k9
        MdupbdNr4jSeVlQD7kVqELaqVmduU8KegPUIxqtNWZb6qoLD6z+pcMl6MUvlYwrgremIlMMocf4JW
        jVKX2d8seEIwUUcCAicqDqUEeJ84rpZ6lBOzwUa5BlDU8rs25zkak0hm7cW8Y7Xj+RKliYz+lAvXw
        tgZXyzTEuX5BGYG8BzqFLdLoLpGuSE65A0PRAvOMK2GIV4Fat8WWpCr8DNCnFibrqmYOQUa3XRgNP
        lCo8DIeA==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDvUH-0000HV-J4; Sun, 21 Feb 2021 20:37:53 +0000
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com>
 <cb6151cf-8f71-2275-c757-098d163f87ff@infradead.org>
 <4862AEE9-1819-43A7-BF95-C02DB6E2D06D@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <40a65a30-ce41-6a51-50f4-34a0b0b1ef6f@infradead.org>
Date:   Sun, 21 Feb 2021 12:37:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <4862AEE9-1819-43A7-BF95-C02DB6E2D06D@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/21 12:10 PM, Bae, Chang Seok wrote:
> On Feb 21, 2021, at 11:30, Randy Dunlap <rdunlap@infradead.org> wrote:
>> Can we tell people (in this Doc file) where to look up the values that can be
>> used in xstate.enable and xstate.disable?
> 
> Perhaps add something like this with the change below:
>     “See comment before function fpu__init_parse_early_param() in
>      arch/x86/kernel/fpu/init.c."

Hi,

I was thinking more along the lines of where can I find the value
0x60000 or BIT(22) or BIT(19), for example and see what they mean,
even though it will likely be some abbreviation.


> /*
>  * The kernel parameter "xstate.enable='mask'" and "xstate.disable='mask'" have a
>  * mask value in a subset of XFEATURE_MASK_CONFIGURABLE.
>  *
>  * The longest parameter is 22 octal number characters with '0' prefix and an extra
>  * '\0' for termination.
>  */
> #define MAX_XSTATE_MASK_CHARS   24
> 
> /**
>  * fpu__init_parse_early_param() - parse the xstate kernel parameters
>  *
>  * Parse them early because fpu__init_system() is executed before
>  * parse_early_param().
>  */
> static void __init fpu__init_parse_early_param(void)

thanks.
-- 
~Randy

