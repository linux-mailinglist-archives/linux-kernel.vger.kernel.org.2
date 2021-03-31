Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31F34E080
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhC3FBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhC3FAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:00:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B396C061762;
        Mon, 29 Mar 2021 22:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=V7tfHUX7gzDCq90JXHU3cfAk5NpLyICliFAAYBpIIDM=; b=dw8TNySkze8eJCHzodSrcGQl5v
        VmXP9p/bUsK5T1f5xa1Rh9iYgt2Nsge5M86mRQLBhC7dZp1XoM7o0l94Pwu69p/AUeIvTSIvgnzU8
        mVUoJnhBukYbETXOQf9CbZBwp76M1oI1WuJvTZDc5ADRjqnPWDsNJxugg5WnWYSkvB5kbx4Mx5IcF
        pM95vp5P2xeuGc7anhDho8LhyHixBkU5llnCm8vVDA+lwkieI78xaDFII2rMl//Ewc9bvu7gfXfpC
        GVfUKExYk0PTuvKuiCfhEInib4+bDTdfYPsNdzoQ6F4Hvexv9rX+4xYem74xAD5x5u1ai5OKmjR/u
        CHQUvfDA==;
Received: from [2601:1c0:6280:3f0::4557]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lR6Ui-002iSV-8o; Tue, 30 Mar 2021 05:00:48 +0000
Subject: Re: [PATCH] Documentation: crypto: add info about "fips=" boot option
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20210330040001.31524-1-rdunlap@infradead.org>
 <20210330043747.GA28166@gondor.apana.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb76dd26-eea8-af06-6968-25719a6dba6b@infradead.org>
Date:   Mon, 29 Mar 2021 22:00:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330043747.GA28166@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 9:37 PM, Herbert Xu wrote:
> On Mon, Mar 29, 2021 at 09:00:01PM -0700, Randy Dunlap wrote:
>>
>> +			If fips_enabled = 1, some crypto tests are skipped.
> 
> I don't think any tests are skipped.  It does however disable
> many algorithms by essentially failing them at the testing stage.

That statement was based on crypto/testmgr.c (in 4 places):

		if (fips_enabled && template[i].fips_skip)
			continue;

and

	if (fips_enabled && vec->fips_skip)
		return 0;

and

		if (fips_enabled && !alg_test_descs[i].fips_allowed)
			goto non_fips_alg;

and

	if (fips_enabled && ((i >= 0 && !alg_test_descs[i].fips_allowed) ||
			     (j >= 0 && !alg_test_descs[j].fips_allowed)))
		goto non_fips_alg;


so it appears (at least to me) that there are some methods (infrastructure)
for tests to be skipped, but maybe none are actually using that possiblilty.

In any case, I don't mind dropping that part of the documentation.

thanks.
-- 
~Randy

