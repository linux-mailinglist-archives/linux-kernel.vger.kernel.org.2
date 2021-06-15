Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B73A8101
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhFONnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231664AbhFONnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:43:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE7FF61433;
        Tue, 15 Jun 2021 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623764466;
        bh=AmuY6XD93X0kTalsW/ktIsUgGaB7gMa/K3RM1ePXtkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYzFtT3KnyoPmfW+TmI2uQX9IiuXWK9CcJPOirhiZW9JVyPUSaXlaalpKYKzqYn3/
         Tder3II8QhY1R/j7mXF4Ro0AWES0Ln1RrAZwezoweQSq+HESxVvomJSNh7Pv/sn0Vu
         9DUG46+AUVXI9EFLqva38G6U3m8N6+K25nEeXMYjeshRSqR7agi4iND/sGpiAx87dV
         MI4EAH5cjgkbqqNLXRI+D5/XJcL+mIRuA44aHFX//kejY7qtIZg2OIY7vY8q4H3Uog
         leHERmJ+AEFfxST4ubCCFcfuelZDgvddIxImjSpzYZoMkfXZjZ4h7QyaTMbwChM2AH
         NQcUB4O1Ig0lg==
Date:   Tue, 15 Jun 2021 15:41:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
Message-ID: <YMit7PZwiB87ig2u@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
References: <20210611093959.821525-1-npiggin@gmail.com>
 <20210611093959.821525-2-npiggin@gmail.com>
 <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <1623722110.amu32mwaqs.astroid@bobo.none>
 <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <20210615125057.GF5077@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210615125057.GF5077@gate.crashing.org>
X-OS:   Linux p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de
 5.12.9-1-default x86_64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Segher Boessenkool [15/06/21 07:50 -0500]:
>On Tue, Jun 15, 2021 at 02:17:40PM +0200, Jessica Yu wrote:
>> +int __weak elf_check_module_arch(Elf_Ehdr *hdr)
>> +{
>> +       return 1;
>> +}
>
>But is this a good idea?  It isn't useful to be able to attempt to load
>a module not compiled for your architecture, and it increases the attack
>surface tremendously.  These checks are one of the few things that can
>*not* be weak symbols, imo.

Hm, could you please elaborate a bit more? This patchset is adding
extra Elf header checks specifically for powerpc, and the module
loader usually provides arch-specific hooks via weak symbols. We are
just providing an new hook here, which should act as a no-op if it
isn't used.

So if an architecture wants to provide extra header checks, it can do
so by overriding the new weak symbol. Otherwise, the weak function acts as
a noop. We also already have the existing elf_check_arch() check for each
arch and that is *not* a weak symbol.
