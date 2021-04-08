Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20242357CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhDHGqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhDHGqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:46:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2345260C3E;
        Thu,  8 Apr 2021 06:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617864364;
        bh=kgaR456sN1WaGdXto/KIuDzgffU96uYwaDi1mKu1a4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WcDQmmrGvl1RJ4XKbTNEB5QdIrnVg+a/BM78gaXzA+CvmphmD+7ca935xzeEfdU9D
         VlbGLhjDsp+jIioDLO7+4S3SiI3RyVgCc+DiQ3HrKJRiRxcBxSbguuoryZuuPayZKy
         bPGZChZWTWIK+zcW2oHsy5W6BO7u27JFmKRfoqhg=
Date:   Thu, 8 Apr 2021 08:45:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chanwoo@kernel.org, cwchoi00@gmail.com,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.13
Message-ID: <YG6moHwO/Wno9n4f@kroah.com>
References: <CGME20210408062703epcas1p22b2d793d4c5f7231964ff258e2ba40e5@epcas1p2.samsung.com>
 <6b1dea1d-331c-e349-6ff4-14585826cc52@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b1dea1d-331c-e349-6ff4-14585826cc52@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 03:44:35PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.13. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:
> 
>   Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.13

Pulled and pushed out, thanks.

greg k-h
