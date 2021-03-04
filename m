Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F4532D57F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhCDOjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:39:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:52325 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhCDOjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:39:33 -0500
IronPort-SDR: wJklkjAGV3FKAtj9VOngOZN70RfjruyiMmQRT2MMdqQ8UIHPUbs63yDSQEVSG31TLod9dOj81Y
 nimfikTVYGhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="174539929"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="174539929"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 06:37:47 -0800
IronPort-SDR: DV1joKPPeNpy9YiUxp2hZVA301uN80SfxooAh9kVab2BkDDJTGXLY6ObkOhS0hPrPhae+4B8YD
 nPRXwqkSR7VA==
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="507406467"
Received: from hmsaaved-mobl1.amr.corp.intel.com (HELO [10.212.160.49]) ([10.212.160.49])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 06:37:46 -0800
To:     linux-kernel@vger.kernel.org
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: regression with TTY changes in v5.12-rc1
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Message-ID: <00154592-c5ee-aaba-956e-b265473b53bc@linux.intel.com>
Date:   Thu, 4 Mar 2021 08:37:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Our SOF/audio CI shows an across-the-board regression when we try 
v5.12-rc1, specifically on pause/resume tests with an interactive 
terminal running 'aplay -i' commands managed by expect to simulate the 
user pressing the space bar to pause/unpause. It turns out the processes 
are not longer killed and the audio devices remain busy (see publicly 
available test results listed below).

git bisect points to commit 33d4ae9885987 ("drivers:tty:pty: Fix a race
causing data loss on close"). Reverting the patch fixes the issue on all 
test devices.

Further analysis with Corey Minyard points to a problem where a slave 
tty will not get a SIGHUP when the master is closed.

Unless there is an alternate fix, a revert looks necessary?

Regards
-Pierre

https://github.com/thesofproject/linux/pull/2772
https://sof-ci.01.org/linuxpr/PR2772/build5352/devicetest/
