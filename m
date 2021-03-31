Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E42D34EE13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhC3QjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhC3QjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:39:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71898C061574;
        Tue, 30 Mar 2021 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=5ZgTo25LsQZ9TJYftKq4wyfWOvd0PUTsUqCCu69Zbns=; b=gujzTzvOxSfmax36yY/iVxvLO9
        66+U/uXHN8lIn0N4EVxWrlFYd3c0IKcdwKm6EN2jvA/PE2Of1kXcmj58YXCYBGHHPh0cQBZex8j+3
        iuKwU7Ni2IGqKdRUU0e5kCxhv4SwR/cJ02qqdiwVmqBU89bp+c77FbMZ2MafcLA+3jnCT8E+cxBYx
        OGGLSrjZ3tO3uKvnIFd8CwxarZBKc77OjuBFm4qrQxA3KMhwxFS5N/3DADyROvaiXPApV069SwvN+
        3+XuI0Vlh7A9Uy5j6H3EmTZ1dL1FNMajfy1Ze1xJpWhgdcuCbM5GqZJ5vPxU7umhhy8Wu8IcFSs1p
        2x5BgkeA==;
Received: from [2601:1c0:6280:3f0::4557]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRHOM-003IqT-TC; Tue, 30 Mar 2021 16:38:59 +0000
Subject: Re: [PATCH v2] Documentation: crypto: add info about "fips=" boot
 option
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20210330050651.13344-1-rdunlap@infradead.org>
 <YGK3OlT3+6WdXbux@sol.localdomain>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f86bb75f-e593-5b2f-943a-db2129256eab@infradead.org>
Date:   Tue, 30 Mar 2021 09:38:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGK3OlT3+6WdXbux@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 10:29 PM, Eric Biggers wrote:
> On Mon, Mar 29, 2021 at 10:06:51PM -0700, Randy Dunlap wrote:
>> Having just seen a report of using "fips=1" on the kernel command line,
>> I could not find it documented anywhere, so add some help for it.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: linux-crypto@vger.kernel.org
>> Cc: Eric Biggers <ebiggers@kernel.org>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>> Updates/corrections welcome.
>>
>> v2: drop comment that "fips_enabled can cause some tests to be skipped".
>>
>>  Documentation/admin-guide/kernel-parameters.txt |   14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> --- linux-next-20210329.orig/Documentation/admin-guide/kernel-parameters.txt
>> +++ linux-next-20210329/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1370,6 +1370,20 @@
>>  			See Documentation/admin-guide/sysctl/net.rst for
>>  			fb_tunnels_only_for_init_ns
>>  
>> +	fips=		Format: { 0 | 1}
>> +			Use to disable (0) or enable (1) FIPS mode.
>> +			If enabled, any process that is waiting on the
>> +			'fips_fail_notif_chain' will be notified of fips
>> +			failures.
>> +			This setting can also be modified via sysctl at
>> +			/proc/sysctl/crypto/fips_enabled, i.e.,
>> +			crypto.fips_enabled.
>> +			If fips_enabled = 1 and a test fails, it will cause a
>> +			kernel panic.
>> +			If fips_enabled = 1, RSA test requires a key size of
>> +			2K or larger.
>> +			It can also effect which ECC curve is used.
> 
> This doesn't really explain why anyone would want to give this option.
> What high-level thing is this option meant to be accomplishing?
> That's what the documentation should explain.

Yes, clearly, even to me.

But I could not find anything in the kernel source tree that would help me
explain that.  So to repeat:

>> Updates/corrections welcome.

thanks.
-- 
~Randy

