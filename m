Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AB2456140
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhKRRR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKRRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:17:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67582C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CUycP2LZnN7zuYOCH9WxVdJP0m6obMv2LWcKMo1HU0o=; b=gGb8Q3hPeNE17RgKw+rVgmYBDW
        38/6qcnlWBUQaiaN8mttoMMYb5a9P2SVdqDnvLMCo+NgADha4bLD7cLVK+u1PPby0cTXW9tzkWGYD
        gGQkVftSXCceQaV5vqQMXzKX/46hm9Iq4x4rzS4gZohXwQhLd3tNuBa4bogGvT2NeewlRQ/SNpUFD
        MK2PqB/J33M6UcHSXIvKCfbNnLY97sxrh+jSrpW5XpDWF+waktBqKkdkOrYQro1gJbPgGaDFlkGke
        Unk5jtltS9X0J0iH8eAId1rl3ywqD5OhPidELO5sMXi2tggfgbQNy1CsgsnUJmmO0pAIzJodYLyIK
        NRAXFzZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnkzn-008R1H-Vb; Thu, 18 Nov 2021 17:14:47 +0000
Date:   Thu, 18 Nov 2021 09:14:47 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mcgrof-next:20211117-sysctl-cleanups-all-set-04 22/36]
 kernel/printk/sysctl.c:82:13: warning: no previous prototype for
 'printk_sysctl_init'
Message-ID: <YZaKB13xLCw/5Eck@bombadil.infradead.org>
References: <202111182027.kz6TCPoO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111182027.kz6TCPoO-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 08:28:35PM +0800, kernel test robot wrote:
>   > 82	void __init printk_sysctl_init(void)

When PRINTK is not set this pukes. I fixed it, thanks!

  Luis
