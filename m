Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08D3366CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbhDUNdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240339AbhDUNdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619011953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHGylvMWVSknLesn5TIShxESJ3h/B3URDa1h0briNGk=;
        b=QQhol4s5fvVz5w0CNT8nM+8DvGBfpI2rJ73iNobcXsYgIE33XTieakOHPgvpjJIhIWe2C5
        RUDons0QWKpLP16G0U25HeAbQSO8mDhTDL3idhtBT/mcqt+dRXJQ/eI0cQ4mze+5riAA99
        FWutE13Q5WNRumiqE+lQM4jw3xz7uq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-97lvuigvP_-ssdBgdw6EGQ-1; Wed, 21 Apr 2021 09:31:45 -0400
X-MC-Unique: 97lvuigvP_-ssdBgdw6EGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 135081936B6D;
        Wed, 21 Apr 2021 13:31:44 +0000 (UTC)
Received: from [10.10.115.104] (ovpn-115-104.rdu2.redhat.com [10.10.115.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4216E10016DB;
        Wed, 21 Apr 2021 13:31:40 +0000 (UTC)
Subject: Re: [IRQ] IRQ affinity not working properly?
To:     Thomas Gleixner <tglx@linutronix.de>,
        Chris Friesen <chris.friesen@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <a0d5551e-761b-1571-b8e1-5586ec4d9f3b@windriver.com>
 <87blb3ce29.ffs@nanos.tec.linutronix.de>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Organization: Red Hat Inc,
Message-ID: <fdebec53-097a-d28f-96ec-cfe8d7ef8412@redhat.com>
Date:   Wed, 21 Apr 2021 09:31:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87blb3ce29.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/21 2:45 PM, Thomas Gleixner wrote:
> On Fri, Jan 29 2021 at 13:17, Chris Friesen wrote:
>> I have a CentOS 7 linux system with 48 logical CPUs and a number of

<snip>

>> IR-PCI-MSI-edge      iavf-net1-TxRx-3
>> 961:          0          0          0          0 28492         0 
>> IR-PCI-MSI-edge iavf-0000:b5:02.7:mbx
>> 962:          0          0          0          0 435608         0 
>> IR-PCI-MSI-edge      iavf-net1-TxRx-0
>> 963:          0          0          0          0 394832         0 
>> IR-PCI-MSI-edge      iavf-net1-TxRx-1
>> 964:          0          0          0          0 398414         0 
>> IR-PCI-MSI-edge      iavf-net1-TxRx-2
>> 965:          0          0          0          0 192847         0 
>> IR-PCI-MSI-edge      iavf-net1-TxRx-3
>>
>> There were IRQs coming in on the "iavf-0000:b5:02.7:mbx" interrupt at 
>> roughly 1 per second without any traffic, while the interrupt rate on 
>> the "iavf-net1-TxRx-<X>" seemed to be related to traffic.
>>
>> Is this expected?  It seems like the IRQ subsystem is not respecting the 
>> configured SMP affinity for the interrupt in question.  I've also seen 
>> the same behaviour with igb interrupts.
> No it's not expected. Do you see the same behaviour with a recent
> mainline kernel, i.e. 5.10 or 5.11?
>
>

Jesse pointed me to this thread and apologies that it took a while for me
to respond here.

I agree it will be interesting to see with which kernel version Chris is
reproducing the issue.

Initially, I thought that this issue is the same as the one that we have
been discussing in another thread [1].

However, in that case, the smp affinity mask itself is incorrect and doesn't
follow the default smp affinity mask (with irqbalance disabled).


[1] https://lore.kernel.org/lkml/1a044a14-0884-eedb-5d30-28b4bec24b23@redhat.com/

-- 
Thanks
Nitesh

