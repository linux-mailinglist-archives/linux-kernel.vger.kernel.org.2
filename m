Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1692378AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbhEJL6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:58:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:23992 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235773AbhEJLGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 07:06:06 -0400
IronPort-SDR: +Bwl7WJm7HyERiF8ffGVOzKPyYjCLhItjstAnAwW3Til5si2D28IUbgc6ZaYYS3/egX5sTNwS4
 0oYwbR/v53fw==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="263097994"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="263097994"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 03:57:32 -0700
IronPort-SDR: HnHmct7TUh4WaPUmbcRG7vgw6BcBlsPuR0mT4B95J8XeZ9oh4pJGNB4Gf6D7UzQrvUXcQX+VdQ
 ykg+vNymJLqQ==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="436094109"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.237.180.87]) ([10.237.180.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 03:57:31 -0700
Subject: Re: [PATCH] ALSA: hda: generic: Remove redundant assignment to dac
 and dacs[i]
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org
References: <1620643295-130162-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <959dfc79-cac1-0bb6-e725-874e7f7af0cf@linux.intel.com>
Date:   Mon, 10 May 2021 12:57:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1620643295-130162-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/2021 12:41 PM, Jiapeng Chong wrote:
> Variable dac and dacs[i] is set to zero, but this value is never read as
> it is overwritten or not used later on, hence it is a redundant assignment
> and can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> sound/pci/hda/hda_generic.c:1436:4: warning: Value stored to 'dac' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   sound/pci/hda/hda_generic.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index b638fc2..cce1bf7 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -1433,7 +1433,6 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
>   			path = snd_hda_add_new_path(codec, dac, pin, 0);
>   		}
>   		if (!path) {
> -			dac = dacs[i] = 0;
>   			badness += bad->no_dac;
>   		} else {
>   			/* print_nid_path(codec, "output", path); */
> 

Not entirely true... dacs is passed by pointer, so value assigned to it 
can be used somewhere else.
