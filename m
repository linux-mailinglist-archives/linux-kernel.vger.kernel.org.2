Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142BF4480FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbhKHOL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:11:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47678 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238838AbhKHOLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:11:55 -0500
Received: from zn.tnic (p200300ec2f33110093973d8dfcf40fd9.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:9397:3d8d:fcf4:fd9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EABCC1EC01FC;
        Mon,  8 Nov 2021 15:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636380550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=afTIKYf1mOVjf2en+sa+/dA5gZljLEsuW+H25HdsaEo=;
        b=PToB6GqDvuo8AkGnFC5fFetj2cDCUpLX8LVQFtaR7g1+SXbDZ1Obz/JUjvsIRvLbss8LuN
        crLYPD9I1wW5t4XGaY7WJK9kO5q6CnWI7ovaKXHqoupzkIwgss0Q6txDqvYTgXLDhcKWQk
        7B+7SsxyzSzlvpQd0fsunpKiQpXh3f0=
Date:   Mon, 8 Nov 2021 15:09:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v0 16/42] USB: Check notifier registration return value
Message-ID: <YYkvgFW07CPRrBPn@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-17-bp@alien8.de>
 <20211108140553.GA1666297@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211108140553.GA1666297@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 09:05:53AM -0500, Alan Stern wrote:
> This is a rather misleading description.  The patch does exactly the 
> opposite: It _adds_ a homegrown notifier registration check.  (Homegrown 
> in the sense that the check is made by the individual caller rather than 
> being centralized in the routine being called.)

See the 0th message - there is a link to another example of what I mean
with "homegrown" but I see your point.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
