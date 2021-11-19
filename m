Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6856D456CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhKSKAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:00:32 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:20783 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232441AbhKSKAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:00:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637315847; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=IEO46rDtgspzaK/zNqTgOWED7gSik+/ygymaEd5+7Tk=; b=XB/GN1M5C9hsmoZs2J5xLYbaunCvOWc+pk00g7jtsS/8xac4svmr+Mry6jq5alrlX19F3/2T
 aCfkPsUZE2aVJsfcoMiLRSdjL7puFeVE8KMWUIzxtKNwQqu8ElW/E3T4Uex6PMm57k4yH0iV
 rLL0bZcSt5acFKtR3AOYQZeq1JY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6197750611cd6d40776d7a4d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Nov 2021 09:57:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 866C2C4360D; Fri, 19 Nov 2021 09:57:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E005C4338F;
        Fri, 19 Nov 2021 09:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9E005C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Miles Hu <milehu@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>,
        ath11k@lists.infradead.org
Subject: Re: drivers/net/wireless/ath/ath11k/mac.c:5408:22: warning: parameter 'changed_flags' set but not used
References: <202111190031.U5H7J6W3-lkp@intel.com>
Date:   Fri, 19 Nov 2021 11:57:19 +0200
In-Reply-To: <202111190031.U5H7J6W3-lkp@intel.com> (kernel test robot's
        message of "Fri, 19 Nov 2021 00:53:41 +0800")
Message-ID: <8735nseadc.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   42eb8fdac2fc5d62392dcfcf0253753e821a97b0
> commit: 689a5e6fff75229ac7c2af7a9c51dc2d3ca1882b ath11k: monitor mode clean up to use separate APIs
> date:   8 weeks ago
> config: x86_64-randconfig-a006-20211118 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c46becf500df2a7fb4b4fce16178a036c344315a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=689a5e6fff75229ac7c2af7a9c51dc2d3ca1882b
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 689a5e6fff75229ac7c2af7a9c51dc2d3ca1882b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/net/wireless/ath/ath11k/mac.c:5408:22: warning: parameter 'changed_flags' set but not used [-Wunused-but-set-parameter]
>                                               unsigned int changed_flags,
>                                                            ^

The commit below should fix this:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=624e0a317030

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
