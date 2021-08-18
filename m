Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E6F3EFA46
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbhHRFmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237672AbhHRFmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:42:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ED7E61029;
        Wed, 18 Aug 2021 05:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629265307;
        bh=TtyVd4dGq0qYP7TYqua7W6a9MO+ANKhVkBaH3kwEP1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6nBYXoCyMfpwWbjpV0bS+bMhf/TzHMK+Dy0lyvu/7LebcuCC0bTv1LaZFvKHARRF
         PBRgHqDy2JcW0/EugrMhSHYwTWSaCtcUvMQ25yUaj50lbU63qCx9JsyzSInvSvkuqX
         vTbPE8BEn6OiEfBN0kOPgqVrA62nuUzrsyReMdGs=
Date:   Wed, 18 Aug 2021 07:41:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     straube.linux@gmail.com, dan.carpenter@oracle.com,
        yangyingliang@huawei.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove unused including
 <linux/version.h>
Message-ID: <YRydlwA9kNvI1rvp@kroah.com>
References: <20210818022321.2395-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818022321.2395-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:23:21AM +0800, Cai Huoqing wrote:
> Remove including <linux/version.h> that don't need it
> based on staging-next

No need for this line in here, describing what tree this was made
against.  Please, if you need to say stuff like this, put it below the
--- line.

Can you please fix up and resend?

thanks,

greg k-h
