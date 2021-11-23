Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6757445A0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhKWLLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234587AbhKWLLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637665677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dq8tkyF7e1BIoHYWJ4eMRxNL9buH6P7iaJgt9bYs6Ok=;
        b=KD8ujFYB60ts7h1y78qe5zlL/iSYKIoIjuMgPAbwBClkBgURnoCF48gdAGjr9bBarcu++O
        EgbQ1pHvE78/HWmOFwRwysy3NeQEU27a6QIoXbpdyrIbmogOQ1aFfd8yYOqsLU+OOfXNgV
        qIrBxH5n4Jc7Pt6mFEGU6kwjJuiKpDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-v80Nb0rBOPykJELYuJqx6g-1; Tue, 23 Nov 2021 06:07:54 -0500
X-MC-Unique: v80Nb0rBOPykJELYuJqx6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD42102CB76;
        Tue, 23 Nov 2021 11:07:53 +0000 (UTC)
Received: from localhost (ovpn-13-79.pek2.redhat.com [10.72.13.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 734285B826;
        Tue, 23 Nov 2021 11:07:45 +0000 (UTC)
Date:   Tue, 23 Nov 2021 19:07:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        vgoyal@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: update kdump maintainers
Message-ID: <20211123110743.GJ21646@MiWiFi-R3L-srv>
References: <YZyKilzKFsWJYdgn@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZyKilzKFsWJYdgn@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 11/23/21 at 02:30pm, Dave Young wrote:
> Remove myself from kdump maintainers as I have no enough time to
> maintain it now. But I can review patches on demand though.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  MAINTAINERS |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-x86/MAINTAINERS
> ===================================================================
> --- linux-x86.orig/MAINTAINERS
> +++ linux-x86/MAINTAINERS
> @@ -10122,9 +10122,9 @@ F:	lib/Kconfig.kcsan
>  F:	scripts/Makefile.kcsan
>  
>  KDUMP
> -M:	Dave Young <dyoung@redhat.com>
>  M:	Baoquan He <bhe@redhat.com>
>  R:	Vivek Goyal <vgoyal@redhat.com>
> +R:	Dave Young <dyoung@redhat.com>

Thanks for the great work on reviewing kexec/kdump related patches, bug
fixing and improvement on kdump.

Acked-by: Baoquan He <bhe@redhat.com>

>  L:	kexec@lists.infradead.org
>  S:	Maintained
>  W:	http://lse.sourceforge.net/kdump/
> 

