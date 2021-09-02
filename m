Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8508A3FEDDB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbhIBMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344538AbhIBMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:36:48 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4FC061760
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 05:35:50 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id x5so1606721ill.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=osIJkBvwdWWjGM2Xczs+xKtVAwutZFKbM96ppuoJRyU=;
        b=SeGdgT925WAlK2GMS4zGWccKacFbYhyrkmazsxC9O1vOB/ssBzdUnp8HXCyYYSxsPk
         W/FVlCBJ/dpx4j3bfMgS3S+Xmtqr8SpioPKN5TfV+WSj+SoPDcvAdKCOomlwfavV6Dvq
         y+dq0VrD5HFx9YeYh0gZhsgpfolQ0OOQTFfnr44Xtw8XNSDFb4CQlAqkMkrLWUeg7n04
         nm0Ant2regqGEcoLFmpa5WELYe1uYZlQBVMQJ+DfQp5DOpWXtXaKGOx1m9xIsj0mM9tw
         HlHJT2WVOj/n2jUFXQGg4WVoEc+BS0PXLVr4bgjQNOxVG+3a2JMmrqjsI/xX3GxeS3yc
         qagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=osIJkBvwdWWjGM2Xczs+xKtVAwutZFKbM96ppuoJRyU=;
        b=hFpndaq8iOVekbwPLmQ32E0g6lteEAZbHrBlI9GL4Xidm3OEgNL+hfDx5WM2KgXcLo
         K0U0A0lPdhE6sI8+IGlkvZekErDKnq881QExITcnWmDBh4I4kelOjDrUFS1vEbOxBL4V
         fvtYYzORCGAhgNCvl/hM+Dbf9jql86wNkZQbiJupLmnThuzj99ewirTFo9/R9zYYA+bl
         /lG0xlFqyTfPer52pyeGAIUiz+xZVEXqkq+qP5+DVXvxuzDKPmpSvgpNqkacngm9mFZi
         VBlFCIsTlpPvJQNhLSl3uG6pFsYg0v0YLzF/wSsAWGzkH+OrE6QngfgAylcLOd9AeRZb
         0hmA==
X-Gm-Message-State: AOAM533bt53H7cQy6x1GBLdv0Yx1I9K+AbfNgiVuXc0pOGLS4DHQkPfy
        CaMeIJIYotCPPZR+QLWd8naWqYmp0s/GJw==
X-Google-Smtp-Source: ABdhPJycVzqLDgXQPl9SzoElPgyfW00LsbFQh6H9OTQHYK2VLCDcaBceG4aBh+ri2HwoqJR01g7tQQ==
X-Received: by 2002:a05:6e02:1bc8:: with SMTP id x8mr2145533ilv.138.1630586149849;
        Thu, 02 Sep 2021 05:35:49 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j5sm875526ilu.11.2021.09.02.05.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 05:35:49 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Move dd_queued() to fix defined but
 not used warning
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210830091128.1854266-1-geert@linux-m68k.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <caf2449c-e86d-195d-3635-9be49159166a@kernel.dk>
Date:   Thu, 2 Sep 2021 06:35:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210830091128.1854266-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 3:11 AM, Geert Uytterhoeven wrote:
> If CONFIG_BLK_DEBUG_FS=n:
> 
>     block/mq-deadline.c:274:12: warning: ‘dd_queued’ defined but not used [-Wunused-function]
>       274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> 	  |            ^~~~~~~~~
> 
> Fix this by moving dd_queued() just before the sole function that calls
> it.

Applied, thanks.

-- 
Jens Axboe

