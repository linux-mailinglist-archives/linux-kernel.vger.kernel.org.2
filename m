Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF1453D1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 01:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhKQA0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhKQA0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:26:43 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB88C061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 16:23:46 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id x10so830118ioj.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=zsadljEAoTW1O/e6cBvAvPdWibAzK1CvOl83K6umqDA=;
        b=Cw5MV68s67fj6e6eunrAfI8H7rqe/BTcJGJBpr6DRoKSdSqEtBsi5ls/9TuKBbVI8J
         q1K1VTKED0cHapqbe+bwWL4K9RJ6plgB0OgwkiebykgvzpQILjZF1+wf9nn8ti+FB7tC
         hw5rLPDHB0l6iWz53ihirPji06SIRyVp0ZYQRhj7UhHj3gQWUbHH9VPwXIxSvmGO2p9F
         w8OxFY+bNSm++4n/GikcCV0uz41W+BAQXjlSgckec0cGDAEQbk0asp2DVrY4DBm6UUiw
         5rjCx71CF5RtjbJTwM768S8xDO+Rx2ykNiOIRBc5BAGdLGbThM2lARm8VjiFKmwt/KhA
         VsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=zsadljEAoTW1O/e6cBvAvPdWibAzK1CvOl83K6umqDA=;
        b=LU9waQXgQjqiooclDyVFjZmcHoREWbveVLCbDgeDVE+jTorfhviQUWbk0fD02EDkFV
         LDFN7oz105YVhsnRdR0ZOCYm10tYILuWdXZuSAGcrfJjs/8RUX/O5mrFBrDsk3wq2CDG
         XIOdY7s7QZIdOcVv6pmr8zpY5gtuTwdV7XY0PPgo8dt7TMlxN/sROljwBFp8JZGG5uvW
         kteq0dDU4idEKdGvQz60AZqFgsyoqE+fjJH/JRa/DeNeoYLTwNck/mHmqxAPJ+1PzRW2
         +rcNVnTdOIkYKj4NKLDNAUVTt7pN+P2d27w9hq28CY2bXdTAX2HMt1RdZYWO3y3JkM9B
         EJgw==
X-Gm-Message-State: AOAM531yPovf73HFABYlLUYFdiLbMJN49c92yKOwLQbdSczzvkSqvq6i
        Y6ID2THJ41tRcHkpnrUumLaX/MGGg5vvJqO7
X-Google-Smtp-Source: ABdhPJyD3SUnIXbcZ9FIm143ErrNjM4H/LvjYDgSMsBFswHxvwmWNYHdOuryNqeFN5/zGT/1kSbgDQ==
X-Received: by 2002:a6b:ea0a:: with SMTP id m10mr7997067ioc.91.1637108625356;
        Tue, 16 Nov 2021 16:23:45 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h19sm13701133ila.37.2021.11.16.16.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 16:23:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20211116181559.3975566-1-keescook@chromium.org>
References: <20211116181559.3975566-1-keescook@chromium.org>
Subject: Re: [PATCH] Revert "mark pstore-blk as broken"
Message-Id: <163710862474.168539.12611066078131838062.b4-ty@kernel.dk>
Date:   Tue, 16 Nov 2021 17:23:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 10:15:59 -0800, Kees Cook wrote:
> This reverts commit d07f3b081ee632268786601f55e1334d1f68b997.
> 
> pstore-blk was fixed to avoid the unwanted APIs in commit 7bb9557b48fc
> ("pstore/blk: Use the normal block device I/O path"), which landed in
> the same release as the commit adding BROKEN.
> 
> 
> [...]

Applied, thanks!

[1/1] Revert "mark pstore-blk as broken"
      commit: d1faacbf67b1944f0e0c618dc581d929263f6fe9

Best regards,
-- 
Jens Axboe


