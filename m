Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9300314D8D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhBIKwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhBIKoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:44:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49B7864EAC;
        Tue,  9 Feb 2021 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612867404;
        bh=woRb0GsIZ6+QV/GQO5Hl5kTs9StLouuSkmaYWHIX23I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NND59zse0NbInxMmekl1uYNZAdDQwMwuqP413vK/qUBihqIyhlm45phDWwHVTeNfs
         FX/jp3JUCg7vjT52hQrP8hVNaziEE73LPFmS2AHp58imBdJ1xPlbxTCUcbamSt0nhw
         8CBUjEUXLskAb40pWnXbeOiLVduzfTpB/eBpihLo=
Date:   Tue, 9 Feb 2021 11:43:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.12
Message-ID: <YCJnSfvAMACmVfG5@kroah.com>
References: <CGME20210209103356epcas1p35b1c52bf4f7597feadec360f6b7c3ae9@epcas1p3.samsung.com>
 <199cf833-c46e-de3f-0996-492adc18eda3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <199cf833-c46e-de3f-0996-492adc18eda3@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 07:49:59PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.12. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi

I see the following error in this repo when trying to pull it:

Commit d8cc19be483a ("extcon: sm5502: Detect OTG when USB_ID is connected to ground")
	committer Signed-off-by missing
	author email:    nikitos.tr@gmail.com
	committer email: cw00.choi@samsung.com
	Signed-off-by: Nikita Travkin <nikitos.tr@gmail.com>

Please fix up.

thanks,

greg k-h
