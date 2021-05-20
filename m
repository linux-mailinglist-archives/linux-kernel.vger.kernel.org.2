Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ACC38B995
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 00:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhETWrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 18:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhETWrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 18:47:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B0DC061574;
        Thu, 20 May 2021 15:45:54 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0eb60071b6495ff2b71657.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:b600:71b6:495f:f2b7:1657])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84EE61EC05E9;
        Fri, 21 May 2021 00:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621550751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NAlC17I1QLLqZNWQkB5/U/VVLYiz8jUlAs0PyUzF62o=;
        b=g6siJU/Z5+8b7f6cMoE5ZW6+lVSzLZ794gGVuZla6mhB0e2gLouDEHOG/Kgq+ZJ7VN7QPL
        fclelvGwcQQxyNaLxSy0Xa0M5ywZqtRicKl/ILVzzN0xd2HefFWOFuwvF662viPARuFPnJ
        p1hILeZzGq4UgoV3kT/9v9to/0QMeOg=
Date:   Fri, 21 May 2021 00:45:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Huang <wei.huang2@amd.com>
Cc:     David Bartley <andareed@gmail.com>, linux-kernel@vger.kernel.org,
        linux-x86_64@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: add AMD family 19h model 50h PCI ids
Message-ID: <YKbmmNKiwDQ7wRl7@zn.tnic>
References: <20210520174130.94954-1-andareed@gmail.com>
 <b6be3a80-df49-70ec-a3dc-e621b1e1a8c2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6be3a80-df49-70ec-a3dc-e621b1e1a8c2@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 04:36:09PM -0500, Wei Huang wrote:
> According to the specification, these IDs look correct to me. I also found
> them on two real machines.

Wei, I'm assuming that's an ACK?

> On 5/20/21 12:41 PM, David Bartley wrote:
> > This is required to support Zen3 APUs in k10temp.
> > 
> > Signed-off-by: David Bartley <andareed@gmail.com>

Btw, David, for the future, pls run your patches through

./scripts/get_maintainer.pl

so that you get a list of people and mailing lists to CC - otherwise it
likely will get missed.

This one I managed to fish out from the lkml firehose, by chance. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
