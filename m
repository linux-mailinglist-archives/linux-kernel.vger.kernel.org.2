Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32FD31D561
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 07:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhBQGfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 01:35:04 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:31978 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhBQGfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:35:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613543684; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=rXPbKTWIi5rEfZI9/+7ppMeB12s7LpLBdTqWdVTE+Qk=; b=ZhWqcF2gvhBtACBVTcsaZgUsw0t/h5HlDOtaDkD21RNCopBcTwhmzNy+ECCgdcrBHsT0SVzj
 nChLcx9SVllf+qxHPMlNIPfeOJW6ldRmd3IrXQdC83oEu0AHNiBu2OJJ1D/KmZteaFoHx6W8
 P8LRsDczoUBrE98TIIH62AKIurI=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 602cb8e09f8fd267c2f400ff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 06:34:08
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 714A0C43466; Wed, 17 Feb 2021 06:34:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.147.187] (unknown [106.195.71.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2DF8C433C6;
        Wed, 17 Feb 2021 06:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2DF8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH] mm: slub: Convert sys slab alloc_calls, free_calls to bin
 attribute
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1610443287-23933-1-git-send-email-faiyazm@codeaurora.org>
 <20210112122245.GK35215@casper.infradead.org>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <2bccabbd-fc41-4484-d19d-cab86cf318b6@codeaurora.org>
Date:   Wed, 17 Feb 2021 12:04:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210112122245.GK35215@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 1/12/2021 5:52 PM, Matthew Wilcox wrote:
> On Tue, Jan 12, 2021 at 02:51:27PM +0530, Faiyaz Mohammed wrote:
>> @@ -5180,6 +5187,7 @@ static int any_slab_objects(struct kmem_cache *s)
>>  
>>  struct slab_attribute {
>>  	struct attribute attr;
>> +	struct bin_attribute bin_attr;
>>  	ssize_t (*show)(struct kmem_cache *s, char *buf);
>>  	ssize_t (*store)(struct kmem_cache *s, const char *x, size_t count);
>>  };
> 
> I'd rather you added a struct slab_bin_attribute.  If that's even
> needed ..  I think you could just use the bin_attribute directly instead
> of embedding it in this struct.
> 
Yes, we can use bin_attribute directly. Please find patch v2.
