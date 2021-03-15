Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0041B33AA58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCOES7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhCOESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:18:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E26C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 21:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=UftIN6fE1u0QhqqkA/YhCC1AeNi+dCOkMNl2dhD5GNg=; b=aQapfMbog4owcKpXxlZ7YGkg+K
        0Msw/DBt2m2T0TVBUnrA4OIk/ys0sVnZFehXPuJNhk4pE7PqfEPKE4ftpwvApZQvF+8GkieJecFHE
        bMr5OZVz0ygqjN4hxg/90EmPfD6/e6f68L4/zDbPy1tTPWI4ZfiuC0OlH10qGiOHg5KrzrAVmikQc
        FdRjA0l0KYwuzud+PC91htKGs0AWjV+VUK0CzakYtk3aZT7nSSL7hp+KHV3wPY+gvZ7imFcsgVDC4
        Trs5ZWZn+ONibXi9nE5vFhtA++JJUXr/eJZSwLYscHYYScdfILQVvTiEZ8rTfDyzJzz2hZZY/lXun
        vmN7bq/g==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLegK-001Fuv-Ii; Mon, 15 Mar 2021 04:18:17 +0000
Subject: Re: [PATCH V2] drm: amd: pm: Mundane typo fixes in the file
 amdgpu_pm.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
        nirmoy.das@amd.com, kevin1.wang@amd.com, ray.huang@amd.com,
        Xiaojian.Du@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210315032136.3669883-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <64472479-0f70-3875-d09a-29417cd8b48e@infradead.org>
Date:   Sun, 14 Mar 2021 21:18:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315032136.3669883-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/21 8:21 PM, Bhaskar Chowdhury wrote:
> 
> s/"an minimum"/"a minimum"/
> s/"an maxmum"/"a maximum"/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Changes from V1:
>   Randy's suggestion to adjust the subject line text
>   And missed out a spell too,which now included
> 
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5fa65f191a37..308249ae1a22 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3315,9 +3315,9 @@ static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,
>   *
>   * - pwm1_max: pulse width modulation fan control maximum level (255)
>   *
> - * - fan1_min: an minimum value Unit: revolution/min (RPM)
> + * - fan1_min: a minimum value Unit: revolution/min (RPM)
>   *
> - * - fan1_max: an maxmum value Unit: revolution/max (RPM)
> + * - fan1_max: a maximum value Unit: revolution/max (RPM)
>   *
>   * - fan1_input: fan speed in RPM
>   *
> --


-- 
~Randy

