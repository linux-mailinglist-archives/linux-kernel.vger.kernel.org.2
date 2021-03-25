Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AF134971C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCYQng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhCYQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616690592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXkz74om/p18FTc/ggtD/waEhXQyGXNW+IbQIQcMvEg=;
        b=OtSebmLD83lw6cdbxXlMxaq7e0ry1nXeBLHXaoFz0XRleHG0tAUJG4aQ7IxJ7UCbxaN6Fv
        aMnlg5KNhxcrqn8WWW2b6wLauRZ8EXUDHepab66HblHZc1N/6VVLH/8SKZEgpsG+7gy2pZ
        iDCal1J4hHh9RnNA4KBs+VOpIzKd9vM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-4tvlbfi4MNGohs7vQUxjag-1; Thu, 25 Mar 2021 12:43:10 -0400
X-MC-Unique: 4tvlbfi4MNGohs7vQUxjag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5193C18C89DF;
        Thu, 25 Mar 2021 16:43:08 +0000 (UTC)
Received: from [10.10.112.16] (ovpn-112-16.rdu2.redhat.com [10.10.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3159660D07;
        Thu, 25 Mar 2021 16:43:07 +0000 (UTC)
Subject: Re: [PATCH] livepatch: klp_send_signal should treat PF_IO_WORKER like
 PF_KTHREAD
To:     Miroslav Benes <mbenes@suse.cz>, Dong Kai <dongkai11@huawei.com>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        axboe@kernel.dk, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210325014836.40649-1-dongkai11@huawei.com>
 <alpine.LSU.2.21.2103251023320.30447@pobox.suse.cz>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <01cbab2f-da8b-f289-2241-d258406a4b6c@redhat.com>
Date:   Thu, 25 Mar 2021 12:43:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2103251023320.30447@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 5:26 AM, Miroslav Benes wrote:
> On Thu, 25 Mar 2021, Dong Kai wrote:
> 
>> commit 15b2219facad ("kernel: freezer should treat PF_IO_WORKER like
>> PF_KTHREAD for freezing") is to fix the freezeing issue of IO threads
>> by making the freezer not send them fake signals.
>>
>> Here live patching consistency model call klp_send_signals to wake up
>> all tasks by send fake signal to all non-kthread which only check the
>> PF_KTHREAD flag, so it still send signal to io threads which may lead to
>> freezeing issue of io threads.
> 
> I suppose this could happen, but it will also affect the live patching
> transition if the io threads do not react to signals.
> 
> Are you able to reproduce it easily? I mean, is there a testcase I could
> use to take a closer look?
>   

If repro is only hypothetical at this point, perhaps we can artificially 
create it in selftests?  And useful to verify the future change you 
mentioned in your other reply?

-- Joe

