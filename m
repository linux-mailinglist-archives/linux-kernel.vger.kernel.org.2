Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EFE381990
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhEOPbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 11:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232483AbhEOPbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 11:31:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 136E1611C9;
        Sat, 15 May 2021 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621092622;
        bh=GvpOdLUN0BGGVqLx+hc71U4t5c+VkOe8e4mFWqfjXQ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZQxYSeTYPcDcDgDbt7aoO9YAZtoRFRxwwL5RnbAwsSYdvG83qx0XtFKiFvsxB9pXi
         utt2eD4j8xvKeNhtxF6CE17aBwwLrtRaY3KGjOmkJpzcqVlASBSDGfPNjhGwu1lsag
         yy2EWc3hhODxf797rScxP+9IkifgA+u9LC0VplxgUImQyvKp/KbCfWr9+KCOIbg1Qv
         0j+tFIeLesu6Oiw25XC+ziv8t35QnUL+pizzCSYiWehiRgnIUm+Hk/Fl8pUV9Y8Ctf
         RLXoBEBGjeAMGvLAYF6acv3XA5zkwDZRUDr4lYcVN0Lp/jkSm4yn180OXPP3vScs+8
         7l7yV4cC6HjdA==
Subject: Re: [PATCH v2 6/9] x86/kexec: set_[gi]dt() ->
 native_[gi]dt_invalidate() in machine_kexec_*.c
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210515014400.2999028-1-hpa@zytor.com>
 <20210515014400.2999028-7-hpa@zytor.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <e30d9d16-de3f-0c72-6404-e94399e08697@kernel.org>
Date:   Sat, 15 May 2021 08:30:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515014400.2999028-7-hpa@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 6:43 PM, H. Peter Anvin wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> These files contain private set_gdt() functions which are only used to
> invalid the gdt; machine_kexec_64.c also contains a set_idt()
> function to invalidate the idt.
> 
> phys_to_virt(0) *really* doesn't make any sense for creating an
> invalid GDT. A NULL pointer (virtual 0) makes a lot more sense;
> although neither will allow any actual memory reference, a NULL
> pointer stands out more.
> 
> Replace these calls with native_[gi]dt_invalidate().
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>

Acked-by: Andy Lutomirski <luto@kernel.org>
