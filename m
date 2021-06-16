Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B95A3A9CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhFPN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhFPN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:56:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5C9C0617AF;
        Wed, 16 Jun 2021 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vgcanmBaWEPTYxk9YYX1X9HoTPoV8jfXM0wcJQhAUoQ=; b=fgwmn8BgsRgkDQzIJ5FdXtqhPz
        R0p/51MWowYXfVIYOkLubeP6TdUYNGWGnoLQv6LSowXJ3Hb5giZia5XJ98i6+sJ70opNqCccLFzUQ
        PyNx1d10bCUxHd//DzvLjcQRwJbr0zQsakac3hivey0hFq+IDD5xyVhtgj842ZA/az2/YnUx7O/p0
        qwMbCjiAnUqdwD7DwN6J1PxpkMG76/18P8/9Vgrgn4d6HBOsTxufnmF5JelVFQyWsXj2rz//PiqM0
        S8zxqjIX8uzIP76bBtzg7Aljlu7WoUmF+D4ldcu/pMLYIyEJ5cHV0I54XeNNzntGI7633DVC7Haod
        GgZMbGCg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltVyI-0086Pw-AE; Wed, 16 Jun 2021 13:52:51 +0000
Date:   Wed, 16 Jun 2021 14:52:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Adrian Sun <a.sun@sun.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linux-ide.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Benoit Poulot-Cazajous <poulot@chorus.fr>,
        Christian Brunner <chb@muc.de>,
        "Christopher J. Reimer" <reimer@doe.carleton.ca>,
        CJ <cjtsai@ali.com.tw>, Clear Zhang <Clear.Zhang@ali.com.tw>,
        "David S. Miller" <davem@davemloft.net>,
        Duncan Laurie <void@sun.com>,
        Erik Andersen <andersee@debian.org>,
        Frank Tiernan <frankt@promise.com>,
        Gadi Oxman <gadio@netvision.net.il>,
        Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Lord <mlord@pobox.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Waychison <crlf@sun.com>, or <source@mvista.com>,
        Paul Mackerras <paulus@samba.org>,
        Robert Bringman <rob@mars.trion.com>,
        Scott Snyder <snyder@fnald0.fnal.gov>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        Tim Hockin <thockin@sun.com>
Subject: Re: [PATCH 00/21] Rid W=1 warnings from IDE
Message-ID: <YMoCLu1rrIYOsMT0@infradead.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
 <YL3YMGl9kmtv55B/@infradead.org>
 <20210614091228.GB5285@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614091228.GB5285@dell>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 10:12:28AM +0100, Lee Jones wrote:
> On Mon, 07 Jun 2021, Christoph Hellwig wrote:
> 
> > Please don't touch this code as it is about to be removed entirely.
> 
> Do you have an ETA for this work?

I just resent the series.
