Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897B633F9D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhCQUPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhCQUPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:15:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE3C06174A;
        Wed, 17 Mar 2021 13:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ru69haEibh+ffOzYRRKW+Sr7WwY3YK8dW6vGs4l/0Bw=; b=ck6KxvHyEjihgIqcU1jqf5YnMM
        eI7A9pxY9VB2OIsXOSfPhQ/Y1dY68LofspY2ArCRMEyvgGM5Kyl46VMwI6iTT3zlnNgBnVoRDIR3x
        59mEN2NPT6MdGteHu2OlbTG68MDJKH4ZHX/NhrmXVmfV3O+2USNVesXB3QbqJiYf/exmMcZvLP1Q0
        bnWciV0b/On5jPj6S7MIve8sdpQP0Iu0/ON0pol9xGTlqRJHohW6jJcPVCZPgU08/SUHi06q8Iv2w
        p30uAuTkLdYmXumDHfBvEDmbSXRRUqFdd3LNSAtn1L7hMiUG1xZycuJNXBG8M5H2fMjIYswKyuEnF
        M1kkttXA==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMcZM-001gYT-Ry; Wed, 17 Mar 2021 20:15:06 +0000
Subject: Re: [PATCH V3] parisc: math-emu: Few spelling fixes in the file fpu.h
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317192427.2050913-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d0f09036-b493-ac22-8986-92116496188f@infradead.org>
Date:   Wed, 17 Mar 2021 13:15:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317192427.2050913-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 12:24 PM, Bhaskar Chowdhury wrote:
> 
> s/synopis/synopsis/
> s/differeniate/differentiate/
> s/differeniation/differentiation/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

although you should be modifying the Subject: order so that the filename
is not near the end...

> ---
>   Changes from V2:
>   Incorporated the changes suggested by Randy
> 
>  arch/parisc/math-emu/fpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/parisc/math-emu/fpu.h b/arch/parisc/math-emu/fpu.h
> index 853c19c03828..ea1c8c3539c6 100644
> --- a/arch/parisc/math-emu/fpu.h
> +++ b/arch/parisc/math-emu/fpu.h
> @@ -12,7 +12,7 @@
>   *      @(#)	pa/fp/fpu.h		$Revision: 1.1 $
>   *
>   *  Purpose:
> - *      <<please update with a synopis of the functionality provided by this file>>
> + *      <<please update with a synopsis of the functionality provided by this file>>
>   *
>   *
>   * END_DESC
> @@ -50,9 +50,9 @@
>  #define EMULATION_VERSION 4
> 
>  /*
> - * The only was to differeniate between TIMEX and ROLEX (or PCX-S and PCX-T)
> - * is thorough the potential type field from the PDC_MODEL call.  The
> - * following flags are used at assist this differeniation.
> + * The only way to differentiate between TIMEX and ROLEX (or PCX-S and PCX-T)
> + * is through the potential type field from the PDC_MODEL call.  The
> + * following flags are used to assist this differentiation.
>   */
> 
>  #define ROLEX_POTENTIAL_KEY_FLAGS	PDC_MODEL_CPU_KEY_WORD_TO_IO
> --


-- 
~Randy

