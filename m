Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB23A4F16
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFLN1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 09:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 09:27:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19913C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 06:25:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n7so2896129wri.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=00xV9d105HN9jx5nQTrpWNtAsSNDaA7khwlfB0pP1mU=;
        b=KpUdpbyfxq6W/oXnibs65Sx5IJw4Ihrvk9jSUgJr3TKCunYqvd76g0Hpw9x/Swo1cM
         o+EZv3gwEChkQnrASIhlirJo8zeOqDjb0cEh/FjxAXNgjIyE2GEzhMRR3PRZ26Macmbu
         UNmkTK79T+ZE4SSIK4oXtI4NySUivq4Noxq7WLmlZNtqH1w9Vc3l0lJsyKqiftbQQolx
         gqPWukQ4ZOVz60EBoFk9MekKqSOJIjGYgFVRDLquXmRnedhAqGHfVBBschRjc0sMN5uj
         PS2SdWNfP1xpP1olQTN12OLe01XMmQjHXhsZq7MBd5uEV+P2WB9u0A3EkwE3BxkX+/Sl
         zsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=00xV9d105HN9jx5nQTrpWNtAsSNDaA7khwlfB0pP1mU=;
        b=Ygim55gGgD8vHeGO3clYxnwTbVTsFMJFV+1J1RqJAz6zinSz5/1nuaTFHHa/NfDcd0
         j71gy76NjHo/GKf2AlX4xj0t9k3GZSnBRt8x5d3Xn+RwKVwt3rLDKg2WAK5qigXr3Y0y
         XIa4m5Bkad2JmOkj81QrcKB6HYtpLhjD+cHXQFB6MDfzSDHQCCq1qsJXOzwAuGng0Br5
         0nMByV4RvpfhqDdKsnDUB941eSoC6XiC4mXOtG6eEPqg6J/urzMFttRvhImHMqtUCIn6
         BluCdvDzwEyCy6NPqipAsQfM7f2zwveZrM7YMrqTmM5ZHvBerkr0qqRhWDtEM4lh2dCR
         9dPQ==
X-Gm-Message-State: AOAM5324TYvx3/WZh4nG3s2pLNjkKuPhZOquGKj/AdSyjggKOl8QmT/v
        wobwy20jqmc/ApT+eu1vWkclVvTGlLI=
X-Google-Smtp-Source: ABdhPJw6IpzCn6Zze8ub44Tjoyx/Q71bXwWB7tY+6dvElvVZrTdQeZDFJE8XmccTZ17jKirq7MjDPw==
X-Received: by 2002:adf:f382:: with SMTP id m2mr9284316wro.394.1623504319626;
        Sat, 12 Jun 2021 06:25:19 -0700 (PDT)
Received: from gmail.com (77-234-80-172.pool.digikabel.hu. [77.234.80.172])
        by smtp.gmail.com with ESMTPSA id q20sm13439568wrf.45.2021.06.12.06.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 06:25:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 12 Jun 2021 15:25:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: Ctrl-C of parallel kernel build sometimes corrupts
 .o.cmd files permanently
Message-ID: <YMS1vNnnbPNUbsVN@gmail.com>
References: <YLeot94yAaM4xbMY@gmail.com>
 <CAK7LNAR54mOqEcUTUmEUfVAwA6XrGLr2J_3+v6fdys9tBLe28w@mail.gmail.com>
 <YLjNa7vaYOfVhBFm@gmail.com>
 <YLjOjZVetM4UbUPn@gmail.com>
 <CAK7LNAQ73zG69F4hMJhgrHp8yT9tUmb-0tN=kFtWA98-YV3eNA@mail.gmail.com>
 <CAK7LNARYuP70tz-dV+MfrpRke_3UvZ9wqqS2X8-FR9eXjcBmWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARYuP70tz-dV+MfrpRke_3UvZ9wqqS2X8-FR9eXjcBmWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <masahiroy@kernel.org> wrote:

> > Hmm, I do not know why GNU Make behaves like this...
> >
> > I will ask about this in GNU Make ML.
> 
> 
> https://lists.gnu.org/archive/html/help-make/2021-06/msg00001.html
> 
> 
> In short, 'tee' was also interrupted,
> then 'make' got SIGPIPE, which terminated the app
> due to the default behavior.

So, what's the solution? It's rather common to 
run a build job while capturing a log via 'tee'. 

Ctrl-C only recently started corrupting the 
kernel build. (As in the past ~2 years ;-)


Thanks,

	Ingo
