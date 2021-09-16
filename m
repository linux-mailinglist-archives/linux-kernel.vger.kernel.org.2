Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3984440E8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354882AbhIPRko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349168AbhIPRdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:33:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D11E263221;
        Thu, 16 Sep 2021 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631810881;
        bh=dvJtbAULpl1zaR+kHUxtHnl5crOxIQDgnI+LHU/i0IA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PoxINvY/maw7+UuKeylard+lca3z+A751s4OGWli7HPGBcigr2U7pO/i2w/rSzaH/
         Sow+NwwYtPpbjzjckhWbgW7Cv9AAgDqFyN14QWA4CAEb75gZN+oWQydwrkESRf1iWg
         OmO10Bf4fA+xbEw6INXeBnypfD06JhPFcsobGggxwksqyfXkvRIxAIA1kU7HtbH/ym
         yIPLIx2C1i9R6lS6//aGNc2MOZEh1TsvvQhWCDbIQWDCTgZBlDgrz2Nww/9pYA3Nrn
         QAothIQZzyJH3no2j15OloVUTGa5mnQdnE57kG6hS7T4iVulaG9QNtz6cfIyP4z9wR
         uz2GUHrsmZaEw==
Date:   Thu, 16 Sep 2021 18:47:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/30] ABI: sysfs-bus-soundwire-slave: use wildcards
 on What definitions
Message-ID: <20210916184757.4f0b3cbf@coco.lan>
In-Reply-To: <9a379f0a-e076-844c-fb5d-130359e36754@linux.intel.com>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
        <416f4a746c116147abb08fb0155a6a4ed065dfd7.1631782432.git.mchehab+huawei@kernel.org>
        <9a379f0a-e076-844c-fb5d-130359e36754@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

Em Thu, 16 Sep 2021 11:36:33 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> escreveu:

> On 9/16/21 3:59 AM, Mauro Carvalho Chehab wrote:
> > An "N" upper letter is not a wildcard, nor can easily be identified
> > by script, specially since the USB sysfs define things like.
> > bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
> > to convert it into a Regex.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks!

> 
> I also realized that we have a similar with the 'master' case
> 
> more sysfs-bus-soundwire-master
> What:		/sys/bus/soundwire/devices/sdw-master-N/revision
> 		/sys/bus/soundwire/devices/sdw-master-N/clk_stop_modes
> 		/sys/bus/soundwire/devices/sdw-master-N/clk_freq
> 		/sys/bus/soundwire/devices/sdw-master-N/clk_gears
> 		/sys/bus/soundwire/devices/sdw-master-N/default_col
> 		/sys/bus/soundwire/devices/sdw-master-N/default_frame_rate
> 		/sys/bus/soundwire/devices/sdw-master-N/default_row
> 		/sys/bus/soundwire/devices/sdw-master-N/dynamic_shape
> 		/sys/bus/soundwire/devices/sdw-master-N/err_threshold
> 		/sys/bus/soundwire/devices/sdw-master-N/max_clk_freq
> 
> If there is an update we should modify this as well for consistency with
> sdw-master-<N>?

It is on patch 15/30:

	https://lkml.org/lkml/2021/9/16/198

Regards,
Mauro		

> 
> > ---
> >  .../ABI/testing/sysfs-bus-soundwire-slave     | 60 +++++++++----------
> >  1 file changed, 30 insertions(+), 30 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-slave b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
> > index d324aa0b678f..fbf55834dfee 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-soundwire-slave
> > +++ b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
> > @@ -64,37 +64,37 @@ Description:	SoundWire Slave Data Port-0 DisCo properties.
> >  		Data port 0 are used by the bus to configure the Data Port 0.
> >  
> >  
> > -What:		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_word
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/min_word
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/words
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/type
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_grouping
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/simple_ch_prep_sm
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/ch_prep_timeout
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/imp_def_interrupts
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/min_ch
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_ch
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/channels
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/ch_combinations
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_async_buffer
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/block_pack_mode
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_src/port_encoding
> > +What:		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_word
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/min_word
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/words
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/type
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_grouping
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/simple_ch_prep_sm
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/ch_prep_timeout
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/imp_def_interrupts
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/min_ch
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_ch
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/channels
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/ch_combinations
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_async_buffer
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/block_pack_mode
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/port_encoding
> >  
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_word
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/min_word
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/words
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/type
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_grouping
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/simple_ch_prep_sm
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/ch_prep_timeout
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/imp_def_interrupts
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/min_ch
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_ch
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/channels
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/ch_combinations
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/max_async_buffer
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/block_pack_mode
> > -		/sys/bus/soundwire/devices/sdw:.../dpN_sink/port_encoding
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_word
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/min_word
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/words
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/type
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_grouping
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/simple_ch_prep_sm
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/ch_prep_timeout
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/imp_def_interrupts
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/min_ch
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_ch
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/channels
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/ch_combinations
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/max_async_buffer
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/block_pack_mode
> > +		/sys/bus/soundwire/devices/sdw:.../dp<N>_sink/port_encoding
> >  
> >  Date:		May 2020
> >  
> >   



Thanks,
Mauro
