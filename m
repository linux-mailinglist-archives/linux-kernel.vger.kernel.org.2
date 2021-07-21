Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059943D0A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhGUHrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234476AbhGUHid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9246A611C1;
        Wed, 21 Jul 2021 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626855534;
        bh=6F/Sr+tGeuAReYoA3DIB0nuRnQHk7E0lWp2ELe2fuEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGbu1xFER90n1Qw7tk33kEXRP0zerpZX9B3xKnUDegdaVXNRo9MGtBBl/weXxc5KE
         j8UWhWvu0FgIDcC81CMm6RkXTFLr449osW1DgPE/sv3vIhTYsAL4bwEQ+8Li+XjJs7
         W63FD+SuhWdGiA/NSC0X7cP/44uUDFglCOFxMAZ0=
Date:   Wed, 21 Jul 2021 10:18:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Remove no more used functions and
 variables
Message-ID: <YPfYa2P2WtHLxUc3@kroah.com>
References: <20210701164115.4288-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701164115.4288-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 06:41:15PM +0200, Fabio M. De Francesco wrote:
> Remove the functions and variables from rtw_security.c that are no more
> necessary since the patch that replaces getcrc32() with crc32_le():
> https://lore.kernel.org/lkml/20210701133809.26534-1-fmdefrancesco@gmail.com/
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> Please, apply after the above-mentioned patch to make the code build
> with no errors.

Does not apply to my tree :(
