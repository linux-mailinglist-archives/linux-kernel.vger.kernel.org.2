Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DEF3A2595
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhFJHhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:37:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BA7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 00:35:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0cf6009da33271b50981fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f600:9da3:3271:b509:81fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 788D51EC05B0;
        Thu, 10 Jun 2021 09:35:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623310555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d1f5FabAps5EXKGAcxmRXWc+4yZjb0sbpXrvuTAR54o=;
        b=GU3TrUtENkomGTUjovlUNoxbtpUSDk4XFoecTM+Y/gUNUemzP5gl/gq8zDYhcHG411Kkgg
        jDCGKRHKFSVtZY/H6lMFWl68q1NeH9CIsYoV0t/Hvv04ba+E10cKkU+EdmdGwpv7shGtLf
        CTDFIG5vhBW5bve671F2+TvHpZZhe6Q=
Date:   Thu, 10 Jun 2021 09:35:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, jroedel@suse.de, trix@redhat.com,
        brijesh.singh@amd.com, rostedt@goodmis.org,
        ying-tsun.huang@amd.com, linux-kernel@vger.kernel.org,
        weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -next] x86/mm/mtrr: fix doc warnings in generic.c
Message-ID: <YMHA1IFHVPHfNC2D@zn.tnic>
References: <20210605064821.694432-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210605064821.694432-1-libaokun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 02:48:21PM +0800, Baokun Li wrote:
> @@ -104,7 +104,8 @@ static int check_type_overlap(u8 *prev, u8 *curr)
>  
>  /**
>   * mtrr_type_lookup_fixed - look up memory type in MTRR fixed entries
> - *
> + * @start: Start addaress.

addaress?

Spellchecker?

> + * @end: End address.
>   * Return the MTRR fixed memory type of 'start'.
>   *
>   * MTRR fixed entries are divided into the following ways:
> @@ -143,7 +144,11 @@ static u8 mtrr_type_lookup_fixed(u64 start, u64 end)
>  
>  /**
>   * mtrr_type_lookup_variable - look up memory type in MTRR variable entries
> - *
> + * @start: Start addaress.

addaress?

Spellchecker?

> + * @end: End address.
> + * @partial_end: Partial end address.
> + * @repeat: Memory is repeat or not.
> + * @uniform: Memory is uniform or not.

Did you actually read that whole comment to see that maybe "repeat" and
"uniform" are explained a bit further down or are you blindly "fixing"
warnings just so that the tool shuts up?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
