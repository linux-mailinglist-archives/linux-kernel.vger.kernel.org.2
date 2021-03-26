Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5234A280
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhCZHZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230007AbhCZHYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:24:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3010461935;
        Fri, 26 Mar 2021 07:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616743494;
        bh=tVARFWteZzvz4340tigTJdsmCz/hOh5guz5vK9EB7N8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OLF3MBwLj84Vusn4dUtIPFGvdkvSREo/iqg5H1tjH+U6U+5jfcILgmMyTtx2Vt0gg
         HvOzHlOJjeedI31Nlt7UAbpeTSjZ3PQ7VsDWdUCHZ9ffxgM/CIonSjs1kAYwG5DLTU
         9+zw9fe74CorqDws7EcmQ6lldigXz8U81blDU4M8fvuDEZo5+271VwUDnUO2XvGghs
         z2/JU1XYh4VEZMvyNRpnc7n+zqsfyk9Dc+3I5sPVBcjFFWewcYzNQFMoLRJrdvFCwL
         lqYtJ6DoDMLiRZQEsH4jC7zBBswgcFXGsUijbOD/x6v7BedeUvuMhDkGf9mDjHSiup
         w7GFnyWzxUJJw==
Subject: Re: [PATCH] [v2] drivers: gpu: drm: Remove duplicate declaration
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wan Jiabing <wanjiabing@vivo.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jyri Sarha <jsarha@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
References: <20210325111028.864628-1-wanjiabing@vivo.com>
 <YFyKriqHBgtWiX2q@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomba@kernel.org>
Message-ID: <78a234fe-1149-24c4-8318-9c78c63fbbc7@kernel.org>
Date:   Fri, 26 Mar 2021 09:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFyKriqHBgtWiX2q@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2021 15:05, Laurent Pinchart wrote:
> Hi Wan,
> 
> Thank you for the patch.
> 
> On Thu, Mar 25, 2021 at 07:10:24PM +0800, Wan Jiabing wrote:
>> struct dss_device has been declared. Remove the duplicate.
>> And sort these forward declarations alphabetically.
>>
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Tomi, I assume you'll handle this patch, please let me know if you don't
> plan to do so.

Yep, picked this up. Thanks!

  Tomi
