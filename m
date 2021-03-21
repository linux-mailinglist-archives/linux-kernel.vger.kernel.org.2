Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EEB34353E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 22:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhCUV5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 17:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhCUV5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 17:57:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72954C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E3phNZz3FbYHtT/FEkxKlmaOuMB+SZr1iPpbaRd+TZg=; b=jV58Qg/CnlhIwAjB/jsgJbRoIw
        id+yiN3aYimfGv/YJBOAiBt7enjA3GtXe1Byhm7s6Ne7X24WQiM2AzdwCA7yopj9AP0OMj6zY7nKQ
        l/2hsDujRJaJwmIaWFGhFCGtXFXOR3ubB87ZSpgM2uRvxVzdHvcxwxnbDx9B1R7bqU6VCh3OVrpW8
        VSA/VWLcrwo7CBzMSQA9k55HQcllqaYbdoxptigK0w2APhbQHd7KzV9vzzQoS8GjNlUpSTTC/NcC6
        KXI4gycLqNGgmRu5yQJGdGoeUpjQD62VnQynzksLIssEsTCycywFZSRxclnEODwvV169KpgFqk27w
        XKgNSoIA==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lO64K-002WiZ-Lh; Sun, 21 Mar 2021 21:57:09 +0000
Date:   Sun, 21 Mar 2021 14:57:08 -0700 (PDT)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry: A typo fix
In-Reply-To: <20210321202253.1393665-1-unixbhaskar@gmail.com>
Message-ID: <bdbd8a75-8a48-f96e-a893-a8593ded79b5@infradead.org>
References: <20210321202253.1393665-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_145708_730729_914DC158 
X-CRM114-Status: GOOD (  11.61  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote: > > s/definitly/definitely/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/definitly/definitely/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> arch/x86/entry/entry_64.S | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 400908dff42e..0a7e9647e84a 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -511,7 +511,7 @@ SYM_CODE_START(\asmsym)
> 	/*
> 	 * No need to switch back to the IST stack. The current stack is either
> 	 * identical to the stack in the IRET frame or the VC fall-back stack,
> -	 * so it is definitly mapped even with PTI enabled.
> +	 * so it is definitely mapped even with PTI enabled.
> 	 */
> 	jmp	paranoid_exit
>
> --
> 2.31.0
>
>
