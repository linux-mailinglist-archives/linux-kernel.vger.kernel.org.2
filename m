Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5187A45D4D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348338AbhKYGea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347916AbhKYGc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:32:27 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE9CC061399
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:26:43 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c4so4976331pfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3KRVplZvCkFOfOVdJLJgvxv7eUeJSjbE0R2ZMjgK8Fg=;
        b=qg7NUJu8MPy9axIndKBSZG/A9a117Qks+SvprKKIx/6u5Dvo/wfW0dxXbnZkcYB28o
         5B17LrKsuz/lmmXBBKRG1orqyFioG0onD0PqUjHrRQL2hHgz3PwlzwxqosZ3wLqzkj95
         UFuYnqXqUObbeHSfCMVySNCroM4b3vD5tROZ069p2SjZyi8C7muv2zb9cvBIyErJBLIf
         7yfIgTo4lBszagYEVQnQN7ArIulNHpavFKtGJAway+kSQ+jAAGPVPNJIYzhBBO3ug9dh
         jt0oPZLzO/XbNsOClyXigay8drAl7EgarlADNCKFMrujlcfFlrXL2QaRS/Wl9NC1qKdr
         qCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3KRVplZvCkFOfOVdJLJgvxv7eUeJSjbE0R2ZMjgK8Fg=;
        b=n9be5YljlZmdwSqZJuzC1ztiUdyZEtri//Sr9dXna8YxS8zW7r+c6o2yORXmRT5mgz
         R5M8YgVUqvA3pp5VXiXIacXjIfHItLMRIX1LKuksCUPTgLpHqrpfR+kJHMjIokQgkLjM
         lHd01DVzNdl+yLQwaRJnj24o6VfuIETvb03ghhLwmljOFapUkbuqK0ELxqIE82WhmVwZ
         3IgBYon8B+gBe5/pqE9Er4g7aJjeErjZGuGjrulNbvwKsTIwua8ZgAczhlxfrg+78EnV
         Ko9q/lM0/nuQcR46lX8PIT1SgbkwcFPOmj11sZZ/q659/GIV/NGnicjiD1GXb3u8EAHm
         fQew==
X-Gm-Message-State: AOAM531Kw5NhQcIx6uBZSKaJUEldvfNlD7PdH4Qws3SGlqarpOpT7iqg
        Scy7rFY2mESdpGd1N8huJF6O/A==
X-Google-Smtp-Source: ABdhPJxroYaq42S+P8YT4URm9RJBoYTh6XWDOXusK9S3jNhc0+OPin92kb/rtWyJBd7dnKPLjtIrIg==
X-Received: by 2002:a63:155d:: with SMTP id 29mr14353211pgv.302.1637821602409;
        Wed, 24 Nov 2021 22:26:42 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:cd6a:1959:1c65:cc19])
        by smtp.gmail.com with ESMTPSA id o23sm1706196pfp.209.2021.11.24.22.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 22:26:42 -0800 (PST)
Date:   Thu, 25 Nov 2021 14:26:37 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v3 3/3] firmware: mediatek: add adsp ipc protocol
 interface
Message-ID: <YZ8snZR/KHLDhIlf@google.com>
References: <20211124084514.28002-1-allen-kh.cheng@mediatek.com>
 <20211124084514.28002-4-allen-kh.cheng@mediatek.com>
 <YZ4TGvtwO5ySCEkT@google.com>
 <43976e8aab2e3055195d8e9c2f466a804e4d2ba7.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43976e8aab2e3055195d8e9c2f466a804e4d2ba7.camel@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 09:47:22AM +0800, allen-kh.cheng wrote:
> On Wed, 2021-11-24 at 18:25 +0800, Tzung-Bi Shih wrote:
> > On Wed, Nov 24, 2021 at 04:45:14PM +0800, allen-kh.cheng wrote:
> > > +	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
> > > +		chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
> > > +		if (!chan_name)
> > > +			return -ENOMEM;
> > > +
> > > +		dsp_chan = &dsp_ipc->chans[i];
> > > +		cl = &dsp_chan->cl;
> > > +		cl->dev = dev->parent;
> > > +		cl->tx_block = false;
> > > +		cl->knows_txdone = false;
> > > +		cl->tx_prepare = NULL;
> > > +		cl->rx_callback = adsp_ipc_recv;
> > > +
> > > +		dsp_chan->ipc = dsp_ipc;
> > > +		dsp_chan->idx = i;
> > > +		dsp_chan->ch = mbox_request_channel_byname(cl,
> > > chan_name);
> > > +		if (IS_ERR(dsp_chan->ch)) {
> > > +			ret = PTR_ERR(dsp_chan->ch);
> > > +			if (ret != -EPROBE_DEFER)
> > > +				dev_err(dev, "Failed to request mbox
> > > chan %d ret %d\n",
> > > +					i, ret);
> > 
> > If ret == -EPROBE_DEFER, wouldn't it need to return
> > -EPROBE_DEFER?  It doesn't retry later if -EPROBE_DEFER.
> 
> If ret != -EPROBE_DEFER, it will show a error message then goto out.
> 
> If ret == -EPROBE_DEFER, probe funcation also will goto out. 
> 
> 
> Both of them will return ret. will not go to next round.

I see.  I misunderstood.
