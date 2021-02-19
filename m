Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52B331F811
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBSLQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhBSLQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:16:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8421064E33;
        Fri, 19 Feb 2021 11:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613733375;
        bh=6CO0lP7reNghTWMR1bYwuUFfBl5QsFlGsJkrQWSHE9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+eT0IoaiJiflvaP5mpOEvqRTzi4eLB963Eib0ysAVmkPrAwlPQwtSXqrfJvs+Bhh
         xkDp/xF0DBN1dg8ydM28Xw/2FnhYF5nBAYZWwrOUwH+nUApK2HR/HKxOMLd+U4WJqX
         xQZiTqfaJWeIbDFepeLj/lYdbCZ/zpqVFEUTvd5o=
Date:   Fri, 19 Feb 2021 12:16:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jari Ruusu <jariruusu@protonmail.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: 5.10 LTS Kernel: 2 or 6 years?
Message-ID: <YC+d/NyXDebGSHwN@kroah.com>
References: <YA/E1bHRmZb50MlS@kroah.com>
 <602E766F.758C74D8@users.sourceforge.net>
 <20210218143341.GB13671@1wt.eu>
 <dbLhDu5W6LMrWDRrgzNQJGLZPMWGkRtOcxFUbghT-Uuc8zmQObV5KjhYqVBo2U6k7r2rNVtVEaMjev_lyz8eNQGvksSTjVrHd8LaPrO_6Qs=@protonmail.com>
 <YC6nZH/4CkLLsxxB@kroah.com>
 <sjYC-8XCIa2KTTlzjXs95LPnYQJvJe3Lrz4tR9NZTLLIfQpWLquW6W2siZAP7wtgHXOsK5bSxo8JqJp7iPLQ_NtDhh8GbES8J3dUlB5sqYs=@protonmail.com>
 <YC91OWVGAfyorRbc@kroah.com>
 <QYs3MUT8alABsssQUgn1j3b7BF6zgqqiBq0-76Rqcpo6lPFnKyfd8iAagAfotVhDzKP6FFRIjlRVVoIaRtCAEaNT3P-4gyF43rTEPEsvqEA=@protonmail.com>
 <YC+U+beaI91aXh5z@kroah.com>
 <OurD0pqDIPLLZlt1kk-JE57wXeMoh0NFPKKcBrbY3ValknDXcpLwAJz6x1DMbB6LNZ6FDdeUrPM-pX60VF5FERTiDK_gzgHy4tq7iG3MFAM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OurD0pqDIPLLZlt1kk-JE57wXeMoh0NFPKKcBrbY3ValknDXcpLwAJz6x1DMbB6LNZ6FDdeUrPM-pX60VF5FERTiDK_gzgHy4tq7iG3MFAM=@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 10:57:30AM +0000, Jari Ruusu wrote:
> On Friday, February 19, 2021 12:37 PM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > Did you report that breakage to us and the developers of the driver?
> > Sounds like a regression that people would love to hear about and get
> > fixed.
> 
> At that time I didn't know where the problem was, so I did not report it.
> I only recently connected-the-dots that problem is in-tree iwlwifi, so I
> am reporting it now.

Great!  Can you run 'git bisect' on the 4.14.y stable tree to find the
offending change?

thanks,

greg k-h
