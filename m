Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF063A0560
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 22:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhFHU6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 16:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFHU6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:58:20 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318F4C061787;
        Tue,  8 Jun 2021 13:56:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso5491201otm.11;
        Tue, 08 Jun 2021 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NKiYxdzGs31CxjZJrlt9rEqqnENuB5AvwhPeYxARrBg=;
        b=O+fmsvhlONAqx69hCimTwya3arVpmhvwQt3UpSttbTh3Jy7n3bYsJO5kvUJ0N5fpNs
         BNIt2H0SOY71BOfbkrwWVgR28mbzYHN41Ldc4CaKSTLjlU7F4Aj5hZhmo2o2OUcfSaX7
         SWSjbt4aI4YXK6eaH1opIZOnFvG7/LSWRpUXNIfPZHbvU6RIyVNT+5P63g9lGdkwLy3B
         DF2F13CCgrxdMi4moNdbCLYPVq4JwvFBdvLSJq2r6M+MS7dREGIqax4iIsdxxY3Amjpq
         2liCMlU4OgDbLrUcAC7laGW3x6p1+oC22h07x+HTrmJFbPM3ZDuLMpk1ay0nzf3vCxrh
         FjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKiYxdzGs31CxjZJrlt9rEqqnENuB5AvwhPeYxARrBg=;
        b=nKVayNKkXNzDLKksku6VR/8DNH2tu2Vq+bxvhgSGd2g/8qBJNn9DBfG+/q5FRnpGUV
         ogYgd1RCQdJ3yhPzQC4gXTRAy4BqYEWfY4z/mST/nPPqpwKIlB9+tSOOLzS67CqlLyIX
         4lDy1uOjC6wqtSAirIP2Vi1LIBS6uUPFmg+apCQd2VbRouoJ71a6fYZRIJl7wzT5GupL
         /QMV+hM626Hq6h7U+uOo4eTVsGA1lkgAdo9Z8/75H4ZfgFB6NLfEuPLijgWptPjihMlh
         97FcuItSKeHgvxb8WgplsXO20MJNY4wtn3Lk86uz2WO7ZHD5g94kANF1jgl+US6nwl/C
         x59Q==
X-Gm-Message-State: AOAM532YxMJPN4EAwy4BbWvjS6MTqir6ASREehAq4M3TIKm4AOkOK/jo
        GwrGMtXAtPJKI0I1/8mqO6M=
X-Google-Smtp-Source: ABdhPJwQKt9VIrHJuSgubA7hRlSPBpd9mQG39Zaqg8uS0e4McUoS23QDVzV1TpYDHw1J2zWbVwviBg==
X-Received: by 2002:a9d:2202:: with SMTP id o2mr2804725ota.24.1623185772613;
        Tue, 08 Jun 2021 13:56:12 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id q26sm3267711otn.0.2021.06.08.13.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 13:56:12 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Strange problem with USB device
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        ierturk@ieee.org
References: <cfc37ce0-823e-0d19-f5d7-fcd571a94943@lwfinger.net>
 <20210608182038.GA1812516@rowland.harvard.edu>
 <a7c7ba62-a74f-d7db-bfd9-4f6c8e25e0b8@lwfinger.net>
 <20210608185314.GB1812516@rowland.harvard.edu>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <960057be-ef17-49e7-adba-ba2929d3a01f@lwfinger.net>
Date:   Tue, 8 Jun 2021 15:56:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210608185314.GB1812516@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/21 1:53 PM, Alan Stern wrote:
> I don't get it.  If this is a PCIe device, why should it appear
> on a USB bus?  Wouldn't you expect it to show up as a PCI device
> on a PCI bus instead?
> 

I do not know the internal details, but Realtek packages a PCIe wifi device and 
a bluetooth USB device in the same package. Intel does the same thing on my 
Wireless 7260.

My lsusb shows:
Bus 003 Device 002: ID 8087:8000 Intel Corp. Integrated Rate Matching Hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 8087:8008 Intel Corp. Integrated Rate Matching Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 004: ID 8087:07dc Intel Corp. Bluetooth wireless interface
Bus 002 Device 003: ID 0bda:c822 Realtek Semiconductor Corp. Bluetooth Radio
Bus 002 Device 002: ID 04f2:b3b2 Chicony Electronics Co., Ltd TOSHIBA Web Camera 
- FHD
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

I have no devices plugged into a USB port.

Larry

