Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F0233FBCA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 00:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhCQX0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 19:26:38 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:50145 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhCQX0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:26:33 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lMfYb-000Ghx-1Z; Thu, 18 Mar 2021 00:26:29 +0100
Received: from p5b13a966.dip0.t-ipconnect.de ([91.19.169.102] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lMfYa-000U7D-RT; Thu, 18 Mar 2021 00:26:29 +0100
Subject: Re: [PATCH 0/1] sched/topology: NUMA distance deduplication
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        debian-ia64 <debian-ia64@lists.debian.org>
References: <255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de>
 <8735wtr2ro.mognet@arm.com>
 <cf4d7277-54a0-8bc7-60fb-9b2f6befb511@physik.fu-berlin.de>
 <87zgz1pmx4.mognet@arm.com> <87wnu5pkib.mognet@arm.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <132937a8-0514-5a62-2897-569187e355a7@physik.fu-berlin.de>
Date:   Thu, 18 Mar 2021 00:26:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87wnu5pkib.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.169.102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin!

On 3/17/21 9:56 PM, Valentin Schneider wrote:
> On 17/03/21 20:04, Valentin Schneider wrote:
>> Technically it *is* coping with it, it's just dumping the entire NUMA
>> distance matrix in the process... Let me see if I can't figure out why your
>> system doesn't end up with nr_node_ids=1.
>>
> 
> Does the below
> a) compile

Yes.

> b) do anything?

It fixes the problem for me.

Will test Sergei's patch now.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

