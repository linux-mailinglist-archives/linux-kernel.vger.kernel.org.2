Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F19E3488B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhCYGEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:04:22 -0400
Received: from mta-out1.inet.fi ([62.71.2.194]:41562 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCYGDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:03:54 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2021 02:03:53 EDT
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudegledgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftnecuuegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepkfhlkhhkrgcurfhruhhsihcuoehilhhkkhgrrdhprhhushhisehpphdrihhnvghtrdhfiheqnecuggftrfgrthhtvghrnhepvddtgeduiefgkeejfedvhefgledugffhheejgfehgeffhfegueelvdefvdevieefnecukfhppeekgedrvdehuddrudelgedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddrjeeingdpihhnvghtpeekgedrvdehuddrudelgedrudeigedpmhgrihhlfhhrohhmpeeophhruhhsihhlqddusehmsghogidrihhnvghtrdhfihequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
Received: from [192.168.1.76] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 605B47EE00035105 for linux-kernel@vger.kernel.org; Thu, 25 Mar 2021 07:57:34 +0200
Subject: Re: WARNING: AMDGPU DRM warning in 5.11.9
To:     linux-kernel@vger.kernel.org
References: <CAK2bqVJ+=nHTK-hnUC=qL1mcOvHWTCwDMYPBKJp77QCbBvBGGw@mail.gmail.com>
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Message-ID: <a38a3c04-4ac8-01a6-da69-a2bdaa54f61d@pp.inet.fi>
Date:   Thu, 25 Mar 2021 07:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAK2bqVJ+=nHTK-hnUC=qL1mcOvHWTCwDMYPBKJp77QCbBvBGGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.3.2021 16.16, Chris Rankin wrote:
> Hi,
> 
> Theee warnings ares not present in my dmesg log from 5.11.8:
> 
> [   43.390159] ------------[ cut here ]------------
> [   43.393574] WARNING: CPU: 2 PID: 1268 at
> drivers/gpu/drm/ttm/ttm_bo.c:517 ttm_bo_release+0x172/0x282 [ttm]
> [   43.401940] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211

Changing WARN_ON to WARN_ON_ONCE in drivers/gpu/drm/ttm/ttm_bo.c 
ttm_bo_release() reduces the flood of messages into single splat.

This warning appears to come from 57fcd550eb15bce ("drm/ttm: Warn on 
pinning without holding a reference)" and reverting it might be one choice.


> 
> There are others, but I am assuming there is a common cause here.
> 
> Cheers,
> Chris
> 

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index a76eb2c14e8c..50b53355b265 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -514,7 +514,7 @@ static void ttm_bo_release(struct kref *kref)
                  * shrinkers, now that they are queued for
                  * destruction.
                  */
-               if (WARN_ON(bo->pin_count)) {
+               if (WARN_ON_ONCE(bo->pin_count)) {
                         bo->pin_count = 0;
                         ttm_bo_del_from_lru(bo);
                         ttm_bo_add_mem_to_lru(bo, &bo->mem);



--
  - Ilkka

