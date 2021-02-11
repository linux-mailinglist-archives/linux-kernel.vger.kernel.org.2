Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F504318855
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBKKiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:38:24 -0500
Received: from elvis.franken.de ([193.175.24.41]:44696 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhBKKcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:32:13 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lA9FS-0005LQ-01; Thu, 11 Feb 2021 11:30:58 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 4B308C0E70; Thu, 11 Feb 2021 11:20:39 +0100 (CET)
Date:   Thu, 11 Feb 2021 11:20:39 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@linux-mips.org, Joe Perches <joe@perches.com>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] MAINTAINERS: replace non-matching patterns for
 loongson{2,3}
Message-ID: <20210211102039.GB7985@alpha.franken.de>
References: <20210210083812.6126-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210083812.6126-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:38:12AM +0100, Lukas Bulwahn wrote:
> Commit ffe1f9356fbe ("MAINTAINERS: Add Loongson-2/Loongson-3 maintainers")
> adds quite generic file entries for drivers/*/*loongson{2,3}* and
> drivers/*/*/*loongson{2,3}* to be informed on changes to all loongson{2,3}
> files in drivers.
> 
> However, only the pattern 'drivers/*/*loongson2*' matches to one file in
> the repository, i.e., drivers/cpufreq/loongson2_cpufreq.c; all other
> patterns have no file matches.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches    F:    drivers/*/*/*loongson2*
>   warning: no file matches    F:    drivers/*/*/*loongson3*
>   warning: no file matches    F:    drivers/*/*loongson3*
> 
> As in the last two and half years, no further files and drivers have
> showed up to match those patterns, just name the one file that matches
> explicitly and delete the others without a match.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on current master and next-20210209
> 
> Keguang, Huacai, Jiaxun, please ack.
> 
> Thomas, please pick this minor non-urgent cleanup patch.
> 
>  MAINTAINERS | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
