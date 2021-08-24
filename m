Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF373F6281
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHXQOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhHXQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:14:28 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9358AC061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:13:44 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id l10so7306028ilh.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fL6M5M+ZQf9tkzwQfSg/E8Nzzkt+d6QKhAddz9kDrLw=;
        b=QcKBXjqgCdKIog3MSnLBEtFgC7Wtxz1vqnDq+Kg/nmaPgFNTeKoHg/Rw36MZwZxDsO
         bgnvECrfd7y0aueCtNDQORvsMR6E7ZNWgrNC4Ak1/96SZapOFioWMy+GjU+TOvMpjzW8
         oXSfbc2wyUOXtmqinq+5F0hI2Y5MaHIDTXI8+u9tKF/nXyTjO3dvnN2FsGbAMzXNG618
         ACEvUwvW/09lqao3vQAs/FmpA0esnExWHoRi4cplCWqNdZ8toZuQTVaZc8fNE8sHg2ur
         pvdL+XTo70hfw2gl/Vy2ZKo0prnI0cdU4umbwKUkWeHFM6uGBhYjDpn+NBQ3M7RyXmwv
         1CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fL6M5M+ZQf9tkzwQfSg/E8Nzzkt+d6QKhAddz9kDrLw=;
        b=ng97rPLKCuiMpB64igjWs9UhUR9pWqPKu3C/uDPjwtUzErIIapUanZUHEIvFAFuJvs
         kJSKQugDg52XMVFQJEMM97u31OozJ5qpZazCH2btvr8xAoqKDrWYMuw4YFAEo1vT90eR
         kIgUT5IftXY0EU7Ws+iF89hbJUZaAfIrxN1Nh5UZJMjh58VLqhk/EdnAAD65hrzXQJtL
         4FwhKKnXfEJ9vio13rTYhaiTedz0gXRGTN5yyRO5JHVBSJAFan1Gac3dAoRCn9cagYf6
         1EeIjB2SCKypfZ/U/eCCGSx+N8cIKqYrfmcZrS6PEC3sEjsT/nRYrnxzdOMnGpkQDXHN
         16cQ==
X-Gm-Message-State: AOAM531HKqie4GGSPDFzg4w3bEnPSqGsLMNVhy+exq0D+rI3Ecn09dwP
        Mat1BTRnzriYzZVT5vC11CJEOunf92l6zg==
X-Google-Smtp-Source: ABdhPJziirSX8gjQLqc3AQRcQQHS7PUSqIE4ljRCP8jio00Kp8Ixuj1HbGq2QsL38XhoQ4k5UcHqZw==
X-Received: by 2002:a05:6e02:1044:: with SMTP id p4mr26857255ilj.227.1629821623851;
        Tue, 24 Aug 2021 09:13:43 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id e1sm10224562ils.76.2021.08.24.09.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:13:43 -0700 (PDT)
Subject: Re: [PATCH v5 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Shaun Tancheff <shaun@tancheff.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210811110505.29649-1-Niklas.Cassel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15e827b8-5bf9-eed4-7358-80f9e2a7766a@kernel.dk>
Date:   Tue, 24 Aug 2021 10:13:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210811110505.29649-1-Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 5:05 AM, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,
> BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without
> CAP_SYS_ADMIN.
> 
> Neither read() nor write() requires CAP_SYS_ADMIN, and considering
> the close relationship between read()/write() and these ioctls, there
> is no reason to require CAP_SYS_ADMIN for these ioctls either.

Applied, thanks.

-- 
Jens Axboe

