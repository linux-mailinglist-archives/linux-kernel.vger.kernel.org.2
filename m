Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A192131886A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBKKmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:42:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhBKKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613039824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RqhIlOOXm2OfTrN0agJ7O4HLKITtUNyiTne5QniNN2I=;
        b=dqiKo6c63NftDiQhO+1zccGMOYBnDTDbRJogfq47zBcEcA9sWoY7e6/sdN+ppARxplKWhc
        4WfCKK72EW7tgFtMx+sCT0a1KOsg1KCqPfTE3x8SjPPX3gJTZ4O55UB9yx3kQdGYDfRz7C
        PO2qL2EgNS2Vhp6MBP7EXDmpVkqHlos=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-bUAS80RNMB-1DacjiPlFmA-1; Thu, 11 Feb 2021 05:37:02 -0500
X-MC-Unique: bUAS80RNMB-1DacjiPlFmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5FB0192CC40;
        Thu, 11 Feb 2021 10:37:00 +0000 (UTC)
Received: from [10.36.114.52] (ovpn-114-52.ams2.redhat.com [10.36.114.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C53525D9E8;
        Thu, 11 Feb 2021 10:36:59 +0000 (UTC)
Subject: This reply comments on the patch to fixes the missing a blank line
 warning
To:     Adithya Chandrakasan <adithya.chandrakasan@gmail.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
References: <20210211072918.376837-1-adithya.chandrakasan@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <bce53689-4a6e-c3c3-a09c-6e946a577f61@redhat.com>
Date:   Thu, 11 Feb 2021 11:36:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210211072918.376837-1-adithya.chandrakasan@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

^

Please create proper patch subjects. Nobody has a glue what you are 
doing when looking at the subject.

"mm/util: fix ??? warning"

Which raises the question, what is ???

Compiler? static code checker? ... ?


Thanks

On 11.02.21 08:29, Adithya Chandrakasan wrote:
> FILE: mm/util.c:930: WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
> ---
>   mm/util.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 8c9b7d1e7c49..60286876636d 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -927,6 +927,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>   	unsigned int len;
>   	struct mm_struct *mm = get_task_mm(task);
>   	unsigned long arg_start, arg_end, env_start, env_end;
> +
>   	if (!mm)
>   		goto out;
>   	if (!mm->arg_end)
> 


-- 
Thanks,

David / dhildenb

