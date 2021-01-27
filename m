Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D91305863
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhA0K1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:27:25 -0500
Received: from foss.arm.com ([217.140.110.172]:37374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235812AbhA0KZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:25:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D72231B;
        Wed, 27 Jan 2021 02:24:53 -0800 (PST)
Received: from [10.57.4.29] (unknown [10.57.4.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F21263F66B;
        Wed, 27 Jan 2021 02:24:50 -0800 (PST)
Subject: Re: [PATCH] drm/lima: add governor data with pre-defined thresholds
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>
References: <20210125081804.13016-1-christianshewitt@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9e30a8e1-ef69-5929-17f1-cdb603686495@arm.com>
Date:   Wed, 27 Jan 2021 10:24:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210125081804.13016-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 1/25/21 8:18 AM, Christian Hewitt wrote:
> This patch adapts the panfrost pre-defined thresholds change [0] to the
> lima driver to improve real-world performance. The upthreshold value has
> been set to ramp GPU frequency to max freq faster (compared to panfrost)
> to compensate for the lower overall performance of utgard devices.
> 
> [0] https://patchwork.kernel.org/project/dri-devel/patch/20210121170445.19761-1-lukasz.luba@arm.com/
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> I have been using Kodi as my test application. If you scroll in library
> views with hundreds of list items and the panfrost values the slow GPU
> ramp up is quite noticeable and the GUI feels sluggish. As everything
> lima runs on is inherently slower than panfrost using devices I believe
> it's better to ramp up to max freq quicker.

It's quite low value for the upthreshold, but I believe you have
experimented and observed that a bit higher (30, 40?) don't work well.
I don't know the Kodi system, though.

You can check if the other frequencies are also used in statistics for
devfreq device:
cat /sys/class/devfreq/<your_gpu>/trans_stats

If they are also used, then it OK (better than stuck at min freq).

Regards,
Lukasz
