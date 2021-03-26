Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFDC34AC03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCZPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhCZPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:54:13 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FB7C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:54:13 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id 19so5436732ilj.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hmKZXA8mj4z2Sn0NHF1dB2StCwX5I/Ah2+MSyhgR2YY=;
        b=zYiTc86pU51MTcqBFxpaU/Sd2COgU4Dmu4VyvQBTD970eIib2xKA34eL45fbrmug+M
         8lf7EveY8LnApuMB8KJ+GK6Wvg+U1ejvCac1bzJxMAFSWCNHv9Wnv2sLDsvK/uIFaT5x
         zyaezKHWg6+ri6yWnUJz0MJLaqWVpkGn8EIrbsHme5FxGESotrhrSeHVYRltvCeZNRfK
         dAR3KAcF2+Zn4jd3lhK8MwITlGXxas5TM3n19xXNwdXVOQexQfOXxHcaaMABPgZqMvfN
         /gSldH64oh2G7X/qFIszTXY32M1WOT7btpmUT4fwKCeY4KTUxdobLuZ6+v4IVOINEXWX
         TEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hmKZXA8mj4z2Sn0NHF1dB2StCwX5I/Ah2+MSyhgR2YY=;
        b=TBrjcL+9aEQliomxqkgjjD1d/gZlpD7NSdpkr5HOqlzgVsxdf/90rtbHYmd9q+/D5j
         cqMvr1ZeoB08maR0P6nHKpciaZ2hp3z4wXFe8mortHxRDTOrtgEw4YpAg5ZYUKpnTVui
         oZ14K8OAMZ8eQK7uL5V+zFbHQ/AbeHZGHm/hOzFpnrXAiJwf/cRMoj3Ka91/9hYYBzdJ
         KnVIcbkWN8OtYCyXsj+wQU3wIXYjcgRae5Mc+6JZNvrOmBmxIiPy+oNRxuyMeb4ukYlR
         bP+cAbJumV0Ys/93Ikp9cuiAxOVxxy83r7/L1av6BVemHnSKHA7clS+6/3vPQMXHfoy3
         BqEw==
X-Gm-Message-State: AOAM532IL31W4VgFWs8liL85hneOq/l0+MYbhC/D30CgCgmmeD4dGKeR
        cGq5NhJ4XNMZvdDga/fuHqSFiOw1AI+lsA==
X-Google-Smtp-Source: ABdhPJzi6hlAERDYVoi4MIIMAiGygBCxqnc7RLVE+8vACOumfKUHb6kQh3nsN6p0QGTulNruW9MZvw==
X-Received: by 2002:a05:6e02:1546:: with SMTP id j6mr10820381ilu.75.1616774052468;
        Fri, 26 Mar 2021 08:54:12 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w1sm4527876iom.53.2021.03.26.08.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 08:54:12 -0700 (PDT)
Subject: Re: [PATCHSET v2 0/7] Allow signals for IO threads
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20210326155128.1057078-1-axboe@kernel.dk>
Message-ID: <c9d2d005-5426-abb7-666c-488b83014924@kernel.dk>
Date:   Fri, 26 Mar 2021 09:54:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210326155128.1057078-1-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 9:51 AM, Jens Axboe wrote:
> Hi,
> 
> For the v1 posting, see here:

Sigh, just ignore the last 4 patches (07...10/10) in this series,
there are sitting on top of this series and I messed up the git send-email.
This patch series ends in the 4 reverts.

-- 
Jens Axboe

