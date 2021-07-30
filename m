Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2DB3DB05A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 02:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhG3AiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 20:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhG3AiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:38:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 218686023F;
        Fri, 30 Jul 2021 00:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627605493;
        bh=DfX+ZxhlbuWNGwOZXy813T+ILOgGiQVjjFJs6GFI8mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8iV6OnGNWg7mvwqMnLsh+kFbJAuEXcV7Z1rTyp0HoEsQOusUPpuZ3mVUCcMy2f9g
         y3ykpNThaPAhysCwLi4FqiP16IMerYtgZ5efkXYii0NiLpfpiLZVoNj+vy+Iw18e6s
         Y+s6RqFTJLEritohM1PSotIF7CCohDcf6Tcvvwk3NCzqN8BBMtFxPrZWocIIF8pUWd
         M5w5DSXFpbIz30AAOl2VIQM3W4sf/ts435xablmekuGfC9hPUl/44DjckCMF8h6n+J
         vIRFfiLW8tlgN94w31gSvYJUNXZ1ieI/m9hDkG1YSN4Jw5rRk2u0p2ivfN4o/OLzo5
         //ECdlEPn6V6A==
Date:   Fri, 30 Jul 2021 03:38:09 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Message-ID: <20210730003809.hp3nmqmgyysa45nz@kernel.org>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-3-tony.luck@intel.com>
 <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 03:19:46PM -0700, Dave Hansen wrote:
> On 7/28/21 1:46 PM, Tony Luck wrote:
> > Export a function sgx_is_epc_page() that simply reports whether an
> > address is an EPC page for use elsewhere in the kernel.
> 
> It would be really nice to mention why this needs to be exported to
> modules.  I assume it's the error injection driver or something that can
> be built as a module, but this export was a surprise when I saw it.
> 
> It's probably also worth noting that this is a sloooooooow
> implementation compared to the core VM code that does something
> analogous: pfn_to_page().  It's fine for error handling, but we should
> probably have a comment to this effect so that more liberal use doesn't
> creep in anywhere.

You could also create an xarray to track physical EPC address ranges,
and make the query fast.

/Jarkko
