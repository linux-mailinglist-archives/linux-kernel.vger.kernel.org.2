Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4304119D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhITQbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbhITQbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:31:51 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB12C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:30:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c20so5795540qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fX1NIYok2togq/y1xR8/yZsYJ2HZag+RJZGr+2D3pS4=;
        b=doNi+RCiM+IWnVuAqKdGGfczTCCKqWsh9dMlPaNlqH8s4vQdO2eHkFnk5WGh8QH44Z
         H8QSF9i2TBc5SYZXEJDYO1bUcgtuCIJHExnSjIpAWZfdxSyzJ/o6mphdCVnC31lh+cX0
         1beilVMYVoTWQly8UMrcfGVtGQHw8aorilT00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fX1NIYok2togq/y1xR8/yZsYJ2HZag+RJZGr+2D3pS4=;
        b=aKm060uyZURT2S+9Hl9RikuksDhJ0VgKad6Yf8jRWMAKiKjVmBsQ5gUMqNw/DfK+Ux
         U19BZT7aGV4gHwwCB6F99fACGfeE6qCvTndNRJmbuwyHEasCmslHS9j+N+27gYvF3cSK
         L2cnRc1Hojaj11VqlFdvWRDAzjT3fBaXlABDmUFxOz17KoJWSPEt1bHTToNPuQCD5aYi
         ss716FFzy92R6JHmtmdbscelKX/N22IwfUfmt+dPLePc9TUkHAzoEhGxYTL/6GiWauGI
         HkpIOwpfYf9OR3jhQfZ9DMRVlfnOu0Bk2xbmT17jJpOFTY/Xxug+6BQa6/NPi1CnVMqM
         GJCg==
X-Gm-Message-State: AOAM5338Jj28ocE1DSCW4XF2LtudFsqlJc0NMQqY3Ty0GWguSZsUW2OJ
        qgdyAGgtRM4uRCB1mpcVipufIw==
X-Google-Smtp-Source: ABdhPJxvN7B6ZMgC+p9GXlJoRJb1SqSHUKQprmWvBBvop6H7cXYqtvysHnyJO6JdtAvnbSkaTQTCWw==
X-Received: by 2002:ac8:5617:: with SMTP id 23mr23598396qtr.20.1632155424161;
        Mon, 20 Sep 2021 09:30:24 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id c19sm3572181qkl.63.2021.09.20.09.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 09:30:23 -0700 (PDT)
Message-ID: <5c88ae67-df7b-60ab-d087-bd244753c98f@labbott.name>
Date:   Mon, 20 Sep 2021 12:30:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [Tech-board-discuss] IMPORTANT: CIVS opt-in for Technical
 Advisory Board voting
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Hansen <dave@sr71.net>,
        "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>, ksummit@lists.linux.dev,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
 <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net>
 <CAMuHMdUUfm6u_Pz3qzA0V7tLZd7jhcwdyxU7L0SyC_EdyzwQxw@mail.gmail.com>
 <CAMuHMdVtHDQ2f0VKAdQFQV9dZJ5uFGD9yHvNviQ_k7AEfhN77w@mail.gmail.com>
 <bf22702e-01b2-214a-1650-da9e4ec3c2be@labbott.name>
 <20210920162329.GJ4192@sirena.org.uk>
From:   Laura Abbott <laura@labbott.name>
In-Reply-To: <20210920162329.GJ4192@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 12:23, Mark Brown wrote:
> On Mon, Sep 20, 2021 at 12:18:09PM -0400, Laura Abbott wrote:
> 
>> Yes that is correct. We attempted to consolidate e-mail addresses if you
>> contribute under multiple ones. This is a pain point we will need to fix
>> next year.
> 
> Will we be getting some futher mail when we should vote?  I opted in but
> didn't vote at that time - I saw the vote was listed but didn't realise
> that voting was open since people still seemed to be nominating.
> 

Nominations are now closed and voting is now open. Please vote at your
convenience.

Thanks,
Laura
