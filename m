Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4A3DD247
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhHBIvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 04:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhHBIvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 04:51:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A10A7600D4;
        Mon,  2 Aug 2021 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627894274;
        bh=JkMPHRlRiWbcXYKwPv+E6sp/LJ9D9Stb3/dNTCbdr6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/r+6hxwGSkiajYaL9VBF4WXnaAaGL6PV/cWHDUU8n+DVB0g+6tom3DuPa3KsuP9j
         LS4qu0pXpISAHWwnB4X8npGchkwNqDth7Ux0ggH0L320hh4Pqykisu5aeJx9E0QHg1
         fdtpO3bLjOlVhLGWoVQeSKOxu//YtCgCXGigiLnErD8FmuGTWI2uP7omPwDZJSGuRG
         fzhQMpe4dUCqmRR31jLQhOMxqaoKkkLErAAHN/w9qiG/66jDJbTYk/zvEofM5ekqjD
         lmt0f+Z2va5jl77jj7fC7g0OujIpmlaPDdMJLjTaPDbdvfY+JUej+GEkG6XShWgPrE
         Ok/Fypsxi/OTw==
Date:   Mon, 2 Aug 2021 11:51:10 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Message-ID: <20210802085110.oo7qxjlccpv6rzcx@kernel.org>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-3-tony.luck@intel.com>
 <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
 <20210730003809.hp3nmqmgyysa45nz@kernel.org>
 <YQQsz/tvrQpqAbpX@google.com>
 <b7b6aabd-1f10-1b21-eaeb-102ead2989cd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b6aabd-1f10-1b21-eaeb-102ead2989cd@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 09:50:59AM -0700, Dave Hansen wrote:
> On 7/30/21 9:46 AM, Sean Christopherson wrote:
> > Out of curiosity, on multi-socket systems, are EPC sections clustered in a single
> > address range, or are they interleaved with regular RAM?  If they're clustered,
> > you could track the min/max across all sections to optimize the common case that
> > an address isn't in any EPC section.
> 
> They're interleaved on the systems that I've seen:
> 
> 	Socket 0 - RAM
> 	Socket 0 - EPC
> 	Socket 1 - RAM
> 	Socket 1 - EPC
> 
> It would probably be pretty expensive in terms of the physical address
> remapping resources to cluster them.

If they were clustered, wouldn't that also break up our initialization code
for NUMA? It's based on detecting of which NUMA nodes address range is the
given EPC section.

I.e. there should be some meta-data to draw the connection to the correct
NUMA node, if they were clustered (which does not exist).

/Jarkko

