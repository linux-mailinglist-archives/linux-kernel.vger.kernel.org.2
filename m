Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C63D890D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhG1HqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhG1HqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:46:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCE3C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:46:13 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1m8eGT-0006hg-9S; Wed, 28 Jul 2021 09:46:05 +0200
Date:   Wed, 28 Jul 2021 09:46:05 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, fabioaiuto83@gmail.com
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu
 driver
Message-ID: <20210728074605.pp5rs4c65tofnqot@viti.kaiser.cx>
References: <20210727232219.2948-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727232219.2948-1-phil@philpotter.co.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp and all,

Thus wrote Phillip Potter (phil@philpotter.co.uk):

> The driver currently in staging is older and less functional than the
> version on Larry Finger's GitHub account, based upon v4.1.4_6773.20130222.
> This series of patches therefore:

[...]

> V4: don't remove old driver now, just mark as deprecated and modify to
>     allow building alongside the new driver.

Basically, you're suggesting to put aside all the fixes and cleanup
that was done since the rtl8188eu driver was imported into the kernel
tree. The TODO file says

- merge Realtek's bugfixes and new features into the driver

Why aren't we going down this route?

Edimax offer a realtek driver linux_v5.7.6.1_36803.20200602 for
rtl8188eu as a .zip file for download on their website

https://www.edimax.com/edimax/mw/cufiles/files/download/Driver_Utility/EW-7811Un_V2/EW-7811Un_V2_Linux_Driver_1.0.1.2.zip

If we integrate and fix the v4.1.4_6773.20130222 driver, are we running
the risk that someone else will come along and propose another replacement?

Thanks,
Martin
