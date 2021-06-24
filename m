Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF153B3149
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhFXO3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhFXO3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:29:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C734613F2;
        Thu, 24 Jun 2021 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624544824;
        bh=sHYaaUtH+g2NFrMoMeOWhr8EhC8hzra0BKRr1vJcO5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n34NMTbNqxRrUD8yZop7QeXfVaKUy4EJ0wSwHxa727c9XABF89NmZZczrAllTXT0E
         EfGMkhKeNCavGuu4PPwJhI88Ff7blMB9Fm3eSySlusqwbX6avQat/VG7Xn35va6e0m
         6S0yROl+yWMitSE11kGRRX7Yv/Fh16A0s53eIO0I=
Date:   Thu, 24 Jun 2021 16:27:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v7 3/8] staging: hi6421-spmi-pmic: do some additional
 cleanups
Message-ID: <YNSWNqEqSVugdemY@kroah.com>
References: <cover.1624542940.git.mchehab+huawei@kernel.org>
 <08b3d0eb4256c4fad25652f2aeb701b81d11ece2.1624542940.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b3d0eb4256c4fad25652f2aeb701b81d11ece2.1624542940.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 04:01:32PM +0200, Mauro Carvalho Chehab wrote:
> Before moving this driver out of staging, do a couple of
> cleanups, in order to make the driver clearer.

Please break this up into "one logical change per patch"

thanks,

greg k-h
