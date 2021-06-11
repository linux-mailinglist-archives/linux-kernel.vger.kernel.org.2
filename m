Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D329A3A4A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFKUu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:50:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54156 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhFKUu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:50:27 -0400
Received: from zn.tnic (p200300ec2f0aec004052742802382cb1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ec00:4052:7428:238:2cb1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11F781EC04EE;
        Fri, 11 Jun 2021 22:48:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623444508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QytOtGP2BPNNHSfxPk0iwWUtgIu5mGV4N0LcsVjdyWA=;
        b=YA6T2jO4bGb57vJqIqfrAkWyC8ADH/oGQ/h6plM7nsOApE9H35vgMrEsSuDAlfc1nC85E3
        G6AFANu5HhhMQkD0KQNdfHtCeNBeVOCky1uudqyNS7APD830G03ZkpNemYg9VVA8OFFhK5
        eg7iX7Y5szl6zwYtDb5lKZS1dVyohZA=
Date:   Fri, 11 Jun 2021 22:48:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:tip] BUILD SUCCESS 3a1176a9af5a1b7d7a0a40b0975412008eb221c3
Message-ID: <YMPMFUsmj0F8btKc@zn.tnic>
References: <60c3c723.X+QEHxMuTiZ6Pqj9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60c3c723.X+QEHxMuTiZ6Pqj9%lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 04:27:15AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tip
> branch HEAD: 3a1176a9af5a1b7d7a0a40b0975412008eb221c3  auto-x86-next: Rename x86/seves to x86/sev

0day folks:

if you have a way to exclude the 0day bot from testing some branches,
this branch is one of them as it doesn't get code but only tip internal
tracking changes and thus doesn't need to get tested by you so that you
can save some infra for the real branches.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
