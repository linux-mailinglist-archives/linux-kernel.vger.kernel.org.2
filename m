Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC1D391A65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhEZOix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:38:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44839 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhEZOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:38:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622039840; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=WrEpK+MxyIabxv4pi0atexsBplGBEOjHKuGt7726NfU=;
 b=asPSq2Z8uy77rXNM7pkvzwcxgGCdyB/hlZ7Nk/uiKuSP0dy/QzB40NdeNdIpkY/U9w8aW2gq
 y7qRAfwteEY7E9viBSpHcvQCvxAS5kzQYYjc7xQr1vzM3j4VXaTwwGZLxdRIHm43L+X8hajF
 tRMXX1vGMvCpIQMqvELByNRo/Vg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60ae5d087b5af81b5cfd6e62 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 May 2021 14:36:56
 GMT
Sender: sharathv=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C5F7C4323A; Wed, 26 May 2021 14:36:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sharathv)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FCD1C43460;
        Wed, 26 May 2021 14:36:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 May 2021 20:06:55 +0530
From:   sharathv@codeaurora.org
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, edumazet@google.com
Subject: Re: Internal error: Oops  from inet_frag_find, when inserting a IP
 frag into a rhashtable
In-Reply-To: <20210519112029.3jbw74fuqe4p2tjm@gondor.apana.org.au>
References: <997dfef63f2bd14acc2e478758bfc425@codeaurora.org>
 <20210519112029.3jbw74fuqe4p2tjm@gondor.apana.org.au>
Message-ID: <221220f299ac4e6af858ce4e5d877d43@codeaurora.org>
X-Sender: sharathv@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-19 16:50, Herbert Xu wrote:
> On Wed, May 19, 2021 at 12:52:27AM +0530, sharathv@codeaurora.org 
> wrote:
>> 
>>   784.185172:   <2>  (2)[71:kworker/2:1][20210408_17:01:54.754415]@2
>> __get_vm_area_node.llvm.17374696036975823682+0x1ac/0x1c8
>>    784.185179:   <2>  (2)[71:kworker/2:1][20210408_17:01:54.754422]@2
>> __vmalloc_node_flags_caller+0xb4/0x170
>>    784.185189:   <2>  (2)[71:kworker/2:1][20210408_17:01:54.754432]@2
>> kvmalloc_node+0x40/0xa8
>>    784.185199:   <2>  (2)[71:kworker/2:1][20210408_17:01:54.754442]@2
>> rhashtable_insert_rehash+0x84/0x264
> 
> Something very fishy is going on here.
> 
> The code path in rhashtable_insert_rehash cannot possibly trigger
> vmalloc because it uses GFP_ATOMIC.  Is this a pristine upstream
> kernel or are there patches that may change things?
> 
> Cheers,

Thanks for the reply Herbert, we have got this crash reported from 
external
folks and I am trying to get the answers for your questions.
