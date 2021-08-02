Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10933DCFC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 06:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhHBEhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 00:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:32818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231707AbhHBEhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 00:37:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3166060FC1;
        Mon,  2 Aug 2021 04:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627879030;
        bh=bOV8QRJlZSK0S7Tob0YrhYTd7LxOrJnuNVmVAD3nWv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Irj82VvJt8GldTn81sJ6UBXl7QOcZ3yl6deRr++5lx6t/7qzUSglVFtdHXDjW6Dci
         RJU1NpN61Gcm2jr+kHyXlvm3Icg7u0yheDdGNh//DhczKkTxNMTVLRlNzOwzKYaFf+
         OWXaigfvCUU2OWLcxDvZc0XqkE/y8dYY1zA+ZdFph1PJBlmw20YOWASUPvpyx+d7po
         X97IfQ28MwUDull+1UM1HljNzne7y3M1/7f/0de5CoYVtDP2EM+an2dHAYSzMvYGzE
         JvXUpOTpMKtMpvA9loG8OTkdYG86eB2BKhIaOgJJuBg4Tck382GVuQZjF3YbqFfCkP
         A2FQFPWrmOVlw==
Date:   Mon, 2 Aug 2021 10:07:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Liao, Bard" <bard.liao@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v2 0/6] soundwire/ASoC: abstract platform-dependent bases
Message-ID: <YQd2ckho9D9DF9lJ@matsya>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
 <20210727161133.GY4670@sirena.org.uk>
 <DM6PR11MB40744606D9CD2D3FD27FC92FFFEA9@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB40744606D9CD2D3FD27FC92FFFEA9@DM6PR11MB4074.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-07-21, 00:38, Liao, Bard wrote:
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Wednesday, July 28, 2021 12:12 AM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org; vkoul@kernel.org; vinod.koul@linaro.org;
> > linux-kernel@vger.kernel.org; tiwai@suse.de; gregkh@linuxfoundation.org;
> > srinivas.kandagatla@linaro.org; pierre-louis.bossart@linux.intel.com; Kale,
> > Sanyog R <sanyog.r.kale@intel.com>; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH v2 0/6] soundwire/ASoC: abstract platform-dependent
> > bases
> > 
> > On Fri, Jul 23, 2021 at 07:54:45PM +0800, Bard Liao wrote:
> > > shim base and alh base are platform-dependent. This series suggests to
> > > use variables for those bases. It allows us to use different bases for
> > > new platforms.
> > 
> > The ASoC bits look fine to me, what't eh plan for merging this?  I can apply to
> > ASoC if people like, or should the Soundwire bits go via the Soundwire tree?

I have acked the sdw parts, pls pick them thru ASoC tree. If we have
conflicts, I can merge the immutable tag from your tree.

> Thanks Mark. Apply to ASoC or Soundwire are both fine to me.

-- 
~Vinod
