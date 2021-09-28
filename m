Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C12741A96E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhI1HNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233681AbhI1HNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 029D6611C0;
        Tue, 28 Sep 2021 07:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632813111;
        bh=khzZIf3Q8Je/p+XmCsetm5TFSg0cYIt4rcBHWjjlO3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEQ8g1KfmIObjRjKJ2VFsVVnz5zJeu0vQC4gAqhnLy/oeczn4xNen+L+63j9yHMF6
         LevdCREsdaJpVqA1lHIJvlT9Px+NkOJUD2ldh4CV4ni4EqEgJJhIGhkDtiqa0jS0V5
         8Fgq4nq7PHZbshSmhadpAZ/r+XnX1gs0cuLAOwSQ=
Date:   Tue, 28 Sep 2021 09:11:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: most: dim2: force fcnt=3 on Renesas GEN3
Message-ID: <YVLANRaCgY/CrYdX@kroah.com>
References: <YVHoXyULqXsWktMN@kroah.com>
 <20210927155804.27877-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927155804.27877-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 06:58:05PM +0300, Nikita Yushchenko wrote:
> Per Renesas datasheet, MLBC0 register's fcnt field in the embedded
> dim2 module must be never set to value different from 3.
> 
> Enforce that, via an optional field in struct dim2_platform_data.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
> Changes from v1:
> - set dev_fcnt via if statement, not conditional expression

Much nicer, thanks!

greg k-h
