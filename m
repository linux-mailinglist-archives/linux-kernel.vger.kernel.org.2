Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261C643C84A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbhJ0LKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 07:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241585AbhJ0LKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:10:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15652C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 04:07:48 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1615002935f4cf24b5c3ba.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1500:2935:f4cf:24b5:c3ba])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61BF41EC0622;
        Wed, 27 Oct 2021 13:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635332866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6Y+JmosdGEZy7psgIzhDJuWc698Re6DNZxC8gUWoCcc=;
        b=ODVYNgY2+z1V2Uko1Ppus2CwrdsBaV5xwyblSlfkR1qNAJp7tmu99L3Nibmmqj5P91q2kW
        7qw0UWd/5td0EozwV75BLvGWvJQsb2eVEf+Pn01qQmrbQpTF3bLwz3+Sn9gPtV25oiZmPA
        qjatPEUicokmLbziSNTbX5Qhv2D6g44=
Date:   Wed, 27 Oct 2021 13:07:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/xstate: Make AVX512 status tracking more
 accurate
Message-ID: <YXky/qrRSvvhI3JN@zn.tnic>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211015204713.2855996-2-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211015204713.2855996-2-goldstein.w.n@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 03:47:17PM -0500, Noah Goldstein wrote:
> This patch splits the timestamps for tracking the AVX512 status into

For future submissions, please avoid having "This patch" or "This
commit" in the commit message. It is tautologically useless.

...

> @@ -1282,8 +1292,27 @@ static void avx512_status(struct seq_file *m, struct task_struct *task)
>  			delta = LONG_MAX;
>  		delta = jiffies_to_msecs(delta);
>  	}
> +	return delta;
> +}
>  
> -	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);

Regardless of whether I think this exposing of AVX512 usage is silly
or not, we do not break userspace by changing those strings which some
script or tool already probably relies upon.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
