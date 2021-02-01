Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6099830A4C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhBAKAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:00:12 -0500
Received: from foss.arm.com ([217.140.110.172]:54722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232646AbhBAKAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:00:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 346E0101E;
        Mon,  1 Feb 2021 01:59:26 -0800 (PST)
Received: from [10.57.8.191] (unknown [10.57.8.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55D163F718;
        Mon,  1 Feb 2021 01:59:24 -0800 (PST)
Subject: Re: [PATCH v2] drm/lima: add governor data with pre-defined
 thresholds
To:     Qiang Yu <yuq825@gmail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
References: <20210127194047.21462-1-christianshewitt@gmail.com>
 <CAKGbVbtaDHmukvfF=sfSmWHVdAYoF6-i4RTzsPQ6zfsjHcGNCw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2c8d2b9e-c1cc-1157-19de-409957ecf9da@arm.com>
Date:   Mon, 1 Feb 2021 09:59:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKGbVbtaDHmukvfF=sfSmWHVdAYoF6-i4RTzsPQ6zfsjHcGNCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/21 1:57 PM, Qiang Yu wrote:
> This patch gets minor improvement on glmark2 (160->162).

It has bigger impact when the load is changing and the frequency
is stuck to min w/o this patch.

> 
> Seems there's no way for user to change this value, do we?
> Or there's work pending to expose it to sysfs?

True there is no user sysfs. I've proposed a patch to export these via
sysfs. Chanwoo is going to work on it. When it will land mainline, it's
probably a few months. So for now, the fix makes sense.

Regards,
Lukasz

