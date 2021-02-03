Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A0B30D6F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhBCKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:02:51 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:37831 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhBCKCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:02:47 -0500
Received: by mail-wr1-f52.google.com with SMTP id v15so23481431wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 02:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DL2MgG7R0iGAIZwYUWgvEIDDkp3CGEEmyEXftED9fsSRnJlVqrkPk5t3BrgTikpLG5
         LjHTqze1O6Z/PJgMDfxnioBph02dlwcVOQVZOGHNw1y1ipgStMovyScZki+C6Qg0vgdA
         5DxCjjSKaNpbeSjLS/KSZvV5s2vYs6/oEDqRJPztcFPOl/zqiDL7AWw8tAdw9QwAUjdX
         MiYEwXMrfHp5eN35WFHmUSxn9DuMkKZe3VvanKwfxO/OM73FUHRUGNmP3DcuRPKtT2KA
         DYfUkImqSn79f9v9N6zu6fMQHirKYKQci7F8i465hUfAJZNoeMGLPCd/xmbakRpzBEIy
         vktA==
X-Gm-Message-State: AOAM5308Svf+fg4MJpsX+GxoUWdB0wIuFsQ3RnKv3sGJIQk84rGgqGyu
        QqYK9Ff1Dqu+9jK/lW61PuY=
X-Google-Smtp-Source: ABdhPJzy9r1w3blcXPLWHRhagtL7Ocpb7GYxYvUSX713YucHGT8ggE6NO8BAbyxHElUba6AOB4xIOg==
X-Received: by 2002:a5d:4ec3:: with SMTP id s3mr2452835wrv.79.1612346525900;
        Wed, 03 Feb 2021 02:02:05 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008? ([2601:647:4802:9070:819b:e1e8:19a6:9008])
        by smtp.gmail.com with ESMTPSA id i6sm2910515wrv.21.2021.02.03.02.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 02:02:05 -0800 (PST)
Subject: Re: [PATCH] nvme: convert sysfs sprintf/snprintf family to sysfs_emit
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, kbusch@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, hch@lst.de
References: <1612249577-66130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3bc03849-b8ef-3596-5f9d-ff172d74f4e4@grimberg.me>
Date:   Wed, 3 Feb 2021 02:02:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1612249577-66130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
