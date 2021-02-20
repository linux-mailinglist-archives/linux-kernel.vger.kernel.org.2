Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C01320619
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 17:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBTQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 11:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhBTQF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 11:05:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AE5E60C3E;
        Sat, 20 Feb 2021 16:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613837116;
        bh=lFJlYNgL7XIuqK2y1QoQUz51iSPxuIi/6M87Q8dVLNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvx6Ml17AODm6gnmQar06ZLD3TJUyvBs3LBOqlSB9SXwC+LIDG4ux5tCwOPkavS6p
         GrrpzQxPJWpxQXmsbnxea4EdOldEFGNWu+4yK6EiOXYdbwioq2fruvza7csk9otNjJ
         jce05K17kR/bvJ3M+vDJKEiMpWDrLDgwd8W8uI/U=
Date:   Sat, 20 Feb 2021 17:05:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jari Ruusu <jariruusu@protonmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YDEzOg4WTRWBC7DS@kroah.com>
References: <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
 <YC6nZH/4CkLLsxxB@kroah.com>
 <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com>
 <YC91OWVGAfyorRbc@kroah.com>
 <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com>
 <YC+U+beaI91aXh5z@kroah.com>
 <OurD0pqDIPLLZlt1kk-JE57wXeMoh0NFPKKcBrbY3ValknDXcpLwAJz6x1DMbB6LNZ6FDdeUrPM-pX60VF5FERTiDK_gzgHy4tq7iG3MFAM=@protonmail.com>
 <YC+d/NyXDebGSHwN@kroah.com>
 <NBnmv-hTU50xKWL-Q7clpw69elSJgEX7kWA2LiuvzVJ4uOwh8xc5yh83qQDmAfMZl8OcCZxatCZ84dxV2-R2bv25kZLhW0howAP0kOadkwE=@protonmail.com>
 <RpmkVZBUhx36C8VTTIM1SZz6jf46qBoOL4rMaBMuTMRTe-TQGmEfgeMcrGhXWt1N6SSPrHfFERM_hzHRBod7Xn9XV6d0cyEHoQ8nqXi7rXA=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <RpmkVZBUhx36C8VTTIM1SZz6jf46qBoOL4rMaBMuTMRTe-TQGmEfgeMcrGhXWt1N6SSPrHfFERM_hzHRBod7Xn9XV6d0cyEHoQ8nqXi7rXA=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 01:29:21PM +0000, Jari Ruusu wrote:
> On Friday, February 19, 2021 5:23 PM, Jari Ruusu <jariruusu@protonmail.com> wrote:
> > My contribution here is trying to point you guys to right direction.
> 
> I have been able to narrow the beginning of the problem to these kernels:
> 4.14.188 ... 4.14.202
> 
> Same "fix" that went info 4.14.y is also bugging 4.19.y kernels.

Great, any chance you can narrow this down to the commit itself?

thanks,

greg k-h
