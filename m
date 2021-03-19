Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58063342420
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhCSSJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhCSSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:08:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7IMe3EI0F09CABp2BTZzKk4vCEjpzO2UA3Cr+FhKrno=; b=Fdulizs3yTlWagIoOyLAbUhEfL
        T2YJkORsM5rcfD56NPaOg6NW2ciReddg/RmIyTR9WD3bphmkTV0jM9Oec35bG8+D5BrvRVOzpYQIh
        l4OhSgt+lo5C2HbFsptfgwZcyEVNeEP3e/SZhMPuosQfK6PH5k0IZlV8iQ6qEzUrLonwXaMaDkM2L
        zFJQ9DLgCVQwzTImlmh1vAWqgZdspvCkMvWczjHjH/BIJVL/khGdAmiE7hUNFLzHlbtjGo6JIGs80
        VXkA0nLKVNBFsEJDgFTXcd/+KLsIiIUvWi1msjwQrdwvZtCmjVVRIv7gFFMjtQM04dRr3oxGzZPni
        TDvyMD7w==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJYM-001RgA-0Q; Fri, 19 Mar 2021 18:08:55 +0000
Date:   Fri, 19 Mar 2021 11:08:53 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     monstr@monstr.eu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] microblaze: Fix a typo
In-Reply-To: <20210319045323.21241-1-unixbhaskar@gmail.com>
Message-ID: <6dc64c0-3c3a-b0f1-58bf-0907c9aac9a@bombadil.infradead.org>
References: <20210319045323.21241-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_110854_068917_D7CB8815 
X-CRM114-Status: GOOD (  11.17  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > > s/storign/storing/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/storign/storing/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> arch/microblaze/lib/uaccess_old.S | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/microblaze/lib/uaccess_old.S b/arch/microblaze/lib/uaccess_old.S
> index 0e8cc2710c27..eca290090038 100644
> --- a/arch/microblaze/lib/uaccess_old.S
> +++ b/arch/microblaze/lib/uaccess_old.S
> @@ -188,7 +188,7 @@ w2:	sw	r4, r5, r3
> 	.text
>
> .align 4 /* Alignment is important to keep icache happy */
> -page:	/* Create room on stack and save registers for storign values */
> +page:	/* Create room on stack and save registers for storing values */
> 	addik   r1, r1, -40
> 	swi	r5, r1, 0
> 	swi	r6, r1, 4
> --
> 2.26.2
>
>
