Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51674073E6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhIJXdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234835AbhIJXdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:33:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5166A611B0;
        Fri, 10 Sep 2021 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631316729;
        bh=nqr4f1XS47t1B3ClErUzXUPQwwrVsVEXFPpaLcDk9OQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBQuqIxZxWbDIEmllHYXleekwU32ZHdacYJMzktzIf2VIFlZl1Fhw8GQ3a1De2wD0
         IbR+mjddZGceCMdz7BKFq/S9irYTDPD8SPtk2xAfGLYyGO1zhaGVDkBfsf70k+5CH5
         +0CbN3o1bS4rmM3pBSVo0qHrjYCd+G/R6GjgCbberP75WQ+m+MWuEoO/XYyEJKRO6u
         JYmwP4PIx0zKYf88qXMQM+R9Be1O7RJaU7KNicY7khuEKA0b60Irs0ASOqC7knewe4
         Kdjq/m8nmhiVXu2C/tut9dn6LrchCqjouAJ1vRIjReBjWQGFjoF2Sc8b5dQwJVYxeg
         LrboeN4sqkGRQ==
Received: by pali.im (Postfix)
        id DDED02828; Sat, 11 Sep 2021 01:32:06 +0200 (CEST)
Date:   Sat, 11 Sep 2021 01:32:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add link to Orion
 Functional Errata document
Message-ID: <20210910233206.fpwd7smtlgrovt5q@pali>
References: <20210704181110.9254-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210704181110.9254-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! I would like to remind this patch.

On Sunday 04 July 2021 20:11:10 Pali Rohár wrote:
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/arm/marvell.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index db2246493d18..753a422d3bb1 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -21,6 +21,7 @@ Orion family
>                 - Datasheet: https://web.archive.org/web/20210124231420/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-datasheet.pdf
>                 - Programmer's User Guide: https://web.archive.org/web/20210124231536/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-opensource-manual.pdf
>                 - User Manual: https://web.archive.org/web/20210124231631/http://csclub.uwaterloo.ca/~board/ts7800/MV88F5182-usermanual.pdf
> +               - Functional Errata: https://web.archive.org/web/20210704165540/https://www.digriz.org.uk/ts78xx/88F5182_Functional_Errata.pdf
>          - 88F5281
>  
>                 - Datasheet: https://web.archive.org/web/20131028144728/http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
> -- 
> 2.20.1
> 
