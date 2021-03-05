Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0E32E0DF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 05:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCEEvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 23:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEEvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:51:53 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 20:51:53 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z9so878749iln.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 20:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TnGi8AEpI5ZKVG6mnh7UvPhO+sCMtGAg+B+k8ek7+Lc=;
        b=ZUDl7FgCgEEyjrIb3yi3eGZNJ9UAicHuInZ+8wrXeUBkj0f+hU00FpRUh9Cqi7031e
         xg0nM5gHs/+/qwvf4ALrzWYxNWXROHlgz326HOTQozczvsec14R+aPBFNH/Mr3V+9GFd
         UuYClmrXCpA5HFjcztUnaUqJnMIUIYg8aYw7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TnGi8AEpI5ZKVG6mnh7UvPhO+sCMtGAg+B+k8ek7+Lc=;
        b=J1G70GCnMu8mZA3r4nP4EAF7v9SuEEJlBhj/cGa9YkY0Y1Ij4kHmj8WS4Pzy5hlDCW
         iGsSbyJfHTL6CjFUwTWgZuEZl+sRL2ro6w51e0CB/op6dkygs/qsXCtSYZVFijXpiApF
         RuupFo9fh3IQJsUHU85nq1V2lRlhgydj4ZoFoQb35cV0wXngdCfz8Y4PYvVveXk4G4vI
         nWZ6V//yMKR8pvld62wKE+z8eB31elfLcoNZ41D9U2b5T5PnagkuERW0Oz1do+XnLmm1
         +pCUcqvmhSRFlMhfA3JGwj3tluiwCsMk0so3MUT6HVhS7IrTOKr8vsL64WS9iDTmsAGL
         vDrw==
X-Gm-Message-State: AOAM5314GRvR4Geji4068gn5RdHyyPHSBWx6mbCJ3RmEzj/szj64Qw2o
        W5aIygTLNruvYN7tThWEYbyc/Wd+5xDHFw==
X-Google-Smtp-Source: ABdhPJyk6h3gmJOUonNz+suqqjPazO+vuk4ZfMZPBeYgmzD5rcx4M/SJNC97QseTC9M+TwEiqYyw2Q==
X-Received: by 2002:a92:6510:: with SMTP id z16mr7617150ilb.88.1614919912445;
        Thu, 04 Mar 2021 20:51:52 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id x2sm797954ilj.31.2021.03.04.20.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 20:51:51 -0800 (PST)
Subject: Re: [PATCH net-next 0/6] net: qualcomm: rmnet: stop using C
 bit-fields
To:     subashab@codeaurora.org, Alex Elder <elder@linaro.org>
Cc:     stranche@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        sharathv@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304223431.15045-1-elder@linaro.org>
 <3a4a4c26494c12f9961c50e2d4b83c99@codeaurora.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <f2d64441-81af-3e11-18da-390f91fbaf15@ieee.org>
Date:   Thu, 4 Mar 2021 22:51:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3a4a4c26494c12f9961c50e2d4b83c99@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/21 9:44 PM, subashab@codeaurora.org wrote:
> 
> Can you share what all tests have been done with these patches

I'm testing with all of them applied and "it works."  On
the first three I think they're simple enough that you
can see by inspection they should be OK.  For the rest
I tested more carefully.

For runtime testing, I have used them on IPA v3.5.1 and
IPA v4.2 platforms, running repeated ping and other network
traffic tests over an rmnet connection.

For unit testing, I did essentially the following.  I'll
use the MAP header structure as an example, but I did
this on all structures I modified.

	struct rmnet_map_header_new new;
	struct rmnet_map_header *old = (void *)&new;
	u8 val;

	val = u8_encode_bits(1, MAP_CMD_FMASK);
	val |= u8_encode_bits(0x23, MAP_PAD_LEN_FMASK);
	new.flags = val;
	new.mux_id = 0x45;
	new.pkt_len = htons(0x6789);

	printk("pad_len: 0x%x (want 0x23)\n", old->pad_len);
	printk("reserved_bit: 0x%x (want 0x0)\n", old->reserved_bit);
	printk("cd_bit: 0x%x (want 0x1)\n", old->cd_bit);
	printk("mux_id: 0x%x (want 0x45)\n", old->mux_id);
	printk("pkt_len: 0x%x (want 0x6789)\n", ntohs(old->pkt_len));

I didn't do *exactly* or *only* this, but basically the
process was manipulating the values assigned using the
old structure then verifying it has the same representation
in the new structure using the new access methods (and vice
versa).

I suspect you have a much better ability to test than
I do, and I would really prefer to see this get tested
rigorously if possible.

					-Alex
