Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991C730CC62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbhBBTyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:54:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240092AbhBBTxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612295524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NxQodtgYcmc4QZjZKTAF3TCMHN4Ic1oSfzkOYjvIdZc=;
        b=b9tJ+SPpBPyF4CJVTCfvhfSZPAXWKZ0UHhLmYkVLJSvVqDYyni7O8fxsn5OWWlL/OrHTmW
        41NjJQjFixQlO1qY5n/73VbwlHAXNRa/WsxBdMPbZ+KeIIy316LdRGEAq1PS7GTpgMGMu/
        Nisv2MD6Blkc6lojrUl707zB+NUxSw8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-JVh8RZXzMlupFhg4JTeOeA-1; Tue, 02 Feb 2021 14:52:02 -0500
X-MC-Unique: JVh8RZXzMlupFhg4JTeOeA-1
Received: by mail-ed1-f71.google.com with SMTP id g6so2305961edy.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NxQodtgYcmc4QZjZKTAF3TCMHN4Ic1oSfzkOYjvIdZc=;
        b=aTXRe1Sx7bctiVKW5UjfLgBDHx1OdoBx7nJMLc9pO5a9FD4FHAKgrKqo4SBPM5S3fO
         swAqoSGqSSLKgc9mFHDmgd1WzMmMXxsswy5xmrbGOgbfaTdZ2kOAdEsegobXq2rJ7g7r
         dJVio8QPtO21tbMF6ZAMZ+DPUz+DTSM1O4BnLNqFpu3QuuU/QRJUvmEkjqgsDHJlNo2j
         g7qUMxJIiNGigR+vYwmXhpJ5v+tJsEcknJZagz+EjgfTX7sqXTImVG6c8RuOpm+w83HS
         I6BEFBri2fUofexhdUAPCKeT6zs+Qv4cfJaBG27MOkuS0BzQnLe27EXPHop1lz2DrPvr
         Ct0g==
X-Gm-Message-State: AOAM532U+qs8GOWIX5Is8s6dmktSi4ila8LQ0rrWh+Qzm+V2cY8Y6oud
        y4gkwQRW0GpDVMqnULF0Qp+5U04truhtsAzqmsXFPbrCq4F+xz2MDxeJ7Ndl5hQj/eK4NE2LyL5
        WfqBkcDDj7FNXf2TLldUKdQj/RRD65BrTzIa59Dwx3UNFBiVC3Ru3FNhN8YjLfuK2BmraSKKA9o
        Gk
X-Received: by 2002:aa7:d755:: with SMTP id a21mr493007eds.301.1612295521054;
        Tue, 02 Feb 2021 11:52:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYfKVSviHVWCzOxE3Kc3e6aX+wFXb2mRq00duIqLVwYSo0WiW7GeLafvB3sL4pPLUfy/AWFw==
X-Received: by 2002:aa7:d755:: with SMTP id a21mr492993eds.301.1612295520859;
        Tue, 02 Feb 2021 11:52:00 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id g2sm9800386ejk.108.2021.02.02.11.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 11:52:00 -0800 (PST)
Subject: Re: [PATCH 0/3] Platform: OLPC: A couple of fixes
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210126073740.10232-1-lkundrak@v3.sk>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9132ebf9-8665-4add-74a8-5e4d73ca7246@redhat.com>
Date:   Tue, 2 Feb 2021 20:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126073740.10232-1-lkundrak@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On 1/26/21 8:37 AM, Lubomir Rintel wrote:
> Hi,
> 
> chained to this message is a couple of fixes related to OLPC EC platform
> code. Please take a look and consider applying to platform-drivers-x86.

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

