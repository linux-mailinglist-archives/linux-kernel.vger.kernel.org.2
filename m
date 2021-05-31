Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC3C396654
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhEaRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhEaPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:51:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D675BC08EA47
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=MlszWsFom6xwHdIA8Zaw87Lde5y0FR+o984bS4PPP4M=; b=HOINdahAnQWIKnpFQ/nC+w//G0
        Z/RXR3CtqTrjvdFyL4WRccbxNLJmIJu//5zYskJTJNlgMKZHXfr0YaLTSdjkxh8W+635R4uIs951y
        AXAq3qtziFyMiQsNm02zzaeIggOu+Figv6S92fBXyQ9VflbwcM+WWBE1GrRzkmjaH08NP/7uEAMyO
        GgOB+LhF1rwQNjql9aW0U4L7CtNMhc43uR37L7MEInaBNcPiD3u2xOgUmfWe4CkGU9v5YO3AnODSv
        eeb/YVAnEFCATYTpQ2cQFMWbOn+Ynl0lWiYoZH2QPjhI2VF7SL91AhGDJLNla5Oz5fE9uGektcYTS
        gQpRc4hg==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lnizZ-00Caax-Bo; Mon, 31 May 2021 14:34:09 +0000
Subject: Re: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko]
 undefined!
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>, Andrew Lunn <andrew@lunn.ch>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.daney@cavium.com>
References: <202105300736.7wVLvXHr-lkp@intel.com>
 <a0edf640-ec05-524e-9125-44decba27bbb@infradead.org>
 <d4c47108-f4d2-4850-14fd-b4c4bd0e0591@infradead.org>
 <CAMuHMdW1xZ-vJe2eOehNSKCP3T=-eq7ji4MBo3D6oGJyPNXGDw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0717b3a5-d838-e1ed-a4ac-80cf14f3a6aa@infradead.org>
Date:   Mon, 31 May 2021 07:34:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW1xZ-vJe2eOehNSKCP3T=-eq7ji4MBo3D6oGJyPNXGDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 12:36 AM, Geert Uytterhoeven wrote:
> On Mon, May 31, 2021 at 3:13 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 5/30/21 5:05 PM, Randy Dunlap wrote:
>>> On 5/29/21 4:25 PM, kernel test robot wrote:
>>>> First bad commit (maybe != root cause):
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   df8c66c4cfb91f2372d138b9b714f6df6f506966
>>>> commit: a9770eac511ad82390b9f4a3c1728e078c387ac7 net: mdio: Move MDIO drivers into a new subdirectory
>>>> date:   9 months ago
>>>> config: sh-allmodconfig (attached as .config)
>>>> compiler: sh4-linux-gcc (GCC) 9.3.0
>>>> reproduce (this is a W=1 build):
>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>         chmod +x ~/bin/make.cross
>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a9770eac511ad82390b9f4a3c1728e078c387ac7
>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>         git fetch --no-tags linus master
>>>>         git checkout a9770eac511ad82390b9f4a3c1728e078c387ac7
>>>>         # save the attached .config to linux build tree
>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sh
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>>
>>>>>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
>>
>> Should we make this one driver depend on !SUPERH ?
> 
> No, we should just fix the driver instead.
> 
> +               /* Wait 1000 clocks so we don't saturate the RSL bus
> +                * doing reads.
> +                */
> +               __delay(1000);
> 
> As this is used only on Cavium Octeon and Thunder SoCs, running
> at 400-600 MHz resp. 1800-2000 Mhz, what about replacing the __delay()
> call by a call to udelay(1) or udelay(2)?

Yeah, I was planning to look into that change this week,
but it would probably be better for David to do it.


thanks.
-- 
~Randy

