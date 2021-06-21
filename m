Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F013AED20
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFUQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:10:26 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:08:11 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f10so10793020iok.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OlCOy+HeD0rN5WnuF7UNheKbb+x7CdKtiEN/ib6DAGc=;
        b=nk/K/v736t7tgQbi4fKvxJbk69XoezM/RDnzm+woo4Ihgmkv0V/PNn/KrFIqnPROak
         0VwfmLpvr7/PxlHjVd6mpXPzRCRPxeA8ufUipVzpLSMTars4mkxbZ7r4N/INfFkM+K+L
         9Y7xynd0caPsPqnpShmz0JUHhjs8CX+ct7qCFUIONcTVSOoB9NuX9SiXgloSLOXtMUWt
         vvWXcpTj1YoSv4CJbYYA3xmArILUSDF/XmdOPH8tT4WNGJuLxICl8hhJK+I3XlrgiQJh
         SUEE+T3gFTtvZbYPN7mjUpS6vQ/PS+FMyakgnmlEy0innk9frwyu6KwsvCJUa1+So3+6
         NMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OlCOy+HeD0rN5WnuF7UNheKbb+x7CdKtiEN/ib6DAGc=;
        b=YP3DEZWJD3yaxPfFskbK9ZbiFeDvYIBwdGTDQiYQ+uXCnIlyGy8qnrV1WvIzpIKN2u
         L8x74OunICoFm3k0eaP1nhWi//FP+xNThgMbsfdTV6SsrXS3kWWeH3Di6XU6lafqdxiM
         2AtJlSpJXVfwVPPozSuoqXs+ycZN+7UAjGdLK8hmGBAxlza7TdBojUKGPcttc9wYePl5
         6o8BVXcm4toRPo9ESfpxUnXez9DP4/n27xAt4DSc4z6yQNynJLeGiOrVdpnyy7Iybk5r
         CKQ9evCU/dzQBigH9SdBmS4pHsVT5wuA9bK7UQxjixeUIo/Q4aYTeoTlTheuCPkqr8dD
         uBpg==
X-Gm-Message-State: AOAM530AnPpQWFH51X44E9WEhla+TwwFGsB41kwo337DLdwI2hEjUjPC
        uOVyrb8NjHX8lmJDhaLk94pJIQ==
X-Google-Smtp-Source: ABdhPJw7GMOu2YIDQVXr+m45vazP/BWgabqyV4P6eXHb7lrtN748i81jWxSafG4j/1BdyvLR9BWL9A==
X-Received: by 2002:a02:a817:: with SMTP id f23mr7422871jaj.101.1624291690445;
        Mon, 21 Jun 2021 09:08:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e14sm6317948ile.2.2021.06.21.09.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:08:09 -0700 (PDT)
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control,
 boost throughput, fix bugs
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com
References: <20210619140948.98712-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <02db63cb-9cd0-4068-00db-dc37314faea7@kernel.dk>
Date:   Mon, 21 Jun 2021 10:08:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/21 8:09 AM, Paolo Valente wrote:
> Hi Jens,
> this series contains an already proposed patch by Luca, plus six new
> patches. The goals of these patches are summarized in the subject of
> this cover letter. I'm including Luca's patch here, because it enabled
> the actual use of stable merge, and, as such, triggered an otherwise
> silent bug. This series contains also the fix for that bug ("block,
> bfq: avoid delayed merge of async queues"), tested by Holger [1].

Applied, thanks.

-- 
Jens Axboe

