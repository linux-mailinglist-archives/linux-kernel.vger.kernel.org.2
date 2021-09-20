Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765BA4119AC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbhITQVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242945AbhITQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:21:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8FC0613EF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:18:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id f130so5064306qke.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=labbott.name; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=95LUMqEJ9/lbpkDllt+74gP/DPDagYgPuusq48yd7js=;
        b=XyqFPnf9gMzF5YjPWm9T76f0zhiAkBwKe8qkdSUFTNfxCFqxS9Cq2QuVA7d5H6uz51
         MgyXYflsq1N/favy0shwrTE72MTUQ01ntdh89N/hDC5BzsadDUS7EmkgCoNxsLWk5/mj
         4A6iA+kg85+Zs0lSkbcqJ33+ASaMpayd0M8CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=95LUMqEJ9/lbpkDllt+74gP/DPDagYgPuusq48yd7js=;
        b=C+N1PagTUKCkD68xpBbj97SXIeh4081aJLILtR2RHA6sWlsZAOsfmLfWJ8lRbRIsIF
         S0VX5Ae1/qjR25qVnkgEm0qlQ8fWRGk3FKjXCVxwfJ1/6uL37QZgQALBTBgQbkVYVDux
         38zPPoghpXVDfR7tXt6kiUMh8+7hzu4Vqzgd698aEtBHGg41zpU/xrlHANl+CfnltiIJ
         xtF8QNirt6g6veHDKAqNp4JbEGD0VE5/dLkq6I+yj1ou20NpHLLFpPgAFcJvLFi/TjMA
         7QyYhU8TtUOlt1VDQMhmRKofFT9mJ6BfRU5KMKQtRMYv4zPq7TiiFaJtabBM8nQSdraX
         Qrnw==
X-Gm-Message-State: AOAM531LaL4WXuqtrE0NgSk2j+FyRISY7BdSfY+2bJCwEb0guM7iDpSg
        G5UTzTZnUeaGZAFF3O1fQUTRXg==
X-Google-Smtp-Source: ABdhPJzg8TRJjQ+Owc9YPRp8WpafdiFFFiGqLYQxAfkP6iSdFWJLPxITzthsdZg9VLuzVLb1nRtPSA==
X-Received: by 2002:a37:b483:: with SMTP id d125mr3679370qkf.362.1632154690680;
        Mon, 20 Sep 2021 09:18:10 -0700 (PDT)
Received: from [192.168.1.168] (pool-74-109-246-95.pitbpa.fios.verizon.net. [74.109.246.95])
        by smtp.gmail.com with ESMTPSA id r139sm10083414qke.84.2021.09.20.09.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 09:18:10 -0700 (PDT)
Message-ID: <bf22702e-01b2-214a-1650-da9e4ec3c2be@labbott.name>
Date:   Mon, 20 Sep 2021 12:18:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [Tech-board-discuss] IMPORTANT: CIVS opt-in for Technical
 Advisory Board voting
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Hansen <dave@sr71.net>
Cc:     "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>, ksummit@lists.linux.dev,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
 <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net>
 <CAMuHMdUUfm6u_Pz3qzA0V7tLZd7jhcwdyxU7L0SyC_EdyzwQxw@mail.gmail.com>
 <CAMuHMdVtHDQ2f0VKAdQFQV9dZJ5uFGD9yHvNviQ_k7AEfhN77w@mail.gmail.com>
From:   Laura Abbott <laura@labbott.name>
In-Reply-To: <CAMuHMdVtHDQ2f0VKAdQFQV9dZJ5uFGD9yHvNviQ_k7AEfhN77w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 12:03, Geert Uytterhoeven wrote:
> On Mon, Sep 20, 2021 at 5:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Mon, Sep 20, 2021 at 5:37 PM Dave Hansen <dave@sr71.net> wrote:
>>> My @linux.intel.com account is the most common one from the git logs.  I
>>> have only received one TAB-related email there:
>>>
>>>          Subject: Upcoming Technical Advisory Board election -- look for
>>>                   your ballot
>>>
>>> However, I never actually received a ballot at that email, presumably
>>> because of this CIVS opt-in issue.
>>>
>>> Was this just me?  Or would it be appropriate to send these opt-in
>>> instructions to all of those that should have received a ballot instead
>>> of just sending to the mailing lists?
>>
>> I did the CIVS opt-in, and entered the confirmation number.
>> Still, unlike Vlastimil, I saw no way to vote?
>> Just retried the opt-in, "already opted-in".
> 
> If you use multiple email addresses, make sure to opt-in using the exact
> same one on which you received the original email from Laura.
> Then there will be a link to the actual poll after entering the confirmation
> code.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

Yes that is correct. We attempted to consolidate e-mail addresses if you
contribute under multiple ones. This is a pain point we will need to fix
next year.

Thanks,
Laura
