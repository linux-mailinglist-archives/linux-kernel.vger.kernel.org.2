Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D7833A77B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 19:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhCNSSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 14:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhCNSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 14:18:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3CFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 11:18:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d15so7559626wrv.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p+POuGrNYEgl5ZmUe9GYUe8ESmbbmhapN7mzSH3N5is=;
        b=vg/vg18eF1c3ABXSKuj6Nphml3m+uu5rE9oFBCtnyX3vNpdh9mWZsySexWISJUaScd
         WW2T9Ti5bT0loR/ZJ8L63UfsUxpHr3nzcx02bwGF8zQiMQw7BoW1OvjtNe1gM4hwv6QN
         vq0NMw9Hse7CeqYMBprh3CxY58RxjupvJu2K45pnX0MifpilAf+QQ1dLBrbwZaUUQMmL
         N5xPnRvHz0SZlwjEkqUuh5muF9LumFAyY84CmtyNwgasc/kpcpEz34T2CxtW0gL0Lk3N
         kwFx/HtAv9eTya9B3EKWyxtKgj+0fmF8jCwbuxNhQpxCE1pzcElbF5JeXkEKZ2Fuyhw4
         SeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p+POuGrNYEgl5ZmUe9GYUe8ESmbbmhapN7mzSH3N5is=;
        b=sEPkTH46WNPcHHysOa/w26gkCiizzU8F1Ld9ygkc2LKCF6qzBKq7j72MPEWZQIXryg
         SPNjJE5Uqxvqy7hY28n9a+iVBa3Ic1yXKD3eu17I7Lek7XG6IFqC8xExfi8vqd6nallN
         H3hl2Pw/cjTHmEsxn/zEekAvT6HltFssvk7i07ubA0TssTqOqxH6WE44mwGE2Arlz6mR
         ePF7CPj6GmGEd7rEuLlq/dRh2Kcr3uuTThO2ZZkSTkus2OEpR8MqeV5C7zRjLRDscRT+
         Ssc9kuwsPhcjHmXPEp9QhHsXlKtt377WBjxFpqlNX6UbEnxAKQAzKNW3ISA2HLtQp6w2
         KgTA==
X-Gm-Message-State: AOAM532E9hdutCErQJbrCLRfTMoR0Mn160glGdSnj0IIr4wCt+OcirA+
        4Ra3Nz+IC38gYLl5Rkjcerc=
X-Google-Smtp-Source: ABdhPJzpdlHUSytyEuV/FMHSQTw3E0Wcs+O6wS00oYlNOG50iVcdMr4mm+ubJbrZM38I3IeWYORKUg==
X-Received: by 2002:a5d:5904:: with SMTP id v4mr24132060wrd.261.1615745904201;
        Sun, 14 Mar 2021 11:18:24 -0700 (PDT)
Received: from agape.jhs (an-19-176-195.service.infuturo.it. [151.19.176.195])
        by smtp.gmail.com with ESMTPSA id 1sm10206985wmj.2.2021.03.14.11.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:18:23 -0700 (PDT)
Date:   Sun, 14 Mar 2021 19:18:21 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] staging: rtl8723bs: remove unused code blocks
Message-ID: <20210314181820.GA1443@agape.jhs>
References: <cover.1615572985.git.fabioaiuto83@gmail.com>
 <YE4ychoJngfPye1O@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YE4ychoJngfPye1O@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 04:57:38PM +0100, Greg KH wrote:
> On Fri, Mar 12, 2021 at 07:33:13PM +0100, Fabio Aiuto wrote:
> > This patch set removes unused code blocks as required in TODO file:
> > 
> > 	find and remove code blocks guarded by never set CONFIG_FOO defines
> > 
> > Changes in v2:
> > 	- modified sunject lines to make them unique
> > 	- added a patch previously excluded (removal of
> > 	  CONFIG_PNO_SET_DEBUG code)
> > 
> > Fabio Aiuto (4):
> >   staging: rtl8723bs: remove unused code blocks conditioned by never set
> >     CONFIG_PNO_SET_DEBUG
> >   staging: rtl8723bs: remove unused code blocks conditioned by never set
> >     CONFIG_PNO_SUPPORT
> >   staging: rtl8723bs: remove unused code blocks conditioned by never set
> >     CONFIG_WOWLAN
> >   staging: rtl8723bs: remove unused code blocks conditioned by never set
> >     CONFIG_TCP_CSUM_OFFLOAD_RX
> 
> The first 2 patches here worked, the others did not apply to my tree due
> to other changes from other developers.  Can you please rebase them and
> resend?
> 
> thanks,
> 
> greg k-h

just sent,

thank you,

fabio
