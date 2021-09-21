Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36941354E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhIUOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhIUOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:30:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:28:39 -0700 (PDT)
Received: from [192.168.1.111] (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A5F822BA;
        Tue, 21 Sep 2021 16:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1632234517;
        bh=YfXp04HKBXQlKS++vdq6OqS5xUMWCLP0iVA5zAB44l0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sZ3N0Va3F24EunkXY8ddYihjHAvGLO/ufcGs0jj/Z3UBisS8rGPyel3jgcZEmcIi5
         MId3ngPGpJvb+B1Vk7z6pzX15HGL1yUEXz0HttWoRc1MQsLJytvKW+Engh/sPTRg5L
         etStZ/csenlkKM3HNY/PiAYRcuTCViI+59USemj8=
Subject: Re: [PATCH 0/3] drm/omap: add crtc properties
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210921141654.66550-1-narmstrong@baylibre.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <44ecbd74-b125-6f96-316f-c79dfc052af2@ideasonboard.com>
Date:   Tue, 21 Sep 2021 17:28:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210921141654.66550-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 21/09/2021 17:16, Neil Armstrong wrote:
> This patchset adds the following CRTC properties:
> - background color
> - transparency keying property
> - alpha blender on DSS3
> 
> Tomi Valkeinen (3):
>    drm/omap: add crtc background property
>    drm/omap: add crtc transparency key property
>    drm/omap: add alpha blender property

Nack, these don't comply with DRM uAPI rules. That's why I never sent 
them upstream.

https://www.kernel.org/doc/html/latest/gpu/drm-uapi.html#open-source-userspace-requirements

  Tomi
