Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D587144EB80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhKLQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhKLQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:40:26 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B20BC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:37:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso8052429pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e7iTg3uUKBh9ZxUEKYMGx8mtlJVEUn+H+Rz33T3uVoM=;
        b=nsrD4v0YgJYBV1mZ1AeZpmbbFBYYCsCQV08NgqAvaUEaOkHZbY4Hicec4VtYfXpAQF
         v9nOoUB+2PaHL6kqpW96ffOMv+g5cO0asAd813mcO3ZYJJQTVqW50d3Hz4Q6cwXI8M65
         bjue0Q0Fy2vK088/JB9RwDOT4MMu45uwsQ1kSNxDxkSD46EluzKZRBy8+Z4DvYELW9eI
         KoSpTRSCC4Lu/DsAp6RJDceECZZu/pr8svArLW013D3wdEsGo17+H4Vbv2S2PcwtCGnl
         7YbDPmmt0N+xv8DnXvS9NqePvcmtQw0tFXQn4wtl3lwpK7fDTNkDP1oobIdhCdcjM/JG
         iOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e7iTg3uUKBh9ZxUEKYMGx8mtlJVEUn+H+Rz33T3uVoM=;
        b=Q14aPNizOK/5GadIr2XyxIud4HuaYiRA8QFgAgC+QrpvlnuJc6aPwpgn26iFAKoB2e
         l+9EM+t4CpuwvdcdpDOVXVcMv94dboB8kbSTAB5sQ/lhNDhO2bmWTUbbvI1v8dQuBWfR
         X2zZzNP2L1ezVLQaEcdHbZ9Jgn5uoNOqG9uvRf3IX8pcYgPshD9Nr15Dv7gep7I0hyah
         aohXSJWAG5q+ZVFYr0uq0uiEiufRw1qWBEh8eb4xbPdjckDCYXCFlPzplxJ4LStj2Y9e
         OmurFwfZ5B6AB/k2nppoGFTr26Fed4f7Zm0PgCsS6xP4+4g5MwV4MaVrkXtKAjFNyXqd
         NLfw==
X-Gm-Message-State: AOAM532pLznrsjJZCbNGaxY2Hz5hNqsJWbDL5MDp8vlhdOs0uVZJ5xuJ
        SeiGC0LCrdv1wvvDCjGV8+Cb5Q==
X-Google-Smtp-Source: ABdhPJyqZiOSqLeGTVRg61sYj3fTdcTrDH7d96OWC7ykTpqEP3q0BM+5wAszcMb6tNcCv7qred2RLA==
X-Received: by 2002:a17:90b:1106:: with SMTP id gi6mr38305386pjb.115.1636735055562;
        Fri, 12 Nov 2021 08:37:35 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t1sm6719895pfe.51.2021.11.12.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:37:34 -0800 (PST)
Date:   Fri, 12 Nov 2021 09:37:31 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jinlong <quic_jinlmao@quicinc.com>
Cc:     Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: Re: [PATCH 05/10] Coresight: Add interface for TPDM BC subunit
Message-ID: <20211112163731.GA2162006@p14s>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
 <1634801936-15080-6-git-send-email-quic_taozha@quicinc.com>
 <20211104180106.GD491267@p14s>
 <20211105082625.GE25738@jinlmao-gv.ap.qualcomm.com>
 <20211112084228.GA24524@jinlmao-gv.ap.qualcomm.com>
 <20211112091034.GA28079@jinlmao-gv.ap.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112091034.GA28079@jinlmao-gv.ap.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 05:10:38PM +0800, Jinlong wrote:
> On Fri, Nov 12, 2021 at 04:42:31PM +0800, Jinlong wrote:
> > [....]
> > 
> > > >  	&tpdm_attr_grp,
> > > > > +	&tpdm_bc_attr_grp,
> > > > 
> > > > It is quite tedious to review all these options at the same time as the core
> > > > drivers.  I suggest to concentrate on the base functionality for now.  When that
> > > > is merged we can add configuration options such as these.
> > > > 
> > > > I am out of time for this patchset and as such will not review the remaining
> > > > patches - those will have to wait for another iteration.
> > > > 
> > > > Thanks,
> > > > Mathieu
> > > 
> > > 
> > > Thank your for all the comments.
> > > We will update the patches.
> > > 
> > > Thanks
> > > Jinlong Mao 
> > > 
> >
> 
> Correct the typo.
> 
>  Hi Mathieu,
>  
>  We will reduce the code changes.
>  There will be code changes below for next version:
>  
>  1. coresight: add support to enable more coresight paths
>  2. Basic function for TPDM(only enable/disable functions)
>  3. TPDA driver
>  
>  Is that ok for you ?

Yes, that sounds much better.

Regards,
Mathieu

> > 
> > > > 
> > > > >  	NULL,
> > > > >  };
> > > > >  
> > > > > -- 
> > > > > 2.17.1
> > > > > 
