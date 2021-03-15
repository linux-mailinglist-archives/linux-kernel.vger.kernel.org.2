Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369F933ADB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhCOIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhCOIh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:37:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87C3C64E90;
        Mon, 15 Mar 2021 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615797478;
        bh=KDSymg59GOfRy5f+OAHx8w+Ptrr0mVGOXd6orWt3pIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZ1PpcyzyHJjbYEIsTVdekY1ZBzMfRwfuSOCN9nIBvdyRph6+0TxsKx9ffXRsF5Qp
         PC1WSrCyznjw7tMB0RMzRWNq+H6DFUQcKXoZj3MT512lKqIha14XtrYDjsp+Tf/qch
         QNxJ5f6dfvnHDT4xtXp7xydKFSpyDjCyHfJExObk=
Date:   Mon, 15 Mar 2021 09:37:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chanwoo@kernel.org
Subject: Re: [GIT PULL] extcon fixes for v5.12-rc4
Message-ID: <YE8c4+ArBLB+ENUE@kroah.com>
References: <CGME20210315022041epcas1p1df3749fbe6488d47e58b2da0f64a9edb@epcas1p1.samsung.com>
 <d1835c2d-f24a-4779-8c1a-beaa4bc5729c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1835c2d-f24a-4779-8c1a-beaa4bc5729c@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:37:18AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-fixes pull request for v5.12. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:
> 
>   Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-fixes-for-5.12-rc4

Pulled and pushed out, thanks.

greg k-h
