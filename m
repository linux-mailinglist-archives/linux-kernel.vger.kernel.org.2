Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE92346B55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhCWVol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhCWVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:44:09 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96268C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:44:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b4so4918723lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+Vy/OTllIvHIVln9G3YJVAy6ekqqDZ8CuhvmaqTkx0=;
        b=ghDamRh9+co6qwZ/IJEaS7romSP7nKOFh7yTaf34FxmI5+Ebgpq/VgV01b5F8qTeyr
         Psuhv0YKetPEY4Z5djEtvis38ayXGklxc+sAkhkNvPJOr39fJoqILtvpjBWXVpDwvTuz
         Rzv4AxL3Sg6cTKWge9PKRUYfJfFLrx7UcPMu9UrgQoQRkG4Hgo15cGRrKUxZ57q1G5LU
         GQs/Br2oP5s1tLpi6XbgLm0rheHCCWI37j7MbLa4ahHp7F7wP6JQ8JV/ouUi3JTQ/0wf
         1qZJU49hpqvXFidmbAi/Hhumerb1LQfuLjORbGsqiNhPlBEe3ikXjeXAcBnJpr1a9p4+
         lnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+Vy/OTllIvHIVln9G3YJVAy6ekqqDZ8CuhvmaqTkx0=;
        b=o0on2pgVl6cAOlkjkeU2Jp7/GO/RcxUd5w9tDsAFZHEbwp007pn1Euh0tephKFZupb
         3r/o9cFuE8wrsxLsRfCcjeCDHRbZ8eBlmizwdFHGWH3CzBoGqDd1STZNIly6/vI4Ozv2
         Kvk/XAZMcWJO6OwBwRZZdkI3Qo6n8doF4HP6CUy8/tHzV1MNgA8ObVvaoJDiksh2F6qQ
         1jUt9Aoooqp3s+vZCS7gwliSTn8SWGM1sf4GjGO3T544cL890TJq1w8gVnrQuEJaJ/6p
         WD1tDM4dk5yjRhvBEXOzd/ebbVsO5u7WxzbAFpjw+l11jRCzwI5/XWiMVE5INs5ZE/TG
         rtug==
X-Gm-Message-State: AOAM530ZCMAOIk1L6Tlsj5M7g1ZbfTH2vCDNZ6jIrM5jSIbvnA8l1tGg
        xa/2bHDhh0ZZRyPFhCumumU=
X-Google-Smtp-Source: ABdhPJyR42MnoR9d6WJ9EMT+p069RoXTuzWP7W1bVn1gQltHm1QEW91JvJT3DoW4YzyLSiXjuu99ZA==
X-Received: by 2002:a19:c14f:: with SMTP id r76mr53127lff.218.1616535847130;
        Tue, 23 Mar 2021 14:44:07 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id r123sm29569lff.27.2021.03.23.14.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 14:44:06 -0700 (PDT)
Subject: Re: [PATCH v5] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org
References: <20210323195050.2577017-1-minchan@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <abe6c403-232c-aa43-5294-2b01bb4c1190@gmail.com>
Date:   Wed, 24 Mar 2021 00:44:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323195050.2577017-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

23.03.2021 22:50, Minchan Kim пишет:
> +#ifdef CONFIG_CMA_SYSFS
> +void cma_sysfs_alloc_pages_count(struct cma *cma, size_t count);
> +void cma_sysfs_fail_pages_count(struct cma *cma, size_t count);

I'd also rename cma_sysfs_alloc_pages_count to
cma_sysfs_account_success_pages and cma_sysfs_fail_pages_count to
cma_sysfs_account_fail_pages.
