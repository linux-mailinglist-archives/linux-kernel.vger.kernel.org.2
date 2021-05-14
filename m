Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59293803BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhENGrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhENGrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:47:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EFC061447;
        Fri, 14 May 2021 06:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620974766;
        bh=LNWmhn0/F3I4Twb0AdNvtSFD/SzwC6jAdWvk+gwCZBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzzpqMGgIXuJr7hx6CQqXRdBPKKVsMTrvIIkpwFFbwVDTtYHqNCe/yPEPrVV8UEAL
         3hNZMO4oMAtJ2oG/vj2XYjiACDAP4egVyT0+ig0Nx2RKPsY1vw1irU7hw1fQYufOyV
         4Jy1cf/CC5HV8+waMQMi7t8pk6sO5xt1+SSx5aNM=
Date:   Fri, 14 May 2021 08:46:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Connor Davis <connojdavis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        xen-devel@lists.xenproject.org, Lee Jones <lee.jones@linaro.org>,
        Jann Horn <jannh@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Mladek <pmladek@suse.com>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2 0/4] Support xen-driven USB3 debug capability
Message-ID: <YJ4cqntf7YdZCOPk@kroah.com>
References: <cover.1620950220.git.connojdavis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1620950220.git.connojdavis@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 06:56:47PM -0600, Connor Davis wrote:
> Hi all,
> 
> This goal of this series is to allow the USB3 debug capability (DbC) to be
> safely used by xen while linux runs as dom0.

Patch 2/4 does not seem to be showing up anywhere, did it get lost?

thanks,

greg k-h
