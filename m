Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A0B443DF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhKCIGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:06:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:48157 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhKCIGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:06:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635926638; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=/FkqchVfdJSfuR6s2AopchaoLWi2TO8wM4NLBqQNehg=; b=HWrLMsKlbp2Eljw/2/B96vcncpxtHGivIeKsvXexMQCgLCVgjx+Pn5vUmfkUjcUSpqam+U96
 XSZS4gKUVpHTSkmcm/wfi78n3ShmbEcf7AVfFmUdePic7rRsusmzkmdVcWT8YkWhqPrPC4T9
 LZQYrmrebJOUi16bWNN0Z23x5ng=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6182426d545d7d365f7cb88d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Nov 2021 08:03:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2588FC43618; Wed,  3 Nov 2021 08:03:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1893DC4338F;
        Wed,  3 Nov 2021 08:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1893DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Benjamin Li <benl@squareup.com>, kbuild-all@lists.01.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [kvalo-ath:pending 53/53] drivers/net/wireless/ath/wcn36xx/txrx.c:275:42: error: variable 'sband' set but not used
In-Reply-To: <202111022135.B8TpALyf-lkp@intel.com> (kernel test robot's
        message of "Tue, 2 Nov 2021 21:56:46 +0800")
References: <202111022135.B8TpALyf-lkp@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 03 Nov 2021 10:03:47 +0200
Message-ID: <875yt9sm1o.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git pending
> head:   1619f62ef8c1766f887eeef36f4d03f01c16b4c9
> commit: 1619f62ef8c1766f887eeef36f4d03f01c16b4c9 [53/53] wcn36xx: fix RX BD rate mapping for 5GHz legacy rates
> config: arc-allyesconfig (attached as .config)
> compiler: arceb-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?id=1619f62ef8c1766f887eeef36f4d03f01c16b4c9
>         git remote add kvalo-ath https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
>         git fetch --no-tags kvalo-ath pending
>         git checkout 1619f62ef8c1766f887eeef36f4d03f01c16b4c9
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/net/wireless/ath/wcn36xx/txrx.c: In function 'wcn36xx_rx_skb':
>>> drivers/net/wireless/ath/wcn36xx/txrx.c:275:42: error: variable 'sband' set but not used [-Werror=unused-but-set-variable]
>      275 |         struct ieee80211_supported_band *sband;
>          |                                          ^~~~~
>    cc1: all warnings being treated as errors

This is a warning in the pending branch. I'll drop this version,
Benjamin please fix the warning in v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
