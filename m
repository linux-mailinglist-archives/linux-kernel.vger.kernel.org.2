Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0ED3A0CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhFIG4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:56:12 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:44720 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhFIG4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:56:10 -0400
Received: by mail-wm1-f52.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so308575wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 23:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hpnTnInlVMtv9lfb54LonTg7qGjKde/CO3J4I0t2FLs=;
        b=aZ9V8AKAW8djNScDa76MyNBfnqPy3Y/TdyYAV0H1uVScbbhjqijtfxnDR5gxAFk5FZ
         G9xkjmuz//BeMhlvFW+jwNds9Kwabmr11jXDQI3QP1aLahNKn2D7xEIMNRXrnsn9MViF
         ldJ1cANjIlVU49//8S1OjS6EtNcBgU4Az0plb0gR+160rE6p4ev7qrnROZstRtBjqlg1
         ca3b5aOd8RIOcM6CsRw/TUr8YLsTfqsTwWSnD/sDOWYOwecqxRm5FXs6VaAy9p12/TM7
         o5irV5f1w80AYkuaTKRShGgr42wj9dytW2Q7Fe6H+68COa2vTu7hmeQN8bfZD977GiWi
         4kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hpnTnInlVMtv9lfb54LonTg7qGjKde/CO3J4I0t2FLs=;
        b=YiObc+WmV2c5/+3H3EDrNCDkDGnmZqrD/70DmP2sG1iks5VDIVXCOb75AbU1hgkjkG
         Nq2GEQNYg8HXeo4GXtdH3WZpofzFUh2pM9bfr65sx27IID6C8QD6jtG9Jsb6b4IQXxVn
         ayZkyu7mlgDQfYny8HCIpWvXixWXlVaW0/ovLCglnWuRdjEWCD1tectzAQIiaq0UDtV4
         euPWHfG6E0bJJ3/ZMV+Jv2+wUVsW9H6c006ThaTyUnudDpJDqL/KJk8tk0S5XUGCK3YP
         RtXoNg9JgpvmWvjDLsz3Rtrx3nD/aSClqwLPAzqeQxpBByRqcZhUwcNvR7KdqSpP3GCu
         y1ZQ==
X-Gm-Message-State: AOAM532jmrM+nl4ENcRMNhf9uu+lMBV7v5F+Pk4gVjZycs9ZWYBmxz5T
        idN93xj7N+r7K27yp6fbj3s=
X-Google-Smtp-Source: ABdhPJxvdlOzmPUSylpqNxTyrbpP8+/f0lxkT6xasdAmpDg4hbUeEM4GV5gFA+NrPpkDB0RxDqGudA==
X-Received: by 2002:a05:600c:3b10:: with SMTP id m16mr7983686wms.55.1623221585760;
        Tue, 08 Jun 2021 23:53:05 -0700 (PDT)
Received: from agape.jhs ([5.171.72.116])
        by smtp.gmail.com with ESMTPSA id 89sm23954873wri.94.2021.06.08.23.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 23:53:05 -0700 (PDT)
Date:   Wed, 9 Jun 2021 08:53:03 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 2/2] staging: r8188eu: use eth_broadcast_addr() to
 assign broadcast address
Message-ID: <20210609065302.GA1500@agape.jhs>
References: <20210608141620.525521-1-liushixin2@huawei.com>
 <YL96vz4okNehxCBG@kroah.com>
 <b77a3e7b0923344e8c5b9b17f4788d28f3ccfb4f.camel@perches.com>
 <YL+ib+tJwKckXagY@kroah.com>
 <eb8d5431301686000746524882c06121a2d21189.camel@perches.com>
 <4773dedc-dd39-ce1c-f7a6-58a93799fd92@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4773dedc-dd39-ce1c-f7a6-58a93799fd92@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Wed, Jun 09, 2021 at 11:01:18AM +0800, Liu Shixin wrote:
> On 2021/6/9 1:34, Joe Perches wrote:
> > On Tue, 2021-06-08 at 19:01 +0200, Greg Kroah-Hartman wrote:
> >> On Tue, Jun 08, 2021 at 09:45:49AM -0700, Joe Perches wrote:
> >>> On Tue, 2021-06-08 at 16:12 +0200, Greg Kroah-Hartman wrote:
> >>>> On Tue, Jun 08, 2021 at 10:16:20PM +0800, Liu Shixin wrote:
> >>>>> Use eth_broadcast_addr() to assign broadcast address.
> >>>> That says what you do, but not _why_ you are doing this?
> >>>>
> >>>> Why make this change?  What benifit does it provide?
> >>> The commit message is clear and concise as using available kernel
> >>> mechanisms is better than homegrown or duplicative ones.
> >>>
> >>> Are you asking merely becuse Liu Shixin hasn't had many staging
> >>> commits?
> >> I'm asking because this changelog text does not explain why this is
> >> needed at all and needs to be changed to do so.
> > IYO.
> >
> > IMO it's obvious and fine as is and you are asking for overly
> > fine-grained analyses in commit messages.
> >
> > The subject is clear though the commit message is merely duplicative.
> >
> > It _could_ show the reduction in object size for some versions of gcc.
> >
> > $ size drivers/staging/rtl8188eu/core/rtw_mlme_ext.o*
> >    text	   data	    bss	    dec	    hex	filename
> >   53259	    372	   2430	  56061	   dafd	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc6.new
> >   53355	    372	   2430	  56157	   db5d	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc6.old
> >   54673	    372	   2430	  57475	   e083	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc10.new
> >   54673	    372	   2430	  57475	   e083	drivers/staging/rtl8188eu/core/rtw_mlme_ext.o.gcc10.old
> >
> > It _could_ describe how the kernel mechanisms depend on a minimum
> > alignment of __aligned(2) in the tested address and also show that
> > the address is properly minimum aligned.
> >
> > struct ieee80211_hdr {
> > 	__le16 frame_control;
> > 	__le16 duration_id;
> > 	u8 addr1[ETH_ALEN];
> > 	u8 addr2[ETH_ALEN];
> > 	u8 addr3[ETH_ALEN];
> > 	__le16 seq_ctrl;
> > 	u8 addr4[ETH_ALEN];
> > } __packed __aligned(2);
> > [...]
> > 	struct ieee80211_hdr *pwlanhdr;
> > [...]
> > -	ether_addr_copy(pwlanhdr->addr1, bc_addr);
> > +	eth_broadcast_addr(pwlanhdr->addr1);
> >
> > It _could_ show that the commit has some effect on runtime.
> > It _could_ show that it passes some (unavailable) regression test.
> >
> > IMO: None of those are really necessary here.
> >
> >
> > .
> >
> The variable bc_addr is repeated many times in the code and looks like magic number. I want to simplify the code by remoing unnecessary bc_addr.
> And I think it's better using eth_broadcast_addr() directly rather than using ether_addr_copy() + bc_addr.
> 
> Thanks to Joe for the data.
> 
> Thanks,
> 
> 
> 

I would change the subject line using the proper driver name: 

	'staging: rtl8188eu: ...'

and not the compiled module name that I think it needs to be fixed (r8188eu).

Thank you,

fabio
