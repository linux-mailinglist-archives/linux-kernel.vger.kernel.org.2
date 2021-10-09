Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CCB42780A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 10:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhJIIQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 04:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJIIQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 04:16:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE0C061570;
        Sat,  9 Oct 2021 01:14:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1e220071dfbf03a8036444.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:2200:71df:bf03:a803:6444])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE4A01EC047E;
        Sat,  9 Oct 2021 10:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633767294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ii9ilVFrFzBPrdZEAvTPG+KbkptRtNK53pyEhnOp3/s=;
        b=Gx5t0ey7vR5N7gh/pkOoX+pBgbX3eETX1ggEKMqLshfUH6RgiY3ye0k8VnpRcslSsmmK63
        DEeDd+arU6JLmpgphJppvFqOJcr7+QvsofUDM4ut3xb5pTxgiPqh+N7Cudco0y//wxpl4S
        4tgrTZVKaazE2iYQw/T0U6yc5Ee/V3o=
Date:   Sat, 9 Oct 2021 10:14:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: Re: [Bug 214453] New: skl_int3472_unregister_clock: kernel NULL
 pointer dereference (HP Elite x2 1013 G3)
Message-ID: <YWFPe8yeiYYeYPWy@zn.tnic>
References: <bug-214453-6385@https.bugzilla.kernel.org/>
 <YVsy5Gv3z6JAWnxj@zn.tnic>
 <035a956e-9987-9b26-38a5-8319f69d4b6d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <035a956e-9987-9b26-38a5-8319f69d4b6d@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 11:18:50PM +0100, Daniel Scally wrote:
> I can patch this - but do I need to do to show that the patch is for
> that specific bug report or anything?

What we do in such cases, usually, is add

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214453

to the commit message, under the SOB chain.

Also, you probably also should give in a Fixes: tag the commit ID of the
patch your fix is for, so that your fix gets automatically backported to
stable.

I.e.:

Fixes: 12-char-sha1-abbrev ("Commit title")
Cc: <stable@vger.kernel.org>

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
