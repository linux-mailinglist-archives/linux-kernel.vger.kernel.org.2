Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3B04308B1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245658AbhJQMfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:35:07 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:43221 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbhJQMfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:35:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HXKCp5LM9z4xqV;
        Sun, 17 Oct 2021 23:32:54 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Kai Song <songkai01@inspur.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, oohall@gmail.com, dja@axtens.net,
        paulus@samba.org
In-Reply-To: <20211009041630.4135-1-songkai01@inspur.com>
References: <20211009041630.4135-1-songkai01@inspur.com>
Subject: Re: [PATCH] powerpc/eeh: Fix docstrings in eeh.c
Message-Id: <163447392810.1159469.11303329795231824264.b4-ty@ellerman.id.au>
Date:   Sun, 17 Oct 2021 23:32:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2021 12:16:30 +0800, Kai Song wrote:
> We fix the following warnings when building kernel with W=1:
> arch/powerpc/kernel/eeh.c:598: warning: Function parameter or member 'function' not described in 'eeh_pci_enable'
> arch/powerpc/kernel/eeh.c:774: warning: Function parameter or member 'edev' not described in 'eeh_set_dev_freset'
> arch/powerpc/kernel/eeh.c:774: warning: expecting prototype for eeh_set_pe_freset(). Prototype was for eeh_set_dev_freset() instead
> arch/powerpc/kernel/eeh.c:814: warning: Function parameter or member 'include_passed' not described in 'eeh_pe_reset_full'
> arch/powerpc/kernel/eeh.c:944: warning: Function parameter or member 'ops' not described in 'eeh_init'
> arch/powerpc/kernel/eeh.c:1451: warning: Function parameter or member 'include_passed' not described in 'eeh_pe_reset'
> arch/powerpc/kernel/eeh.c:1526: warning: Function parameter or member 'func' not described in 'eeh_pe_inject_err'
> arch/powerpc/kernel/eeh.c:1526: warning: Excess function parameter 'function' described in 'eeh_pe_inject_err'
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/eeh: Fix docstrings in eeh.c
      https://git.kernel.org/powerpc/c/b616230e2325e5560330c40172a4d4e4c5da2c59

cheers
