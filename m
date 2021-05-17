Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E8838274F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbhEQIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbhEQIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:46:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE35C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:45:09 -0700 (PDT)
Received: from zn.tnic (p200300ec2f061b00f416f01ed532e4bf.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:1b00:f416:f01e:d532:e4bf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C8D211EC0345;
        Mon, 17 May 2021 10:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621241105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XT1VDWp+32xfBKa+NxSvVUNJdTSwHiQt0pKtZlWF3Fo=;
        b=d86DH9BA1D5hKYz4TGaXAEu9X9otE1AwGMoowBVFIjgaMq00StL+jcMx4/qnidJVV9KNhT
        R0EiPEh1KkqP1ywZ2e3+g4Y4EEh3z730jfT54rJHWvIaWWRrBVuzD6JNUVSbhoej9Sz+tQ
        PdQc2GDY5dxZIN9sqwkO5b6g0N7ypgs=
Date:   Mon, 17 May 2021 10:44:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [5.13-rc1][bug] often hangs for no reason
Message-ID: <YKItC18evdS7efii@zn.tnic>
References: <CABXGCsMA4grweMDnN7_4jepk0w8hBbynMFfHUJv-PrM9STyZUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXGCsMA4grweMDnN7_4jepk0w8hBbynMFfHUJv-PrM9STyZUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 03:27:23AM +0500, Mikhail Gavrilov wrote:
> Hi folks.
> 5.13-rc1 after 5.13-rc0 is a disaster because it hangs and hangs again
> after reboot.
> All hang's have in common is that they all happens in
> smp_call_function_many_cond function (I compared all trace [1], [2],
> [3], [4], [5])
> I do not know if this is a known problem or not, so I'm reporting here.

Looks like some splat, lockdep probably, in amdgpu when it gets loaded.
Maybe locking's botched although the beginning of the splats is missing
for whatever reason...

Adding them to Cc in case they have a better idea.

> Full logs here:
> [1] https://pastebin.com/u7SkKGDT
> [2] https://pastebin.com/fNae4dSL
> [3] https://pastebin.com/jEDMjQDy
> [4] https://pastebin.com/vEMhWGgE
> [5] https://pastebin.com/fvWx5ctR
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
