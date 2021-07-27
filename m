Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA803D75AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhG0NRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhG0NRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:17:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F85601FD;
        Tue, 27 Jul 2021 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627391859;
        bh=OOCCNXzx21q2l0kDMmSD+oFNhSnD0BpDuNRFYaqiBOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+g+iNG6pSkq4HWM5+uUlVZe7mk3unP/5rdNkCygIFoFQKYJ/j5Jq59Sj1cucJR7f
         FWkCExX0dU8cuoteuzWxfBV+FhtpWJ3+ChjHlmZbAqGIgOKIArNkw4SrDuvi7dbN9c
         YmfwOSKUCDVRUmMLhydGtpt3MNBkUFOUTnn1LVn4=
Date:   Tue, 27 Jul 2021 15:17:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH v4 0/2] staging: rtl8188eu: Replace a custom function
 with crc32_le()
Message-ID: <YQAHcbOeh2ohAmTg@kroah.com>
References: <20210723192620.10669-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723192620.10669-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 09:26:18PM +0200, Fabio M. De Francesco wrote:
> Use kernel API crc32_le() in place of the custom getcrc32(). Remove no
> more used functions and variables after the changes made by patch 1/2.
> 
> Fabio M. De Francesco (2):
>   staging: rtl8188eu: Replace a custom function with crc32_le()
>   staging: rtl8188eu: Remove no more used functions and variables
> 
>  drivers/staging/rtl8188eu/core/rtw_security.c | 81 +++++--------------
>  1 file changed, 19 insertions(+), 62 deletions(-)

Much nicer, thanks!
