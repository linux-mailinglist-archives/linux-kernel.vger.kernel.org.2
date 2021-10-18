Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D4F43206D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhJROzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232651AbhJROzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:55:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B176E60E0B;
        Mon, 18 Oct 2021 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634568780;
        bh=/5CgXtVv/3GIxEMurkQWBSAadZn1nHoUiimdgKpASPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpYYBp1GTllaNTapDskkC4PLDgTlbUy2beQU4mnZxBj4GDt6a+N9E7K3dSKMNjY64
         jPeZq2+do9gBuwXIIC2hFqFf0w5cuEB0CwwJ75kawPu2OPVgFmkqQg5ho+mP4EtSAj
         0x0LRbOGhtx5WnitFu50UKrCmBAx8dqt5aeG0C5c=
Date:   Mon, 18 Oct 2021 16:52:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: fix camelcase byData in card.c
Message-ID: <YW2KSVbZUhmcZu/P@kroah.com>
References: <20211018082042.15814-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018082042.15814-1-tomm.merciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:20:40AM +0200, Tommaso Merciai wrote:
> Replace camelcase variable byData in card.c

Replace it with what?

And why?

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/SubmittingPatches for what is needed in order
to properly describe the change.

thanks,

greg k-h
