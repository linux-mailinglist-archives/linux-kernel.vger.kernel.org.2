Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A531839B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBKCgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBKCf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:35:57 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60401C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:35:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e9so2454003plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 18:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IZKBnioi6lgTPw8uFaPQLhjUKqaEYGrc2R8Xge9s1u0=;
        b=ohem4GjwP/RcWqNYzmyoFCPCORlnCa+Mm7r0XcuhzvDg47gdnEUgu/MIPzkmVb1DDZ
         j8NajRWfWgtreMXI4rM2jwazq3crKe2Q5ciXDFUAxKLsM+1qHsKSaaRn4xqHOKoO4Put
         oyY2PYfbRmwF5sivA+ocGDOyqP4UC7+KXd1xTOjdgVu+5KqHul92mV2aqJSxLbIXfQiy
         I2Lhxl5QQ+M4NHF2WwbfpcadelUOB9vlPgvfTNGlF6Ry3tE+APDbr+OMdyGf3qVYzRXd
         ibefWfEMPPVNBaCh994pGGzowuH4bihIPV13LIKlaq8t9dS6/3BWzF2Ru0tSE8D/cpZR
         +3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IZKBnioi6lgTPw8uFaPQLhjUKqaEYGrc2R8Xge9s1u0=;
        b=K8hlWsyNmf1Z1USTo+OTkuS71qX9dvgZJOQF7by5h68NgA7BP02PON+CVNAnfBsYaT
         fow9mFhCMJqgZsg2+mkwgrAP5yvbg4dT1gS+CpgUt+sbZu1W/1k4rkfKAAdcmlKfDGGU
         QllfH8Xlg5rRgtXeCMUrR0bsz5XmhcR9HBv0KQ4L48FwlQ3sph3+x630RU1z8o+HWviE
         od1YgaxRWKKc0R1/48BnEW+JWoCKNLwAnvnRg/265YajIEhkEcR+U/8tvfWhCbh+rJH1
         OyBwplLH5JVInJLv/c8GIM3LwaRvVX9XA4VeFWt7y9G9mZflFo6vk97kctGleM2o6oOL
         xBew==
X-Gm-Message-State: AOAM530Ycse+k3wJ3ehT82CpufQFhbMn/91Mr92Q2vDhr3T6jZod4AiY
        Xs1XoT0I5Ct01EDXMquJq7SjofEfVlidPw==
X-Google-Smtp-Source: ABdhPJzmh3Pgc04oNcO87GJ5yYz/woJKA2njPXAtnp2SC9+9/nwXF7cLpwrA6dwRWUSTlpdpij0RfA==
X-Received: by 2002:a17:902:e5cc:b029:de:cdab:2da5 with SMTP id u12-20020a170902e5ccb02900decdab2da5mr5589754plf.32.1613010916807;
        Wed, 10 Feb 2021 18:35:16 -0800 (PST)
Received: from localhost (121-45-171-254.tpgi.com.au. [121.45.171.254])
        by smtp.gmail.com with ESMTPSA id x64sm3579238pfc.46.2021.02.10.18.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 18:35:15 -0800 (PST)
Date:   Thu, 11 Feb 2021 13:35:11 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     sblbir@amazon.com, davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid
 status
Message-ID: <20210211023511.GE286763@balbir-desktop>
References: <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
 <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
 <20210127111346.GB59838@balbir-desktop>
 <CAA70yB6P4_JsZnCrBkYg=7eyT5KW0XucUY+Y7T8YYMnXj6iVXA@mail.gmail.com>
 <20210204102020.GA286763@balbir-desktop>
 <CAA70yB4P2jhOSH=MSc+2NNSmaH8ckF4M0v_vGwE7c9qShMGKew@mail.gmail.com>
 <20210205000848.GB286763@balbir-desktop>
 <CAA70yB7VwbuzuU0=SH+mhSkYBiC28G2NCe9vpqfHv27gyxafCw@mail.gmail.com>
 <20210208055531.GD286763@balbir-desktop>
 <CAA70yB74AH6J0iuhd5s4ONDVh71fEuh3Kr625H_CypyMP0Te+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB74AH6J0iuhd5s4ONDVh71fEuh3Kr625H_CypyMP0Te+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Still not convinced about it, I played around with it. The reason we did not
> > use ioctl in the first place is to get the benefits of TLA with netlink, which
> For monitoring long-time-running process the ioctl can meet our requirement,
> it is more simple than netlink when we get the real user data(struct taskstats).
> The netlink mode needs construct/parse extra strcutures like struct msgtemplate,
> struct nlmsghdr, struct genlmsghdr. The ioctl mode only has one
> structure (struct taskstats).
> For complicated user case the netlink mode is more suitable, for this
> simple user case
> the ioctl mode is more suitable. From the test results we can see that
> ioctl can save CPU
> resource, it's useful to build a light-weight monitor tools.

I think your missing the value of TLA and the advantages of async
send vs recv

> > ioctl's miss. IMHO, the overhead is not very significant even for
> > 10,000 processes in your experiment. I am open to considering enhancing the
> > interface to do a set of pid's.
> It's a good approach to collect data in batch mode, I think we can support it in
> both netlink and ioctl mode.
> 
> Add ioctl can give user mode choice and make user code more simple, it seems no
> harm to taskstats framework, I'd like to support it.
> 
> Thanks very much

In general the ioctl interface is quite fragile, conflicts in ioctl numbers,
inability to check the types of the parameters passed in and out makes it
not so good. Not to mention versioning issues, with the genl interface we have
the flexibility to version requests. I would really hate to have two ways to
do the same thing.

The overhead is there, do you see the overhead of 20ms per 10,000 calls significant?
Does it affect your use case significantly?

Balbir Singh
