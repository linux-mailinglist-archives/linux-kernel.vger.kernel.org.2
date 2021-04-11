Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7364A35B209
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhDKGlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhDKGlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:41:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EC05610A7;
        Sun, 11 Apr 2021 06:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618123257;
        bh=ez2/qmN7ucaZmOhlZErFDvgVp7Q+SCQWNUwCs8UCI/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Ernrul8z79N88iBRqTlSVtfZcPYCAuMf12yJQfY2+brSaHO/+UyZdMurBDljaRAb
         x1SPuyU56YBRGpYtrv/YgViZLW57CtN2/pBPOEaTgMefzZ4Jiaj44Rrnl3pHB56df/
         d6XZg/SfgKaS5OvN8JialWFp5qppar0T6xfyKESo=
Date:   Sun, 11 Apr 2021 08:40:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 2/5] staging: rtl8723bs: include:
 Fix misspelled words in comments
Message-ID: <YHKZ99v1FOmDem4L@kroah.com>
References: <20210410150008.5460-1-fmdefrancesco@gmail.com>
 <20210410150008.5460-3-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410150008.5460-3-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 05:00:05PM +0200, Fabio M. De Francesco wrote:
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

I can not take patches without any changelog text at all, sorry.
