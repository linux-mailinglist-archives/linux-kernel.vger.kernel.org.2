Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12242360C24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhDOOrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232774AbhDOOrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A0B8611CD;
        Thu, 15 Apr 2021 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618498048;
        bh=cHuvASof4cEDa0CgFMEjc3MfMRcbdCVjcIlcGec1vDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ur71+nf4sZphgCqov1HZANWal3mCDWqYYEx9UcGEnR1H5TLxz0iurai3fSEafNieu
         2AtIkxgoCoBhbcwry8C+nDr0qjGgT0rQDeoz5gZ5u4RDcWVtnphLMpl2eafyd9RR/N
         SL6dYhb3Op8HpMWJ5Sb3+GO+CyOK8AK8gugXzNyqiL2T8bGo2wlMJy/kxkABYxv0RW
         CyFNc9KxoPBX4dcgy+UwWLyCPGbbTxDOazLm/4lnnaFVXLeZPwMYlqcUtyjLXpyR/O
         k+nI6XWKV2ls/kuVEIXj7hlaSmu3wg4d6So92Ns5ImBt07AN1LaNJC7FavbKis/PxL
         VoTg7H/sRA0XQ==
Date:   Thu, 15 Apr 2021 07:47:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] x86/events/amd/iommu: Fix sysfs type mismatch
Message-ID: <YHhR+l5Kmdy6OSSL@archlinux-ax161>
References: <20210415001112.3024673-1-nathan@kernel.org>
 <20210415075335.GA1954964@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415075335.GA1954964@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 08:53:35AM +0100, Christoph Hellwig wrote:
> On Wed, Apr 14, 2021 at 05:11:11PM -0700, Nathan Chancellor wrote:
> > dev_attr_show() calls _iommu_event_show() via an indirect call but
> > _iommu_event_show()'s type does not currently match the type of the
> > show() member in 'struct device_attribute', resulting in a Control Flow
> > Integrity violation.
> 
> While the fix looks fine I think we need to solve this kind of problem
> by better type checking.  The fact that we can use the wong type here
> without a compiler warning is the real issue.

I agree. Unfortunately, it seems that is going to be a much longer tail
project because of how pervasive this is (using container_of() +
attributes to get callbacks).

https://lore.kernel.org/r/202006112217.2E6CE093@keescook/
https://lore.kernel.org/r/202104021823.64FA6119@keescook/

Cheers,
Nathan
