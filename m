Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF3F316B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhBJQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhBJQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:39:44 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB5FC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:39:04 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id y5so2424167ilg.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JV4Ql9KQvz2aQzVgMYltIdHx2mjwmlHNpDGI0MR+TO4=;
        b=k8PSQF9m04mzFOs+Ko82ihv/AVrehPpQDFAx2TxGHFhAU7+EYNNE3GF5uiErDrhL84
         WYj3fDnOgadhkXP9L8L9WYVUlWt1omqEr4fqYg/IO3rSkAVRZnvvhFGPXQ779qMpX7Mx
         jykI09prfeDNI+sTGI15ImDpydSmWQhfy9SvZeuz723dOMedeHLyx4STjo0L+Ptws0r0
         gL6nOu96rOfxkoTrUKERr320ZDybsx+CQgLQJjYeuByLUq7poUXMRaP+ON+Oebe9vHNW
         FfSGRTIY/oY7lHj3MVVKzHSxNgD+I/GJM9OZOy+pZl5tt8fYFn0UFn0E93R0STCqv57p
         acvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JV4Ql9KQvz2aQzVgMYltIdHx2mjwmlHNpDGI0MR+TO4=;
        b=bAU7MYEq2I4r9mSJ+5vl1WLrTSkvygoGOrXFD2xOaWP6ardjtncNBtr5PB50ZF3PA6
         HxMBd28VQ1gagX5s4Fo09MTT5mTcJK1qpxKAReNxW02hRJyGZiqpyuvvkcwHNv+mNaol
         b/qk7Ff6uUBjRAoV2s2c8BMb6Ubt5MEAFnNmGIGj5VooJd6ylLt68VKcyTmNjdBCH8mq
         lM8LYy6vWO29HM7ON1H3fZ5k3sHK64+muWZmDkh46JQzprmjTSRlYhK7zF3Tzr/8c9jE
         GUeCLf8fqBdz/3GoNL2sF9cBL8tmSAIdknqLQVLGVT0Y9IGinCVq2EG9lSFiKPJML3we
         6iOA==
X-Gm-Message-State: AOAM533Ha4AVnNlTTnrTdPGlNun7uvK7idey8KYYQB7I1S+sSKSVy02q
        aHNnBjXOE5g0xJDo1nQLoXeVeV0CcVBIVF9T
X-Google-Smtp-Source: ABdhPJw1merUBFK9auBoXl06LixxbdwajQJcJD3Jz93k8Zq2oCcy2VpISqLU1+xUe0ziW9c0U8hReg==
X-Received: by 2002:a05:6e02:1ca2:: with SMTP id x2mr1826237ill.243.1612975143608;
        Wed, 10 Feb 2021 08:39:03 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n194sm1163801iod.25.2021.02.10.08.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:39:03 -0800 (PST)
Subject: Re: [PATCH] nbd: Convert to DEFINE_SHOW_ATTRIBUTE
To:     winndows@163.com, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <1612595455-4050-1-git-send-email-winndows@163.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f50c63c-adbb-a89d-9188-e77bd5e6dd32@kernel.dk>
Date:   Wed, 10 Feb 2021 09:39:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612595455-4050-1-git-send-email-winndows@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/21 12:10 AM, winndows@163.com wrote:
> From: Liao Pingfang <winndows@163.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Applied, thanks.

-- 
Jens Axboe

