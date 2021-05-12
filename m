Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3337C079
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhELOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhELOoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:44:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F53CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:42:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m37so18350118pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+UirbY6lxN8Jzb57kXaKy+LkPAyfcN95Fxx30BqluHI=;
        b=0ose4SAhg1I5qKEKEcVMb7ymxoyI9/Hg4OryPbTqcFMggjrx0q2IWLxCZ0rVbTW44J
         mz7yqbArVH8DLeQhntDCg3pFuDvBymAmf5OAgXVrTyZUvG/tkQGfhKKaVLuTQ1h2PqDt
         2zg5lhkqe7MNRg8Ggu2G3HOYI0KLqJXIFiANsPHpD2NddZmfePSOxGLegEWzlPiwvWfJ
         49HaHzXQj2s6P0pU6MasZPC377orOaybGabrc4vTbhNN3nNJc0O6Vvnaz9iUKK4Qq8to
         cvM9zu/D6f8DXR2onh+lxXap4+euA0miF4Y1oEB6pnUtlUE5KMKiBCo/lC8xl2TxTmTY
         OE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UirbY6lxN8Jzb57kXaKy+LkPAyfcN95Fxx30BqluHI=;
        b=HlXJLD+xG5XjuIPfbmkp+8MC2CHeYNcwbLw7TuTF4zUVeDwFTbb0AKq5eQRZ0I6hD4
         xgNMhDAs0bkKC9G3dHHwdgUNsBwPO3Wi3kZRSJ9fYySqMpErb5MDwhUEQwOqrSOv0bdD
         9aVjOqPNK5SC6q8O9CSl/xxwskWraFES/2lm9zTO+4QB39ri7/HLG/KmwkS2hX3dhE4T
         5WUm1jjudOnB7U+MyBjRam81L+C3d8I8IQ2xhsQzfFjkmjXckIAqGt6qNTE74FS+3aHO
         iknZlFavy4a2QDpwi5DpCRfgn7l5ZqR21rvJ2+j5MWCGjfbO6KTDb3ZLvFyWOdE+Mui3
         XwGw==
X-Gm-Message-State: AOAM533TgqBDXMPbOxyq8JIs/vilpd20HQBy06JJaM8M6ThaRT8tga/h
        /0w7LiiL23SsHRQCt+pSyNE1vQLJTliPjw==
X-Google-Smtp-Source: ABdhPJzPhS2CIOVzPw8qvsFuRca1NX77mw4hBIAMHNySwWOzhdg09kxFDd0g2e5VDnxDnjKiRxqDEQ==
X-Received: by 2002:a63:904:: with SMTP id 4mr9588621pgj.64.1620830574139;
        Wed, 12 May 2021 07:42:54 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id e20sm4766519pjt.8.2021.05.12.07.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 07:42:53 -0700 (PDT)
Subject: Re: [PATCH 0/2] fix a NULL pointer bug and simplify the code
To:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com,
        Markus.Elfring@web.de
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20210512114331.1233964-1-sunke32@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5196e425-c073-25e7-b53c-34ffab1fc1f1@kernel.dk>
Date:   Wed, 12 May 2021 08:42:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210512114331.1233964-1-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 5:43 AM, Sun Ke wrote:
> fix a NULL pointer bug and simplify the code
> 
> They should have been applied for 5.12, something was wrong.
> So, send them again. 

Applied, thanks.

-- 
Jens Axboe

