Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F1315F76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhBJG1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhBJG0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:26:17 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB5C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 22:25:37 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b145so614417pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 22:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T6iLwlvBFG1EiaZPDKGBqgctstyNp7MrLxck6nK7ef8=;
        b=nYi8+aZl046CuZe4rtb1FYS68GX7vAraXSHJK2kEQh6ksl1jDiTmgaTSSsD5HrN8Sw
         NmY95337W6sIudQTqwd3/bEbk8QZSjw8j3bkRMEaIIb7ehGiO50xfs2uEGThAPmQJlXx
         P+LAAAumvq/jD9GZ5cfGJXnDU+KxiwTorzBL+zq/eSLtKCAAqsWGMwuUeiVhkyPcTwRv
         TKmahcy22dE6jlAbYS/ItLWGR1NF+m7Kccpp1LJJfv4QaiS25K1tmod70gFDpgnbKKVV
         9u1Xndn7HmlIwapjUPqd21Ywhd8HE1ExFPfCibmLzNvpW29n/7G0D4cDHrkdt5N4pcDO
         wGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T6iLwlvBFG1EiaZPDKGBqgctstyNp7MrLxck6nK7ef8=;
        b=b/gjaxLk3USUI7Bg3vf031WLjuXG/3BY69nAJOn0a2W84hFZ0+Jx4BmcQ56A7oNvwh
         iEfVUk8kARP5oxgSwzB264+Tld/FwmsJSWEp/v+NtJczPiMB0ydiwrLEB9eo8wIAo7ub
         kTDg0VC2utLuW9z2qfHSxs/y4Cp0+giMTS000uA+0Nq0ToE+JLVosgBIv2c1m3mOFtIt
         8nSyW5ER3ZSc1RH3UrraYU3cP0vXqQ36s0peKJUaAE4hpG3omXAkTxlMzaLGi1joDOYO
         wDKO+OVZ/94anJ89Pruf10HKs/LDYoYx0+2HaS6cm40dPVQ1LMfeNmrRrPnAHteK9QUq
         +WTg==
X-Gm-Message-State: AOAM530zIdZQL5DgvXjhsctXbB0lqy/kryyMFGAddp0wbE0e7AD2rQbD
        F0vYosGqjSN2Jq36a9s6y1v7
X-Google-Smtp-Source: ABdhPJwyawLSN7Yp9ZuQ5OJzfKBAFZLsLLnA5M91VV0i9TSZFR3Zg1mYlKv0c0kitIx8hIaM/yvTeA==
X-Received: by 2002:a63:724a:: with SMTP id c10mr1772848pgn.124.1612938336434;
        Tue, 09 Feb 2021 22:25:36 -0800 (PST)
Received: from work ([103.66.79.29])
        by smtp.gmail.com with ESMTPSA id u19sm928497pjy.20.2021.02.09.22.25.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Feb 2021 22:25:35 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:55:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Aleksander Morgado <aleksander@aleksander.es>,
        Loic Poulain <loic.poulain@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [RESEND PATCH v18 0/3] userspace MHI client interface driver
Message-ID: <20210210062531.GA13668@work>
References: <YBfi573Bdfxy0GBt@kroah.com>
 <20210201121322.GC108653@thinkpad>
 <20210202042208.GB840@work>
 <20210202201008.274209f9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <835B2E08-7B84-4A02-B82F-445467D69083@linaro.org>
 <20210203100508.1082f73e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAMZdPi8o44RPTGcLSvP0nptmdUEmJWFO4HkCB_kjJvfPDgchhQ@mail.gmail.com>
 <20210203104028.62d41962@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAAP7ucLZ5jKbKriSp39OtDLotbv72eBWKFCfqCbAF854kCBU8w@mail.gmail.com>
 <20210209081744.43eea7b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209081744.43eea7b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 08:17:44AM -0800, Jakub Kicinski wrote:
> On Tue, 9 Feb 2021 10:20:30 +0100 Aleksander Morgado wrote:
> > This may be a stupid suggestion, but would the integration look less a
> > backdoor if it would have been named "mhi_wwan" and it exposed already
> > all the AT+DIAG+QMI+MBIM+NMEA possible channels as chardevs, not just
> > QMI?
> 
> What's DIAG? Who's going to remember that this is a backdoor driver 
> a year from now when Qualcomm sends a one liner patches which just 
> adds a single ID to open another channel?

I really appreciate your feedback on this driver eventhough I'm not
inclined with you calling this driver a "backdoor interface". But can
you please propose a solution on how to make this driver a good one as
per your thoughts?

I really don't know what bothers you even if the userspace tools making
use of these chardevs are available openly (you can do the audit and see
if anything wrong we are doing). And exposing the raw access to the
hardware is not a new thing in kernel. There are several existing
subsystems/drivers does this as pointed out by Bjorn. Moreover we don't
have in-kernel APIs for the functionalities exposed by this driver and
creating one is not feasible as explained by many.

So please let us know the path forward on this series. We are open to
any suggestions but you haven't provided one till now.

Thanks,
Mani
