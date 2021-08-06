Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA583E2FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbhHFT24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbhHFT2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:28:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC5FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 12:28:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b11so12389450wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iBgsPv8uRdWwkx7rHRZvOyITPMRjDmXuZ1R73HYK1Ts=;
        b=Jg7hn+1Aewl14ObREqCwr1O6pJqKme0aymGG2Z3HIeFIO3Lxk7I8Nd6s+CpvrDlsSL
         vp7GpUVcZ3Ynjb3oahq1OgTqjCSb3t7ON0mnav0/9alOklcS/g8ndqYuqvAkQ1J9mGBu
         DSh/7ce2TWvSurdbSHYz9gnlbEzJNBkAc5oi71AT8wfF+sexpoZsggnJ/3SYiAVnezea
         Rh4Btm6ua75hT/CLVklTGm0L/b5tsxPmIfmKju2MVJcYddc3/wU1cIW+8ORvupbusLhl
         NtFEzexFWPskTHzOnIUNhXCiSdxtoqlz+joANM1Oxsj1A+Je64XUhHBt8VVOzawjCyjn
         xITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iBgsPv8uRdWwkx7rHRZvOyITPMRjDmXuZ1R73HYK1Ts=;
        b=uWmrNOKQDk85IywcU/zCNBbBev+eRxawuRx1KrLmmtY/ao8BtOvJcf10yA2rTzqef4
         UB0Ajm99b5hRrBgxZlW1VeR/MNunwNRsCTmx4eo0XwOqQeDVSlJW3/xnOhZumh1dLvSN
         tKPnoTwm9RghyPPYyNxNb8Ps6t8nt2bTo5F9Y5CET0FYt3hqIB3qbAQmJKsPvqMBqJhC
         fA7YxMfrou0ksd0wqmgdEaX/JhB764YymJiiPOfRO31MZW+wLtzKCym5ZIIAgnCrZYy/
         mVQHLk/yHER0GoVLB9GW8MdidhuiAc0FBoNlvnMX3QAueMf1w1ruiAKigvDMigx1iMfT
         ocrQ==
X-Gm-Message-State: AOAM530xMkX98CqWApvCbw++0yeE0okoenXauXNHjpIMar7K1009fFGZ
        EGz9rciS1sxuAz4bs6fXBac=
X-Google-Smtp-Source: ABdhPJw6itfDHCEqaq1VzcqKqDXOYufcSGYFWBAB8Ih0C9oc8IBkGklugdNMEOehz2Jj4wtAxZEFNQ==
X-Received: by 2002:adf:d225:: with SMTP id k5mr12319492wrh.10.1628278117232;
        Fri, 06 Aug 2021 12:28:37 -0700 (PDT)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id j14sm10821609wru.58.2021.08.06.12.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 12:28:36 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Check for endpoints in fwnode->secondary more
 sensibly
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210805220850.131545-1-djrscally@gmail.com>
 <CAJZ5v0g1Udw1oyVSOBO1HefawDNSfHYbMK7=ggR0WKOCawCosg@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <cfb96395-dfe0-5363-eb64-2ed2959311e2@gmail.com>
Date:   Fri, 6 Aug 2021 20:28:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g1Udw1oyVSOBO1HefawDNSfHYbMK7=ggR0WKOCawCosg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/08/2021 16:29, Rafael J. Wysocki wrote:
> On Fri, Aug 6, 2021 at 12:10 AM Daniel Scally <djrscally@gmail.com> wrote:
>> Hello all
>>
>> A while ago I patched fwnode_graph_get_endpoint_by_id() to check for endpoints
>> against fwnode->secondary if none was found against the primary. It's actually
>> better to do this in fwnode_graph_get_next_endpoint() instead, since that
>> function is called by fwnode_graph_get_endpoint_by_id() and also directly called
>> in a bunch of other places (primarily sensor drivers checking that they have
>> endpoints connected during probe). This small series just adds the equivalent
>> functionality to fwnode_graph_get_next_endpoint() and reverts the earlier
>> commit.
>>
>> Thanks
>> Dan
>>
>>
>> Daniel Scally (2):
>>   device property: Check fwnode->secondary in
>>     fwnode_graph_get_next_endpoint()
>>   Revert "media: device property: Call fwnode_graph_get_endpoint_by_id()
>>     for fwnode->secondary"
>>
>>  drivers/base/property.c | 30 +++++++++++++++++++++---------
>>  1 file changed, 21 insertions(+), 9 deletions(-)
> The series looks good to me, but can you please resend it with a CC to
> linux-acpi?


Yeah sure; I'll do that shortly

