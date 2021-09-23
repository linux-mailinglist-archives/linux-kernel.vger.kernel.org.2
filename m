Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F665416813
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243460AbhIWWfO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Sep 2021 18:35:14 -0400
Received: from aposti.net ([89.234.176.197]:50048 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243431AbhIWWfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:35:13 -0400
Date:   Thu, 23 Sep 2021 23:33:31 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] DRM/Panel : abt-y030xx067a yellow tint fix
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Christophe Branchereau <cbranchereau@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <VZRWZQ.AN75Q6XHYN1C1@crapouillou.net>
In-Reply-To: <YUzg7wv8NQGf3Qq0@ravnborg.org>
References: <20210914092716.2370039-1-cbranchereau@gmail.com>
        <YUzg7wv8NQGf3Qq0@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu., sept. 23 2021 at 22:17:51 +0200, Sam Ravnborg 
<sam@ravnborg.org> a écrit :
> Hi Christophe, Paul,
> On Tue, Sep 14, 2021 at 11:27:16AM +0200, Christophe Branchereau 
> wrote:
>>  The previous parameters caused an unbalanced yellow tint.
>> 
>>  Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> 
> with the subject fixed the patch is:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Paul - I assume you will apply this as you wrote on irc.

I added:
Fixes: 7467389bdafb ("drm/panel: Add ABT Y030XX067A 3.0" 320x480 panel")

I also fixed the subject (case and punctuation), and pushed to 
drm-misc-fixes.

Thanks!

Cheers,
-Paul

> 
> 	Sam
> 
>>  ---
>>   drivers/gpu/drm/panel/panel-abt-y030xx067a.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>>  diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c 
>> b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
>>  index 2d8794d495d0..3d8a9ab47cae 100644
>>  --- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
>>  +++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
>>  @@ -146,8 +146,8 @@ static const struct reg_sequence 
>> y030xx067a_init_sequence[] = {
>>   	{ 0x09, REG09_SUB_BRIGHT_R(0x20) },
>>   	{ 0x0a, REG0A_SUB_BRIGHT_B(0x20) },
>>   	{ 0x0b, REG0B_HD_FREERUN | REG0B_VD_FREERUN },
>>  -	{ 0x0c, REG0C_CONTRAST_R(0x10) },
>>  -	{ 0x0d, REG0D_CONTRAST_G(0x10) },
>>  +	{ 0x0c, REG0C_CONTRAST_R(0x00) },
>>  +	{ 0x0d, REG0D_CONTRAST_G(0x00) },
>>   	{ 0x0e, REG0E_CONTRAST_B(0x10) },
>>   	{ 0x0f, 0 },
>>   	{ 0x10, REG10_BRIGHT(0x7f) },
>>  --
>>  2.33.0


