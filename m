Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1033D567
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhCPOEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235373AbhCPOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:03:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FED564F9D;
        Tue, 16 Mar 2021 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615903435;
        bh=ho8VK/nwBd5H2y4bKi45p7YEcMtEVUmmuah52IEH4i4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qfBlXzqOKN8+OZvXkcSig6NsWRFQ09BsPvxD0eTyC3mDElfi3qpbcjT/puy5EdIBX
         Uo8/Lz/Vk4fLgYowCsw+dxO1JF9ZLRbW88SjX6JdLQBs/EkZG4Ozp93/3t0yg0s/kh
         xty6RA9AlV/Ce2yAkox6W6hG2Rykt0TdEYguHOm38Nc0StjP4SnP2oimyEMNzd3kfW
         vllR0K0GOk0nibk1GLeZ4L0NZAMCvFHIM249/weo6mX3igAPnoqjGXVuPfTi8inhNI
         sigi/vc8KYEbiZed4fXaNYXmTCD7GwQ5zXe0xRw126ptZxfBbMeO+pjrlLwB5MzU0x
         aFEng6GGMMPSg==
Subject: Re: [PATCH] drm/omap: dsi: fix unsigned expression compared with zero
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        angkery <angkery@163.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, sebastian.reichel@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Junlin Yang <yangjunlin@yulong.com>
References: <20210312071445.1721-1-angkery@163.com>
 <YE1xsg0gm0nNR8hy@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomba@kernel.org>
Message-ID: <dd0578a1-9726-4be2-f8a1-b164675b1b02@kernel.org>
Date:   Tue, 16 Mar 2021 16:03:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YE1xsg0gm0nNR8hy@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2021 04:15, Laurent Pinchart wrote:
> Hi Junlin,
> 
> Thank you for the patch.
> 
> On Fri, Mar 12, 2021 at 03:14:45PM +0800, angkery wrote:
>> From: Junlin Yang <yangjunlin@yulong.com>
>>
>> r is "u32" always >= 0,mipi_dsi_create_packet may return little than zero.
>> so r < 0 condition is never accessible.
>>
>> Fixes coccicheck warnings:
>> ./drivers/gpu/drm/omapdrm/dss/dsi.c:2155:5-6:
>> WARNING: Unsigned expression compared with zero: r < 0
>>
>> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Tomi, will you take this in your tree ?

Thanks. Yes, I'll pick this up.

  Tomi

