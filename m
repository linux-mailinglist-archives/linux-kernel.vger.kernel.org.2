Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970B93A8B79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFOV6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFOV6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:58:45 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD7DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:56:40 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w22-20020a0568304116b02904060c6415c7so454130ott.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tDnHXc57D9QyDGOF5LH+HAMbCqdszKSM0k+K0sq3moA=;
        b=wl3/ABkvdM4ZCEMrtcyNlgsn9a2KN96Zy1tQifdjvb6XD712ejwdyKSdZXhuGLuRo2
         bzWkEg81yF6kpDgMHMEpl+et1F5F3hM01yn3b7NAX8yWXYlVSjWUCfveHRHdlD2UpzDf
         SjcViThX399IN3Q6eQ6MpZZ4UYi72AA0u7ZZx/E1ub44gQsvGK+0WND0/Y5GG3vYHVjY
         9H/qF28TNclK/riujjcnz8mLt/YYgL0zDsuvQXbHt/5OyhR4qWRGpp0y4+HsfrvTThkT
         wzqnLYRNMJRoT/+p8VF7JGLqBluRReKanbZnnHUoX7F1/Wdt4CmWoyiEQahUnySLo/t9
         KYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tDnHXc57D9QyDGOF5LH+HAMbCqdszKSM0k+K0sq3moA=;
        b=PulWh0S3qYgpo5m48dJ370pYTOL1kewzz/1uOYe2dAxnWAl51WIO8WwCgygvOLIQW5
         +6MPuTFrqmS5gO4iS4FHus6bV6zRMtv4TiVm5dK+lE3Xjsa3MhVEGEKKm55R2DkL/c26
         x8J3X2TsHxgarhBBZ7es51PltXcoC2B7pZOGaXTxoEbTiepyCzbEBmD3bztxwycGQhk7
         UrirdSqq15iBAdWs/o7oXantF5EhQFb5gyhFu6buQQw0OVS/5T0tnQGKO1NTm+IMFAVa
         4sLbg7JpXHlq2oJKB8ZDWUdC7d1we2caiiTUjwaAUX7N09gqY6EMnIMEpcjmrpAo5uyx
         Terg==
X-Gm-Message-State: AOAM532xurP17KX5AVSF7di0OSR0Y/fZalSdlT9dMQWVc1qjKFu/26Ev
        13V3PLs0RLzShtm5un/5H3TuD7a5LW6ZXg==
X-Google-Smtp-Source: ABdhPJzdNO2QgxcfwPPXlpSIkvFMGWzjk2XcT72fuEEiQQOxrvHKF55SxmnMCBZiNzH1KW5suQ5ghw==
X-Received: by 2002:a9d:748b:: with SMTP id t11mr1119913otk.35.1623794199650;
        Tue, 15 Jun 2021 14:56:39 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id 2sm50177ota.58.2021.06.15.14.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 14:56:39 -0700 (PDT)
Subject: Re: [PATCH] null_blk: remove an unused variable assignment in
 null_add_dev
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org
References: <20210614060231.3965278-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <073da0e6-26e4-328a-70db-e22bb2c1c9ce@kernel.dk>
Date:   Tue, 15 Jun 2021 15:56:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210614060231.3965278-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 12:02 AM, Christoph Hellwig wrote:
> Fix up the recent blk_alloc_disk conversion.

Applied, thanks.

-- 
Jens Axboe

