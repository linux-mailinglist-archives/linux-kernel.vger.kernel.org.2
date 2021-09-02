Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3213FE8D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhIBFiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhIBFiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:38:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DE2260238;
        Thu,  2 Sep 2021 05:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630561036;
        bh=XAOQMmpzS5+K6LZwqRx/7+PbsAYp8B8Dhv0MqbKjc2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bSXgv4fwCAEsGEMzWCUTcl42RW3JvsDGWQ0Fp8gcNT0QTx2v5g/UGHmCx2IQatgbe
         DJ8TwF/efaE/nM67ZbfqVDzTuOgoOggVKPWHGdmwXS6ft01H+C0dwOZBjO98o8EhMM
         M1YfJB1jXKUxvBC4c18oIeLO/JwMjiSCd8bc7eAQ=
Date:   Thu, 2 Sep 2021 07:37:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] driver core: platform: Fix the line-break indentation
Message-ID: <YTBjCA6UcHDgVdCv@kroah.com>
References: <20210902052446.31839-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902052446.31839-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 01:24:45PM +0800, Cai Huoqing wrote:
> Fix the line-break indentation for the helper function
> devm_platform_get_and_ioremap_resource()

Why?  What is wrong with what is there today?  You need to explain _why_
you do something, not just _what_ you did.

If you want to do basic coding style cleanups, please stick with
drivers/staging/

thanks,

greg k-h
