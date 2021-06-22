Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A974B3B00D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFVKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVKAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:00:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8B9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:58:01 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h11so5411983wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XGm5a/Fe5N5jRf7hJWwEELPPpr6Kdx/ELnvMfUGOCzM=;
        b=KnOYTGoqCw3yaoYvo6WJY/UiRv5L8oNDkJMj3qqXhtSJC835E+qd6HXIB3rnAMslG3
         FlJpyUZu60Z/+0jhexM/YXJPwtu5aYO7Asi5ExTZnWujKsutCzN15EN3Ore2qHi1b4tx
         lhGjv/I1H69Vie0p2xnUX+GmE4FqwivQOUxPVX65ZYiQBgMag8JKa9XxdkduVElUYOuV
         dMumUbCSxr9Nq4IzKk9X8yr0ko06dB52YhTAb7A+t5tMyccXmDsMUlTFDqlOUrSNp3Md
         0IptmioZF3w+PnZVEofJLqr1bSiTHTyRx4oOiOyEjJ1tMSUTh4C9JReJiM6m53eU0oRA
         WdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XGm5a/Fe5N5jRf7hJWwEELPPpr6Kdx/ELnvMfUGOCzM=;
        b=V5XT66E+XkC7FCuSetlpE2zrBzghcABpw93wXNPc6qoTMQj4vstY2isVRowKDGLNHF
         lqNC6rAhvqa1Tb7Hmt8zHZo4bP2BNAQLBHF1lMQjtb6hCzY/hRW+EjQcAiQuWmAS9O30
         pO2gD3At63pW/5uWGZ8/i+qFp81+o29G05mpOCGcogHT28GWroD9IQ9HRoEu4k3hRnIa
         rqNwj94ry8z62rfuVTr5xD24I+epd23KC25CznbFtTZK4Wj6S6x/7PnQo8D1Qeed1xka
         Uqg5mHcqy83jD7N0dPdcgE3uIaE+BoJRBuSjEGCzZTFqFhVytNpEW6eB5Og7ts4XtHHu
         Vs8Q==
X-Gm-Message-State: AOAM532K06Kn4gWS7Z1nCpXUhFTxpkaiJLWCG/0gpRH+DKa2WwJdRdiJ
        e3fENht9XxSNaHwNvfBVBNOazQ2jG0IaVA==
X-Google-Smtp-Source: ABdhPJxKxy5rTDAIOoB35xJ/WuhJV0nmoikd+B5VMZ3tQEvzlCfODC2nIz+tWU0Yr5YpQv+yJ34l0A==
X-Received: by 2002:a5d:6a8b:: with SMTP id s11mr3645664wru.88.1624355880057;
        Tue, 22 Jun 2021 02:58:00 -0700 (PDT)
Received: from agape.jhs ([5.171.72.34])
        by smtp.gmail.com with ESMTPSA id m184sm1875029wmm.26.2021.06.22.02.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 02:57:59 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:57:57 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/18] staging: rtl8723bs: remove VHT dead code
Message-ID: <20210622095757.GB1426@agape.jhs>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
 <d3f79570088ad339bd80fe9d6b24604ac91ea8d3.1624099126.git.fabioaiuto83@gmail.com>
 <dd0332d7-5d9f-49e5-3fc6-8ae3e623f29c@redhat.com>
 <20210622091602.GA1426@agape.jhs>
 <4f128bd2-b84b-132e-c75f-0030701a8a9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f128bd2-b84b-132e-c75f-0030701a8a9b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 11:19:36AM +0200, Hans de Goede wrote:

Hi Hans,

> Hi Fabio,
> 
> > Moreover I have been quite conservative, for I left untouched HT indexes above
> > 7 which rtl8723bs doesn't support.
> > 
> > So IMO I think this patch is fine as is...
> >> Perhaps this entire block can never be executed ?
> > 
> > the block is executed but there's no register write happening. Just
> > updating of values which will never be fetched.
> 
> Ack, my bad I was under the impression that phy_SetTxPowerByRateBase()
> would actually do a register write, but I checked and it just updates
> some unused table values, so dropping this code is fine and you can
> keep this patch for v2 of the patch set.
> 
> Regards,
> 
> Hans
> 

thank you, what do you think about what I replied about patch 1, shall
I remove the '> 14 if block' or leave it as is? Do you think is necessary
to keep the conditions inside the block and pack them?

I would leave as is but is my opinion...

regards,

fabio
