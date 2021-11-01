Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E753B442195
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhKAUWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:22:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53052 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhKAUW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:22:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id D04D01F43CCC
Subject: Re: [PATCH] clk: composite: Also consider .determine_rate for rate +
 mux composites
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        sboyd@kernel.org
Cc:     heiko@sntech.de, knaerzche@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        Collabora Kernel ML <kernel@collabora.com>
References: <163425193558.1688384.15520943968787313145@swboyd.mtv.corp.google.com>
 <20211015120559.3515645-1-martin.blumenstingl@googlemail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <04a58d50-634b-fa20-95b4-eb6831f77e85@collabora.com>
Date:   Mon, 1 Nov 2021 20:19:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211015120559.3515645-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Please see the bisection report below about a boot failure on
rk3328-rock64.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

Some more details can be found here:

  https://linux.kernelci.org/test/case/id/617f11f5c157b666fb3358e6/

Here's what appears to be the cause of the problem:

[    0.033465] CPU: CPUs started in inconsistent modes
[    0.033557] Unexpected kernel BRK exception at EL1
[    0.034432] Internal error: BRK handler: f2000800 [#1] PREEMPT SMP

There doesn't appear to be any other platform in KernelCI showing
the same issue.

Please let us know if you need help debugging the issue or if you
have a fix to try.

Best wishes,
Guillaume


GitHub: https://github.com/kernelci/kernelci-project/issues/69

-------------------------------------------------------------------------------

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

mainline/master bisection: baseline.login on rk3328-rock64

Summary:
  Start:      75fcbd38608c3 Merge tag 'perf-tools-fixes-for-v5.15-2021-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
  Plain log:  https://storage.kernelci.org/mainline/master/v5.15-rc7-240-g75fcbd38608c/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.txt
  HTML log:   https://storage.kernelci.org/mainline/master/v5.15-rc7-240-g75fcbd38608c/arm64/defconfig/gcc-10/lab-baylibre/baseline-rk3328-rock64.html
  Result:     675c496d0f92b clk: composite: Also consider .determine_rate for rate + mux composites

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       mainline
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  Branch:     master
  Target:     rk3328-rock64
  CPU arch:   arm64
  Lab:        lab-baylibre
  Compiler:   gcc-10
  Config:     defconfig
  Test case:  baseline.login

-------------------------------------------------------------------------------

Git bisection log:

git bisect start
# good: [119c85055d867b9588263bca59794c872ef2a30e] Merge tag 'powerpc-5.15-6' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 119c85055d867b9588263bca59794c872ef2a30e
# bad: [75fcbd38608c3ce9f4dc784f2ac8916add64c9a8] Merge tag 'perf-tools-fixes-for-v5.15-2021-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
git bisect bad 75fcbd38608c3ce9f4dc784f2ac8916add64c9a8
# bad: [095729484efc4aa4604c474792b059bd940addce] perf build: Suppress 'rm dlfilter' build message
git bisect bad 095729484efc4aa4604c474792b059bd940addce
# bad: [3a4347d82efdfcc5465b3ed37616426989182915] Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad 3a4347d82efdfcc5465b3ed37616426989182915
# good: [54c5639d8f507ebefa814f574cb6f763033a72a5] riscv: Fix asan-stack clang build
git bisect good 54c5639d8f507ebefa814f574cb6f763033a72a5
# bad: [675c496d0f92b481ebe4abf4fb06eadad7789de6] clk: composite: Also consider .determine_rate for rate + mux composites
git bisect bad 675c496d0f92b481ebe4abf4fb06eadad7789de6
# first bad commit: [675c496d0f92b481ebe4abf4fb06eadad7789de6] clk: composite: Also consider .determine_rate for rate + mux composites

-------------------------------------------------------------------------------

Breaking commit found:

commit 675c496d0f92b481ebe4abf4fb06eadad7789de6
Author: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat Oct 16 12:50:21 2021 +0200


On 15/10/2021 13:05, Martin Blumenstingl wrote:
> Commit 69a00fb3d69706 ("clk: divider: Implement and wire up
> .determine_rate by default") switches clk_divider_ops to implement
> .determine_rate by default. This breaks composite clocks with multiple
> parents because clk-composite.c does not use the special handling for
> mux + divider combinations anymore (that was restricted to rate clocks
> which only implement .round_rate, but not .determine_rate).
> 
> Alex reports:
>   This breaks lot of clocks for Rockchip which intensively uses
>   composites,  i.e. those clocks will always stay at the initial parent,
>   which in some cases  is the XTAL clock and I strongly guess it is the
>   same for other platforms,  which use composite clocks having more than
>   one parent (e.g. mediatek, ti ...)
> 
>   Example (RK3399)
>   clk_sdio is set (initialized) with XTAL (24 MHz) as parent in u-boot.
>   It will always stay at this parent, even if the mmc driver sets a rate
>   of  200 MHz (fails, as the nature of things), which should switch it
>   to   any of its possible parent PLLs defined in
>   mux_pll_src_cpll_gpll_npll_ppll_upll_24m_p (see clk-rk3399.c)  - which
>   never happens.
> 
> Restore the original behavior by changing the priority of the conditions
> inside clk-composite.c. Now the special rate + mux case (with rate_ops
> having a .round_rate - which is still the case for the default
> clk_divider_ops) is preferred over rate_ops which have .determine_rate
> defined (and not further considering the mux).
> 
> Fixes: 69a00fb3d69706 ("clk: divider: Implement and wire up .determine_rate by default")
> Reported-by: Alex Bee <knaerzche@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Re-sending this as inline patch instead of attaching it.
> 
>  drivers/clk/clk-composite.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 0506046a5f4b..510a9965633b 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -58,11 +58,8 @@ static int clk_composite_determine_rate(struct clk_hw *hw,
>  	long rate;
>  	int i;
>  
> -	if (rate_hw && rate_ops && rate_ops->determine_rate) {
> -		__clk_hw_set_clk(rate_hw, hw);
> -		return rate_ops->determine_rate(rate_hw, req);
> -	} else if (rate_hw && rate_ops && rate_ops->round_rate &&
> -		   mux_hw && mux_ops && mux_ops->set_parent) {
> +	if (rate_hw && rate_ops && rate_ops->round_rate &&
> +	    mux_hw && mux_ops && mux_ops->set_parent) {
>  		req->best_parent_hw = NULL;
>  
>  		if (clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT) {
> @@ -107,6 +104,9 @@ static int clk_composite_determine_rate(struct clk_hw *hw,
>  
>  		req->rate = best_rate;
>  		return 0;
> +	} else if (rate_hw && rate_ops && rate_ops->determine_rate) {
> +		__clk_hw_set_clk(rate_hw, hw);
> +		return rate_ops->determine_rate(rate_hw, req);
>  	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
>  		__clk_hw_set_clk(mux_hw, hw);
>  		return mux_ops->determine_rate(mux_hw, req);
> 

