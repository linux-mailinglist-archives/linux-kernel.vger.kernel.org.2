Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6530B65D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhBBETn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231491AbhBBETk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:19:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0EBE64ED7;
        Tue,  2 Feb 2021 04:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612239537;
        bh=RDT0bUgRK+Fj0jvAniyFsKdE4wHp6llp9BXuE5SfrCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6EzdWUMpVYMz2ncPSGNpuLf15UmOxwbJDh9x7/03Brv+qYuS54cbhbPriO7m8+f8
         ybKvsKsRcuhfqL7neTnJlCmmCj7YNFmlV+masicOm9bjshbb9AxlQAwUXOL48lv9GP
         oTbg8yp/AFKjpFtpLgWH2zIkETwBPnAyaGMiLkiplGLxjWxJnOxBrXWExzo0F8O2u8
         4cf2dfcXeocMz/R3iQ/i2PQTAKGSr41MVehZZZ5MDUFs7JExttVJhEOmjFmbP1i041
         0PPTqtSOC/XXka1LXfCLUEcbFyIopI/EOBGfEwjuhMOgiA50w33PhnRqUwIneIZ48W
         LafRJAxyVvf+w==
Date:   Tue, 2 Feb 2021 09:48:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
Message-ID: <20210202041853.GF2771@vkoul-mobl>
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
 <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
 <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
 <20210201101414.GS2771@vkoul-mobl>
 <4b850685-1058-0e18-d3e8-e23e20086235@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b850685-1058-0e18-d3e8-e23e20086235@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-02-21, 10:10, Pierre-Louis Bossart wrote:
> On 2/1/21 4:14 AM, Vinod Koul wrote:
> > On 21-01-21, 17:23, Srinivas Kandagatla wrote:
> > > On 21/01/2021 15:12, Pierre-Louis Bossart wrote:
> > > > On 1/21/21 6:03 AM, Srinivas Kandagatla wrote:

> > > I totally agree!
> > > 
> > > If I understand it correctly in Intel case there will be only one Link ID
> > > per bus.
> > 
> > Yes IIUC there would be one link id per bus.
> > 
> > the ida approach gives us unique id for each master,bus I would like to
> > propose using that everywhere
> 
> We have cases where link2 is not used but link0, 1 and 3 are.
> Using the IDA would result in master-0,1,2 being shown, that would throw the
> integrator off. the link_id is related to hardware and can tolerate gaps,
> the IDA is typically always increasing and is across the system, not
> controller specific.
> 
> We can debate forever but both pieces of information are useful, so my
> recommendation is to use both:
> 
> snprintf(name, sizeof(name), "master-%d-%d", bus_id, bus->link_id);

I agree we should use both, but does it really make sense for naming? We
can keep name in ida and expose the link_id as a parameter for
integrators to see in sysfs.

Also, even in intel case you would run into issue if you have two
independent controllers, am not sure if we ever get to see that, but I
think link_id is unique for a controller and not across system, right?

Thanks
-- 
~Vinod
