Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274BA3B3CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 08:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFYG5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 02:57:55 -0400
Received: from m32-153.88.com ([43.250.32.153]:55746 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229437AbhFYG5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 02:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=IbXXHF+XTLAX3HDF7anDNuHXZoZnR21DQTRBt
        iFP+ME=; b=mgnRk4On89L1/qKMVzoT3oucjrQLIKlfE4abvE8NMx4NX7TVl64mC
        vlr1cdbQTmRRIDF99mLd4R5NQxyvmfYJSdTFfc8DFqyB7/vHj2Qy7d21pXaVTFoN
        1COuiNwjZ12//5/RxTEb/u23UUSwu8Vw8HJnPmT0lDVQa4BofkG6NU=
Received: from bobwxc.top (unknown [120.238.248.220])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgBHHfzcfdVgmlgqAA--.22568S2;
        Fri, 25 Jun 2021 14:55:26 +0800 (CST)
Date:   Fri, 25 Jun 2021 14:55:24 +0800
From:   "Wu X.C." <bobwxc@email.cn>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        SeongJae Park <sj38.park@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK ascii-art
Message-ID: <20210625065524.GA11219@bobwxc.top>
References: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <386938dc-6290-239c-4b4f-c6153f3d98c5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CM-TRANSID: GiKnCgBHHfzcfdVgmlgqAA--.22568S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1DWry3AFyktr18Xr1DWrg_yoW5uw4DpF
        W3Wwnxt3Z5tr1j9ws7Xw4UuF1ruw4fCr15Ja42qw1fCr95CrySkr4xtas0vF9rCr1fXFyU
        Zw4jva15ZFZrA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUqSb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04
        k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU-KZXDUUU
        U
X-Originating-IP: [120.238.248.220]
X-CM-SenderInfo: pere453f6hztlloou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 09:06:59PM +0900, Akira Yokosawa wrote:
> Subject: [RFC PATCH 0/3] docs: pdfdocs: Improve alignment of CJK ascii-art
> 
> Hi all,

Hi Akira,

> 
> This is another attempt to improve translations' pdf output.
> I see there is a mismatch in the font choice for CJK documents, which
> causes poor-looking ascii-art where CJK characters and Latin letters
> are mixed used.
> 
> One of noticeable examples of such ascii-art can be found in
> Korean translation of memory-barriers.txt.
> 
> Hence the author of Korean translation of memory-barriers.txt is
> in the CC list.
> 
> At first, I thought the issue could be fixed by simply selecting
> "Noto Sans Mono CJK SC" as both of monofont and CJKmonofont.
> It fixed the mis-alignment in the Chinese translation, but failed
> in the Korean translation.
> 
> It turns out that Hangul characters in "Noto Sans Mono CJK SC"
> are slightly narrower than Chinese and Japanese counterparts.
> I have no idea why the so-called "mono" font has non-uniform
> character widths.
> 
> GNU Unifont is an alternative monospace font which covers
> almost all Unicode codepoints.
> However, due to its bitmap-font nature, the resulting document
> might not be acceptable to Korean readers, I guess.

OK, it works.

But I still want to say that the display effect of Unifont is really
not good. Unifont's lattice is too small, and only one size.
http://fars.ee/QA1k.jpg	    http://fars.ee/GAAv.jpg
Looks like computers 20 years ago, LOL :)

It there any chance to use other fonts, like *Sarasa Mono* ?
                                              等距更紗黑體
Looks more beautifull http://fars.ee/DTT6.jpg
But I guess not many people installed it.

> 
> As a compromise, Patch 2/3 enables Unifont only when it is available.
> 
> A comparison of some of ascii-art figures before and after this change
> can be found in the attached PDF.
> 
> Patch 1/3 is a preparation of Patch 2/3.
> It converts font-availability check in python to LaTeX and make the
> resulting LaTeX code portable across systems with different sets of
> installed fonts.
> 
> Patch 3/3 is an independent white space fix (or a workaround of Sphinx
> mis-handling of tabs behind CJK characters) in Korean translation
> of memory-barriers.txt.
> 
> Any feedback is welcome!
> 
> Side note:
> 
> In Korean translation's PDF, I see there is another issue of missing
> white spaces between Hangul "phrase groups" in normal text.
> Looks like the pair of xelatex + xeCJK just ignores white spaces
> between CJK characters.

Yes, xeCJK ignores spaces between CJK characters by default.

> 
> There is a package named "xetexko", which might (or might not) be
> a reasonable choice for Korean translation.
> 
> It should be possible to use a language-specific preamble once
> we figure out the way to load per-directory Sphinx configuration
> and move translation docs into per-language subdirectories.  
> 
> As I am not familiar with Korean LaTeX typesetting, I must defer to
> those who are well aware of such conventions.
> 
>         Thanks, Akira
> --
> Akira Yokosawa (3):
>   docs: pdfdocs: Refactor config for CJK document
>   docs: pdfdocs: Add font settings for CJK ascii-art
>   docs: ko_KR: Use white spaces behind CJK characters in ascii-art
> 
>  Documentation/conf.py                         | 26 +++++++++++--------
>  .../translations/ko_KR/memory-barriers.txt    | 14 +++++-----
>  2 files changed, 22 insertions(+), 18 deletions(-)
> 
> -- 
> 2.17.1
> 

Thanks,
	Wu X.C.

