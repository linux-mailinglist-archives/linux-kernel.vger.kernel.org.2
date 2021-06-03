Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF791399EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFCKRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 06:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229665AbhFCKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622715328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8m+4TrAzUIo46n3NC92oZFAzX2j7x90WMjwhToa6xAY=;
        b=iDzhbg0pbEOSfU6ZsWTuwSGQJGQARH4OZ5z2q9Y1QFw81VKcutomKRtnCq8bNOVFyUYPDU
        O54sbfkHY3IDIB2nKJlLIIq3mSan4iME5Yckne1TmhaZVSSXCdOY2HtRn+ZzI/QvkXqcEL
        C5lwV1WhANUN5B25MjSt80CcYvbvYa0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-W9Zl-M_0OL-jfpn6kARMSg-1; Thu, 03 Jun 2021 06:15:24 -0400
X-MC-Unique: W9Zl-M_0OL-jfpn6kARMSg-1
Received: by mail-wr1-f70.google.com with SMTP id n2-20020adfb7420000b029010e47b59f31so2217630wre.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 03:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8m+4TrAzUIo46n3NC92oZFAzX2j7x90WMjwhToa6xAY=;
        b=Xb76601gDdqTQz1VYwkdBS2Xxf4sojdOX9vDk+sgN9LWdAxO9lJdrnx65c30Yt2A7x
         pv45FrQwOkhkw2vv2qCkheG3p7deetNPWdly+uoEqLlcUs89cftIoNS90IKMWiphlebw
         hmJEnqesAw8baCGAoEifkU7eo8BEaxLcAuLV7GkBpg9x3nP5rpBpCvqdth7XUFpfTDk9
         oFvgjfe5fF3YWYZO7XWmZ7X74PDcwppEjBupE+eXRm5cl/4N87g4xP9oDJEmgN+a0s9N
         7xLpAwRedzLzrU6ffPjTJQL3DuVu+uJ9UrQHO7EEgxJFSBKie9op8HlKqyvo/hmKSY/1
         LcAQ==
X-Gm-Message-State: AOAM5334t96Vu/BkswLFF62SDW9lCWby0+aKl9O+W4xBo5WCvuQzTiS5
        PH1D8sIUVsTOC1t4pv9/wgQyC5UvyVuOSd3eNvDJN8ndcDUvwlSByoIaNGFWsWloqmIuahfjYay
        bGQcDm1N7XfodVdco3vbm5pii
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr38293672wrz.309.1622715323329;
        Thu, 03 Jun 2021 03:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwhEK7ocSfer7sUBxmCXKsQG6Yu/zYN1X/JyKdQCXJn6N33yFmZlR86aHuURAQSeROvXJU3w==
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr38293652wrz.309.1622715323176;
        Thu, 03 Jun 2021 03:15:23 -0700 (PDT)
Received: from ?IPv6:2a02:1205:5026:3180:7cea:b72b:7e73:8d8? ([2a02:1205:5026:3180:7cea:b72b:7e73:8d8])
        by smtp.gmail.com with ESMTPSA id c7sm2842696wrs.23.2021.06.03.03.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 03:15:22 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the amdgpu tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210603083957.2ad2f30d@canb.auug.org.au>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>
Message-ID: <61d13275-a699-d4f2-e8db-75084f65c541@redhat.com>
Date:   Thu, 3 Jun 2021 12:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603083957.2ad2f30d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-03 12:39 a.m., Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    56b019f8eda0 ("drm/amdgpu: Use drm_dbg_kms for reporting failure to get a GEM FB")
> 
> Fixes tag
> 
>    Fixes: f258907fdd835e "drm/amdgpu: Verify bo size can fit framebuffer
> 
> has these problem(s):
> 
>    - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.

Got it.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer

