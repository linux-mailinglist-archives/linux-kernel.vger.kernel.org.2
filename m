Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2026434CF40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhC2Lli convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Mar 2021 07:41:38 -0400
Received: from aposti.net ([89.234.176.197]:39248 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230180AbhC2LlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:41:22 -0400
Date:   Mon, 29 Mar 2021 12:41:00 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drm: DON'T require each CRTC to have a unique primary
 plane
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Simon Ser <contact@emersion.fr>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        od@zcrc.me, dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Message-Id: <C4BQQQ.FDNJ4NAK9OAD3@crapouillou.net>
In-Reply-To: <20210329111533.47e44f72@eldfell>
References: <20210327112214.10252-1-paul@crapouillou.net>
        <1J_tcDPSAZW23jPO8ApyzgINcVRRWcNyFP0LvrSFVIMbZB9lH6lCWvh2ByU9rNt6bj6xpgRgv8n0hBKhXAvXNfLBGfTIsvbhYuHW3IIDd7Y=@emersion.fr>
        <24LMQQ.CRNKYEI6GB2T1@crapouillou.net> <20210329111533.47e44f72@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun. 29 mars 2021 � 11:15, Pekka Paalanen <ppaalanen@gmail.com> a 
�crit :
> On Sat, 27 Mar 2021 11:26:26 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>>  It has two mutually exclusive background planes (same Z level) + one
>>  overlay plane.
> 
> What's the difference between the two background planes?
> 
> How will generic userspace know to pick the "right" one?

First primary plane cannot scale, supports RGB and C8. Second primary 
plane goes through the IPU, and as such can scale and convert pixel 
formats; it supports RGB, non-planar YUV, and multi-planar YUV.

Right now the userspace apps we have will simply pick the first one 
that fits the bill.

Cheers,
-Paul

>>  Le sam. 27 mars 2021 � 11:24, Simon Ser <contact@emersion.fr> a 
>> �crit
>>  :
>>  > On Saturday, March 27th, 2021 at 12:22 PM, Paul Cercueil
>>  > <paul@crapouillou.net> wrote:
>>  >
>>  >>  The ingenic-drm driver has two mutually exclusive primary planes
>>  >>  already; so the fact that a CRTC must have one and only one 
>> primary
>>  >>  plane is an invalid assumption.
>>  >
>>  > Why does this driver expose two primary planes, if it only has a
>>  > single
>>  > CRTC?
>> 
>> 
>>  _______________________________________________
>>  dri-devel mailing list
>>  dri-devel@lists.freedesktop.org
>>  https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


