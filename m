Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1147541E6D3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 06:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351817AbhJAEjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 00:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhJAEjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 00:39:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3324B61A54;
        Fri,  1 Oct 2021 04:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633063078;
        bh=t5IURBDxfZPai/CGrMzCSvsfRwGEicSy+gaqsFTHCdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8x1lO2IZANAIkvkRE36jcRwzbLcEG5INzAL0THLU6GTNwyGAw3WRaHxrdXufgTEj
         vOsWsPOxkU33wakgddjZe0mhQ4Y7jdIovbQAvIiCCB6aTb3N/+dFvnFGDso3Ma9/Jo
         nPFBZepRmn761dx4282Bnd5gD+jMD5flNa7ZOS5dX6AbTq739a7uDoC9FUOEPoRc7p
         f0n6HWlRb/LmYmea8xanzCK14ssZwEecIsm/vHPlntCYJLCL4gHbvJv//p3AgQtirl
         08g7x0uCvIQOFRAWbVQ7vDXWOz/F78WPlsBSn6UKkB5oqHq0c8+WHMYcH3yNxrL4p7
         XPLuEJyho/EBQ==
Date:   Fri, 1 Oct 2021 10:07:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/30] ABI: sysfs-bus-soundwire-slave: use wildcards
 on What definitions
Message-ID: <YVaQohW0ykARCJJh@matsya>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
 <416f4a746c116147abb08fb0155a6a4ed065dfd7.1631782432.git.mchehab+huawei@kernel.org>
 <9a379f0a-e076-844c-fb5d-130359e36754@linux.intel.com>
 <20210916184757.4f0b3cbf@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916184757.4f0b3cbf@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-21, 18:47, Mauro Carvalho Chehab wrote:
> Hi Pierre,
> 
> Em Thu, 16 Sep 2021 11:36:33 -0500
> Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> escreveu:
> 
> > On 9/16/21 3:59 AM, Mauro Carvalho Chehab wrote:
> > > An "N" upper letter is not a wildcard, nor can easily be identified
> > > by script, specially since the USB sysfs define things like.
> > > bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
> > > to convert it into a Regex.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > 
> > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Thanks!
> 
> > 
> > I also realized that we have a similar with the 'master' case
> > 
> > more sysfs-bus-soundwire-master
> > What:		/sys/bus/soundwire/devices/sdw-master-N/revision
> > 		/sys/bus/soundwire/devices/sdw-master-N/clk_stop_modes
> > 		/sys/bus/soundwire/devices/sdw-master-N/clk_freq
> > 		/sys/bus/soundwire/devices/sdw-master-N/clk_gears
> > 		/sys/bus/soundwire/devices/sdw-master-N/default_col
> > 		/sys/bus/soundwire/devices/sdw-master-N/default_frame_rate
> > 		/sys/bus/soundwire/devices/sdw-master-N/default_row
> > 		/sys/bus/soundwire/devices/sdw-master-N/dynamic_shape
> > 		/sys/bus/soundwire/devices/sdw-master-N/err_threshold
> > 		/sys/bus/soundwire/devices/sdw-master-N/max_clk_freq
> > 
> > If there is an update we should modify this as well for consistency with
> > sdw-master-<N>?
> 
> It is on patch 15/30:
> 
> 	https://lkml.org/lkml/2021/9/16/198
 we should have been cced :(

Thanks to b4, I was able to grab this and apply as well

-- 
~Vinod
