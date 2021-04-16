Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7E361A16
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 08:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhDPGy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhDPGy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:54:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 920B0610FC;
        Fri, 16 Apr 2021 06:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618556043;
        bh=WVEAR4/mOGJcfwKtKTiJzRqxOkx5jC2Bf3OQ5/TkxUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYbIKYmhEdoNZ4dHlIR7UKkFPN/8f2uhPVxZ1GriR4mN/iiPD33tg++lwpZFQg1Xc
         WZb07o98Lc5xrMyPideF3ux1HjqXv1cptwO8JPtWegQQ4G//tfmjLnILkBqE1S3LSp
         S9eGjetNR37hD+fSte9+PL7Q7jbIJ5vnkUCfbR8s=
Date:   Fri, 16 Apr 2021 08:54:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     mike.leach@linaro.org, leo.yan@linaro.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] coresight: Fix for v5.12-rc7
Message-ID: <YHk0iDnfujBR3mTB@kroah.com>
References: <20210415202404.945368-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415202404.945368-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 02:24:03PM -0600, Mathieu Poirier wrote:
> Hi Greg,
> 
> Please consider this patch as a fix for v5.12-rc7.  Applies cleanly
> to your char-misc-linus branch (e49d033bddf5).

It's too late for 5.12-final, and really my tree should be closed for
5.13-rc1 now.  I can sneak this in for the merge window, is that ok?

thanks,

greg k-h
