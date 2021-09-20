Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2F411F33
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348362AbhITRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351511AbhITRgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 13:36:39 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C443C061768
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:53:51 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id bk29so44581043qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OUGz0PuSbbybtRH66I6txS95faxT4LuGSV+sAKO/f0s=;
        b=XwjMKTnXngJTB05gr1CM8OAw9ZLJ5QffJdbB+Mn1T7DxrPyypZrPcokIddSPHECwO8
         t8GRuiKoI7+SzCmb5cehGj1rWGArEQswsqIQq9e9llaTKG2+uQQprHoYM6jmpv/urMI/
         W+QijuYDfLmvm7ZS95uaWZsfBAbnfPkqg9z/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OUGz0PuSbbybtRH66I6txS95faxT4LuGSV+sAKO/f0s=;
        b=TRoeC4GjOT4cco5b3jnjX9kioiOWU6I4C4V5q0O8f0KRRHhDsZDE6Aqn5TYTvZ6QGO
         7/v9Qn6HQ5amK+7ijlbZf/OAr5PURDM6ywukbE34Bbuh41Bm3LEGGTs3skkNn+ifgMDb
         dLXCwf54j/3+BNcP0xpOofERlY289BB3IJs6U79N0dnDLd55jaoAtKNscl2swS9GY235
         MAW0skMBQ+p/FUMBy5+FbwreNms6uAlpttDDrnYwsprUaLZs+5mT1rE0lW5jAYvim/C/
         e/RCbIFkof+BLc7ZM9s6Xm8YSwT4a8jJp+L1cUOoDik+93tGdC2gs1fSqNpcp07q4ycB
         +4Ow==
X-Gm-Message-State: AOAM530G6djHDfL2PEWWwB0cWuQHB8Daw8wSpg+F8twSxEmgkyDYP06c
        B9Qxr0soKQYoqiSi3L4gluNV4giiCmmzdWNF
X-Google-Smtp-Source: ABdhPJygir2fpG5Mbn7SzUrlfqznZYFgAcVs6M6VcULtZy0UipFbNc+8a0WZLtzOtEbXWFPOuZC/zQ==
X-Received: by 2002:a37:c83:: with SMTP id 125mr8261726qkm.229.1632156829380;
        Mon, 20 Sep 2021 09:53:49 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id d23sm3201938qto.91.2021.09.20.09.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 09:53:48 -0700 (PDT)
Message-ID: <ebcaac1d-9b97-81d9-28eb-eeb51c51673f@labbott.name>
Date:   Mon, 20 Sep 2021 12:53:48 -0400
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
From:   Laura Abbott <laura@labbott.name>
In-Reply-To: <20210920164837.GK4192@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 12:48, Mark Brown wrote:
> On Mon, Sep 20, 2021 at 12:30:23PM -0400, Laura Abbott wrote:
>> On 9/20/21 12:23, Mark Brown wrote:
> 
>>> Will we be getting some futher mail when we should vote?  I opted in but
>>> didn't vote at that time - I saw the vote was listed but didn't realise
>>> that voting was open since people still seemed to be nominating.
> 
>> Nominations are now closed and voting is now open. Please vote at your
>> convenience.
> 
> How can I do this?  As (IIRC) Geert reported if you've activated your
> mail then attempting to activate again causes CIVS to report "This email
> address is already activated" with no link to any existing polls.
> 

CIVS said it should give a list of all polls but perhaps that didn't
happen. I'll see if I can get it to resend.

Thanks,
Laura
