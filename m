Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A5A3D0A98
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhGUHqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235831AbhGUHjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:39:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12A1760725;
        Wed, 21 Jul 2021 08:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626855575;
        bh=rSPMcqavfaZHJaVAoTYpAUv/15YqukMFmRLnFN5hDns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0/gD1mRnrfhmRCmDq+D658f+DH4AoV7oBRyJnvhus33WWabIjAnsF+zxhHetVSBu
         LT+uB7YWGDZ5XDP3pc7dEKaV1uulupmJFrXrwPZhULQVHeeuRjpnnzbCHUK1GO4QPe
         7GGhpaU8kKEvNdiivk2YE8466cic/DCR0FtcrBr4=
Date:   Wed, 21 Jul 2021 10:19:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8188eu: Remove an unused variable and
 some lines of code
Message-ID: <YPfYlf25CtKckRQx@kroah.com>
References: <20210705134151.15143-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705134151.15143-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 03:41:51PM +0200, Fabio M. De Francesco wrote:
> Remove set but unused iw_operation_mode[]. This driver doesn't support
> SIOCSIWRATE.  It just returns zero and does nothing.  Change it to
> return -ENOTSUPP instead.  (This is an API change but we don't expect it
> to break anything).
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1->v2: Delete rtw_wx_set_rate() and its association with command
> SIOCSIWRATE as suggested by Dan Carpenter <dan.carpenter@oracle.com>

Does not apply to my tree :(
