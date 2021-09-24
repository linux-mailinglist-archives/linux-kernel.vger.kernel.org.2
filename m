Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C64D4171BB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245395AbhIXMZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245047AbhIXMZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:25:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B73C061756
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:23:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b20so39875331lfv.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dzKeUX0AW45t7iXSmN1I7J2blU6QmvARGs0GZ8XsUxE=;
        b=luHtkgUOx6Gs0Kn+pKYj1i1+436AkRWfu9DdqJcoqtmkqd8MIhijxgBxLFopQe67Vw
         HG1+YdXKuJDyBOzih5Zdt/49JPMSjjhcyDYuud7J5+vy1PWsyv7ugSYR4FT3RDD2EU2S
         PN4XkAQQDrj9Y4M9B9pzQeSnWH5sv648t9jbIdFnPX6mjAxUbe/s4Z73adxbXwI1tq6a
         qriSrgQAybbrX8aogYBVUWBaf0scUflnDmRCH6p+82AUzJXPasFcn6rHDkauRjj68ewW
         ZmPxKZ2wh6nXMgFiFSfgpFkL+aNoqqvvrlwdEyQJAUG3h6DZdHy1cK8rKpUebHZnBRpS
         riDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dzKeUX0AW45t7iXSmN1I7J2blU6QmvARGs0GZ8XsUxE=;
        b=2pihkdv+r6XwBefgBmE6e6IBUlPGWs+BBmGQ1zWtiGqmP18ERhcyudPGcMYafQ1ifV
         gcJg3DN/EhINI0vy8pl/VKecmtobqUTh9jnVfMt5aXb8onZ4JOvNrXOhBpHEdOHmWgCw
         hfkEW1FDLJnUHXOaH/HLbjomF6Xb+rF1IDtO57awSQljncaxlTRECu5jOa1kqmQWYgD0
         ezoZrWjriLYuFqFPFEIi4xNAGq4KWlIUEegjhNa6MCSDho5iiHxGr37ngfvdQgnU0x0r
         34Qb1PsvA5rmR+0ao4Zy253VS/z1xDXE1DEzmPH6gU30O0x9c0HPmGvSRRLwxysDEWXO
         zc4A==
X-Gm-Message-State: AOAM532ajomWqlqAbuye07saJK7FAJQbh76eUSK16oPWP3KLNMCzNlhO
        DT9MxgkcxCj8RUHNpznMno7dAw==
X-Google-Smtp-Source: ABdhPJzrYRdIdeUvok/8Tee2r2ZdQDrv4rPEYHcthy7CJQWRo8/UnfRgrcHLHAvr5PcaU0km6647Qw==
X-Received: by 2002:a2e:8957:: with SMTP id b23mr6744281ljk.239.1632486234327;
        Fri, 24 Sep 2021 05:23:54 -0700 (PDT)
Received: from [192.168.112.17] (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id o6sm130500ljh.32.2021.09.24.05.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 05:23:53 -0700 (PDT)
Subject: Re: [PATCH] media: rcar-vin: add support for GREY format
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <20210924081938.30230-1-nikita.yoush@cogentembedded.com>
 <YU2htCDCbedXi4ai@oden.dyn.berto.se>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <c3c5e578-915b-8ab6-7120-d61f69106494@cogentembedded.com>
Date:   Fri, 24 Sep 2021 15:23:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YU2htCDCbedXi4ai@oden.dyn.berto.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Niklas

> I been wrestling a while with this as I have no sensor where I could
> test it with I always put it off. May I ask what sensor and platform was
> used to test this?

We have used this with ov2311 (LI-OV2311-UB953, LI-OV2311-MAX9295) on:

H3ULCB+KF+FPDLINK3/GMSL2 camera boards
V3HSK+Cogent VideoBoxes (FPDLINK3, GMSL2).

Also this code was included into Renesas BSP for a long time.

> The code looks good and I truest that it's tested and produce a good
> image, one small nit below.

Will submit v2 in a moment.

Nikita
