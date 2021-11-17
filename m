Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89A454E47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhKQUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhKQUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:07:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD17EC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 12:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=CYxm5Cqmepf+ZVOq1YCWdgYFRIfV5vO/wlx2Vw8B9DM=; b=BKXOjqRhb8y49+JuViqQi3EYHV
        6k7D8SGDGQ6Xuujz8WrIrYgKFq1LihwRNUHm1mjxVAnkL7JXvhIJDpH2g7uS8iy8e0fMObzoY8xvC
        PT/CwMsdw+abRoP3jqG3newMBl4/R3JoQmabfP6mBb91isYk5v+BxmvtlmhkOSV7zqYQCePjZb0tM
        /U0aSVc1NjfI5IVy5Chjhai9CaOCoDVbar0fk//Lg8+oI2IecBd2tyJWK4H9yoq/pNtaOcmMCcp6v
        aoILfrxGaz3IDOWTbb4sCkXk7egfxeEZol1ZwvXn/OfjX3Y+uu/M0BxhoolefwOugdVPDzMM4F6uW
        oIh0FIRg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnRAZ-006DO0-Pf; Wed, 17 Nov 2021 20:04:36 +0000
Subject: Re: [PATCH] drm/panel-edp: modify Kconfig to prevent build error
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20211117062704.14671-1-rdunlap@infradead.org>
 <CAK8P3a1cayrsR9J+G6bAkZjK-hGaNzqSQAxB5LS4pvJm_rtpHQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <34aeb1de-7edf-77bd-e9d9-8cf203e73433@infradead.org>
Date:   Wed, 17 Nov 2021 12:04:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1cayrsR9J+G6bAkZjK-hGaNzqSQAxB5LS4pvJm_rtpHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 11:58 PM, Arnd Bergmann wrote:
> On Wed, Nov 17, 2021 at 7:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> When CONFIG_DRM_KMS_HELPER=m and CONFIG_DRM_PANEL_EDP=y,
>> there is a build error in gpu/drm/panel/panel-edp.o:
>>
>> arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-edp.o: in function `panel_edp_probe':
>> panel-edp.c:(.text+0xf38): undefined reference to `drm_panel_dp_aux_backlight'
>>
>> Fix this by limiting DRM_PANEL_DEP by the value of the DRM_KMS_HELPER
>> symbol.
> 
> I think the analysis is correct, but this is not the correct fix since
> DRM_KMS_HELPER
> is not user-selectable. (Almost) all other drivers that rely on DRM_KMS_HELPER
> use 'select' for this, and mixing the two risks running into circular
> dependencies.

Oops. Thanks for catching that.

My first (local) version of the patch used select, but that got me
into kconfig circular dependency chain land (ugly).
Maybe your all-at-once patch can take care of that problem.

> 
> I see that there are already some 'depends on DRM_KMS_HELPER' in bridge
> and panel drivers, so it's possible that we have to fix them all at the same to
> do this right. I ran into another problem like this the other day and
> I'm currently
> testing with the patch below, but I have not posted that yet since I am not
> fully convinced that this is the correct fix either.

I'll test some with it also.

thanks.

-- 
~Randy
