Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED854447E53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbhKHK6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:58:41 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:56820 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236942AbhKHK6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:58:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636368950; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=4M9uOTBXUH00cBBpv3ijxurnpayOaBUBlP63Y3jJYOc=; b=bTQBIz3pz92pCNEvG/be2OG82+FNE/cSDhd3Lcoa9UIlqHdGKFaPk4H02FKYp7twLKKESapc
 L57xWp8bjza2Rc7LwgvRQliQjaU/Pqbe6UXBq3t1cu+dvbzpThiadobWlTZQFR7AoeFua+2e
 Y+JPRLvMIkr60/4fqTpzDX5jxBM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 618902318037be2651bc03a6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Nov 2021 10:55:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85223C43617; Mon,  8 Nov 2021 10:55:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92915C4338F;
        Mon,  8 Nov 2021 10:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 92915C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Miles Hu <milehu@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>,
        "ath11k\@lists.infradead.org" <ath11k@lists.infradead.org>
Subject: Re: drivers/net/wireless/ath/ath11k/mac.c:5408:22: error: parameter 'changed_flags' set but not used
References: <202111061154.1NPBOyXF-lkp@intel.com>
Date:   Mon, 08 Nov 2021 12:55:39 +0200
In-Reply-To: <202111061154.1NPBOyXF-lkp@intel.com> (kernel test robot's
        message of "Sat, 6 Nov 2021 11:54:04 +0800")
Message-ID: <87v912q5lg.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ ath11k list

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fe91c4725aeed35023ba4f7a1e1adfebb6878c23
> commit: 689a5e6fff75229ac7c2af7a9c51dc2d3ca1882b ath11k: monitor mode clean up to use separate APIs
> date:   6 weeks ago
> config: hexagon-buildonly-randconfig-r006-20211013 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project b6a8c695542b2987eb9a203d5663a0740cb4725f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=689a5e6fff75229ac7c2af7a9c51dc2d3ca1882b
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 689a5e6fff75229ac7c2af7a9c51dc2d3ca1882b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> drivers/net/wireless/ath/ath11k/mac.c:5408:22: error: parameter 'changed_flags' set but not used [-Werror,-Wunused-but-set-parameter]
>                                               unsigned int changed_flags,
>                                                            ^
>    1 error generated.

Looks like a valid warning to me, can someone submit a patch?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
