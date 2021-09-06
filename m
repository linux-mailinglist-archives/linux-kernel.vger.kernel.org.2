Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16282401EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbhIFRHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhIFRHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 13:07:06 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689ECC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 10:06:01 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s20so9524343oiw.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8N5dv2ieAj6WReNYQqN3ySnoIucRiGwcLO0xoBdAQlU=;
        b=Y4uXB9uI7Wtl+u4XOu/tLTL41ZQPuRjT7m6U1IIYQNwN34qwfquX4yTr0Ti8KIohmq
         aEaZ7T+isCjtSX0tYnr6qG/Dh1MxsE0DDhDWDmlIorM/vmQMifsOYAOo+FwMtK0XDrJa
         uw7lvddnE/8uwncJ4Dx1uQSAT8x7I27Oc4PA3yD6RRsrALKBhzeAZpXXJ7ZtDzwIbXri
         1jqKIQ7sznqFTD29b3YNVXP1J8xQbUqShDTwJ3qnA0gZV2I35eIs+c787BBn38YyVvcs
         DYD0YUudpVBr0CSVgMZHiYm5k/lOb1jcL32lNx3ktGOdcgtqKxE4eQbqcyLhdk3HE1sS
         gVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8N5dv2ieAj6WReNYQqN3ySnoIucRiGwcLO0xoBdAQlU=;
        b=ub6sBRYw1bRtGtTHbFRfGH81tqL+rMlZ6o0fbJ+l8lLzf4KkqpDxFtha8j7FnV+ZCo
         Kib4VAXnTUaJ4xyAtdFnL8DbhPsRdOl5F+x0CNzoq3kciRMCxZNEtfkM1GMICgCTIIIF
         tBEYUEtrdPObwWeaRRzJQWvHAe8OCLKzkhqF/L391J0FwU41+PmM46xSDhb15pQjxfyj
         0fGO07e5eYABJXuKsCanhU7WkiRCZ5h3g62fkUrWLosPxMKZ7gnt/YQ+VjTC0RQg6cvm
         Rvwra4FQ12NxW5F0bbq6H5U9uJ3cmlZbN/biiXl0bOOhZPNdLK8m15oGC0l0Hbk8T99W
         w6Zg==
X-Gm-Message-State: AOAM531K8WxtUo683prg+pkZLkiRCoHhQrHL/ElTUJts6hg5Qx2QW1NG
        bV3Sy6xrRfR+fPu1BsN9c6fF25F6XcI=
X-Google-Smtp-Source: ABdhPJx42KB2q0FJDOxx1J4WDD9WgfBrgOQikG/mNjJYaoeqOrTAdhB3rE2DTU2VD4dfpkPGupzq0A==
X-Received: by 2002:a05:6808:f0c:: with SMTP id m12mr63241oiw.149.1630947960476;
        Mon, 06 Sep 2021 10:06:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q22sm1853311ots.64.2021.09.06.10.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 10:05:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
Date:   Mon, 6 Sep 2021 10:05:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 9:12 AM, Linus Torvalds wrote:
> On Mon, Sep 6, 2021 at 7:26 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Build results:
>>          total: 153 pass: 89 fail: 64
> 
> Well, that sadly proves the point of that patch. x86-64 may be clean,
> because I have required it manually. Others not necessarily so much..
> 
> I've got at least one sparc64 fix in my inbox. It _might_ fix some
> other cases too (syscall checking), but I suspect it's one of those
> "death by a thousand cuts" situations, not just one or two issues that
> show up.
> 
> Do you end up exposing the errors anywhere where I can take a look?
> 

Logs are available from KernelCI.
See https://linux.kernelci.org/job/mainline/
I expect that 0-day will also have a field day.

> If some of them are just because of bad tooling on certain
> architectures (ie fundamentally "this is unfixable, because we use
> gcc-XYZ that just always causes warnings") then those we could/should
> just disable -Werror for those and forget about them.
> 
> But hopefully most cases are just "people haven't cared enough" and
> easily fixed.
> 

We'll see. For my testbed I disabled the new configuration flag
for the time being because its primary focus is boot tests, and
there won't be any boot tests if images fail to build.

Guenter
