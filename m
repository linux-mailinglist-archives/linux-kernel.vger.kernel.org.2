Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF23E82F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhHJS0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbhHJSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:25:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E9EC0613A1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:24:12 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so459854pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 11:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BB2E/eMc79JthrmvTZ51XPlnHyBCKKLrw6A5OUus8gA=;
        b=fiO5qt9bNa4BdgZLD8403p4zmbrBTpMtQj75AG/O6lLDvRLPoEkn3WpnEuu0umVnwB
         Wby4S1veNuotXGw8bipvWY+khejLEYiLXgYa1/HE7uAo7Lr3sG3mpH7sgGR7X7LkKsJD
         /fnhEyUv0quYYr9mmj4i5j7e/0AL2aDM8iGDZOlSBEEAPdW6dkF7IV5f6oLHfv0ikk1g
         2stE5oyWO7U5g76mS+JsNCsJ9alVtDFLR2COc9ZyIIlcpH4l8VvnvBphCYaIbv5yD90P
         /LwjrYbKCtv0eXwGoU7yjyrW/lIcLt5dk7kG3XOsTBwQt7ejIl40Us1NvB5DKYjlBMDF
         znAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BB2E/eMc79JthrmvTZ51XPlnHyBCKKLrw6A5OUus8gA=;
        b=GMzkQi0cDVBN9rFNRvKvqH9XmWsNhWnlHylExhZy7+qYoO5Jw1p6lQBIk6pGkE8c7Y
         qW23/A+mxhZpWdGe0ielk5Vzwuoio6NUxhUx65HCuQ7+slKnynVv5cRSprefHQsd0Tli
         ctg1y+o4dqnKP4XEikE5cPMpifr0C0tq59h/8PYes89P1jkUJEWfzRZrq6tzyb98GClI
         ZqAWqa6xJZFt6SpySeb7jhZgF85pIWj0D3Fp43Z+2O9zOm0el6fDDvsXOuAoBigECAiQ
         LRhkO6DlZGSp06V75NjQ8S2PRfw53Z7CsuL1/LmGrksMblsGWRGRmKS+kYOE2oQyJhgS
         Zlvw==
X-Gm-Message-State: AOAM531aAGZrEzFhYbh/5kuWbzWWe/8UHt49c7f+ttjO2RIqNATR1+Hv
        hCu3TlrcIVKMAflMz9rQrmpcLg==
X-Google-Smtp-Source: ABdhPJxWbmHmctsQhjqG4Z7qSBbgo0Ph7bs63V4XSW10stcYdRKms6ite739TkHDPz4uXsomyGiA7Q==
X-Received: by 2002:a17:90b:2304:: with SMTP id mt4mr15230928pjb.180.1628619851899;
        Tue, 10 Aug 2021 11:24:11 -0700 (PDT)
Received: from sspatil2.c.googlers.com (190.40.105.34.bc.googleusercontent.com. [34.105.40.190])
        by smtp.gmail.com with ESMTPSA id pj11sm3823128pjb.4.2021.08.10.11.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 11:24:11 -0700 (PDT)
Subject: Re: [pipe] 3a34b13a88: hackbench.throughput -12.6% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
References: <20210802024945.GA8372@xsang-OptiPlex-9020>
 <CAHk-=whr-zgf41B0BPsWnL-WWqhdk71rKffhV0fzdCuem3=SCQ@mail.gmail.com>
 <CAHk-=whYu7f=itjJJTfAWdDN2Baz0whdU1bzxh_5RAfj+LyB3g@mail.gmail.com>
From:   Sandeep Patil <sspatil@android.com>
Message-ID: <27c8b23d-a4cb-1306-b7ad-91d83c6f167c@android.com>
Date:   Tue, 10 Aug 2021 18:24:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whYu7f=itjJJTfAWdDN2Baz0whdU1bzxh_5RAfj+LyB3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 5:14 PM, Linus Torvalds wrote:
> On Mon, Aug 2, 2021 at 10:06 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Sandeep, does something like the attached patch (written to be on top
>> of the existing one) work for you?
> 
> .. and by "attached patch" I obviously meant the patch that wasn't attached.
> 
> It's here.
> 

Thank and apologies for delay. I'll get back by my EOD if this still works.

Sandeep
