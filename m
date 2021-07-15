Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886E63CA183
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhGOPcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbhGOPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:32:52 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E67C061762
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:29:59 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t143so7054730oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PC2VbGgFNMREyj7t2K6qMwTJqqmujTnFnTwETsTl8KE=;
        b=ZTkEOsNFqSsyfKnxnOTBkE8/wgJ/33qsotjSIS+MPztNmZ7sxk5xxqRKgMaMmufRXq
         pGXb3buYLa8d22iZc16hKU72UJKlG9BMfGYbCJvmjr/81LJV7rfAEHCXZvtF0jhc8+BX
         IsnyzyPfaqvpuHoV96ZEOhzyhN2drYCAtdRY+8buOoI446VAreXkeMWfjFBQyrI6v5AK
         xq4SDid+0zfwHALvdfzZFJFoTPp79pdCC62oZJrUfwALZNMWwQBCatRXAmeS1S/3Ezj5
         FFjN1VZ3o/XtFaV/w75AD6GlN1RX9agFPDIlFXYh6S7hb/Yjb5ZtRb8oPEb6tfAniIMX
         IRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PC2VbGgFNMREyj7t2K6qMwTJqqmujTnFnTwETsTl8KE=;
        b=McsRUk6/7UqnhII6F08Xzih8g96v6xvgwn61jxcuKSnK/v/snkz0DZawT1nrbdFYoi
         zn138pzk68JTDe8VRbPk5YHa3m6YI/duIBzH0ErYBpSd4uwrmKtKkjP0FYYRbLzOl8T6
         VMWDEzawisZJddnXNjkCOA4TGsJVEMIoj1qJP8oYogNq6QTvT3BPOLBdWkBaOoWofTGh
         Njw0JINY/tQkTPTZgikKxM9E43LLSrkiHP4fOlA1g4K4syo3oC4zDYuANuRiya+gWGHk
         a2HpQ6c3HuhXv0o2zJ1HKBaGEMq9D1YaGUa+PQF6v7YXB94oWzmOnuCkT4GmZ4vhMiNC
         IT1g==
X-Gm-Message-State: AOAM531t50Pejm0qLLEcBCP5VUMJDUIqMxsldAldcsQB1azLbXg43OeX
        /FeSNW635msQSv84LgbDxevaWg==
X-Google-Smtp-Source: ABdhPJxLUGGvParA/BhFVdZiL1shYP+EoD1vvgU3uqV+DmLA8OKC1ZEL3QwlDa5F+UBxM0EK5gM0tw==
X-Received: by 2002:aca:af91:: with SMTP id y139mr4048545oie.36.1626362998437;
        Thu, 15 Jul 2021 08:29:58 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k7sm778110otn.60.2021.07.15.08.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:29:57 -0700 (PDT)
Subject: Re: [PATCH] block: nbd: fix order of cleaning up the queue and
 freeing the tagset
To:     Wang Qing <wangqing@vivo.com>, Josef Bacik <josef@toxicpanda.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a5668e8c-99db-e7d2-85a5-adacbd607ef7@kernel.dk>
Date:   Thu, 15 Jul 2021 09:29:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1625477143-18716-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/21 3:25 AM, Wang Qing wrote:
> Must release the queue before freeing the tagset.

Applied, thanks.

-- 
Jens Axboe

