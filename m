Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFCF337CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhCKSt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhCKSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:48:50 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BE3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:48:49 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id d5so265322iln.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mc3m6KTJHLsCOwY+P4RkckClV3Dd+46obNbceKBuou8=;
        b=DBkzDJoj9Cc3MSJ1VZYsxObLtFcMaxmjSOk6+p63w5dET7yVHsDJFS09dtBv6Q0OXa
         gU/q/B4VETCpDwcrPEz6cBl3KPXdMmxPPlDAIsASmS/c0NAZS2aO0INS0hDc2Jlqt8H3
         gXg7Qb8P/HK6nPHFOIYWFOgi6y06csFbGAEOm5n4Hf0yI2HLMBmDyIngoBNUQFJqzF+N
         YcRjNQ9yRGjWJGAYT+q/4MPduyKGBV86w4kuMdhmJowyDDggOeDTznJKi3zct3rAwiQs
         ExIekUdFtOXH3G/Bl/pDai9Ulv6Citw/EkJiW5WyL6W76t15CsThHf8tP2e2Ug4FZxF9
         Zg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mc3m6KTJHLsCOwY+P4RkckClV3Dd+46obNbceKBuou8=;
        b=j1wAdd7P5vg6J4RO1tECI+NQXoJTm6yATgcRdiA9Jf+KZEY1k8GW04n7cAa0AsLWMR
         HxUzegNZERG4CseWGFHKYQ3f+QWVyUYvEUJ/IwRkG4aBPCvzRwdA2gPM0ZdQcTz0vF8u
         jj0qNuAbuRYZB9pof+99KTxw6t0ND3HSxEaDr979VMRM4bFhUBGXc74auUI2oJvG0/nK
         XpRUeSl2nkY7heynlyFmukLfbfk5ZH0RUVNJ2UNIIhL3MXgPJjT+ACjQBj5tBnw+nYTK
         Biav0XRvdMhmiZT6lq+P1Rnir1lf28QTZ+mx8sQtcFJlMQIig7hLTywTTJOIlahtABAy
         bUgQ==
X-Gm-Message-State: AOAM530trLIiB3PuVqVZN3R5RJqX7YewEav8MUonNqMrznYsul1BN+g4
        2JsiqWhchIREHy8miyOxCRaFvA==
X-Google-Smtp-Source: ABdhPJyoW9KnOG0NsO7f6Z/sQxXYXqzw2vQtcO0xf6/CtOQsV6F0npUkTXAyPLtD0RlFNS0+c/praA==
X-Received: by 2002:a05:6e02:bc4:: with SMTP id c4mr7886434ilu.169.1615488529365;
        Thu, 11 Mar 2021 10:48:49 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k10sm1734105iop.42.2021.03.11.10.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 10:48:49 -0800 (PST)
Subject: Re: [PATCH v2] block: Suppress uevent for hidden device when removed
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Martin Wilck <mwilck@suse.com>
References: <20210311151917.136091-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2117129c-368f-41e9-5f2d-ad7430c40ec0@kernel.dk>
Date:   Thu, 11 Mar 2021 11:48:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311151917.136091-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 8:19 AM, Daniel Wagner wrote:
> register_disk() suppress uevents for devices with the GENHD_FL_HIDDEN
> but enables uevents at the end again in order to announce disk after
> possible partitions are created.
> 
> When the device is removed the uevents are still on and user land sees
> 'remove' messages for devices which were never 'add'ed to the system.
> 
>   KERNEL[95481.571887] remove   /devices/virtual/nvme-fabrics/ctl/nvme5/nvme0c5n1 (block)
> 
> Let's suppress the uevents for GENHD_FL_HIDDEN by not enabling the
> uevents at all.

Applied, thanks.

-- 
Jens Axboe

