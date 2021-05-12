Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7137C089
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhELOqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhELOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:46:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEC5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:44:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o21so21488945iow.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/YZN+MSVLPkWofxbZAWYKNj4wEM9OcLmmNp7bQLb0XI=;
        b=KpeFEHBVswSbtbyp64ODyEl2b2G1M1OYbrXui+ZtU+8NMIeFNdIOZO4g+vFoo+QPxd
         TTm9thZ12lZ7shB8z0LmJDnTrRHPcIanVfBlrFJh5sYLvEMhTntN4jT5upcAXOi/DSnS
         3cX68M4ToYrJFR4wpv6rPq+I5c+wluWpaCJw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/YZN+MSVLPkWofxbZAWYKNj4wEM9OcLmmNp7bQLb0XI=;
        b=fJw5MNS5PO0WPyEPILuYz6CKMvHg0JDlDfvoIwRUBEM2fSbk8LXXEY/QyJQlhNRzaL
         bBYAPvfiyijx/F0NvOhgZUOMmU/rS40pnHB+LGqxfEkyK+1/NVmfgmN+3PmfG+439kMf
         S3xGCzkWxqLiZW27ULRdWM7VP/+KLkqVr4qPAY9+PmxgL7ZLYz+KSbewMuOopWlYYxkb
         XWUOotG95r/oXSJir251NPKSN4WxhfnTwTVmyZTHPZbSOnBosBw/9v5T2PIt40ZWf90H
         tMPBP+NgHdcr+PR8Pj2YOkH3lTcVt5ziZKZsZwnGDosUr0UvLu9mLM46OW6ai530KpWP
         ZXEg==
X-Gm-Message-State: AOAM532DqFhVb/BLSVBtcn3yMK854SjNCMtIF/zXOpvkX774Ikzsunhw
        EyXAtrQCSk98ImDk+fT1PH/j8w==
X-Google-Smtp-Source: ABdhPJweixDynszmecRhA8323ba/tGgxAlYyy9/DkD4fSi4gRrG0hxGHj7LifS7hhM4IRqT5KjTNBQ==
X-Received: by 2002:a02:54c1:: with SMTP id t184mr23600448jaa.79.1620830694614;
        Wed, 12 May 2021 07:44:54 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z14sm29907ilb.48.2021.05.12.07.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 07:44:54 -0700 (PDT)
Subject: Re: [PATCH 1/2] cpupower: implement the multi-cpu monitoring of
 programs
To:     Hamza Mahfooz <someguy@effective-light.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-pm@vger.kernel.org,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210512112658.89965-1-someguy@effective-light.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <75c9f5a4-8e42-8a6e-2ac7-bb968817038e@linuxfoundation.org>
Date:   Wed, 12 May 2021 08:44:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512112658.89965-1-someguy@effective-light.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 5:26 AM, Hamza Mahfooz wrote:
> If we look inside cpupower/ToDo, the current 6th point makes mention of
> a method to implement multi-cpu monitoring without introducing noise to
> the tested program itself.
> 
> Suggested-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>

You have to use real name/address in you signed-off-by. Is this how
you sign your legal documents?

Please refer to:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

thanks,
-- Shuah
