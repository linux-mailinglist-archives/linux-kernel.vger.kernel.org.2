Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2DC3AE865
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFULxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhFULxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624276251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KrUT04ET7j9PxJUik4TN78ZN7Dz6iXoztaQ6uI00AE=;
        b=WZ14MuBfGzxosqcVhgTXAvvP3XWrSKX8Gz47B485soWYLXla2MY1zNAb2oryD1XlDq1KJ6
        1XPmkGPQukVTP4d6QwGG4mSQUus9+7Bvr0HWAp2aaeX79xSABV1b/W9xJmfxlKMAfdHlGo
        YLzVmlkpHE3yPW0UHWNkDY9yJad0yTk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460--HrMB2i6Nrm-ddlWil24Fg-1; Mon, 21 Jun 2021 07:50:50 -0400
X-MC-Unique: -HrMB2i6Nrm-ddlWil24Fg-1
Received: by mail-ej1-f71.google.com with SMTP id j26-20020a170906411ab02904774cb499f8so3861738ejk.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 04:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9KrUT04ET7j9PxJUik4TN78ZN7Dz6iXoztaQ6uI00AE=;
        b=SQGyfWD9Odd1vW+qQsqWkc5bWfMEE/IplFto3yq9/ek7FzuS+Nj71WF3kiR6As4dK+
         2jOmVmNHt0oqW6RAqUcnlHrbl4C61SaGToJZC9sCmaoN+NC+dy7x4SYubuVuxT9eIrTU
         jAiadERNFiahju7QTbVyaXOiuBDoFLdT8O1WT7O7s7PeI4jDTdSoZEgbPMn46X+PI//s
         ZtBIx3FRlJGxJhGfSKqqxMOYL2V445RngkN+Z4sIUsiRR1p1gRxsNyOguKn3plZCYcQ9
         KKYFgTPTqyH6jVS4luR19zjjgvOGsTt1AJ500vzFOrXDqzoRwJELpyQTG4MoJJ0JiYs5
         4ppw==
X-Gm-Message-State: AOAM530xQUeNOGaGuQ56c7oI06q7f7opSLUEoAcR989oh5/z+HoBMYL5
        Abu9qIQg2ywttZC+U0qym+QX2YquSrPT+TH/MQsdbHxEFNsFHzTsVcFQd5CHMOuRtBaTrMCQNkU
        W72tranw57HmZIMbiWnKE19UCLBJ7/Yu3eAMHNrAM5FjS1azUxvv8cdyVS5ZNQ1OcJASnF5WNDU
        c=
X-Received: by 2002:aa7:dccb:: with SMTP id w11mr20386560edu.96.1624276248930;
        Mon, 21 Jun 2021 04:50:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSjuxC/PSf0i5LWbsHxybj9qFxn7JBf807PcTs7lndnICmXQsULopHSpuAfZ1OwRldiHnC6A==
X-Received: by 2002:aa7:dccb:: with SMTP id w11mr20386518edu.96.1624276248722;
        Mon, 21 Jun 2021 04:50:48 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id r17sm10360218edt.33.2021.06.21.04.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 04:50:48 -0700 (PDT)
Subject: Re: [PATCH V4 06/12] trace: Add a generic function to read/write u64
 values from tracefs
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1623746916.git.bristot@redhat.com>
 <681a2fb508b3dad2979ac705c3df633f14abb9b2.1623746916.git.bristot@redhat.com>
 <20210618125651.7de04840@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <1a8ccc87-6f04-7918-65ad-76c0cf13af07@redhat.com>
Date:   Mon, 21 Jun 2021 13:50:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618125651.7de04840@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 6:56 PM, Steven Rostedt wrote:
>> +        return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
> Egad, this entire patch is filled with whitespace issues!
> 
> Please check your other patches too.

<talking to myself>
daniel daniel daniel.... after all these years...
</talking to myself>

Sorry... it was only in this patch.

>> +}
>> +
> 
>> +
>> +#define ULL_STR_SIZE		22	/* 20 digits max */
> Nit. I'd make this 24, just to be integer aligned. I mean, it's used as:
> 
> 
> trace_min_max_read(struct file *filp, char __user *ubuf, size_t cnt,
> 		      loff_t *ppos)
> {
> 	struct trace_min_max_param *param = filp->private_data;
> 	char buf[ULL_STR_SIZE];
> 	u64 val;
> 	int len;
> 
> Probably should reverse the above as well, that way if you do have
> ULL_STR_SIZE as 24, then the int len, will fit right in before the u64
> val. Although, I think compilers are free to optimize that too :-/

I will do that!

-- Daniel

> -- Steve
> 

