Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E333955DF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhEaHTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:19:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60260 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhEaHTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:19:10 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lncAz-00012W-9T
        for linux-kernel@vger.kernel.org; Mon, 31 May 2021 07:17:29 +0000
Received: by mail-wm1-f70.google.com with SMTP id w3-20020a1cf6030000b0290195fd5fd0f2so2849439wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZTOFo+MaUW6bLeDfHsCuxgOawe6aQHUICLT+z0be/C4=;
        b=VWY8MdbeuS41eRr2v9cWSO+OyxT0k7MyMWzlK7O27R5wc5KPC0pj+n+7a/fcpq+Kym
         g5o4jX0Yt+9leV0YfguMDgg+nMEtLU2zHc0QE4o/7jKKvZKvHII9cqJtD4aBGf5eGVI3
         Q+JwrlRg5qykzggTG8N/ExHSD6kqUJaqivnSjydXak6oUc0udbLdHjzrzdYI+a/UnPOP
         ASzq26R5sPwIxThO2kEmcsfakBYJxZm3LsLRIqA0D97AxMTx6gKVYCFEn0A2k7f7Bzhw
         aSpYruwe5jtSH4jQZvwmpkr/TMMpDsIGInEku7tgcqvzxAX73ohEMRUR1MjaxEU4yX9b
         qe0A==
X-Gm-Message-State: AOAM531Zn8HMht96T/0LsZ59D3zT0gRkv1akWQNsynTPW+i6Vpd15T5e
        bd6FBkyPNNC99AIdardgYcvxSpWwi5Y0yajGpi2ErhtF/bnD4DPtFviKv2wWGf2POzPLHj2IKON
        x4NtUeWNx0A/hNuzGNztfiFqtSN8t9wJjJQydAV19yQ==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr20101320wrw.278.1622445448810;
        Mon, 31 May 2021 00:17:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyL1dPyIG3xEo8t+XluxVdxVZL6v4mAgtBCgrs0AQgTyghIEB8Z9V9txxck75EZzjFW1LA/g==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr20101314wrw.278.1622445448672;
        Mon, 31 May 2021 00:17:28 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id c6sm16090699wrt.20.2021.05.31.00.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 00:17:28 -0700 (PDT)
Subject: Re: [PATCH net-next] nfc: hci: Fix spelling mistakes
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531020019.2919799-1-zhengyongjun3@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d9c68f7c-6956-48ee-97d3-5a3df93cced2@canonical.com>
Date:   Mon, 31 May 2021 09:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210531020019.2919799-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2021 04:00, Zheng Yongjun wrote:
> Fix some spelling mistakes in comments:
> occured  ==> occurred
> negociate  ==> negotiate
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  net/nfc/hci/command.c   | 2 +-
>  net/nfc/hci/core.c      | 2 +-
>  net/nfc/hci/llc_shdlc.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
