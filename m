Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189B7344D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCVRlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhCVRlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:41:39 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C58C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:41:39 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id x16so14825387iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cFGfgA15yCvg5nxOaSdeBAMBjRJ6Sj1F+vc4dD4Jyeo=;
        b=gU9aJk+/fYJ32a0U+/JmRp/NAxFYPbmwcBLoJM6tOTylt9Y55pYiW+s1dTL45j/vtM
         PnaB50jmUmSieTtZyLhsrERXgTkSFYTOT9ifTil4c6k0X1qyIWOi6KeKIWpwQVaxA2zO
         l4NayK/Iwea4TCCHxFDZDaP+HzrYurxStF7TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cFGfgA15yCvg5nxOaSdeBAMBjRJ6Sj1F+vc4dD4Jyeo=;
        b=sXrhrU1tFj0yDeY6xXfxrCQfv9bssgk1HPZx3NNFHyfrQFkGijd/xvPV97dP1xb2tG
         ozqIj6Dpibdd/EvpK0VMxvQgNwuZxVmiI8qIUs7CfMuuZj3BlkWXAFxIngiJBrNLMvq5
         aEsaOduIv+vuF24MaYUK/Ppg67Y6WIuF6yjiZRCz1o2iPQmE8u1NmTHap3H++r1RLqW8
         5UGMSep1+pkoynjPZUOLrUfZpdLhycm0izHiCUAZirtuhRMbnTdbJjVmkFdaESOmehWG
         y7lPXlajy5lrxz7e2h8aO+LWGHGZS8LLB2tZpxTdiQ5TMzvEeMFJZ49JL/OJP+Yf6Q8O
         6L/Q==
X-Gm-Message-State: AOAM5302riirgF35K2aZdmvWszPdWrNiawVlGI/X5S+KqBXQ6yG/rbNt
        x3jRsI1fUgO2pUmvM/en+b0X9A==
X-Google-Smtp-Source: ABdhPJxYA11jm5sybKyGQkMfmu5eOiUXZhrvlZGwOE0hePOcH4C7qiYfFe/bFNKAqe83ZLNk38kiHw==
X-Received: by 2002:a05:6602:82:: with SMTP id h2mr762438iob.20.1616434898772;
        Mon, 22 Mar 2021 10:41:38 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id o15sm8281983ils.87.2021.03.22.10.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 10:41:38 -0700 (PDT)
Subject: Re: linux-next: Tree for Mar 22 (net/ipa)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alex Elder <elder@kernel.org>
References: <20210322185251.66566cfd@canb.auug.org.au>
 <83366bbc-af28-4ffd-2a25-f688a52f9239@infradead.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <33380a70-c594-cefe-14b8-c1fbf2dd90af@ieee.org>
Date:   Mon, 22 Mar 2021 12:41:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <83366bbc-af28-4ffd-2a25-f688a52f9239@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 12:16 PM, Randy Dunlap wrote:
> On 3/22/21 12:52 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Warning: Some of the branches in linux-next may still based on v5.12-rc1,
>> so please be careful if you are trying to bisect a bug.
>>
>> News: if your -next included tree is based on Linus' tree tag
>> v5.12-rc1{,-dontuse} (or somewhere between v5.11 and that tag), please
>> consider rebasing it onto v5.12-rc2. Also, please check any branches
>> merged into your branch.
>>
>> Changes since 20210319:
>>
> 
> 
> on i386:
> 
> ld: drivers/net/ipa/gsi.o: in function `gsi_ring_alloc':
> gsi.c:(.text+0x926): undefined reference to `__umoddi3'

This code assumes a 32-bit kernel implies a 32-bit dma_addr_t.
But it seems that's not the case for i386...

Let me try to reproduce this.  The fix should be easy.

Sorry about that.

					-Alex

