Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D893E36729E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbhDUSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238438AbhDUSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619030040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0ler724KCUKqQfuTRpL+s1fIh5Og/jAgjF8UUhS5TM=;
        b=HJkxeBfPcn2MyzymD9x1XaSUizdxH+ujGaxdmkONv7CX77Rpe4zy1lUAfRq1laCLNZB5MK
        1oR2SSB/ajldKa/BUg2Zpv7WsO1rMleqotJVu0M+Ar45wLDEKttNlWG2ZXmhn40ZmlKYET
        QJlHoiu7rRY6KBNgiJN0XF3wG6IKCQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-sPWdTmGWNcmsuK4NQhRQFw-1; Wed, 21 Apr 2021 14:33:58 -0400
X-MC-Unique: sPWdTmGWNcmsuK4NQhRQFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0CED9F93C;
        Wed, 21 Apr 2021 18:32:14 +0000 (UTC)
Received: from gigantic.usersys.redhat.com (helium.bos.redhat.com [10.18.17.132])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0125C19D9B;
        Wed, 21 Apr 2021 18:32:13 +0000 (UTC)
From:   Bandan Das <bsd@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ramakrishna Saripalli <rsaripal@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 4/4] x86/speculation: Add PSF mitigation kernel parameters
References: <20210421090117.22315-1-rsaripal@amd.com>
        <20210421090117.22315-5-rsaripal@amd.com>
        <4c688fc7-67df-3187-54b2-bf20e510fb39@infradead.org>
Date:   Wed, 21 Apr 2021 14:32:13 -0400
In-Reply-To: <4c688fc7-67df-3187-54b2-bf20e510fb39@infradead.org> (Randy
        Dunlap's message of "Wed, 21 Apr 2021 09:04:30 -0700")
Message-ID: <jpg4kfzfpzm.fsf@linux.bootlegged.copy>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> Hi,
>
> On 4/21/21 2:01 AM, Ramakrishna Saripalli wrote:
>> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
>> 
>> PSF mitigation introduces a new kernel parameter called
>> 	predict_store_fwd.
>> 
>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 04545725f187..58f6bd02385b 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3940,6 +3940,11 @@
>>  			Format: {"off"}
>>  			Disable Hardware Transactional Memory
>>  
>> +	predict_store_fwd	[X86] This option controls PSF mitigation
>> +			off - Turns on PSF mitigation.
>> +			on  - Turns off PSF mitigation.
>> +			default : on.
>
> This should be formatted more like:
>
> +	predict_store_fwd=	[X86] This option controls PSF mitigation
> +			off - Turns on PSF mitigation.
> +			on  - Turns off PSF mitigation.
> +			default: on.
>
> But why does "off" turn it on and "on" turn it off?
>
Maybe, rename the parameter to something like psfd_disable, then off -> disables mitigation and on -> enables it.
Or just rewriting this to off -> turns off predictive store forwarding is probably ok too.

Bandan

>
>> +
>>  	preempt=	[KNL]
>>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>>  			none - Limited to cond_resched() calls
>> 
>
> thanks.

