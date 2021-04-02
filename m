Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACFD352DBA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhDBQ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 12:28:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43426 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhDBQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 12:28:07 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lSMeT-00023n-C1
        for linux-kernel@vger.kernel.org; Fri, 02 Apr 2021 16:28:05 +0000
Received: by mail-ed1-f72.google.com with SMTP id w18so4787129edu.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 09:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l5pH59VX/ksTw6Nw5DlDio0coKgCovudT1I3TQsyeWk=;
        b=CSNPkhCjXUfE3QvdPDoq83o+1iKTJJL1wzjvcAaofxNaGGZYj6FCk+pLv9jOjWQGur
         0kGquMAIpPZVx7W+MayL+lenzYcTCKBnwoe5oKWT4Y6komDHHxws334HyQnpyKaKTXrs
         REpjqFaBd74k1SSpKUecIU804zWaCLRmG9YECd9gzjQf7Chsm//ghXHVweAd865FJzfx
         Z7dR8xM6U8lMa2Fi08xMlD6iRyLxYXKbYpJ2M3ZVJgBmmOQHYJIuxqlNqMpnQ4VTCT31
         OQF+AiyvnaYxEld153FcjeHz7BxXnM4WUCYTsPurQ/EdvM4iuXNwQYctNEOG3woCyMNW
         5RZg==
X-Gm-Message-State: AOAM530M9OWSoRGlhzO5xxq7h/7d1oD+uJ7gOpjMpwo697yzskPlix8M
        Be2dJ4u6VKJTdmEglEMeG2URZ1sC6v2OpBHo3X/z9KAGHFxtpAM3Em5Qzl5DoLkEk8I4Sc9qRrU
        AbvtRxHvbn5eHNhssrmvaZx8OLCzrUy/fI8zrRdDUHA==
X-Received: by 2002:a05:6402:5255:: with SMTP id t21mr16441025edd.91.1617380885103;
        Fri, 02 Apr 2021 09:28:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9g2d4llc2lwvaUsr9cW/SpPKLMYQ3D0UiMnrkeKAcbMQ7aKl9IfvLpIbgjyCTD6YjNjFkaA==
X-Received: by 2002:a05:6402:5255:: with SMTP id t21mr16441002edd.91.1617380884934;
        Fri, 02 Apr 2021 09:28:04 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id hd8sm4311138ejc.92.2021.04.02.09.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 09:28:04 -0700 (PDT)
Subject: Re: [PATCH] nfc: s3fwrn5: remove unnecessary label
To:     samirweng1979 <samirweng1979@163.com>, k.opasiak@samsung.com
Cc:     linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
References: <20210402121548.3260-1-samirweng1979@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <0dc19abe-28e6-69a6-40e6-ba03a09aa3ae@canonical.com>
Date:   Fri, 2 Apr 2021 18:28:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210402121548.3260-1-samirweng1979@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2021 14:15, samirweng1979 wrote:
> From: wengjianfeng <wengjianfeng@yulong.com>
> 
> In function s3fwrn5_nci_post_setup, The variable ret is assigned to 0,
> then goto out label, but just return ret in out label, so we use
> return 0 to replace it. and other goto sentences are similar, we use
> return sentences to replace it and delete out label.

The message is difficult to understand - you created one long sentence
with mixing tenses and subjects. "The" starts capital in the middle of
sentence but "and" starts after full stop.

Please rephrase it.

The code itself looks ok.

Best regards,
Krzysztof
