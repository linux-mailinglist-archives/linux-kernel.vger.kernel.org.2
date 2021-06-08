Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCAC39FD3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhFHRJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232541AbhFHRJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:09:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9296261351;
        Tue,  8 Jun 2021 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623172059;
        bh=OwOQSgYET3vjOuH9i278qqL8LTQ8bZ1JIMmEUmSlAy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QG1vP4uu/Zs9B/ezhUOBigwLYXsP5TWzW0UPde5P/mtuDX1qA3agMDrd4VeIjL9JV
         CddpnMD3UuMqCcMkCLKqKIQvNfRaewF3EpgSBr6p/i3vRJRqT/yVBZYlaNke5AI6lN
         k4o30ntILUc688NMqpNwq/KGWSh5iN1H8ImbARL0anl31Xj6FoUIqIp7M7x0zuLs2d
         wFQbFXlSoS7+hhbEive2o/r9/d+iPO5rWtmXpUq8X84Yr+bLtZgAWRM7UPOKlHeueX
         155SQpibckwpzVtrTqlcCxZPwA9Bf3NM57CTmZ6OfxurSh099ZuPANalK0nK9iEBlD
         6fbBcwFx0KT+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B17E340B1A; Tue,  8 Jun 2021 14:07:36 -0300 (-03)
Date:   Tue, 8 Jun 2021 14:07:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Borislav Petkov <bp@suse.de>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:x86/cpu 4/4] Warning: Kernel ABI header at
 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at
 'arch/x86/include/asm/cpufeatures.h':  111< /* free                                    (
 3*32+29) */
Message-ID: <YL+j2CfGJS40sPKM@kernel.org>
References: <20210602094153.GH1271937@shao2-debian>
 <YLdTRopUV9OyulSq@zn.tnic>
 <YLelUPtti40D7DUl@kernel.org>
 <YLlIsS1brAdNyG4K@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLlIsS1brAdNyG4K@zn.tnic>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 03, 2021 at 11:25:05PM +0200, Borislav Petkov escreveu:
> On Wed, Jun 02, 2021 at 12:35:44PM -0300, Arnaldo Carvalho de Melo wrote:
> > ... 
> > will build in older systems where things added to the updated copy of
> > the kernel headers isn't present, so trying to update the file and then
> > rebuild perf, only warning me if it doesn't build would give me an early
> > warning about things that are breaking and that I should look sooner
> > rather than later.
> > 
> > 	Doing just the diff is not that useful :-)
> 
> Lemme see if I understand this correctly: you'd like for the 0day folks
> to take those perf-*src-pkg builds, put them on an *old* distro and see
> if it builds. Am I close?

Apply the patch, try to build it, it doesn't matter where you build it,
only that after applying the patch I want to know if it doersn't build,
so that I can look at it earlier than when it gets to my attention by
merging upstream, etc.
 
> And do that with the headers in tools/ which do not have the new changes
> and see if they still build?
> 
> Or?
> 
> Alternatively, we can always go back to keeping the headers in sync with
> those in tools/ and f'get about it.

We're doing it already, Peter wants to help me with it, and I think this
has value.

- Arnaldo
 
> Thoughts?
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 

- Arnaldo
