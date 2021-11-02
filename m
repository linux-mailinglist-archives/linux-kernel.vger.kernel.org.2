Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ABE443753
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhKBUcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 16:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhKBUcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:32:02 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F4C061205
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 13:29:27 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id g8so169647iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=iPJd9JKTKxLNWmDdjVV2bUXNG4tGl0vH0hJO+CARqRw=;
        b=0iIp4qk45JZl1eOFfgcQuEuMyPgmWAp0PIdI3whd/fVgR7yCJcpTMnISa9O/U0kOC4
         fkeVFp5HJNr8sa0uTicRXc3EZBGSQO89AFaXTWBRevZ2FUpL1BjDnIuvYX+8zielpi2Y
         hRvnIJ2n2MshnrHULrraf+auIzUpvcqzwQ9lcVM7hSSwDJQCZJiYn4v1bpgEzjtP4nZF
         tbBvbEWNy7cXTpi8tN5ZxwwbFH3TFwoK6NOfCi9dmRoZ9oBU1FAZRa9O+ijBcP8K7DaN
         s4xkAjz1XS1frafIHcKGwm4xtl5cxoq9rqlZbvdUH6YBrms7Q44h3axld+Yw1xYLktCG
         zmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=iPJd9JKTKxLNWmDdjVV2bUXNG4tGl0vH0hJO+CARqRw=;
        b=UH/UhHCMaadQPxYP+FT9a6CcWLGMJ/aS8Gqro2U6ZCdcJjUvgnziWrlFk7sNliXs7J
         /ApNH547gO01qrTqlcfLD3IPJUF+usXvFjyITdwjICMOyQfE6lDKWD7LGaabFEb7FZ2Y
         b5g8+ujUUfi3AVujaLFbrz1lXS4NTI3Rb3J7rnciqnwARsIlDVtfzKwEy5yC0HyMfv7V
         NA9guNCaruaGbKxf03g8MPrEY/LquGPu6I8jFM+qPm6E7yFQIpZ5mG1dWq1orIDDaJab
         1A3K8e7DLVHyd+TyX0ey5+OjXo5lbNWIttj1SA4VJVqqEqKLZs2jAE4BFMy9szbJJT5l
         Qlpg==
X-Gm-Message-State: AOAM532g7ZP7bJ+24ySPXo4ouY/Z5F2iU4SELPvh1tJDCMsYuSMJDKOw
        5Nyhj40b2NBbKjuFHL8vvBzVExox/SbDCg==
X-Google-Smtp-Source: ABdhPJwnz9iQP8TzSsd39fWJULmH8Pcme8HX4Yxdc1kaIrDPhustKj+Qk4HQk3fIwuIJsC+FHvvgow==
X-Received: by 2002:a5d:804a:: with SMTP id b10mr25637599ior.197.1635884966849;
        Tue, 02 Nov 2021 13:29:26 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y12sm76815iow.2.2021.11.02.13.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 13:29:26 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Nghia Le <nghialm78@gmail.com>, asml.silence@gmail.com
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
In-Reply-To: <20211102190521.28291-1-nghialm78@gmail.com>
References: <20211102190521.28291-1-nghialm78@gmail.com>
Subject: Re: [PATCH] io_uring: remove redundant assignment to ret in io_register_iowq_max_workers()
Message-Id: <163588496632.461656.9257626147763186958.b4-ty@kernel.dk>
Date:   Tue, 02 Nov 2021 14:29:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2021 02:05:21 +0700, Nghia Le wrote:
> After the assignment, only exit path with label 'err' uses ret as
> return value. However,before exiting through this path with label 'err',
> ret is assigned with the return value of io_wq_max_workers(). Hence, the
> initial assignment is redundant and can be removed.
> 
> 

Applied, thanks!

[1/1] io_uring: remove redundant assignment to ret in io_register_iowq_max_workers()
      commit: 83956c86fffe0465408c7d62e925d88748075e00

Best regards,
-- 
Jens Axboe


