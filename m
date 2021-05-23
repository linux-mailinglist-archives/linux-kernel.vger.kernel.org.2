Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E0038DAEB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 12:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhEWKwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 06:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhEWKwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 06:52:43 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B130EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 03:51:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FnxwH754hz9sRN;
        Sun, 23 May 2021 20:51:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1621767072;
        bh=X4NtLMivf9OnS/Dpei3UYlbkelZal2VO/5jUSAl6Krs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=apJpFz3oTrM1TCz5/jKU78KvIO5bPBBdqh9BIizd3LavEzQu4aBuFN1AY17K7yWtc
         5Ys5HZuq4tIcylMjvwrjriWbEpER2Sh1fG26L4/w5A2HKxUgfU/yqB/wcYgw53sYaC
         creV/kfLL0JbdpstR0krx5/Qy+gTTKWvPem7Mls/87DAvzu4ZuTKSsDWnpryu4Ak+t
         CDrkcPA3iMnqUegZ1kx9QPdQBWUIlTBxpoR7qUiOmFg83BOm3OYgXJ9oAAVXtnHCJQ
         pI/FbKnQTyJZenWSJW3wW0JNbYTZXIhx2OT8lSdGeMDrLGVg01PyKZx6K1p2OBbjQI
         9oX9MN8EN8Y0w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org
Subject: Re: [PATCH] powerpc/udbg_hvc: retry putc on -EAGAIN
In-Reply-To: <YKer6KPaHDgaWS8k@kroah.com>
References: <20210514214422.3019105-1-nathanl@linux.ibm.com>
 <YKer6KPaHDgaWS8k@kroah.com>
Date:   Sun, 23 May 2021 20:51:09 +1000
Message-ID: <87mtsliuzm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:
> On Fri, May 14, 2021 at 04:44:22PM -0500, Nathan Lynch wrote:
>> hvterm_raw_put_chars() calls hvc_put_chars(), which may return -EAGAIN
>> when the underlying hcall returns a "busy" status, but udbg_hvc_putc()
>> doesn't handle this. When using xmon on a PowerVM guest, this can
>> result in incomplete or garbled output when printing relatively large
>> amounts of data quickly, such as when dumping the kernel log buffer.
>> 
>> Call again on -EAGAIN.
>> 
>> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
>> ---
>>  drivers/tty/hvc/hvc_vio.c | 2 +-
>
> Subject line does not match up with this file name.
>
> Don't you want "tty" and "hvc" in there somewhere?

It's a powerpc only driver, but I guess the subject should still be
"tty: hvc: ..." to match convention.

I was planning to take this via the powerpc tree, but I can drop it if
you'd rather take it.

cheers
