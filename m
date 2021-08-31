Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2560F3FC97F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhHaOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhHaOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:16:46 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DACC061575;
        Tue, 31 Aug 2021 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=IwVDVSRkq1mFvqFDRXC6n97YzWiMMq7IqL+KsJFCFj8=; b=K470W4XhRu+mM5sEymp8eI9GN1
        xU8xY5adCX3qk2QPAAfWhccgmlxGztHB60LYsV170iclqt4THGE88flMwvp2s0oQAMRGlpcb2mATm
        91mJHXW7mXL/mgzTM3J7EEVTEeldbYqoBTS2JnLdC0eQk4WvFDAndl6X1JQ8VEiX6rYK+k+yPJZes
        HAea/iKXN7+Zaz7/jCCn29S/OtDxPpaQRVgeBglS48+smmkjOou7zIvEoU0oTbgDvjo5eiw1m7W8y
        QTUWOsMmUXv4vyfzORGOhO0Vormeehtjkcz7Ux0CVEggRApV9nXVdURPzHBzybiigSPHao/qFRoq3
        2L8Bb/Ew==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL4YI-002Wks-Bb; Tue, 31 Aug 2021 14:15:50 +0000
Subject: Re: [PATCH RESEND v3] Trivial comment fix for the CRC ITU-T polynom
To:     Roger Knecht <roger@norberthealth.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jiri Kosina <trivial@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210831130702.31526-1-roger@norberthealth.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ba219b5-0a9d-610e-0670-232e5d3d4ad3@infradead.org>
Date:   Tue, 31 Aug 2021 07:15:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831130702.31526-1-roger@norberthealth.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/21 6:07 AM, Roger Knecht wrote:
> This patch fixes a small typo in the CRC ITU-T polynom documentation.
> 
> The code comment says that the polynom is x^16 + x^12 + x^15 + 1, but the
> correct polynom is x^16 + x^12 + x^5 + 1.
> 
> Quote from page 2 in the ITU-T V.41 specification:
>    "2 Encoding and checking process
> 
>    The service bits and information bits, taken in conjunction, correspond
>    to the coefficients of a message polynomial having terms from x^(n-1)
>    (n = total number of bits in a block or sequence) down to x^16. This
>    polynomial is divided, modulo 2, by the generating polynomial
>    x^16 + x^12 + x^5 + 1. [...]"
> 
> Source: https://www.itu.int/rec/T-REC-V.41-198811-I/en
> 
> The hex polynom 0x1021 and CRC code implementation are correct.
> 
> Signed-off-by: Roger Knecht <roger@norberthealth.com>
> ---
> Changes for the resend:
>    - Moved "changes and thanks" out of the commit message.
> 
> Thanks,
> Roger
> 
>   include/linux/crc-itu-t.h | 2 +-
>   lib/crc-itu-t.c           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/crc-itu-t.h b/include/linux/crc-itu-t.h
> index a4367051e192..2f991a427ade 100644
> --- a/include/linux/crc-itu-t.h
> +++ b/include/linux/crc-itu-t.h
> @@ -4,7 +4,7 @@
>    *
>    * Implements the standard CRC ITU-T V.41:
>    *   Width 16
> - *   Poly  0x1021 (x^16 + x^12 + x^15 + 1)
> + *   Poly  0x1021 (x^16 + x^12 + x^5 + 1)
>    *   Init  0
>    */
>   
> diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
> index 1974b355c148..56e6e0d63d1e 100644
> --- a/lib/crc-itu-t.c
> +++ b/lib/crc-itu-t.c
> @@ -7,7 +7,7 @@
>   #include <linux/module.h>
>   #include <linux/crc-itu-t.h>
>   
> -/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^15 + 1) */
> +/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^5 + 1) */
>   const u16 crc_itu_t_table[256] = {
>   	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
>   	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,


I should have noticed this earlier:

Please change the /** to a simple /*.
/** means "beginning of kernel-doc comment" and this is not
a kernel-doc comment.

Thanks.

-- 
~Randy

