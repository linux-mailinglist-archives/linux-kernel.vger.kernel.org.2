Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923923160C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhBJITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:19:17 -0500
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:46280 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231494AbhBJITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:19:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A67FE127A6;
        Wed, 10 Feb 2021 08:18:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:967:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1568:1593:1594:1711:1714:1730:1747:1777:1792:1981:2194:2199:2393:2525:2565:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3872:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4362:5007:7652:8985:9025:10004:10400:10848:11232:11658:11914:12043:12048:12050:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21212:21611:21627:21749:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: party75_5a0b9892760e
X-Filterd-Recvd-Size: 1872
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Feb 2021 08:18:28 +0000 (UTC)
Message-ID: <aeaa56b9a50444c571a5ab34914d9b4590a9d629.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: replace non-matching patterns for
 loongson{2,3}
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Feb 2021 00:18:27 -0800
In-Reply-To: <20210210075947.15604-1-lukas.bulwahn@gmail.com>
References: <20210210075947.15604-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-10 at 08:59 +0100, Lukas Bulwahn wrote:
> Commit ffe1f9356fbe ("MAINTAINERS: Add Loongson-2/Loongson-3 maintainers")
> adds quite generic file entries for drivers/*/*loongson{2,3}* and
> drivers/*/*/*loongson{2,3}* to be informed on changes to all loongson{2,3}
> files in drivers.
> 
> However, only the pattern 'drivers/*/*loongson2*' matches to one file in
> the repository, i.e., drivers/cpufreq/loongson2_cpufreq.c; all other
> patterns have no file matches.

Thank you.  I hope one day it gets applied...

https://lore.kernel.org/linux-mips/20190325212717.27044-1-joe@perches.com/
https://lore.kernel.org/linux-mips/20180928215928.30611-1-joe@perches.com/
https://lore.kernel.org/linux-mips/20180928220034.30697-1-joe@perches.com/


