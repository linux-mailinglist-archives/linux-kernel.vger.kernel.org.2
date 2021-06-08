Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8098339FEAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhFHSI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234021AbhFHSIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:08:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3E6161246;
        Tue,  8 Jun 2021 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175620;
        bh=VBdS+EzQQcuzpWQ5FS3TOaHtkM6itymUNX9r9Ug72i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0wUIIzIyaT/i6EEFHVtQBn28KxvbWXb22tygZDsicEYVfaloxK6Ngcl4ra9Ut4EE
         FFrGWOupgYAZ9bppA0CR1Qog7++5Pv75z/WG2+TzJNhjwXgQ7EpOYbzwMdHnW5TRPI
         8XceNVFjYgTVjsJbVz/YiseOuE5dYWmVdL6XgcM3ra4Ed+wh46u4cLDVjyAng2K6zP
         +Vr1zNEs51l69BvXBixAUr/ZqEoTXjs6FBTBp+sx6QuvAAIfmlBUYg39Bro38fKwBc
         h9/ONBVHMrTva8qiPe7aikYNgLYTSWrhIQu0C0Tpt1cFunEF1At2keGVnYiuv5qDF3
         eiTWbPT+XboGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C45AD40B1A; Tue,  8 Jun 2021 15:06:57 -0300 (-03)
Date:   Tue, 8 Jun 2021 15:06:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:x86/cpu 4/4] Warning: Kernel ABI header at
 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at
 'arch/x86/include/asm/cpufeatures.h':  111< /* free                                    (
 3*32+29) */
Message-ID: <YL+xwYq8LNLY6ePU@kernel.org>
References: <20210602094153.GH1271937@shao2-debian>
 <YLdTRopUV9OyulSq@zn.tnic>
 <YLelUPtti40D7DUl@kernel.org>
 <YLlIsS1brAdNyG4K@zn.tnic>
 <YL+j2CfGJS40sPKM@kernel.org>
 <YL+rEhU4A1tXNFYO@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL+rEhU4A1tXNFYO@zn.tnic>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 08, 2021 at 07:38:26PM +0200, Borislav Petkov escreveu:
> On Tue, Jun 08, 2021 at 02:07:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > Apply the patch, try to build it, it doesn't matter where you build it,
> > only that after applying the patch I want to know if it doersn't build,
> > so that I can look at it earlier than when it gets to my attention by
> > merging upstream, etc.
> 
> I believe if you give the 0day guys a step-by-step what to do, they'll
> probably add it to the lineup. :)

I think I already did it in a another e-mail.
 
> > We're doing it already, Peter wants to help me with it, and I think this
> > has value.
 
> Or, if we start doing that then they don't have to do anything.

Who? Previously its me doing this work, i.e. keeping things in synch.
Actually it is expected that people doing the kernel work don't touch
tools/ wrt adding the copy, there is value in the warning, in looking at
what changed, to see if we should change tooling in some way beyond what
automation in merely making the copy can possibly do.

What has value is checking that the process of addressing the out of
sync warning doesn't break the build, to point to things that will need
human work to get it back to a buildable state.
 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

-- 

- Arnaldo
