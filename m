Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7A347B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhCXOuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbhCXOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:49:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16428C0613DE
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:49:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so33333073ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xSeOSmridG1M9kfiCY1YupSt6cezElWp7TUDkFUuT28=;
        b=qYgTV4icgJx3mA4AMiewR2wwe13OJ7oy28ABkcs2iAv3R5kCbGGEewQn1K2Yz1b385
         CxzMXx8fcizYz3lMv98eD4S8NOVpnpNuJt6fDuRdtAm/eom9ppzVSmKUwJ0sRr/TnqJC
         uAP/8PVvMUIh84WkNFEc2M6MFj2Mds4uFd+/z70XNMNxqd8Wm4sg9pN8i9YW1YyUCsiZ
         BP7gbSEg4K8VYMcwRvoGRRm7Nklo1srerhUjAKeHZa3r2zWymDlShGvTRNF/nuZ5lY3E
         87qUXyO24j6OutcvAWGvWnkzYPOss8BMoJke1DJeC5vlJ2qUQoobUCZa/jpXAgDNOVHs
         RBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xSeOSmridG1M9kfiCY1YupSt6cezElWp7TUDkFUuT28=;
        b=ROuTsCjv8pCzfD4FyC2ep/G/mAuyJekPP92634l1yagYJufYs5wblzQ+uRYULjUT2E
         iKAaAlz91ZuXQgqVytVjy6VLEi6GPS6CxFCkq62AWT5JmMJ2lqmxTUqNcfJmBtTx7Pf9
         XKtMWQcuLB+O9mQKKfAUFN5Snn7D1LLAh7hJaS7alnb/KNW1QRP5r/4YhCHHh+BRR1qB
         aU7bs7Na1iBNrqBhyPn5W9zP5W6UTp1pnPxg03HjbINDeMXtkPY13byL+ss6GuRxN4tK
         64WCF/o8KHlfjnQWI8djYRN56wKHY4sMy4XjQfrTpTeKIyYQqM859nmPpIwyszanPGqo
         cdEQ==
X-Gm-Message-State: AOAM530MA9WhORVlAoHTYuFdyE2vW1fNY5NS5qg2+UeQBUq4YkuMazpB
        BaIYHkK7Cby2VVrwRdYlOUAuMw==
X-Google-Smtp-Source: ABdhPJySRa5lAY8InJTwQjSSygaV8/DaG9ypGCTX1MhO8f8WmlnkzMklmVldQod3KsZ9XaAVOTZy2g==
X-Received: by 2002:a17:906:2795:: with SMTP id j21mr4077998ejc.283.1616597375680;
        Wed, 24 Mar 2021 07:49:35 -0700 (PDT)
Received: from [192.168.1.54] (hst-221-123.medicom.bg. [84.238.221.123])
        by smtp.googlemail.com with ESMTPSA id u24sm1246759edt.85.2021.03.24.07.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 07:49:35 -0700 (PDT)
Subject: Re: linux-next: manual merge of the opp tree with the v4l-dvb tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
References: <20210323112705.3094525d@canb.auug.org.au>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <20225c7e-1151-7865-2bc6-a1e5694c3d65@linaro.org>
Date:   Wed, 24 Mar 2021 16:49:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323112705.3094525d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen!

On 3/23/21 2:27 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the opp tree got a conflict in:
> 
>   drivers/media/platform/qcom/venus/pm_helpers.c
> 
> between commit:
> 
>   08b1cf474b7f ("media: venus: core, venc, vdec: Fix probe dependency error")
> 
> from the v4l-dvb tree and commit:
> 
>   857219ae4043 ("media: venus: Convert to use resource-managed OPP API")
> 
> from the opp tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

I don't know what is the best solution here.

Viresh, Can I take the OPP API changes through media-tree to avoid
conflicts?

-- 
regards,
Stan
