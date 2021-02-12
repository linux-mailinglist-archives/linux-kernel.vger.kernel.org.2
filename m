Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9531A03A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBLOCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhBLOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:01:57 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7429C061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:01:17 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q7so9381265iob.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hfpu4JNrDZMZnmuhC/B9i4uH563p9QYRFbc8Z09AD8Y=;
        b=GVHI2HxeHVr1cuXtdzYruzbOiB4KETUjoyUjvXcXqgUOA9aFMSI3A365t7/7fGTAtq
         YKJVDBzuKs/D84SZkm9Dw0+S13oOh9H3BG8AFUnVN3h7aCcNBdaHxXxVQeh0JDuYyxfi
         7W9e0uvmlM7ICY+AZfbgjwiABPj+emU5f+acs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfpu4JNrDZMZnmuhC/B9i4uH563p9QYRFbc8Z09AD8Y=;
        b=aChGHnqH1J1q74ShVRJwdJKIZWSWcnT9ZEuaB4ChJIzo17h85MpUT0NWpZ9ZdKerXW
         nOjPAHZd+sJQP9PyICoEMuIytE3NWvr4AFkXa4C9l9ZP9quvgMEEE1BDg1Mvk+Gl+JZy
         YEUQ/zjrrCqIWTjmtl8bY2Yjn4La4+/M2nqKEtTQI9ZJBWGqknqGB9iQ5mWIqf06Jz68
         zOG3kNGXVI5M0v9k2OLkxhupcSOYCZg3VTMbrBl2QfVujXENWQ78EelJ/qkXYO+J8UmH
         Hgt9vjl9YVu8R5qvs5+PuBmBq3vKIv4R1U+3W7tT6LV+7v1s1go2KpnCpJW49v2XTN3X
         CfJA==
X-Gm-Message-State: AOAM533IyZHRH/nItebMs8dnGHuuuItKrd0hWMRbq8rRZoQ3HSqvCH7H
        z948h/yuYi0q2yFM8rrdlVhuv+4zGQc/pOMs
X-Google-Smtp-Source: ABdhPJylam6eGTL3mklnT2GyKQxTakQ2Q39BnfQThOB9Nf0FTkzmUCs0MldOziz7vdfNTcrQ8nBpjw==
X-Received: by 2002:a02:30d5:: with SMTP id q204mr2659530jaq.55.1613138476532;
        Fri, 12 Feb 2021 06:01:16 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id i20sm4494742ilc.2.2021.02.12.06.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 06:01:15 -0800 (PST)
Subject: Re: [PATCH 2/3] net:ethernet:rmnet:Support for downlink MAPv5 csum
 offload
To:     Jakub Kicinski <kuba@kernel.org>,
        Sharath Chandra Vurukala <sharathv@codeaurora.org>
Cc:     davem@davemloft.net, elder@kernel.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1613079324-20166-1-git-send-email-sharathv@codeaurora.org>
 <1613079324-20166-3-git-send-email-sharathv@codeaurora.org>
 <20210211180459.500654b4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <1c4e21bf-5903-bc45-6d6e-64b68e494542@ieee.org>
Date:   Fri, 12 Feb 2021 08:01:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210211180459.500654b4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 8:04 PM, Jakub Kicinski wrote:
> On Fri, 12 Feb 2021 03:05:23 +0530 Sharath Chandra Vurukala wrote:
>> +/* MAP CSUM headers */
>> +struct rmnet_map_v5_csum_header {
>> +	u8  next_hdr:1;
>> +	u8  header_type:7;
>> +	u8  hw_reserved:5;
>> +	u8  priority:1;
>> +	u8  hw_reserved_bit:1;
>> +	u8  csum_valid_required:1;
>> +	__be16 reserved;
>> +} __aligned(1);
> 
> Will this work on big endian?

Sort of related to this point...

I'm sure the response to this will be to add two versions
of the definition, surrounded __LITTLE_ENDIAN_BITFIELD
and __BIG_ENDIAN_BITFIELD tests.

I really find this non-intuitive, and every time I
look at it I have to think about it a bit to figure
out where the bits actually lie in the word.

I know this pattern is used elsewhere in the networking
code, but that doesn't make it any easier for me to
understand...

Can we used mask, defined in host byte order, to
specify the positions of these fields?

I proposed a change at one time that did this and
this *_ENDIAN_BITFIELD thing was used instead.

I will gladly implement this change (completely
separate from what's being done here), but thought
it might be best to see what people think about it
before doing that work.

					-Alex
