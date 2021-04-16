Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAED0361DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhDPJoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235027AbhDPJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618566218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0tOmO2L7ffsG3OHqCgxG9Ex0uvhoWJPoKZqPNeCsosE=;
        b=jO+0+x0s/trfIV/AT2c4dCt2XPdJSQGVix+HgC+/skfCJcXcgm9nWtp1Ga45GtmZk9wogY
        BKuWZuwJhmwABoQyt9ZBcwN2tvfczQGe58rXyyI/aTwWQKSjv6N5e/tUnlpMEc2x86gkkf
        UYkDerx8g2FX2g6ztQ1rB0+X7QKk0H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-NQK4CrDJPaWKXSaDjWc14A-1; Fri, 16 Apr 2021 05:43:36 -0400
X-MC-Unique: NQK4CrDJPaWKXSaDjWc14A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1596DCC624;
        Fri, 16 Apr 2021 09:43:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA49169FA4;
        Fri, 16 Apr 2021 09:43:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 16 Apr 2021 11:43:34 +0200 (CEST)
Date:   Fri, 16 Apr 2021 11:43:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: syscall.h: Add sign extension handling in
 syscall_get_return_value for compat
Message-ID: <20210416094324.GA1962@redhat.com>
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416075533.7720-2-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416075533.7720-2-zhe.he@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16, He Zhe wrote:
>
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -44,7 +44,12 @@ static inline long syscall_get_error(struct task_struct *task,
>  static inline long syscall_get_return_value(struct task_struct *task,
>  					    struct pt_regs *regs)
>  {
> -	return regs->regs[0];
> +	long val = regs->regs[0];
> +
> +	if (is_compat_thread(task_thread_info(task)))
> +		val = sign_extend64(val, 31);
> +
> +	return val;
>  }

I can't really review these arm-specific patches, but with this change both
syscall_get_error() and is_syscall_success() can use syscall_get_return_value()
to avoid the code duplication.

Oleg.

