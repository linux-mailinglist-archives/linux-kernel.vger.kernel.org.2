Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F2B4448EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhKCTa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhKCTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:30:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A12C061208
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 12:28:12 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g25-20020a9d5f99000000b0055af3d227e8so547821oti.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UePDyJ5YGTt0SI7wSYrq2teto/cQR2vkkj6nAm2W3a0=;
        b=iJPu7qjoWnWpnlD3pbi8ofB5MCwNTChZ4jlIPjBLmxcCizs6UsV3G8NIpJvwQns6xz
         Mcu2063seKgTdnAoui3FtZzMw8tih4oa/T0SA1zkZ8TWIgMTCTlvKwUnRQJJX9o8hTQo
         NO5VmJ63MSPyzGtQlLxtrNhEUEkrQEkpnINZoI7anc9hmGLMdLfv28zMqBiXyzp7XfrI
         Ch4low2MMbl4FMIg2eatNVS8VMh4Fy+7tyv+dPfwdSjjwvwv6LXIR/YJ6bywUGJoXBmN
         xJ2/AiVAJMuY6c1kefCFBdNCE67M6OuV9vkZKDH4WRUFtlR5dRH6zzPvPZ7M7qHdques
         FncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UePDyJ5YGTt0SI7wSYrq2teto/cQR2vkkj6nAm2W3a0=;
        b=suyFJnRJR4XinycptyU4Vg1jXdxeDRbgCRe29kQ+w1A3pQimI6C71durDREVE3/K08
         ueLcxoWlzIqOYjl524OcljI2um3UwNHfw+kiO2lMasYaQd/4tjrqMzPZnoEcjqkoxQds
         dihOJuzWS1BH6JhLKETHdg500KvE92ExZPZAaGpR7lrQ/J/qHVZ/hn1SjkB88/8jFqsj
         ITH4jJCMYz+moy/rTru4t56EmQFJY9T4WC6sTFxp+Mjob0tZaQzjhGy7fDAMD5/3hXmB
         Ddwc6WMmPNUeRMtmHMNA7LVhmOLWU3amm1Buk68hca9M1TNYciOcovPZwN5jQ+c25cDk
         +AWA==
X-Gm-Message-State: AOAM533LUlWARRhHI8TeCeWHvXXBvjWBA/bQ1vzeTL1MZByt5sE+0ttT
        Sd334nX2NuoY+z5P7SexXk2Mm7zGlsDNLA==
X-Google-Smtp-Source: ABdhPJyDHe9v7v0ovnKDw8B7RfOBJHhSliZhy8hiaOCde7In7CDoT4l8tvqDIUDUaywzpQBTQ1nVDQ==
X-Received: by 2002:a05:6830:2058:: with SMTP id f24mr19740345otp.248.1635967691754;
        Wed, 03 Nov 2021 12:28:11 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c1sm790336otl.71.2021.11.03.12.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 12:28:11 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] last set for add_disk() error handling
To:     Luis Chamberlain <mcgrof@kernel.org>, hch@lst.de,
        penguin-kernel@i-love.sakura.ne.jp, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, richard@nod.at, miquel.raynal@bootlin.com,
        vigneshr@ti.com, efremov@linux.com, song@kernel.org,
        martin.petersen@oracle.com, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211103181258.1462704-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e01938a3-11c9-e368-65da-fcb5830e5a4c@kernel.dk>
Date:   Wed, 3 Nov 2021 13:28:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211103181258.1462704-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 12:12 PM, Luis Chamberlain wrote:
> This v4 only updates the last 2 patches from my v3 series of stragglers
> to account for Christoph's request to split the __register_blkdev()
> probe call changes into 3 patches, one for documentation, the other 2
> patches for each respective driver.

Part of the reason why I think this has taken so long is that there's
a hundreds of series, and then you get partial updates, etc. It's really
super hard to keep track of...

Can we please just have one final series, not 1 and then another one
that turns the last two into more?

-- 
Jens Axboe

