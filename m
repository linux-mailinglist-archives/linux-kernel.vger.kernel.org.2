Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF345624B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhKRSZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhKRSZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:25:49 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5998C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:22:48 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id m15so6131593pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 10:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RxXagynv4ZtTxwDXTPjZYaISy3py26voDBtBw3aaQgQ=;
        b=OBlnJC4k1myvVeYu1NZFyNQ7qs/DclyrajXgQLwlwDdvyrZ1+s9GpJL+W34aT1uHku
         J9wZKd+02F7Er09DCXIA4DItiSZshXGnoeLLFc0LEv1itHvrGlrNwc86GwZ+//C5msRa
         QQXoaNdT+OSK2tLxMzOUcYsIV1YXz0/Nmu3cNVd2SO5kWEG6YrMHl8I0nbd9mg3BjspR
         NIo0GdtkntdAdN9EIj31GsTeZ5hB8HliqHEFc0AJ0e/ZfzHWSdsq8Gh9tPPV2zL4ofso
         VSK22FsK0SEiEcRe50ecyel1PB1xFbX31kTsaXpkN/sYQYsin8zVD07JdS1VXFcMUG7O
         t9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RxXagynv4ZtTxwDXTPjZYaISy3py26voDBtBw3aaQgQ=;
        b=vOABUM2hHcldLYD6w1pWLi3upXphMsjiwVvBi4z+2ZlDSsxv5EQoW9RfoshnqREf4o
         L7cWx3km8436U4t9s5+Ec5i0bezfJEZOYME65Bv3SLNJ9GsoUnNHkNAKbs69rVfSQHVC
         aGVavQpyzVNuo4cLSfv/7m00g767fAYrhU0yu91xcq4SjYPs0pzRf3xHQaIBAMcZ8xG9
         +njnpjjtTjedrAtWq2EiNBWbFZtoxlzRdVe5nbBgxk1f+ptzgjtJazJTmXZPu7vqWX9B
         naLwiv12/u/3LMuft72/fM1CYKYegYuUkgwzce9ADIB9J+Zh+12ou5FpyE72I/sb6YU8
         7Wfw==
X-Gm-Message-State: AOAM531hlMAVa0WCtxeKoc5pNlS1ST519Sgj8/SR2Tr0Ip71YKSOy2Ei
        BdaMd5ii57NW/GmXUetH/xiN1ztEKIXPJQ==
X-Google-Smtp-Source: ABdhPJyTh37LpHwXrN+6deoifsV0BNizkbqHIu8tIW6La8IWWgSK2j8DxntCks4HzMc3Ez+BucvBTw==
X-Received: by 2002:a63:6945:: with SMTP id e66mr12760455pgc.9.1637259768283;
        Thu, 18 Nov 2021 10:22:48 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i68sm264849pfc.158.2021.11.18.10.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:22:47 -0800 (PST)
Date:   Thu, 18 Nov 2021 18:22:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-kernel@vger.kernel.org, anup.patel@wdc.com,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Update Atish's email address
Message-ID: <YZaZ9KxEz+GVjH7q@google.com>
References: <20211118060501.932993-1-atishp@atishpatra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118060501.932993-1-atishp@atishpatra.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021, Atish Patra wrote:
> I no longer employed by western digital. Update my email address to
> personal one.
> 
> Signed-off-by: Atish Patra <atishp@atishpatra.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a2345ce8521..b22af4edcd08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10434,7 +10434,7 @@ F:	arch/powerpc/kvm/
>  
>  KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)
>  M:	Anup Patel <anup.patel@wdc.com>
> -R:	Atish Patra <atish.patra@wdc.com>
> +R:	Atish Patra <atishp@atishpatra.org>
>  L:	kvm@vger.kernel.org
>  L:	kvm-riscv@lists.infradead.org
>  L:	linux-riscv@lists.infradead.org
> -- 

Please add an entry in .mailmap as well.
