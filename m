Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8664B3B1913
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFWLk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhFWLks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:40:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A3DE600D3;
        Wed, 23 Jun 2021 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624448310;
        bh=S898zwNpsinFowMpLRyDEegavX6x/+MKEGLEmq46PZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCgnjq6LFKZr7vrAe8w5an+Zaz1v2JDT49COGfNBASX4ds+VOgFxh1BXqUCrgCGTN
         7+FHa6FUl6lKPO06hq1gtRUo5mbHuWqlCEEqruK3Ii/0DGuYWcu3W/lujLlBkwNf5l
         YYYlEGt0oW+5eDZRWMP6VuFxVky2WqrtYNHM1LxA=
Date:   Wed, 23 Jun 2021 13:38:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.14
Message-ID: <YNMdJIDOm92Fsfr/@kroah.com>
References: <CGME20210623094841epcas1p16ed20c34344bde1fd1720e8ca73d4ad3@epcas1p1.samsung.com>
 <985190ea-dafc-875e-49d5-e40011c00406@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985190ea-dafc-875e-49d5-e40011c00406@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 07:07:55PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.14. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:
> 
>   Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.14

Pulled and pushed out, thanks.

greg k-h
