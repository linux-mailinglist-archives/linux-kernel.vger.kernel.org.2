Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF834788D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 13:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhCXMdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 08:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhCXMdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:33:10 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0DFC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:33:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g8so24559264lfv.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ETqBMU69OiVYdMvCczpxH6iSVMFBbrvvC1c+Nearczk=;
        b=XypW53avmJ4g2E1pKslW36bigwllw9bzame6yU/kPt6JgEqriLu1KCO3Usk1g6d6pR
         hgWgRfZ4sFu3UglyoEsbQgwrdXnDY0ygCkG1ChPaSYVxVKMtr0aFVa8CZQiJVKTPdPns
         IsPOu6DtiVIbhj7laA0Wftj3art0pxx0RlAr0j7Hfbs9RoBlqXZFWgmuPaxCVHYSk5zZ
         az0nvJlTD9fgs0TngACy8f0K6oqGqnPkxFYDhAt8NnmKaCGo+rOazlGEoKNQBFMk73Vv
         gZhZk7sOA+P7zWKLfDJvfDIJg5LhW6ZQe/5Km5QSehqd76nQnNOFn6Svum3niOluJClx
         gpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ETqBMU69OiVYdMvCczpxH6iSVMFBbrvvC1c+Nearczk=;
        b=Qt8qq2tc9w7NrxPIFyqpd1WKQtEiR/1TaQsBIS4ZUDQXdKAWt9yZKv6HS53dqOIuf7
         wOEr21XYPWq886IR8ye09SgklZgcnz1F4Wyp5aSCc7l6/5RZkivc9LbhyEARU2bq9py/
         zHjajBzlLRoAJb/4uYdecHKX5S9QlwEynyg+z6f74wswHaWHd6U9OXZxKr7+psweaWMa
         RZHaUXU0P6l0h42UGqpeBNsqbuxvVmqOUK1AlBAHO6ni5tX3ljt+530MJ31MzgTbKxyp
         vcuIBv307MLwuDI4UMgku2cqU/blnHMhA3tXjx7MGrkYmEifG9uv/lxuvnmAGFEAXQne
         q85Q==
X-Gm-Message-State: AOAM532F1qKPEFf65g1ELTAehp+FxG8hAFmYu7gjSENfY2lBUpvIqjTF
        aB8d1Em049sXp3CvGhHsIX8=
X-Google-Smtp-Source: ABdhPJzKeCr5gBrukru+Rp9XMBBi9uUxkaJnWxEsEaxThFvI60q4T0jOf+vT8goDZgzawCC9To6XSQ==
X-Received: by 2002:ac2:4826:: with SMTP id 6mr1830392lft.629.1616589188609;
        Wed, 24 Mar 2021 05:33:08 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-60.dynamic.spd-mgts.ru. [109.252.193.60])
        by smtp.googlemail.com with ESMTPSA id h24sm295528ljg.77.2021.03.24.05.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 05:33:08 -0700 (PDT)
Subject: Re: [PATCH v6] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, surenb@google.com, joaodias@google.com,
        jhubbard@nvidia.com, willy@infradead.org
References: <20210324010547.4134370-1-minchan@kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3d90177b-e143-03b9-0f78-77740690266f@gmail.com>
Date:   Wed, 24 Mar 2021 15:33:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324010547.4134370-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.03.2021 04:05, Minchan Kim пишет:
> +static struct kobject *cma_kobj_root;

This should be a local variable.

> +static struct kobj_type cma_ktype = {
> +	.release = cma_kobj_release,
> +	.sysfs_ops = &kobj_sysfs_ops,
> +	.default_groups = cma_groups

I'd add a comma to the end, for consistency.

> +};

