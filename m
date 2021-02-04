Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C682230EE8B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbhBDIeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:34:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234935AbhBDIeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612427558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5a/vTcjLzOjEP+uctbeny3ZIbf8QS7zvppeT9pC6J4=;
        b=MM4LH8YdOehSsheed4/fYyuQtmaDZ9Taz/g9azei0b3vUSBx9UnFJLvnfkYMFOAkaAp+bC
        1x0AYlegAkJBYcrQdSRaafuoHnQFdUpvjPpNtWZyyQYN7VpDe6+I330UnHeQPL4hRRAEUj
        n6/W4KVtU4EaMxVtjNuuWvphdrMjgAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-JJJZ8yjsN9yydDpelZ4wdg-1; Thu, 04 Feb 2021 03:32:36 -0500
X-MC-Unique: JJJZ8yjsN9yydDpelZ4wdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C5C3192CC4C;
        Thu,  4 Feb 2021 08:32:35 +0000 (UTC)
Received: from gondolin (ovpn-113-130.ams2.redhat.com [10.36.113.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFC5010013C1;
        Thu,  4 Feb 2021 08:32:29 +0000 (UTC)
Date:   Thu, 4 Feb 2021 09:32:27 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <borntraeger@de.ibm.com>,
        <frankja@linux.ibm.com>, <david@redhat.com>,
        <imbrenda@linux.ibm.com>, <hca@linux.ibm.com>, <gor@linux.ibm.com>
Subject: Re: [PATCH -next] KVM: s390: Return the correct errno code
Message-ID: <20210204093227.3f088c8a.cohuck@redhat.com>
In-Reply-To: <20210204080523.18943-1-zhengyongjun3@huawei.com>
References: <20210204080523.18943-1-zhengyongjun3@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 16:05:23 +0800
Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> When valloc failed, should return ENOMEM rather than ENOBUF.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  arch/s390/kvm/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2f177298c663..6b7acc27cfa2 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2252,7 +2252,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
>  	 */
>  	buf = vzalloc(len);
>  	if (!buf)
> -		return -ENOBUFS;
> +		return -ENOMEM;
>  
>  	max_irqs = len / sizeof(struct kvm_s390_irq);
>  

This breaks a user space interface (see the comment right above the
vzalloc).

