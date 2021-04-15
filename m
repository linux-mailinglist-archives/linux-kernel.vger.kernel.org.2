Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D962936057E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhDOJUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:20:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:26136 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhDOJUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:20:40 -0400
IronPort-SDR: 9Z0vg8P6gX/DCdgLdbCPrQocmlP1+Kq94A9vtj/INKPfkbrUXSPo25jSpnmBJnUumDZ7KcgH0S
 MwSBhua5+0EA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="194383848"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="194383848"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 02:20:16 -0700
IronPort-SDR: n5soXkagFEqGqwFmH8J/fHl9ftelwXXgyTGTn83FZG4lrlItyzBPeIkqVI2EgtgMjNXvlKQ1IP
 04g8avGPvBOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="444123430"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2021 02:20:14 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
In-Reply-To: <YHf6s2r28XOtP2+2@kroah.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
 <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
 <YHcnckePpKDujCU+@kroah.com> <YHcqxMLR44laX2PZ@smile.fi.intel.com>
 <YHc68v7keeITnA3K@kroah.com>
 <87sg3sfzl1.fsf@ashishki-desk.ger.corp.intel.com>
 <YHf6s2r28XOtP2+2@kroah.com>
Date:   Thu, 15 Apr 2021 12:20:14 +0300
Message-ID: <87pmyvgb01.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Wed, Apr 14, 2021 at 10:14:34PM +0300, Alexander Shishkin wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>> 
>> >> Using raw buffer APIs against uuid_t / guid_t.
>> >
>> > So you want to do that, or you do not want to do that?  Totally
>> > confused,
>> 
>> My understanding is that:
>> 1) generate_random_uuid() use is allegedly bad even though it's in their
>> header,
>> 2) poking directly at the byte array inside uuid_t is bad, even though,
>> again, header.
>> 
>> It is, indeed, not ideal.
>> 
>> If agreeable, I'll update this patch to the below and respin the whole
>> series.
>
> You are showing that Andy wrote this, when you are the one that did :(

That's intentional, it's Andy's patch. In fact, it was probably me who
insisted on the open-coded-byte-array version, in an offline
conversation some time ago. I'd like to keep his name on it if that's
ok. I've re-sent it [1] as a standalone patch.

> Anyway, I've dropped this single patch from the series and applied the
> rest.  Feel free to send this patch as a stand-alone one once you have
> the authorship issues sorted out.

Thank you!

[1] https://lore.kernel.org/lkml/20210415091555.88085-1-alexander.shishkin@linux.intel.com/

Regards,
--
Alex
