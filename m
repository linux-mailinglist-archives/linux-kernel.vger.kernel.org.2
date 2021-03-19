Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0A53428F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 23:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhCSWzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 18:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCSWzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 18:55:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82BBC061761
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 15:55:38 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v2so4663982pgk.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+mKc7fzvtmKcq42w/Ei3G2a4+9kipCCTifLYCq+cQUc=;
        b=fTSSfnD45mdZ0Rg/urKyh1uwj4uUpAETH8fwk7hqT7RUREoh0bDBBI9FZNtKQTpBG/
         gCMrqh92Tp4seSaBDr9tEnhbQlSk/qnnPDhsuQ/I3PHCPIZdPo0vDLV/qONC4N2+AAwr
         wa19dKu8t5AhkcsNUTav6ypcoxoDrGR7GtuxQykLVEFgLa6w/lvmqRlIa0rVG5TPdyZT
         Sx89+6Jsv6rY6pX2nd394mMCq3p3AMmzQCQJl2/ABZpRcslBXlxpLYsJPA+VlIigAzXk
         lDXEvtLiAkeGiKMQ3dGjOLDFkpF0CQ10aVLXAHC53fkrku3CVHK+RBkqusGEEhzcjumK
         2VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+mKc7fzvtmKcq42w/Ei3G2a4+9kipCCTifLYCq+cQUc=;
        b=s/n2AWdMyDp/DmeF33YiEp5Hek9Cv2X0g9hZ0W2lUIMQy3rU6S4uFwVV/FuETbi/gr
         Ehmdkp33OC4hq6STZ6UC09/VhDxR1OYnR3aFRz+8l4IApyNm4y7ABdO2JrGKjQnXYNWx
         N4G/xH09mi9OQl9a6RrlFZMl9kSWuwNoAJb2gmUanByH4qXWI5g63OVL3XslUpq5lvJk
         wkfS4bhGqLL0V/QKwQDtG4f3pJUeuIJelZdcvTJxqa13XL/kRVoFrLLWeRDxpBw3spi5
         MZcBYsTb47SzmIU544bCyC81Nb0RuDLqZ1gwQxQ5zhvvadreTg6cmuTTJSlpL+ks5Hu5
         PmYA==
X-Gm-Message-State: AOAM533O7hJ5/Rd/Qroa6RJY5Y7VXMx74810eaT620R9CyxJltY/m0m7
        EMnNPAOsxNUhrkeP86/wgnND0Q==
X-Google-Smtp-Source: ABdhPJyC/IEs/ys0JgG2hYRBSBTKDcU9qfaF+f2gG+JGeGa80ahadwzxKMNZBXodeu6pa3bYlgpc0Q==
X-Received: by 2002:a63:d70f:: with SMTP id d15mr13705177pgg.397.1616194538100;
        Fri, 19 Mar 2021 15:55:38 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q25sm6427705pfh.34.2021.03.19.15.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 15:55:37 -0700 (PDT)
Subject: Re: [PATCH V4] blk-mq: Sentence reconstruct for better readability
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210319225222.14271-1-unixbhaskar@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ff3edeb-aef8-6cf1-5974-4edca486feb2@kernel.dk>
Date:   Fri, 19 Mar 2021 16:55:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319225222.14271-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 4:52 PM, Bhaskar Chowdhury wrote:
> Sentence reconstruction for better readability.

Thanks, applied.

-- 
Jens Axboe

