Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA333FD71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhCRCyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:54:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230507AbhCRCy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616036065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tjdti5kTNL3zD2uNkTDcpxYIrVKXWkg9ROqzL7KcVJ4=;
        b=E4rWPYWiIioBEQVGBqac+3YQ5eWgheqOsoIAEmOnOTO6rbXdEmR3Fj+UBLRGN3L+6spGb0
        PFSp3YPyXWYyZ6fZ9vvRil4Zq7e2co3OS01eabvhrYp28UmWe+/PMHQxZ5OAzuDoH745O3
        8AJkoeGR6b/MQq7qs7JLRH/dUaZGv9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-kT4dhYSkNUa-dXlfTbk42g-1; Wed, 17 Mar 2021 22:54:23 -0400
X-MC-Unique: kT4dhYSkNUa-dXlfTbk42g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1A7881280;
        Thu, 18 Mar 2021 02:54:22 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-171.rdu2.redhat.com [10.10.117.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B5F45C1D0;
        Thu, 18 Mar 2021 02:54:18 +0000 (UTC)
Subject: Re: [PATCH 3/4] locking/ww_mutex: Treat ww_mutex_lock() like a
 trylock
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
References: <20210316153119.13802-1-longman@redhat.com>
 <20210316153119.13802-4-longman@redhat.com>
 <YFK5yBIOTiCdFLNm@boqun-archlinux>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <64af1d7b-6720-0ac1-4a55-bb0acb642c6f@redhat.com>
Date:   Wed, 17 Mar 2021 22:54:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFK5yBIOTiCdFLNm@boqun-archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 10:24 PM, Boqun Feng wrote:
> Hi Waiman,
>
> Just a question out of curiosity: how does this problem hide so long?
> ;-) Because IIUC, both locktorture and ww_mutex_lock have been there for
> a while, so why didn't we spot this earlier?
>
> I ask just to make sure we don't introduce the problem because of some
> subtle problems in lock(dep).
>
You have to explicitly specify ww_mutex in the locktorture module 
parameter to run the test. ww_mutex is usually not the intended target 
of testing as there aren't that many places that use it. Even if someone 
run it, it probably is not on a debug kernel.

Our QA people try to run locktorture on ww_mutex and discover that.

Cheers,
Longman

