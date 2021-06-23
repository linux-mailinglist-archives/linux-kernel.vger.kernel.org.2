Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816833B17FB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhFWKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:20:00 -0400
Received: from srv6.fidu.org ([159.69.62.71]:41106 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWKT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:19:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id BA174C800A7;
        Wed, 23 Jun 2021 12:17:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id cq-7LrBxmnzK; Wed, 23 Jun 2021 12:17:40 +0200 (CEST)
Received: from [IPv6:2003:e3:7f39:4900:3156:839d:aed8:6ea6] (p200300e37f3949003156839Daed86eA6.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:4900:3156:839d:aed8:6ea6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id 2D4ABC8009D;
        Wed, 23 Jun 2021 12:17:40 +0200 (CEST)
Subject: Re: [PATCH v4 09/17] drm/uAPI: Add "active color range" drm property
 as feedback for userspace
To:     Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        tzimmermann@suse.de, rodrigo.vivi@intel.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
 <20210618091116.14428-10-wse@tuxedocomputers.com>
 <20210622100042.4041624a@eldfell>
 <56d079d4-841a-0ca5-b8a6-d2c10f91d211@tuxedocomputers.com>
 <k_QeCRpur3SNNIspBiTHOTT6Oj1pSteEO3MzyQFUG0lSXmEqJUI2tMXJ6wR9chzUHGahdQApJZrUxdJvIv6s8aXr2DBdoHg-2PsGH4kEMyA=@emersion.fr>
 <20210623103256.01d680ba@eldfell>
From:   Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <5947f768-dd87-6b39-ecfc-b7c4aaa88aca@tuxedocomputers.com>
Date:   Wed, 23 Jun 2021 12:17:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623103256.01d680ba@eldfell>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 23.06.21 um 09:32 schrieb Pekka Paalanen:
> On Tue, 22 Jun 2021 11:48:52 +0000
> Simon Ser <contact@emersion.fr> wrote:
>
>> On Tuesday, June 22nd, 2021 at 11:50, Werner Sembach <wse@tuxedocomputers.com> wrote:
>>
>>> Unknown is when no monitor is connected or is when the
>>> connector/monitor is disabled.  
>> I think the other connector props (link-status, non-desktop, etc) don't
>> have a special "unset" value, and instead the value is set to a random
>> enum entry. User-space should ignore the prop on these disconnected
>> connectors anyways.
> That sounds fine to me.

Currently the only case for "not applicable" is when the monitor is disconnected, but sicne the properties are so
interdependent, there might be a case in the future where e.g. a color format that has no differentiation between full
and limited arises. When there is no special unset/not applicable option, the userspace has to know exactly when an
option is valid or not, possible requiring additional logic.

Setting a "not applicable" value allows userspace to be more dumb, without much hassle on the kernelspace side.

>
>
> Thanks,
> pq
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
