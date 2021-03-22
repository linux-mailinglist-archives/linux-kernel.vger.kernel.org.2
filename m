Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C588334459E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhCVNYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhCVNWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:22:24 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED188C061762
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:22:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id x16so13879228iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LDFmPL3FUyXAXW58ViM3KSmHndreYQbAHVk8Pw7J5gM=;
        b=pJHzjJz1LO66n9zQO/gPaPsJ6L4IIUQnuiOdMClt1mh2TsA/xNdC+XU5oUtEpKDN6j
         eAmSQGUp9KWDqinUqh0tF4QYfjH2i4cIqOOjIl9SSuBFxQwxudEZxXPoXcW0I25vHPpS
         pgcvFLLQYxXSr/ivSj8arTBjTb4yskX128A7dSEwzCCAmFQkTYb5UhmjHoiNoRgxCFMd
         e8AWNFTSGlc9jYAUiID4wAA/3aLG5YCp25ie1EEYFgkSieSlLZcvEGjaZyEL7/wnB/E/
         Z4F0hNr9u9CWfH93MK+VONFlLfNa9jNyWUZ2jt62+FKSd6CH6cRBovMxYJ4MffI4Ucwk
         w1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LDFmPL3FUyXAXW58ViM3KSmHndreYQbAHVk8Pw7J5gM=;
        b=CVxZ9YtaALfOci34IZDQCzl00VvHHeWJgy1yJiWicEanCuB5TihNEIONVTmF7PMsIb
         CToSO4ViS0eG9sVjm05NkBz8Xh/SF2g1Mm5Bj5DZhTPrN9tBI4MV3TW5FT2k0gFpVtQe
         Mn2YI1iASoRnyqlT0YWN3f2ZCjTIqpm3k7au+m0Kb8h8HXOKSBznP1XNFFMWZIW1zSIo
         MpFvKK9e4NDbLgmEusiJjTT1uMh8XBGWNNqhQKTnDFluK+ZAYNjSbifVlOX+sR3BQyIu
         1Stsmf0bmticT278CHvVANA69MWlAqeTE6ggfgzdUNtkANwME+/zDhcR27HUWBVd6amW
         vJLQ==
X-Gm-Message-State: AOAM531+R6XfL+QcGkVzs0C45MY0ibPOkjRKCR1pnIvxueIZQ4auTtjh
        LM6OnN1+WKZhewQqCTem5iI2FC/DPZ0awG7u
X-Google-Smtp-Source: ABdhPJybyZ3/5iLg2KBMhozbaQb09OmVsWn50IxBdfvf2AFm+RrTv0eljS+Na01VP+o8kyGGzC2kxQ==
X-Received: by 2002:a02:6a14:: with SMTP id l20mr11470773jac.12.1616419341901;
        Mon, 22 Mar 2021 06:22:21 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y3sm7598394iot.15.2021.03.22.06.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 06:22:21 -0700 (PDT)
Subject: Re: [PATCH net-next v2 0/2] net: ipa: fix validation
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     leon@kernel.org, andrew@lunn.ch, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210320141729.1956732-1-elder@linaro.org>
Message-ID: <f1b719d3-c7f2-1815-9cfe-19ea23944cce@linaro.org>
Date:   Mon, 22 Mar 2021 08:22:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210320141729.1956732-1-elder@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/21 9:17 AM, Alex Elder wrote:
> There is sanity checking code in the IPA driver that's meant to be
> enabled only during development.  This allows the driver to make
> certain assumptions, but not have to verify those assumptions are
> true at (operational) runtime.  This code is built conditional on
> IPA_VALIDATION, set (if desired) inside the IPA makefile.
> 
> Unfortunately, this validation code has some errors.  First, there
> are some mismatched arguments supplied to some dev_err() calls in
> ipa_cmd_table_valid() and ipa_cmd_header_valid(), and these are
> exposed if validation is enabled.  Second, the tag that enables
> this conditional code isn't used consistently (it's IPA_VALIDATE
> in some spots and IPA_VALIDATION in others).
> 
> This series fixes those two problems with the conditional validation
> code.

After much back-and-forth with Leon Romanovsky:

	--> I retract this series <--

I will include these patches in a future series that will
do cleanup of this validation code more completely.

Thanks.

					-Alex

> Version 2 removes the two patches that introduced ipa_assert().  It
> also modifies the description in the first patch so that it mentions
> the changes made to ipa_cmd_table_valid().
> 
> 					-Alex
> 
> Alex Elder (2):
>    net: ipa: fix init header command validation
>    net: ipa: fix IPA validation
> 
>   drivers/net/ipa/Makefile       |  2 +-
>   drivers/net/ipa/gsi_trans.c    |  8 ++---
>   drivers/net/ipa/ipa_cmd.c      | 54 ++++++++++++++++++++++------------
>   drivers/net/ipa/ipa_cmd.h      |  6 ++--
>   drivers/net/ipa/ipa_endpoint.c |  6 ++--
>   drivers/net/ipa/ipa_main.c     |  6 ++--
>   drivers/net/ipa/ipa_mem.c      |  6 ++--
>   drivers/net/ipa/ipa_table.c    |  6 ++--
>   drivers/net/ipa/ipa_table.h    |  6 ++--
>   9 files changed, 58 insertions(+), 42 deletions(-)
> 

