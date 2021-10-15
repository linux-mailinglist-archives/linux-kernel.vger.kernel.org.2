Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3F142EDC9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbhJOJiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbhJOJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:38:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9191C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:36:05 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r2so8067868pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A+kABcpWl5XxkQdy8GVu6UutPeMvCwc5El4ILSgOxyA=;
        b=CTckGThWx99BeEmmpCecOoOFRE4LurGhMWexxNlLQEyaC0LOXYXQ76c0Tb9sAxEExj
         SLyqtARZhFq4DnlaAGSjeOenWfNltBzPd2xO47x/Vo03PPDgkIQV2bIqy3oKnTEjdjx5
         NttU0KD1eC+g36CXTORH6FOtmZ2++jfeHzJJME+zapW931RIZBLdym/5HZoqNRvrFIpX
         nIH5NhZRW11qXZCSzQi4AHabqbYZeKkCkuOVUl2LKcJzASTZqw59JqUxF4cP0Bee9t2W
         YsQV7rDU/qFggGuEs21Z31PagYH+9n9eCzEosLxyYI9egm2i8x9S/7I5OiOXr6JDXuor
         VxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A+kABcpWl5XxkQdy8GVu6UutPeMvCwc5El4ILSgOxyA=;
        b=ufBfrWktOPtjG+LvzB194V4sg2WKd1rYT43+dBH4wdQgHlTW+xzgyKKQ0Toxp4TTEK
         T0AcnJW2XmIzg32KQi3FkFhOUZ1QV0lVytrVOxzXJkTbSpq4L31dSA/yrIJz4HeGt1rG
         E/Z26jbWzqmUkWbd3xyCmfRqdmETLoGp6RhNmhHig29WgQx4Sb70i73CY4Kzikgkabf7
         hvsTeGZqAVVqs3Kzu5ab5jUYvDTNHN+dFfJdXjt1foOIAbZjXcU4JRARHBlLcSFG1EQy
         4oHY0g7PUNDOcDyWXNV6nCrhTFEhuA0Fsc9yPkNvbFRbMiYsCQTn7Z03NQ+f6iT1nr9p
         uGRw==
X-Gm-Message-State: AOAM533sDo+Oy5CW+Y4h8e7Q25gxO7ppWn6O54vRZc65TSDOtuSxBLvT
        oO2Owyd3htsax2XGu/yo8/M=
X-Google-Smtp-Source: ABdhPJzTd8AeBKBhl1ChlDOpc9y+GVVrXndPBMVKfJEufwVbC7S9stK8peXzsriDnfaSDScLxtg9iA==
X-Received: by 2002:a63:8f02:: with SMTP id n2mr8413116pgd.270.1634290565423;
        Fri, 15 Oct 2021 02:36:05 -0700 (PDT)
Received: from ?IPV6:2601:645:8400:1:ffb7:9e6f:baa:dfce? ([2601:645:8400:1:ffb7:9e6f:baa:dfce])
        by smtp.gmail.com with ESMTPSA id e15sm4383332pfc.134.2021.10.15.02.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 02:36:05 -0700 (PDT)
Message-ID: <5fe0ffa5-f2db-ca79-5a10-305310066ff9@gmail.com>
Date:   Fri, 15 Oct 2021 02:36:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Performance regression: thread wakeup time (latency) increased up
 to 3x
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
 <YWlBUVDy9gOMiXls@hirez.programming.kicks-ass.net>
From:   Norbert <nbrtt01@gmail.com>
In-Reply-To: <YWlBUVDy9gOMiXls@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/21 01:52, Peter Zijlstra wrote:
> On Fri, Oct 15, 2021 at 12:43:45AM -0700, Norbert wrote:
>> Performance regression: thread wakeup time (latency) increased up to 3x.
>>
>> Happened between 5.13.8 and 5.14.0. Still happening at least on 5.14.11.
> 
> Could you git-bisect this?
> 

So far I haven't built a kernel yet, I'm quite new to Linux in that way, 
so it may take me some time to figure it all out, but yes.

(By the way, of course I meant that throughput *de*creases, not increases.)
