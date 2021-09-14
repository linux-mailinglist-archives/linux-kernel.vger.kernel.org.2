Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C5740A565
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhINEaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:30:18 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39461 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231817AbhINEaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:30:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 14E293200B04;
        Tue, 14 Sep 2021 00:29:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 14 Sep 2021 00:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=JWdT8ndpqpmw9XpaTGB1QVl61MD
        uDjRulkZk9+RLXl4=; b=KnVvX5jyAO9uqB4m3L4KKxrxCc0cRePdWefHYX/eMya
        /q7PCRW2ATbFvQrLe2Fpzje8m7wY9y0/pXJgDYIBQ4K/P1i/+QCQAoHu6bmUPB+W
        V3M6C2qwnkaLdve0mgmdVMUuII2sqt+dzCKIerk1foFF0fF2kTgb248FfAgUehpJ
        ttnDWJBpw3PDukrh12nvbzyOYCpbL9dKZGLyBnOgrEWA9ceZxVWLOsp5f8TgQwMB
        6QU2a80wIjLcacTuqg9Phr/zRPkMLfw323WK/Dnv+P7SEVLCj5e3pCqW+5dF3l8e
        NsOi63hI+WMkxsz6FuKJOwEHCzs2rhmI/U9dKlPviJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JWdT8n
        dpqpmw9XpaTGB1QVl61MDuDjRulkZk9+RLXl4=; b=Arb7AH/EO++FV+qPNhsagp
        TeXbJlOCUpH6frPj/x9BW0fPxAG+K81me2S71XTCy2Q3aQcFPS7k6elqyjUx5qoG
        g4+Tq8vKeRxQM75Wm7MgqrbEtrg3Apb6taKTZVS6uP9Q9BU/khpLnqxa3nMhbxeG
        7EHeGTTdwbRuxTH4enIs1Qwyhx9HirS6Zu7FK+Udt8XJCwCWRaD6IDNKEV9SADyX
        rWaJtYDj4pw1dWIBZB5TIfNVkbxQQHZMA5nN5d3iEdUo35VTKeZoQuzHKA8srQAl
        hkPWFEu07QO81GtxZCfBpCSBJYpvP98+stmshQQPcs5m4wBkXfL5Ssik5CHIHz2A
        ==
X-ME-Sender: <xms:CyVAYeLknGSRfr-waDxQxclwQg0ANx9utIZAdeqneBFBW28V6hvyHg>
    <xme:CyVAYWKcvhDwNVKqzEs1HPtzrNNG3MFFIzWuD_h3VA1dvygXH4HZ_SAQ5Lrt5qd17
    AN0IWIrDz8MVA>
X-ME-Received: <xmr:CyVAYev5YH8sZI27yUokBkrPiKi9WwxKeoFZr-0ZFgq6_TCpkIy4fx8GNBkynzN6grTIaF4tvQ27Hu2FUVJpukfsEZd2RzRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegkedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmrhhorghh
    qdfjrghrthhmrghnuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrh
    hnpeelgfegjefftdeguedtfeevvefhtdefueeffeejhfeludeugfeigeevleeujeetffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgh
    eskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:CyVAYTb3WtCPMOer4Eh0j2Y-gnb8nSh1jrZ1veJLh5zL5AI8dm1Ysg>
    <xmx:CyVAYVaK4WbM34L3N4A6CMNeh-d6UVeODEomPgCVDq-Z-l_CK6zSHg>
    <xmx:CyVAYfDGfwyzci9GvH8VvqT8A83eX4l1ldvGm4CaieRi-dmPCx3qPw>
    <xmx:CyVAYUlMN32lLRCqxRqqOVDgp7BqqF8ysTbs37PW5ZeXtAgb-xvVFg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Sep 2021 00:28:59 -0400 (EDT)
Date:   Tue, 14 Sep 2021 06:28:39 +0200
From:   Kroah-Hartman <greg@kroah.com>
To:     Tawah Peggy <tawahpeggy98@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: cfg80211: replace
 ieee80211_frequency_to_channel with ieee80211_freq_to_channel.
Message-ID: <YUAk97xkbo+3RTvA@kroah.com>
References: <20210913230211.GA63982@peggy-InsydeH2O-EFI-BIOS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913230211.GA63982@peggy-InsydeH2O-EFI-BIOS>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:02:11AM +0100, Tawah Peggy wrote:
> This patch changes ieee80211_frequency_to_channel(channel->center_freq)
> to ieee80211_frequency_to_channel(channel->center_freq) because the
> function name has originally been changed in a patch in other to fix a
> checkpatch error.
> 
> Signed-off-by: Tawah Peggy <tawahpeggy98@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What commit does this fix?

And why are you not cc:ing all of the needed mailing lists as
get_maintainer.pl asks you to?

thanks,

greg k-h
