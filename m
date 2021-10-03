Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3065F420116
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhJCJbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 05:31:15 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:56046 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJCJbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 05:31:13 -0400
Received: by mail-wm1-f43.google.com with SMTP id v127so10836324wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 02:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GggRRnmWlhH6C9Vs1UHXp1pUk4jP4nsZJ81+cipIwbo=;
        b=75Sg4E+CReK7gv+Su/pAPWbo0Jd46CMDG+f6DCPcG96VlJs/tffhg2YovIjaCi15lb
         Vg0HsfOI/pNphqmMo1Q+iAi37mvY3ib/F2e0Eey3tX4ta3Agfod50QeFmphYaAOHxOCo
         jwvZVWp9C08okHvwYkEwTjKNxvjSdnxGlUqJdDbu8bzNx4HuS7uj/ih7bE1o1OR8QOMr
         stEOATG/rnIblGeXxoIEWSvMqOCbjO7jgmnaypbvKujTLwPxkaCLn4A8XH/tfCYttxI6
         F2BidXHM8+nsgYPs3/mEZYwz1wnQAUldOprao3P1jmOMz5sJ0HBF7tTfjFiMXav4UFjh
         nFmw==
X-Gm-Message-State: AOAM531/5xOulCQF6HidzAKHrrYMByIp0UA5sVvQvk53P8Z06exInVHg
        seIIZrombffC2YKS+ZKNwHD2kaaVpMQ=
X-Google-Smtp-Source: ABdhPJzptMQnKh1ZIJZBjgio2siQUeZpuIdQSZHHxgKiiT9aaRkVzslb0+ouKPBjCf6p9dUbVcxwSA==
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr641618wml.70.1633253365140;
        Sun, 03 Oct 2021 02:29:25 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h9sm5902290wrw.46.2021.10.03.02.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 02:29:24 -0700 (PDT)
Subject: Re: [RFC PATCH] nvme: allow specific passthrough IOs without
 CAP_SYSADMIN
To:     Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Kanchan Joshi <joshi.k@samsung.com>
References: <20211001234017.4519-1-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f1e00f76-235a-e4b0-ce98-3eabe0a50ea3@grimberg.me>
Date:   Sun, 3 Oct 2021 12:29:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211001234017.4519-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The passthrough IOCTL interface allows for prototyping new non-standard
> NVMe features in userspace. However, all passthrough commands require
> full CAP_SYSADMIN over and above file access to the device. This means
> applications must run as root when running proof of concepts which is
> not often desirable.
> 
> Instead, relax that requirement for vendor specific commands as well
> as identify and get_log_page admin commands (which both have vendor
> specific components). Identify and get_log_page only query information
> from the controller so users with this privilege shouldn't be able to
> cause any negative side effects and vendor specific commands are the
> vendors responsibility to avoid dangerous side effects.
> 
> Users that want to send any of these passthrough commands will still
> require access to the NVMe char device or namespace. Typically, the
> char device is only accessible by root anyway and namespaces are
> accessible by root and the disk group. Administrators are free to
> add udev rules to adjust these permissions for specific devices they
> want to allow.

I don't understand what is the difference between VS commands and normal
commands? Why do you consider VS commands safe to relax privileges as
opposed to any other command?
