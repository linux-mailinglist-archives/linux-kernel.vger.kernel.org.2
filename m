Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70D305988
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhA0LWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:22:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:38602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236185AbhA0LVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:21:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611746437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTPfmJYS9K4cDzIeVmkm+0vr0eBqdm0Bp1Q5Z9yBMa0=;
        b=tcWvnXzV4MLZ+DQuecYXmwdrTwr8uC8U2uXoOm24fc/K3CAM+orKakcfguyxzw9PYjOlwA
        GKpQUDgv4GaECfg1CsitVK8kMnElzq4jqkXaScoIK/Ais7a6rdPx+u2ft4p7Pqqji8cfj3
        MXtgHuDvQ1tUyjyJEkgI3MzJjgEnPN8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 078F5AD26;
        Wed, 27 Jan 2021 11:20:37 +0000 (UTC)
Subject: Re: [PATCH] xen-blkback: fix compatibility bug with single page rings
To:     paul@xen.org
Cc:     'Paul Durrant' <pdurrant@amazon.com>,
        'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
        =?UTF-8?B?J1JvZ2VyIFBhdSBNb25uw6kn?= <roger.pau@citrix.com>,
        'Jens Axboe' <axboe@kernel.dk>,
        'Dongli Zhang' <dongli.zhang@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20210127103034.2559-1-paul@xen.org>
 <cd70ae5e-a389-7521-8caf-15650a276152@suse.com>
 <026001d6f49c$eab982b0$c02c8810$@xen.org>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <ed1988d9-131a-daf1-787f-3f49269b91aa@suse.com>
Date:   Wed, 27 Jan 2021 12:20:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <026001d6f49c$eab982b0$c02c8810$@xen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.2021 12:09, Paul Durrant wrote:
>> -----Original Message-----
>> From: Jan Beulich <jbeulich@suse.com>
>> Sent: 27 January 2021 10:57
>> To: Paul Durrant <paul@xen.org>
>> Cc: Paul Durrant <pdurrant@amazon.com>; Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>; Roger Pau
>> Monné <roger.pau@citrix.com>; Jens Axboe <axboe@kernel.dk>; Dongli Zhang <dongli.zhang@oracle.com>;
>> linux-kernel@vger.kernel.org; linux-block@vger.kernel.org; xen-devel@lists.xenproject.org
>> Subject: Re: [PATCH] xen-blkback: fix compatibility bug with single page rings
>>
>> On 27.01.2021 11:30, Paul Durrant wrote:
>>> From: Paul Durrant <pdurrant@amazon.com>
>>>
>>> Prior to commit 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to avoid
>>> inconsistent xenstore 'ring-page-order' set by malicious blkfront"), the
>>> behaviour of xen-blkback when connecting to a frontend was:
>>>
>>> - read 'ring-page-order'
>>> - if not present then expect a single page ring specified by 'ring-ref'
>>> - else expect a ring specified by 'ring-refX' where X is between 0 and
>>>   1 << ring-page-order
>>>
>>> This was correct behaviour, but was broken by the afforementioned commit to
>>> become:
>>>
>>> - read 'ring-page-order'
>>> - if not present then expect a single page ring
>>> - expect a ring specified by 'ring-refX' where X is between 0 and
>>>   1 << ring-page-order
>>> - if that didn't work then see if there's a single page ring specified by
>>>   'ring-ref'
>>>
>>> This incorrect behaviour works most of the time but fails when a frontend
>>> that sets 'ring-page-order' is unloaded and replaced by one that does not
>>> because, instead of reading 'ring-ref', xen-blkback will read the stale
>>> 'ring-ref0' left around by the previous frontend will try to map the wrong
>>> grant reference.
>>>
>>> This patch restores the original behaviour.
>>
>> Isn't this only the 2nd of a pair of fixes that's needed, the
>> first being the drivers, upon being unloaded, to fully clean up
>> after itself? Any stale key left may lead to confusion upon
>> re-use of the containing directory.
> 
> In a backend we shouldn't be relying on, nor really expect IMO, a frontend to clean up after itself. Any backend should know *exactly* what xenstore nodes it’s looking for from a frontend.

But the backend can't know whether a node exists because the present
frontend has written it, or because an earlier instance forgot to
delete it. It can only honor what's there. (In fact the other day I
was wondering whether some of the writes of boolean "false" nodes
wouldn't better be xenbus_rm() instead.)

Jan
