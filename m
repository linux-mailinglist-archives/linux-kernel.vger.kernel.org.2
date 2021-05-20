Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA293389D64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhETFyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:54:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhETFyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:54:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 508E7610CC;
        Thu, 20 May 2021 05:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621489999;
        bh=9rMQGnzzBRPlN0Gp2jTsSgysZ5Xta6n6JFuCG3gNC8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzAzdYheGuLila2LodiRyj97bC2Mpi4J0Dnb4Cea0raUOjWs/Axsj2xzjZbSDThrZ
         0W0Ili1ZHxnWDwOLwQPdmjZUFJEBxL7qrYggUbq0K+Rf8rw//kPEPhFvFyQJq3K3pu
         2hb/ErWWq5STfYLFZk2S3NraLPP5lZn9pNQZzzzk=
Date:   Thu, 20 May 2021 07:53:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 2/4] nvmem: eeprom: at25: add support for FRAM
Message-ID: <YKX5S/6rKFhgpqhS@kroah.com>
References: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
 <20210520054714.8736-3-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520054714.8736-3-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 07:47:12AM +0200, Jiri Prchal wrote:
> +static int mypow(int x, int n)
> +{
> +	int i;
> +	int res = 1;
> +
> +	for (i = 0; i < n; ++i)
> +		res *= x;
> +
> +	return res;
> +}

We really don't have a in-kernel function for this today?
