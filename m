Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C0B30527F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhA0DQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405460AbhAZUNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:13:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE90C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:13:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cq1so2659935pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t4rIGbMP+nugCJVqhcBEG6esf1Gvvdhv+s6G8fme28Y=;
        b=gjs4vxZOZ0TsibEO7cm9pJ5JakbmZfyDmmJJBGeRB8Zt4itspBlkuzC2YgOg6tc4RF
         GZGZpH4MSw6NfpPG1DxgFPbNP91pruWog2OekSw6DGF1P6rkqHbJbqFA45O+t8ffaiU3
         V3DPmxkflm2XoDb/jffDcJCNpG86tInDTM3y9DZFsxgeBZPVbvQWRAq5ZwXks0tBRJX1
         XEUY09izQpEVUBGSCHhkUSmASW44oRjkmq4et9Ef2qygYAXsujdQ123ZH0KGKE2UPg3E
         jx+OCq+yTjYYaVUoaISEt8RCl2fzp1+kJNDh6fKTIKaEQJEUeIy8Dn5BRETZuynG0X43
         qExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t4rIGbMP+nugCJVqhcBEG6esf1Gvvdhv+s6G8fme28Y=;
        b=ZAvWiZeszRhKfzCdZGrUk/UfNDqMN0LDaeiLSGohQ50+LYqz3+lX+vDNHcmzAjvQNT
         cr6ocPur1qx13D/jLKiyVLNjd+e1KCWMe+BpDgA5CXgyI+wm0P6oHQrtoZ8ZTG4hD5yW
         SdoeAo8qsa3leevEomxjxsPn7TGfom15Uiirf9S/fpH2g04XUi7R56tvMQV4izX4EbYG
         un4devVWU/hgQ3owLNACeZNNUgvnlAEo6+OrOiS26qHCcsbkEji/de8rPdxjvith+d5z
         8NdCVIxUbSRzBfO+OM8Z0QxAWTXKLBJb9LeludSOg/7bN/3KCUR9lRd1I7ZJK+3Ib4aH
         xo/w==
X-Gm-Message-State: AOAM533RNPbhSCMFny3mdueN2Y+oWHvvJQPhDPslzhJ087x5qucIN6ey
        kYH1b9cDRVwckNt0F97QA52/vA==
X-Google-Smtp-Source: ABdhPJx3V2k3+5lERyKD2HLXO8yJrphtnh3SX9edaN3iprpAUZBZFD9KdvXev2rEerVxNHEO0fcjMg==
X-Received: by 2002:a17:90b:8cf:: with SMTP id ds15mr1535433pjb.182.1611691992462;
        Tue, 26 Jan 2021 12:13:12 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id q141sm9867997pfc.24.2021.01.26.12.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:13:11 -0800 (PST)
Subject: Re: [PATCH] blk: wbt: remove unused parameter from
 wbt_should_throttle
To:     chenlei0x@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lei Chen <lennychen@tencent.com>
References: <1611574024-23713-1-git-send-email-lennychen@tencent.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a08df994-4bc5-c465-a1d9-6d76c0b66b38@kernel.dk>
Date:   Tue, 26 Jan 2021 13:13:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611574024-23713-1-git-send-email-lennychen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 4:27 AM, chenlei0x@gmail.com wrote:
> From: Lei Chen <lennychen@tencent.com>
> 
> The first parameter rwb is not used for this function.
> So just remove it.

Applied, thanks.

-- 
Jens Axboe

