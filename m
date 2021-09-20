Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7819F4126FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 21:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348567AbhITToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 15:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348233AbhITTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 15:42:41 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1814C03D749
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:10:50 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id w9so11621546qvs.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y6nvQb0L48eSzQFJoONTKkgY7weF0wuR5ubctAfNdmw=;
        b=mBY4ZBIxeXQy5PndrWozNlXND0HELUcnxwFwBBelMqWmWaxhwxLg+2uDCYXj/m2zmO
         4tZvgfcUzr7mrIKiC2Uy1/Ci/r3DZF3v6P9slYcSpvkXKhksXOwub3imBtnpwLLsqoXF
         p5cuTDlrSy2ZGREd9OlTIlTbGtpNBDLecTds0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y6nvQb0L48eSzQFJoONTKkgY7weF0wuR5ubctAfNdmw=;
        b=H5I5fvw/Br35rPkFqEczUExQSHBJo4YV6zTg8kT81lwXcSwXgkxguh3liBeuuMXrVG
         jfTI5FNaCrAwtNNliSwwGaQgpTe1KTZRx28ClxPog1oPJ3EJO3Ia07Q7u0ZT0fAWWK2/
         0rwilPw8Dsc+0YX7t54BLoYV6zL4ejop/2J1+0313GW1UbD3+7xMjMYgUlNNrK+y4FqO
         sRu35E3Ei4FROT6YWW1Qj/6AA5nMCXfXqXYR4eajdTNMVaKw2XuBadJM7vFCpP0y/bZx
         4OHh9sDas0c7wulOCRhcdaVXLexqanqow8jg6KcA1Cfwn49EdI4lBOFTLGX7qk6yXih6
         ZlSQ==
X-Gm-Message-State: AOAM531DFwSCVFs9nKGMlxNynTCV8iYvmasDBcSCgIwpBAkRVmkpWL9i
        vYznZvbvZy+Rlng/GHW6WXiKTEMspQ0cRVhQ
X-Google-Smtp-Source: ABdhPJxI34IkZe2zkjnmzZE9LyndlQADUdCivzVMUlD1PwBYUol1UnDEOIYGdAY3EscZ3c4aqpfR7Q==
X-Received: by 2002:a0c:ab01:: with SMTP id h1mr26235633qvb.0.1632157849823;
        Mon, 20 Sep 2021 10:10:49 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id bj31sm1564398qkb.43.2021.09.20.10.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 10:10:49 -0700 (PDT)
Message-ID: <0279daae-f1f9-b52c-6aef-f016914b21bc@labbott.name>
Date:   Mon, 20 Sep 2021 13:10:48 -0400
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
 <5c88ae67-df7b-60ab-d087-bd244753c98f@labbott.name>
 <20210920164837.GK4192@sirena.org.uk>
 <ebcaac1d-9b97-81d9-28eb-eeb51c51673f@labbott.name>
 <20210920165716.GL4192@sirena.org.uk>
From:   Laura Abbott <laura@labbott.name>
In-Reply-To: <20210920165716.GL4192@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 12:57, Mark Brown wrote:
> On Mon, Sep 20, 2021 at 12:53:48PM -0400, Laura Abbott wrote:
>> On 9/20/21 12:48, Mark Brown wrote:
> 
>>> How can I do this?  As (IIRC) Geert reported if you've activated your
>>> mail then attempting to activate again causes CIVS to report "This email
>>> address is already activated" with no link to any existing polls.
> 
>> CIVS said it should give a list of all polls but perhaps that didn't
>> happen. I'll see if I can get it to resend.
> 
> It gives a list of all polls on activation but it seems like it doesn't
> get that far on reactivations, it looks like it's generating an error
> refusing to activate again before it gets that far.
> 

I just resent the links again. The e-mail server from CIVS can be a bit
slow. Thanks everyone for your patience here.

Thanks,
Laura
