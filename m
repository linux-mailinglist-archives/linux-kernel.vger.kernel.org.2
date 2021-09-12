Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3311407F6B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhILSbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 14:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhILSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 14:30:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBCBC06175F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 11:29:43 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id a13so9188837iol.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3rarLVmhjlYCLBQP/dFIghpuLAWbLj88vP6T0e8keIE=;
        b=hLJBZhwubj3JFpf6gdUSuPJmM5Xmwh7RET4YKzt2SytNGLpRpOJ14lAHyDpi6j4WqQ
         tjBdsWafGKD1e5q5YmgdAYMJhQmein+qYM41GAeATMBt4Erj9jK5vRcswwWsRCdgA1Zw
         o/VEPFpZW119IBYPwQ8G4aYDv9rsY3mSYhA2bKMlBjCfBbTo0aywG+NwqCL7QFktudtr
         cNx3b+ewrzljtTpzD3veBLObjp2FNGcqrq2sQyGOdwHxG68yutrkclk06Rg20cVRroD3
         jY8jL0yXSs0aYVUDPUeAdJrARHPKRGEaKYZLdPtSOdRgAq+R9KR6iJ8ZrEaeIq7uGoGc
         Exrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3rarLVmhjlYCLBQP/dFIghpuLAWbLj88vP6T0e8keIE=;
        b=vFPJZSjORyyl9g+qVZdrQJQqvB6gClKzW5E0P2Z1A+XSvqvoZoPa9D9R+54JUU0la6
         5oKLCxLm6nyv+lZg76F09+A9CxHe4mdEKPkb8Tx9SEbKObCrSeFc1Pn0BA+6G+kk4j7t
         UtTFxxV0DhsIrMdj+60hY5Hknjzf8RB4Hu1+gP1xWlw29eYTo4SN43clwFbAXaMHLm6Y
         uzy3ofK73GwLvuSUxx0fPujvYSyvYaaaMheApkXH0bY76vOfDo37wQ9TVGAAjn8RLCQ/
         I2TNN2AXaDJZNRsbDJFRFWvFWkfwCdXsCHE/mViPrnJGIbEASUvZUNblW4BADUZBFQtQ
         /xlA==
X-Gm-Message-State: AOAM533W5Mbu+Hr0MVFbA32e1JnVByjB3FljRDe5Dn59j1E2683MY7Pi
        fy4TD0ThTatEpKmHG6o+EFAIuQ==
X-Google-Smtp-Source: ABdhPJwVwJgSLhPe0+BW+Sq74zac2nHWb5SRB41ZT3wL3Lu6eSg64DEbxo3/P7URMgWaWB9IesOyjg==
X-Received: by 2002:a5e:990e:: with SMTP id t14mr6060888ioj.75.1631471382926;
        Sun, 12 Sep 2021 11:29:42 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id b8sm3212270ilc.41.2021.09.12.11.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 11:29:42 -0700 (PDT)
Subject: Re: [PATCH] io-wq: expose IO_WQ_ACCT_* enumeration items to UAPI
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dmitry V. Levin" <ldv@strace.io>, linux-api@vger.kernel.org
References: <20210912122411.GA27679@asgard.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6027db7-3ebc-6f12-2b58-4b068a346ee2@kernel.dk>
Date:   Sun, 12 Sep 2021 12:29:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210912122411.GA27679@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/21 6:24 AM, Eugene Syromiatnikov wrote:
> These are used to index aargument of IORING_REGISTER_IOWQ_MAX_WORKERS
> io_uring_register command, so they are to be exposed in UAPI.

Not sure that's necessary, as it's really just a boolean values - is
the worker type bounded or not. That said, not against making it
available for userspace, but definitely not IO_WQ_ACCT_NR. It
should probably just go in liburing, I guess.

-- 
Jens Axboe

