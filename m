Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682893448B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCVPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCVPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:06:16 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95ACC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:06:15 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id v3so15144410ilj.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7bKfDRT1iiBZC/5ufV15uCw7hwlt7jFcxCdAI9kPbOA=;
        b=aIIPlqBGhXmu+vPQqkOTKXVP1ROucFSLsfEXI+jPDcpreQXQUtY+MQZZgnawvo9Pay
         E9W009IkmwkCALSjxziXJiQEMEyX+tvFkSuHqOWHbz/IMIww8MxXeKLgtDaCWT0kUsPR
         vjoio3wP8sBZTRPQx3qoUrSQJEzsH/rqnL1buYsh6NY1tO/MpdqKQtn5eUqqTDiHsgI4
         nPGN5d7IuQe89oJLdBy+pJyijPNSg2rSffiwNGcibewRrZJ6jdiVELaYLm3Oov5En0oJ
         cpzR/gCJKbD2n/uZJvFkX0ZsWelQBWv4UZmWcLVEqhfeEI9nXeVBOU0DKqu5YttC76PJ
         W2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7bKfDRT1iiBZC/5ufV15uCw7hwlt7jFcxCdAI9kPbOA=;
        b=Zi2hdsOzi5gVJsMXFV+MtLZTiX5h3hEdsCBlUqGx8+hEvx/yAwCr+ZDilcMAV3LK6f
         IkP8ocCYoF6wp9bTOQ8n3q2vV/uoNTCKQke+Rz4auLdCEgdUMzzWkGUQuh3xtDTcBkBv
         i6Ix+V/DMJSIhMo50I3zj36RtAdhktCECORXGv85aj1Rm+PqKVDQSYUvdET4e+0HPo3d
         Md/1hliNusg2rFAwR6eohFLuQuJGGE+nfpNA9WZskkDCvloxhzvR4p8JDf7vT6LT+v4t
         tWz37woeRyaqBAg18T+1xfefXUQ1bg4d14tGKoSTS8abXIl7dwf0zlW2lElcG9NqsdTP
         2iMA==
X-Gm-Message-State: AOAM5307ui0VgUxlJBU3KRVfeC48xF2zZh6RhurwZ1fAuqRVz1V2I7M0
        sg0pDkMQTFFxPnF+WTYku+ACw0gxOB714MmB
X-Google-Smtp-Source: ABdhPJx3DB/cdDQozSfKvzSEJ0k/J102dyBKbVAjQ1lsfbFHitAfxXf4YC6vYqzHofFqH4yquVUrVw==
X-Received: by 2002:a05:6e02:e0f:: with SMTP id a15mr354732ilk.203.1616425574923;
        Mon, 22 Mar 2021 08:06:14 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id g16sm7963010iln.29.2021.03.22.08.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 08:06:14 -0700 (PDT)
Subject: Re: [PATCH net-next v2 2/2] net: ipa: fix IPA validation
To:     Leon Romanovsky <leon@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210320141729.1956732-1-elder@linaro.org>
 <20210320141729.1956732-3-elder@linaro.org> <YFcCAr19ZXJ9vFQ5@unreal>
 <dd4619e2-f96a-122f-2cf6-ec19445c6a5c@linaro.org> <YFdO6UnWsm4DAkwc@unreal>
 <7bc3e7d7-d32f-1454-eecc-661b5dc61aeb@linaro.org> <YFg7yHUeYvQZt+/Z@unreal>
 <f152c274-6fe0-37a1-3723-330b7bfe249a@linaro.org> <YFim9CWuu45FcdcN@unreal>
From:   Alex Elder <elder@linaro.org>
Message-ID: <fd7e233a-1c0b-62db-2340-edd211cd436f@linaro.org>
Date:   Mon, 22 Mar 2021 10:06:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFim9CWuu45FcdcN@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 9:17 AM, Leon Romanovsky wrote:
> We are not talking about putting this tool in upstream repo, right?
> If yes, please get buy-in from David/Jakub first.

I'll make the user space sanity check tool either way.

It would be nice to have it upstream, the checks
continue to be made as the kernel moves forward.

If I need to keep it in my own repository it will be
fairly isolated, and easier to carry for my own use.

If David/Jakub comments here, I'll know.  Otherwise I'll
post it as an RFC initially when I've got something.

					-Alex
