Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A653FBF62
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 01:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbhH3XXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 19:23:13 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:40842 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbhH3XXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 19:23:12 -0400
Received: by mail-pj1-f41.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso601396pjh.5;
        Mon, 30 Aug 2021 16:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3BuLY5kAE+rCQDQ4lYnvYWzvrhUWdDxg0o3sLidGK5s=;
        b=Gh66qja4pYH+aIgAe6BAOooCPzzd7FEyDdxlaZZ+IqEa0Y8ah80VpiVZUvwF7aHqpM
         qgUrEV94Aj1Kpl2czixtt4DALMsiQFMED8u+pittgy5PjY3NDWy2A5qlj2oWFjc+R1Pr
         0VVDaPwM+D0SDMfMaureoD3x61pDbOLE/dxlz8geiDCRvJ4ZvgcLD4WsD6kFW15iDpMQ
         6fCBAXbHLfYIADC+bPdQC0GnZfkaO/pIOrYiW3IqeughHh4pPmvcBT1zloiDpepjhkIf
         NYyWbsS7PdZdha2kYzJjfcVw11AUMhQVnEIORqvUMxg/NDUeYsxpTWAGAzdvXoiykS+i
         qquQ==
X-Gm-Message-State: AOAM5333ut9J4qU6S7v7cJEvwn7AGkdNeF+pfLWFmotifo0q+AXLDekY
        EXwDcK7DeYSZCiwMmTmrtqO8oSwPG68=
X-Google-Smtp-Source: ABdhPJx0Kt94qu+u3L/jCu5PjC+so9nK8TNaDN8+z2gVkqDkG4poj7ZG9IKS+p+/l0cMxxVBoD68rw==
X-Received: by 2002:a17:902:9009:b0:12d:8de4:bc2d with SMTP id a9-20020a170902900900b0012d8de4bc2dmr1830427plp.44.1630365737564;
        Mon, 30 Aug 2021 16:22:17 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:86a7:224:3596:de63])
        by smtp.gmail.com with ESMTPSA id u6sm17625679pgr.3.2021.08.30.16.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 16:22:16 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Move dd_queued() to fix defined but
 not used warning
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210830091128.1854266-1-geert@linux-m68k.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <eaffaaba-ac90-62fe-7f7a-0e621f60cf73@acm.org>
Date:   Mon, 30 Aug 2021 16:22:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210830091128.1854266-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 2:11 AM, Geert Uytterhoeven wrote:
> If CONFIG_BLK_DEBUG_FS=n:
> 
>      block/mq-deadline.c:274:12: warning: ‘dd_queued’ defined but not used [-Wunused-function]
>        274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
> 	  |            ^~~~~~~~~
> 
> Fix this by moving dd_queued() just before the sole function that calls
> it.
> 
> Fixes: 7b05bf771084ff78 ("Revert "block/mq-deadline: Prioritize high-priority requests"")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

The Fixes tag probably should be changed into the following:

Fixes: 38ba64d12d4c ("block/mq-deadline: Track I/O statistics")

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
