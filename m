Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD131EDAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhBRRwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:52:14 -0500
Received: from z11.mailgun.us ([104.130.96.11]:45755 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhBRPHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 10:07:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613660784; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=1uExP2WGvf9xPZ33k+OCJqm0dqeYbUXRNsv4T2X8DpA=; b=fstIjlIY8op6J1IIl9HGS7l+lT0ctBL7FrYBxPAmeAZRkCVt9y0bUZ6VNe+r1oGWiU84SBKa
 XrQyHhOwKujbTOHe0/omi/yx0mjaifEfb7OtR9Cf4XPrLYzonNJiW0Rsw0+CDmIsuynOaSpo
 EVDIbAnhLhuF8NCJre9OlQd+aR4=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 602e824eba08663830b8c847 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Feb 2021 15:05:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 08479C43462; Thu, 18 Feb 2021 15:05:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0080DC433C6;
        Thu, 18 Feb 2021 15:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0080DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: undefined reference to `led_classdev_unregister'
References: <202102181657.0GhWB9nF-lkp@intel.com>
Date:   Thu, 18 Feb 2021 17:05:44 +0200
In-Reply-To: <202102181657.0GhWB9nF-lkp@intel.com> (kernel test robot's
        message of "Thu, 18 Feb 2021 16:42:59 +0800")
Message-ID: <874ki9l8l3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f40ddce88593482919761f74910f42f4b84c004b
> commit: 72cdab808714b1ec24b0c7bdebed163ce791f01f ath9k: Do not select MAC80211_LEDS by default
> date:   6 months ago
> config: parisc-randconfig-r002-20210218 (attached as .config)
> compiler: hppa64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=72cdab808714b1ec24b0c7bdebed163ce791f01f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 72cdab808714b1ec24b0c7bdebed163ce791f01f
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    hppa64-linux-ld: drivers/net/wireless/ath/ath9k/gpio.o: in function `.LC54':
>>> (.data.rel.ro+0xe8): undefined reference to `led_classdev_unregister'
>    hppa64-linux-ld: drivers/net/wireless/ath/ath9k/gpio.o: in function `.LC64':
>>> (.data.rel.ro+0x120): undefined reference to `led_classdev_register_ext'

This commit should fix the issue:

b64acb28da83 ath9k: fix build error with LEDS_CLASS=m

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
