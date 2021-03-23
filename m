Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4346B346B15
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhCWV31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbhCWV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:29:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0D5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:29:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 16so27535299ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VB2Rli/wp6daf+0Rl+O8aL5+Mm/3G7ESffCZbqZfaRQ=;
        b=bxDavkCcCIproe94KQdt2CLKc783cy7xaHhrY0V88/NYN2lAYcrnTgAY9DBnGA1eHk
         4iW+FyT+Rl+KNFwyF7uR82uJ3oSY0K5ts4XzMy6HWqzE02GGP4FPO6dqniqVqwU3e0nR
         VEgqcTZz9zHZ1imNYYcjTYPEpNS1Zs8hjtwssRp6xU+ZVQeoHl4h0u9zXtPj47UCFgsa
         1plWTGRur+Y0v4NbZoI+i41n9ig3khbb22ReZEwnleyKySlS3kTDGA7QCqCxLM2L6Gsz
         tavKBcP0GK5JLnxKWJKqu/j2sjlaPk5plubvCFUAWTpCPUU4Z2ru9VCEoWQVEODHdCXY
         xesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VB2Rli/wp6daf+0Rl+O8aL5+Mm/3G7ESffCZbqZfaRQ=;
        b=CQwFc7ZHl0pVb0LUJn8gEOyFH2MIc/OfIy+bH7PSn47pbACkPOIxgcYWnuIPN3OsXC
         DS77070Hn/SaSvmvj46NtKaK9mUw0TJslKqwvLrRChuAe2TBIFgsOw2QTtsIQk6xJmuM
         Sg08rrPD7548Vs3NaH10n3OdFPFn5ujDbKYywe4jtW899DBqe9dl1PKP0fmTVQUvLWfI
         JiM4fyeLSmiwDCLtr7bEPK3IUcaoJcPrZZVqC6hvx9xgHHO1d1bABNzMzwKbyeheqviY
         Yx12weuE6hHJ+xMd7e0ubFijxb7tSDgieUwcaC9xcRBCJ2LMNP951CPNVeeIeI4dGbyk
         da+Q==
X-Gm-Message-State: AOAM532cniuuImH1QNG5KKgeCuxkkg2qamZwczVT+6vdBc9vCcu3zlgD
        3rtDWEFHOKuZmy3OH8ItnNcY9JZefGM=
X-Google-Smtp-Source: ABdhPJzQdnAsy7VZg8KomuQlbi0mPfgseYVlud4b9LsW2PI38hauzoucu+o27SlQHTOOZ+lCy1eJHw==
X-Received: by 2002:a2e:8709:: with SMTP id m9mr4195319lji.483.1616534950847;
        Tue, 23 Mar 2021 14:29:10 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id m22sm26095lfa.170.2021.03.23.14.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 14:29:10 -0700 (PDT)
Subject: Re: [PATCH v5] mm: cma: support sysfs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org
References: <20210323195050.2577017-1-minchan@kernel.org>
 <bff2b424-91f7-5748-fa27-54cc75667548@gmail.com>
Message-ID: <dfa57d3c-6aa0-d771-8c78-91ec0c42c7b5@gmail.com>
Date:   Wed, 24 Mar 2021 00:29:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bff2b424-91f7-5748-fa27-54cc75667548@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.03.2021 00:19, Dmitry Osipenko пишет:
>> +		if (!kobj)
>> +			goto out;
>> +
>> +		kobj->cma = cma;
>> +		cma->kobj = kobj;
>> +		if (kobject_init_and_add(&cma->kobj->kobj, &cma_ktype,
>> +					 cma_kobj_root, "%s", cma->name)) {
>> +			kobject_put(&cma->kobj->kobj);
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +out:
>> +	kobject_put(cma_kobj_root);
>> +
>> +	return -ENOMEM;
> kobject_init_and_add returns a error code, it could be different from
> ENOMEM. Won't hurt to propagate the proper error code.
> 

I think it will be cleaner to write it like this:

		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
		if (!cma_kobj) {
			kobject_put(cma_kobj_root);
			return -ENOMEM;
		}

		cma_kobj->cma = cma;

		err = kobject_init_and_add(&cma_kobj->kobj, &cma_ktype,
					   cma_kobj_root, "%s", cma->name);		   
		if (err) {
			kobject_put(&cma_kobj->kobj);
			kobject_put(cma_kobj_root);
			return err;
		}
	}

	return 0;
}
