Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED21432D68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhJSFwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhJSFv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:51:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57D9760F46;
        Tue, 19 Oct 2021 05:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634622586;
        bh=rQloIryMv0HhFIsTzvWz8cG6c81v5XbKulgqtGe5oMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMPCUCAfqUtw8rJmYCKZJsEOw/CMwHrfR7jC5+XbhE7KB0LB36e6+TaovvqdpoS8T
         VPMKNCpJwVHr2vG+5ZNr73Y2GAbwyudwRer6u0AYUTIXQWP62ZNV9/Yr/5AXeMjw49
         VprmGCxbuAcqFW39DWGkd6P7WskDKkWqSQC02z9E=
Date:   Tue, 19 Oct 2021 07:49:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: fix camelcase byData in card.c
Message-ID: <YW5ceCLSIRl5zJIm@kroah.com>
References: <20211018192124.8738-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018192124.8738-1-tomm.merciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 09:21:22PM +0200, Tommaso Merciai wrote:
> Replace camelcase variable "byData" into linux kernel coding style
> equivalent variable "data" in card.c.
> "by" prefix in hungarian notation stands for byte or unsigned char
> 
> References:
>  - https://www.cse.iitk.ac.in/users/dsrkg/cs245/html/Guide.htm

Don't provide web links in a changelog text, they might not endure.

>  - https://www.kernel.org/doc/html/v4.10/process/coding-style.html

Why the old and obsolete 4.10 kernel document?

thanks,

greg k-h
