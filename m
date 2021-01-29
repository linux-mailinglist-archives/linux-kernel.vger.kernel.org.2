Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A431308F08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 22:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhA2VJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 16:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhA2VJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 16:09:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E4BC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:08:36 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id q2so5999025plk.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9YzMSqkbMdwyLW7bnY85Ps0hr1nUm8VqGkvZHY3ppnQ=;
        b=q0JRnU5DeZ0mt9nszXcnrwygTcitoW7AmCRbNY2bSZMjpRA8pdAP2Mns339+kra0pz
         A21qssoGxuCmCuu1lvk0VLLBvkLq7Y3J2cxCN4Wn7hQVuvLEKGuBzvHG7Srx3vb2y15I
         Vbb9epAAG+tO8XuZVOl3ZjA/NgiuXta29KgLbW1szvIlJPGPGlzcl2KmXEvqAF/zd2ec
         gXmlk6vGjq51CXFugGGIsnPf2ctFE4M5KagLdMR5OznJBwDZqTFbyUp6TN4JqRsB7vRX
         5fe1wW+E5TA27gk4n/AZOF3JKfrRGD2tZjLCqCfnr/p9fIQWVizINbbQjUYrpJLH892K
         N+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9YzMSqkbMdwyLW7bnY85Ps0hr1nUm8VqGkvZHY3ppnQ=;
        b=d0PrdCbCgB1DafaMY/uDL4Ph2BikpG5vX3Ntc+bV2ESZ4uHN5m2lgnWi2U1EUNEIi7
         19GHsqT+3G3rlKu4QWzFdzgwtw89ulIN2OTorGlOv5tnBJoAml48zU86s/qaKNU5VHnF
         qtV0rKBjsG1w5cmdSD0VOAnURNNa0lcAXgrj634op2G6gmxpHvBmTiwsiBmQcMraw1eD
         1pybgszxa3mBvlQkT1zK9gLNinknvYULTsMiD5G7gC5Akuh1ZZ5kQTpfJcAP/YlKzVv6
         24N57hON80oPT+IptLFWegSz5sSSwg6KGbJi7v67QomGCsFkESYfkXd4Hwffjfo/daEl
         jAiw==
X-Gm-Message-State: AOAM531nvdij9WZnEyd3Ms+kBcIAHSVFM4kFaz1lmpO1aQxZolR17e/h
        LWzda9BkK9A5F+UvUR1sIvPc3g==
X-Google-Smtp-Source: ABdhPJzJ3RKoIVNBEIpAZUDx0mVsnf29XRmLMzGYV2NZz1WTTvIIYrUctHn5uj0WCHJqS162zsraQw==
X-Received: by 2002:a17:90b:e86:: with SMTP id fv6mr6131803pjb.118.1611954516017;
        Fri, 29 Jan 2021 13:08:36 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i7sm9952148pfc.50.2021.01.29.13.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 13:08:35 -0800 (PST)
Subject: Re: [PATCH RESEND] ata: ahci_brcm: Add back regulators management
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>
References: <20210129182846.1944699-1-f.fainelli@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <12b9d77c-784d-52c6-eece-e67db3f4f52c@kernel.dk>
Date:   Fri, 29 Jan 2021 14:08:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210129182846.1944699-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/21 11:28 AM, Florian Fainelli wrote:
> While reworking the resources management and departing from using
> ahci_platform_enable_resources() which did not allow a proper step
> separation like we need, we unfortunately lost the ability to control
> AHCI regulators. This broke some Broadcom STB systems that do expect
> regulators to be turned on to link up with attached hard drives.

Applied, thanks.

-- 
Jens Axboe

