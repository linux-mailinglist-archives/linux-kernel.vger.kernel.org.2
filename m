Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47C4059A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhIIOtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:49:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241698AbhIIOsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:48:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAEF0611B0;
        Thu,  9 Sep 2021 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631198862;
        bh=Dz/OOUamLZNNHgporcJbIVgfcdT9MPY39TSGUVp8YKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlXZ8ig5LFKt5nySMsmNqcvj9N0NGiSHlJnSyYkoEaErTynyQqibuV7k3LT1w7vjo
         H0jy+qQtpWi3aBvryvheZhPM008LNRfdXPofGsBN02tQitwSDwNgXSr6dUMu/AgvhY
         9ducIeaNn6lyD0/sbi/V90SDfoUb2XNzbkfWCkuWcOxrySPn+v46yC56akSRA9Iv7s
         Wez8eeyovNqtcFHsOtV63plqtlMc11iwD5Mrkrjia0QwNVL8vPRys0EDwklvJ3gYhA
         V4kb5ksdiUCKkPSg5KREYd1NZca/zeqf0cxrvV6EOoD/zyty+fWsniBq3ag3gEz+e7
         DyIaOdMZPO1Kg==
Date:   Thu, 9 Sep 2021 07:47:39 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Message-ID: <20210909144739.GA2464330@dhcp-10-100-145-180.wdc.com>
References: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 05:50:21PM +0800, Jiapeng Chong wrote:
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> 
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/nvme/host/core.c:786 nvme_configure_directives() warn: missing
> error code 'ret'.

Nak, the code is correct as-is. Returning a negative error for this
harmless condition will result in disabling the controller when we can
proceed just fine without directives.
