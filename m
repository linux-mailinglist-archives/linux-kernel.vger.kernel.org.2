Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826043F1D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbhHSP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238753AbhHSPz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629388521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pmp4Kw5okIF5wwBbrjrJBs+O1tcqAHxdEgDPFxbvKOQ=;
        b=Hq6mlylSKbjn4oPTOjyHNmeH2gB5jNcHZynbhJ+MhkUTbOjHset8vPUW+0YPmMEmDUzLTd
        3iU2b5aYzrRpvdBewnTLncnnFNB8fHlgVZXUTlq5KzXfZMYbEq9DX4zkp13pNdvXG4CxVI
        jJmxtCdgyGENCeGnnlaw9hXgmeqkRkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-7RTWZI9gOJCZx4QlD894jA-1; Thu, 19 Aug 2021 11:55:20 -0400
X-MC-Unique: 7RTWZI9gOJCZx4QlD894jA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E6A087D573;
        Thu, 19 Aug 2021 15:55:19 +0000 (UTC)
Received: from redhat.com (unknown [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7AF3421F;
        Thu, 19 Aug 2021 15:55:11 +0000 (UTC)
Date:   Thu, 19 Aug 2021 10:55:09 -0500
From:   David Teigland <teigland@redhat.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] fs: dlm: possible ABBA deadlock
Message-ID: <20210819155509.GB21218@redhat.com>
References: <79f8d302-f53f-3891-965a-bcb460ab15ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79f8d302-f53f-3891-965a-bcb460ab15ca@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 04:54:57PM +0800, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports a possible ABBA deadlock in the dlm
> filesystem in Linux 5.10:
> 
> dlm_recover_waiters_pre()
>   mutex_lock(&ls->ls_waiters_mutex); --> line 5130
>   recover_convert_waiter()
>     _receive_convert_reply()
>       lock_rsb()
>         mutex_lock(&r->res_mutex); --> line 69
> 
> dlm_recover_waiters_post()
>   lock_rsb()
>     mutex_lock(&r->res_mutex); --> line 69
>   mutex_lock(&ls->ls_waiters_mutex); --> line 5307
> 
> When dlm_recover_waiters_pre() and dlm_recover_waiters_post() are
> concurrently executed, the deadlock can occur.
> 
> I am not quite sure whether this possible deadlock is real and how to fix it
> if it is real.
> Any feedback would be appreciated, thanks :)

They won't be concurrent, "pre" runs before recovery, and "post" is after.
Dave

