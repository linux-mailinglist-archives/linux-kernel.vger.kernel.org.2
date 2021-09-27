Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652D44197DE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbhI0P2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235215AbhI0P2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:28:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84B8D60E9C;
        Mon, 27 Sep 2021 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632756399;
        bh=ViGwEkKfdlXHkYliW+p4slVaJG+wyeDSRms58u/4Ph4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GC5iClaw9BR6ARGpPAKjBXWnT4XQ70fknEwXPgjEVaqE/WdqIhs3nmUZs1pC/HjJK
         h0E9Bl/t1UVttzTNLbNSX2qmvtWLMLprMSnG2fNFqr07Jg3N4bhAas49UBzp98kjHd
         19Rm35xqu7dnFZJ/6WbUH/v7te+5V/12PGNG15vk=
Date:   Mon, 27 Sep 2021 17:26:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Yujia Qiao <rapiz@foxmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] staging: vt6655: fix camelcase in ldBmThreshold
Message-ID: <YVHirHixyOIgvqKB@kroah.com>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-3-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926162527.21462-3-tomm.merciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 06:25:19PM +0200, Tommaso Merciai wrote:
> Replace camel case variable ldBmThreshold with snake case
> variable ld_bm_threshold.

Same here, what exactly does this name mean and why did you pick it?

thanks,

greg k-h
