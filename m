Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A253812DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhENVeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:34:06 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:10895 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230309AbhENVeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:34:05 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4FhhZr1Vpfz4w;
        Fri, 14 May 2021 23:32:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1621027972; bh=Djm/NR5a0wmp9qybZtVtvTmKM8xCKGXtXFxIgYAHFw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zn7nMib/DFbb0KOqI5CWVItFDkR/tWNGfUnulNLRCBMoXZwPJobyqrP0mW9jEYL8y
         K6zLsH+lT2WETFc7a2lKt+Z62a1olLjVywMmMTST0aatFTsrxFaV0JCLBeqJZKYIux
         cMRNg2HNiE85v0UgeizA/vUEkce8UfW04xLjUJfVOSQ6bwMIbU/o50HJHWnNrQCE+c
         GJkKNZtVR8+3hBuQFciPeiYDLLvIDqsJ6Zb3r6//KawpephHQZ7C0/6iZNSne7PKRs
         vUl42YDpP7vlHTR8CqmSCfOFQ8sqXxZvsbSrVaEbs2lFM3BOOVkoNmjCnSefYVxx/p
         NRFTudhvqK2uw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Fri, 14 May 2021 23:32:51 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nikola =?iso-8859-2?Q?Milosavljevi=E6?= <mnidza@outlook.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Restore voltages before rebooting of NVIDIA Tegra
 SoCs
Message-ID: <20210514213251.GB1969@qmqm.qmqm.pl>
References: <20210510220526.11113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210510220526.11113-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 01:05:24AM +0300, Dmitry Osipenko wrote:
> Hi,
> 
> Nikola Milosavljeviæ reported that rebooting wasn't working properly on
> Asus Transformer TF101, which is Tegra20-based tablet device.  We found
> that TF101 and some other devices have bootloader which doesn't re-initialize
> voltages properly on a reboot.  The problem is resolved by ensuring that
> SoC voltages are at a levels that are suitable for the rebooting of the
> SoC before reboot happens. This series adds reboot handler to the Tegra
> regulator couplers, it bumps voltages on the reboot event.

Which tree does this series apply to?

Best Regards
Micha³ Miros³aw
