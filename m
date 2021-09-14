Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A8C40B336
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhINPfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:35:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:24594 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233241AbhINPf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:35:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="244371129"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="244371129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 08:28:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="481865571"
Received: from tjohn2x-mobl.amr.corp.intel.com (HELO [10.209.157.105]) ([10.209.157.105])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 08:28:23 -0700
Subject: Re: [PATCH v2 16/29] ABI: sysfs-bus-soundwire-slave: use wildcards on
 What definitions
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org
References: <cover.1631629496.git.mchehab+huawei@kernel.org>
 <5b868cdb441090cd9c1c4fcc593f069d1b1023d9.1631629496.git.mchehab+huawei@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <89985d2d-2aff-b7d6-ad9f-535655a5feb5@linux.intel.com>
Date:   Tue, 14 Sep 2021 10:28:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5b868cdb441090cd9c1c4fcc593f069d1b1023d9.1631629496.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/21 9:32 AM, Mauro Carvalho Chehab wrote:
> An "N" upper letter is not a wildcard, nor can easily be identified
> by script, specially since the USB sysfs define things like.
> bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
> to convert it into a Regex.

No objection on the convention but shouldn't that convention be applied
to all attributes?

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-soundwire-slave | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-slave b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
> index d324aa0b678f..db6b8ffa753e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-soundwire-slave
> +++ b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
> @@ -64,7 +64,7 @@ Description:	SoundWire Slave Data Port-0 DisCo properties.
>  		Data port 0 are used by the bus to configure the Data Port 0.
>  
>  
> -What:		/sys/bus/soundwire/devices/sdw:.../dpN_src/max_word
> +What:		/sys/bus/soundwire/devices/sdw:.../dp<N>_src/max_word
>  		/sys/bus/soundwire/devices/sdw:.../dpN_src/min_word
>  		/sys/bus/soundwire/devices/sdw:.../dpN_src/words
>  		/sys/bus/soundwire/devices/sdw:.../dpN_src/type

if we change max_word, shouldn't we change all the others as well?
